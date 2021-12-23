const express = require('express');
const router = express.Router();
const pool = require('../database');
const Formulario = require('../controllers/formulario.controller');

//CARRITO DE COMPRAS
router.get('/prenda/Carrito', Formulario.G_carrito);
router.post('/prenda/Carrito', Formulario.P_carrito);

//FORMULARIO DE DATOS
router.get('/prenda/FormularioDato', Formulario.G_formulario_datos);
router.post('/prenda/FormularioDato', Formulario.P_formulario_datos);

//FORMULARIO DE ENVIO
router.get('/prenda/FormularioEnvio', Formulario.G_formulario_envio);
router.post('/prenda/FormularioEnvio', Formulario.P_formulario_envio);

//FORMULARIO DE PAGO
router.get('/prenda/FormularioPago', Formulario.G_formulario_pago);
router.post('/prenda/FormularioPago', Formulario.P_formulario_pago);

module.exports = router;