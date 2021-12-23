const express = require('express');
const pool = require('../database');
const fs = require('fs');
const path = require('path');

//VESTIDOS
const G_vestidos = async(req, res) => {

    const prenda = "descripcion = 'vestido' ";
    const Panel = [{
        descripcion: "Vestidos"
    }];
    //Este codigo llama a las prendas
    const Modelos = await pool.query(
    `
        SELECT
            prenda.id,
            estilos.estilo,
            precios.precio,
            descripciones.descripcion,
            modelos.modelo,
            colores.color
        FROM
            prenda
                INNER JOIN estilos
                    ON prenda.id_estilos = estilos.id
                INNER JOIN precios
                    ON prenda.id_precios = precios.id
                INNER JOIN descripciones
                    ON prenda.id_descripciones = descripciones.id
                INNER JOIN modelos
                    ON prenda.id_modelos = modelos.id
                INNER JOIN colores
                    ON modelos.id_colores = colores.id
        WHERE
            ${prenda}
    `);

    res.render('prenda/prenda',{Modelos,panel: Panel[0]});
}

const P_vestidos = async(req, res) => {

}

const G_vestidos_und = async(req, res) => {
    const { id } = req.params;
    console.log(id);
    let prenda = "descripcion = 'vestido' ";

    const Modelo = await pool.query(
    `
        SELECT
            prenda.id,
            estilos.estilo,
            precios.precio,
            descripciones.descripcion,
            modelos.modelo,
            colores.color
        FROM
            prenda
                INNER JOIN estilos
                    ON prenda.id_estilos = estilos.id
                INNER JOIN precios
                    ON prenda.id_precios = precios.id
                INNER JOIN descripciones
                    ON prenda.id_descripciones = descripciones.id
                INNER JOIN modelos
                    ON prenda.id_modelos = modelos.id
                INNER JOIN colores
                    ON modelos.id_colores = colores.id
        WHERE
            descripcion = 'vestido' AND  prenda.id = '${id}'
    `);

    res.render('prenda/prenda_und',{modelo:Modelo[0]});
}

const P_vestidos_und = async(req, res) => {

}


//POLOS
const G_polos = async(req, res) => {

    const prenda = "descripcion = 'polo' ";
    const Panel = [{
        descripcion: "Polos"
    }];
    //Este codigo llama a las prendas
    const Modelos = await pool.query(
    `
        SELECT
            prenda.id,
            estilos.estilo,
            precios.precio,
            descripciones.descripcion,
            modelos.modelo,
            colores.color
        FROM
            prenda
                INNER JOIN estilos
                    ON prenda.id_estilos = estilos.id
                INNER JOIN precios
                    ON prenda.id_precios = precios.id
                INNER JOIN descripciones
                    ON prenda.id_descripciones = descripciones.id
                INNER JOIN modelos
                    ON prenda.id_modelos = modelos.id
                INNER JOIN colores
                    ON modelos.id_colores = colores.id
        WHERE
            ${prenda}
    `);
    res.render('prenda/prenda',{Modelos,panel: Panel[0]});
}

const P_polos = async(req, res) => {

}

const G_polos_und = async(req, res) => {
    res.render('prenda/prenda_und');
}

const P_polos_und = async(req, res) => {

}


//CASACAS
const G_casacas = async(req, res) => {
    const prenda = "descripcion = 'casaca' ";
    const Panel = [{
        descripcion: "Casacas"
    }];
    //Este codigo llama a las prendas
    const Modelos = await pool.query(
    `
        SELECT
            prenda.id,
            estilos.estilo,
            precios.precio,
            descripciones.descripcion,
            modelos.modelo,
            colores.color
        FROM
            prenda
                INNER JOIN estilos
                    ON prenda.id_estilos = estilos.id
                INNER JOIN precios
                    ON prenda.id_precios = precios.id
                INNER JOIN descripciones
                    ON prenda.id_descripciones = descripciones.id
                INNER JOIN modelos
                    ON prenda.id_modelos = modelos.id
                INNER JOIN colores
                    ON modelos.id_colores = colores.id
        WHERE
            ${prenda}
    `);
    res.render('prenda/prenda',{Modelos,panel: Panel[0]});
}

const P_casacas = async(req, res) => {

}

const G_casacas_und = async(req, res) => {
    res.render('prenda/prenda_und');
}

const P_casacas_und = async(req, res) => {

}


//BLUSAS
const G_blusas = async(req, res) => {
    const prenda = "descripcion = 'blusa' ";
    const Panel = [{
        descripcion: "Blusas"
    }];
    //Este codigo llama a las prendas
    const Modelos = await pool.query(
    `
        SELECT
            prenda.id,
            estilos.estilo,
            precios.precio,
            descripciones.descripcion,
            modelos.modelo,
            colores.color
        FROM
            prenda
                INNER JOIN estilos
                    ON prenda.id_estilos = estilos.id
                INNER JOIN precios
                    ON prenda.id_precios = precios.id
                INNER JOIN descripciones
                    ON prenda.id_descripciones = descripciones.id
                INNER JOIN modelos
                    ON prenda.id_modelos = modelos.id
                INNER JOIN colores
                    ON modelos.id_colores = colores.id
        WHERE
            ${prenda}
    `);
    res.render('prenda/prenda',{Modelos,panel: Panel[0]});
}

const P_blusas = async(req, res) => {

}

const G_blusas_und = async(req, res) => {
    res.render('prenda/prenda_und');
}

const P_blusas_und = async(req, res) => {

}


//CHOMPAS
const G_chompas = async(req, res) => {
    const prenda = "descripcion = 'chompa' ";
    const Panel = [{
        descripcion: "Chompas"
    }];
    //Este codigo llama a las prendas
    const Modelos = await pool.query(
    `
        SELECT
            prenda.id,
            estilos.estilo,
            precios.precio,
            descripciones.descripcion,
            modelos.modelo,
            colores.color
        FROM
            prenda
                INNER JOIN estilos
                    ON prenda.id_estilos = estilos.id
                INNER JOIN precios
                    ON prenda.id_precios = precios.id
                INNER JOIN descripciones
                    ON prenda.id_descripciones = descripciones.id
                INNER JOIN modelos
                    ON prenda.id_modelos = modelos.id
                INNER JOIN colores
                    ON modelos.id_colores = colores.id
        WHERE
            ${prenda}
    `);
    res.render('prenda/prenda',{Modelos,panel: Panel[0]});
}

const P_chompas = async(req, res) => {
}

const G_chompas_und = async(req, res) => {
    res.render('prenda/prenda_und');
}

const P_chompas_und = async(req, res) => {
}

//JEANS
const G_jeans = async(req, res) => {
    const prenda = "descripcion = 'jean' ";
    const Panel = [{
        descripcion: "Jeans"
    }];
    //Este codigo llama a las prendas
    const Modelos = await pool.query(
    `
        SELECT
            prenda.id,
            estilos.estilo,
            precios.precio,
            descripciones.descripcion,
            modelos.modelo,
            colores.color
        FROM
            prenda
                INNER JOIN estilos
                    ON prenda.id_estilos = estilos.id
                INNER JOIN precios
                    ON prenda.id_precios = precios.id
                INNER JOIN descripciones
                    ON prenda.id_descripciones = descripciones.id
                INNER JOIN modelos
                    ON prenda.id_modelos = modelos.id
                INNER JOIN colores
                    ON modelos.id_colores = colores.id
        WHERE
            ${prenda}
    `);
    res.render('prenda/prenda',{Modelos,panel: Panel[0]});
}

const P_jeans = async(req, res) => {

}

const G_jeans_und = async(req, res) => {
    res.render('prenda/prenda_und');
}

const P_jeans_und = async(req, res) => {

}


//FALDAS
const G_faldas = async(req, res) => {
    const prenda = "descripcion = 'falda' ";
    const Panel = [{
        descripcion: "Faldas"
    }];
    //Este codigo llama a las prendas
    const Modelos = await pool.query(
    `
        SELECT
            prenda.id,
            estilos.estilo,
            precios.precio,
            descripciones.descripcion,
            modelos.modelo,
            colores.color
        FROM
            prenda
                INNER JOIN estilos
                    ON prenda.id_estilos = estilos.id
                INNER JOIN precios
                    ON prenda.id_precios = precios.id
                INNER JOIN descripciones
                    ON prenda.id_descripciones = descripciones.id
                INNER JOIN modelos
                    ON prenda.id_modelos = modelos.id
                INNER JOIN colores
                    ON modelos.id_colores = colores.id
        WHERE
            ${prenda}
    `);
    res.render('prenda/prenda',{Modelos,panel: Panel[0]});
}

const P_faldas = async(req, res) => {

}

const G_faldas_und = async(req, res) => {
    res.render('prenda/prenda_und');
}

const P_faldas_und = async(req, res) => {

}

module.exports = {
    G_casacas,
    P_casacas,
    G_casacas_und,
    P_casacas_und,
    G_vestidos,
    P_vestidos,
    G_vestidos_und,
    P_vestidos_und,
    G_polos,
    P_polos,
    G_polos_und,
    P_polos_und,
    G_blusas,
    P_blusas,
    G_blusas_und,
    P_blusas_und,
    G_chompas,
    P_chompas,
    G_chompas_und,
    P_chompas_und,
    G_jeans,
    P_jeans,
    G_jeans_und,
    P_jeans_und,
    G_faldas,
    P_faldas,
    G_faldas_und,
    P_faldas_und
};