const express = require('express');
const router = express.Router();
const pool = require('../database');
const Index = require('../controllers/index.controller');
const multer = require('multer');
const path = require('path'); 
const fs = require('fs');

router.get('/', Index.index);

router.get('/nosotros', Index.nosotros);

router.get('/filtros', Index.error);

/**
 * Guardar en multer
 */
const diskstorage = multer.diskStorage({
    destination: path.join(__dirname, '../public/images/prendas'),
    filename: (req, file, cb) => {
        cb(null,file.originalname);
    }
});

const fileUpload = multer({
    storage: diskstorage
}).single('image') 

/**
 * Get + Post: Imagenes
 */
router.get('/admin/imagenes', async(req,res) =>{

    /**
     * Informaciòn de Prenda
     */
    //Prenda
    const Prenda = await pool.query(`
        SELECT
            prenda.id,
            modelos.modelo AS modelo,
            modelos.ruta_imagen AS ruta_imagen,
            descripciones.descripcion AS descripcion
        FROM 
            prenda 
                INNER JOIN modelos
                    ON prenda.id_modelos = modelos.id
                INNER JOIN descripciones
                    ON prenda.id_descripciones = descripciones.id
    `);


    //console.log(Prenda[0].id);
    //console.log(Imagenes[0].modelo);
    //console.log(Imagenes[0].ruta_imagen);

    /**
     * Guardar en dbimagenes segun id:prenda
     */
    for(i=0;i<Prenda.length;i++){
        fs.writeFileSync(path.join(__dirname,'../public/images/dbimagenes/' + Prenda[i].descripcion + 's/' + Prenda[i].id + '.png'),Prenda[i].ruta_imagen);
    }

    res.render('index/imagenes');
});

router.post('/admin/imagenes', fileUpload , async(req,res,next) => {
    /**
     * Recoger el nombre del archivo
     * @name : nombre del archivo;
     * @data : obtener el archivo binario de la imagen
     */
    const name = req.file.originalname;
    const data = fs.readFileSync(path.join(__dirname, '../public/images/prendas/'+ req.file.filename));
    
    /**
     * Separar datos del nombre
     */
    const arrayName = name.split("-");
    const ultimo = arrayName.pop();
    const APNG = ultimo.split(".");
    arrayName.push(APNG[0]);
    //console.log(arrayName);
    
    /*
    for (let i = 0; i < arrayName.length; i++) {
        console.log(arrayName[i]);
    }
    */
    
    /**
     * Verificar que no haya copia de: descripcion, color, nombre del modelo, estilo, precio, busto, cintura, cadera
     */
    const Descripcion = await pool.query("SELECT * FROM descripciones WHERE descripcion = ?",[arrayName[0]]);
    const Color = await pool.query("SELECT * FROM colores WHERE color = ?",[arrayName[1]]);
    const Modelo = await pool.query("SELECT * FROM modelos WHERE modelo = ?",[arrayName[2]]);
    const Estilo = await pool.query("SELECT * FROM estilos WHERE estilo = ?",[arrayName[3]]);
    const Precio = await pool.query("SELECT * FROM precios WHERE precio = ?",[arrayName[4]]);
    const Tamaño = await pool.query("SELECT * FROM tamaño WHERE busto = ? AND cintura = ? AND cadera = ?",[arrayName[5],arrayName[6],arrayName[7]]);
    
    
    const IDS = new Array();
    //descripción
    if (Descripcion.length == 0) {
        var result = await pool.query("INSERT INTO descripciones (descripcion) VALUES (?)",[arrayName[0]]);
        IDS.push(result.insertId);
        //console.log("La nueva desripcion es: " + result.insertId);
        //console.log(IDS[0]);
    } else {
        IDS.push(Descripcion[0].id);
        //console.log(IDS[0]);
    }
    //console.log(IDS);
    
    //color
    if (Color.length == 0) {
        let result = await pool.query("INSERT INTO colores (color) VALUES (?)",[arrayName[1]]);
        //onsole.log(result.insertId);
        IDS.push(result.insertId);
        //console.log(IDS[0]);
    } else {
        IDS.push(Color[0].id);
    }
    //console.log(IDS[0]);
    //nombre del modelo
    if (Modelo.length == 0) {
        console.log(IDS[1]);
        let result = await pool.query("INSERT INTO modelos (modelo,id_colores,ruta_imagen) VALUES (?,?,?)",[arrayName[2],IDS[1],data]);
        //onsole.log(result.insertId);
        IDS.push(result.insertId);
        //console.log(IDS[0]);
    } else {
        IDS.push(Modelo[0].id);
    }
    //console.log(IDS);
    
    //estilo
    if (Estilo.length == 0) {
        let result = await pool.query("INSERT INTO estilos (estilo) VALUES (?)",[arrayName[3]]);
        //onsole.log(result.insertId);
        IDS.push(result.insertId);
        //console.log(IDS[0]);
    } else {
        IDS.push(Estilo[0].id);
    }
    
    //precio
    if (Precio.length == 0) {
        let result = await pool.query("INSERT INTO precios (precio) VALUES (?)",[arrayName[4]]);
        //onsole.log(result.insertId);
        IDS.push(result.insertId);
        //console.log(IDS[0]);
    } else {
        IDS.push(Precio[0].id);
    }
    
    //tamaño
    if (Tamaño.length == 0) {
        let result = await pool.query("INSERT INTO tamaño (busto,cintura,cadera) VALUES (?,?,?)",[arrayName[5],arrayName[6],arrayName[7]]);
        //onsole.log(result.insertId);
        IDS.push(result.insertId);
        //console.log(IDS[0]);
    } else {
        IDS.push(Tamaño[0].id);
    }

    //console.log(IDS);
    
    /**
     * Insertar valores en las tablas: descripcion, color, nombre del modelo, estilo, precio, busto, cintura, cadera
     */
    

    //Verificar copia
    const Prenda = await pool.query(`
        SELECT * FROM prenda WHERE 
            id_estilos = ? AND 
            id_precios = ? AND 
            id_descripciones = ? AND
            id_tamaños = ? AND
            id_modelos = ?
    `,[IDS[3],IDS[4],IDS[0],IDS[5],IDS[2]]);
    
    if (Prenda.length == 0) {
        const prenda = {
            cantidad: '12',
            id_estilos: IDS[3],
            id_precios: IDS[4],
            id_descripciones: IDS[0],
            id_tamaños: IDS[5],
            id_modelos: IDS[2]
        };
        
        await pool.query("INSERT INTO prenda SET ?",[prenda]);
    } else {
        const prenda = {
            cantidad: Prenda[0].cantidad + 1,
            id_estilos: IDS[3],
            id_precios: IDS[4],
            id_descripciones: IDS[0],
            id_tamaños: IDS[5],
            id_modelos: IDS[2]
        };
        
        await pool.query(`
            UPDATE prenda SET ? WHERE 
                id_estilos = ? AND 
                id_precios = ? AND 
                id_descripciones = ? AND
                id_tamaños = ? AND
                id_modelos = ?
        `,[prenda,IDS[3],IDS[4],IDS[0],IDS[5],IDS[2]]);

    }
    
    //delete IDS;
    res.redirect('/admin/imagenes');
});

module.exports = router;