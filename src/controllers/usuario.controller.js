const express = require('express');
const pool = require('../database');
const helpers = require('../lib/helpers');

/**
 * GET + POST: perfil de usuario
 */
const usuarioGet = async(req, res) => {

    const id = req.user.id;
    const Cliente = await pool.query("SELECT * FROM cliente WHERE id = ?",[id]);
    
    let idU = Cliente[0].id_user;
    let idI = Cliente[0].id_info;
    let idT = Cliente[0].id_tamaño;

    const Usuario = await pool.query("SELECT * FROM user_cliente WHERE id = ?",[idU]);
    const Info = await pool.query("SELECT * FROM info_cliente WHERE id = ?",[idI]);
    const Tamaño = await pool.query("SELECT * FROM tamaño WHERE id = ?",[idT]);

    if (Tamaño == undefined){
        Tamaño[0] = {
            ...Tamaño[0],
            busto: '0',
            cintura: '0',
            cadera: '0'
        }
    }

    //res.status(200).json({tamaño:Tamaño[0], info:Info[0]});
    res.render('usuario/perfil',{cliente:Cliente[0],usuario:Usuario[0],tamaño:Tamaño[0], info:Info[0]});
}

const usuarioPost = async(req, res) => {
    //res.redirect('/perfil');
}

/**
 * GET + POST: editar perfil de usuario
 */
const editarGet = async(req, res) => {
    const id = req.user.id;
    const Cliente = await pool.query("SELECT * FROM cliente WHERE id = ?", [id]);
    const cliente = Cliente[0];

    let idU = cliente.id_user;
    let idI = cliente.id_info;
    let idT = cliente.id_tamaño;

    const Usuario = await pool.query("SELECT * FROM user_cliente WHERE id = ?",[idU]);
    const Info = await pool.query("SELECT * FROM info_cliente WHERE id = ?",[idI]);
    const Tamaño = await pool.query("SELECT * FROM tamaño WHERE id = ?",[idT]);

    if (Tamaño == undefined){
        Tamaño[0] = {
            ...Tamaño[0],
            busto: '0',
            cintura: '0',
            cadera: '0'
        }
    } 

    /*
    else if (Tamaño[0].busto <0 || Tamaño[0].cintura<0 || Tamaño[0].cadera<0){
        //valores negativos para medidas no posibles
    }
    */

    res.render('usuario/editar_perfil', { cliente: Cliente[0], usuario:Usuario[0],tamaño:Tamaño[0], info:Info[0]});
}

const editarPost = async(req, res) => {
    /**
     * id del cliente
     */
    const {id} = req.params;
    console.log(`estamos en editar perfil: ${id}`);
    const clientes = await pool.query("SELECT * FROM cliente WHERE id = ?",[id]);
    const cliente = clientes[0];

    if(clientes.length > 0){
        /**
         * Recuperar idU, idI, idT
         */
        const idU = cliente.id_user;
        const idI = cliente.id_info;
        let idT = cliente.id_tamaño;

        /*
        console.log(idI);
        console.log(idU);
        console.log(idT);
        */
        
        /**
         * parametos de la persona
         */
        let {
            nomC,
            apeC,
            apeC2,
            dniC,
            telfC,
            mailC,
            pass,
            pass1,
            busto,
            cintura,
            cadera
        } = req.body;

        if (pass == pass1){
            const rows = await pool.query('SELECT * FROM user_cliente WHERE mailC = ?', [mailC]);
            if (!(rows.length > 0)){
                /**
                 * Actualizar usuario
                 */
                const editU = {
                    mailC,
                    pass
                };
                editU.pass = await helpers.encryptPassword(editU.pass);
                await pool.query("UPDATE user_cliente SET ? WHERE id = ?",[editU,idU]);
                /**
                 * Actulizar info
                 */
                const editI = {
                    nomC,
                    apeC,
                    apeC2,
                    dniC,
                    telfC
                };

                await pool.query("UPDATE info_cliente SET ? WHERE id = ?",[editI,idI]);

                /**
                 * Actualizar medida
                 */
                if (idT != undefined || idT != null) {
                    busto = parseFloat(busto).toFixed(2);
                    cintura = parseFloat(cintura).toFixed(2);
                    cadera = parseFloat(cadera).toFixed(2);
                    //console.log('idT != null');
                    const editT = {
                        busto,
                        cintura,
                        cadera
                    };
                    await pool.query("UPDATE tamaño SET ? WHERE id = ?",[editT,idT]);
                } else {
                    busto = parseFloat(busto).toFixed(2);
                    cintura = parseFloat(cintura).toFixed(2);
                    cadera = parseFloat(cadera).toFixed(2);

                    const editT = {
                        busto,
                        cintura,
                        cadera
                    };

                    const nuevoT = await pool.query("INSERT INTO tamaño SET ?",[editT]);
                    editT.id = nuevoT.insertId;
                    idT = editT.id;

                    /**
                     * Actualizar cliente
                     */
                    const editC = {
                        id_info:idI,
                        id_user:idU,
                        id_tamaño:idT
                    };

                    await pool.query("UPDATE cliente SET ? WHERE id = ?",[editC,id]);
                }
                
            }else{
                //el usuario no existe
                //res.redirect('/perfil/editar/' + id);
            }
            //res.status(200).json({message: 'todo ok'});
            //res.redirect('/perfil/');
        } else {
            //contraseñas no coinciden
        }
    }else{
        //el cliente no existe
        //res.redirect('/perfil/editar/' + id);
        //res.status(200).json({message: 'todo mal'});
    }
    res.redirect('/perfil/editar/' + id);
}

const eliminar = async(req, res) => {
    const { id } = req.params;
    res.redirect('/perfil');
}

module.exports = { usuarioGet, usuarioPost, editarGet, editarPost, eliminar };