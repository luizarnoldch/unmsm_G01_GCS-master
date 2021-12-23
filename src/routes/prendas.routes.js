const express = require('express');
const router = express.Router();
const pool = require('../database');
const Prenda = require('../controllers/prendas.controller');

//VESTIDOS
router.get('/vestidos', Prenda.G_vestidos);
router.post('/vestidos', Prenda.P_vestidos);

router.get('/vestidos/:id', Prenda.G_vestidos_und);
router.post('/vestidos/:id', Prenda.P_vestidos_und);

//POLOS
router.get('/polos', Prenda.G_polos);
router.post('/polos', Prenda.P_polos);

router.get('/polos/:id', Prenda.G_polos_und);
router.post('/polos/:id', Prenda.P_polos_und);

//CASACAS
router.get('/casacas', Prenda.G_casacas);
router.post('/casacas', Prenda.P_casacas);

router.get('/casacas/:id', Prenda.G_casacas_und);
router.post('/casacas/:id', Prenda.P_casacas_und);

//BLUSAS
router.get('/blusas', Prenda.G_blusas);
router.post('/blusas', Prenda.P_blusas);

router.get('/blusas/:id', Prenda.G_blusas_und);
router.post('/blusas/:id', Prenda.P_blusas_und);

//CHOMPAS
router.get('/chompas', Prenda.G_chompas);
router.post('/chompas', Prenda.P_chompas);

router.get('/chompas/:id', Prenda.G_chompas_und);
router.post('/chompas/:id', Prenda.P_chompas_und);

//FALDAS
router.get('/faldas', Prenda.G_faldas);
router.post('/faldas', Prenda.P_faldas);

router.get('/faldas/:id', Prenda.G_faldas_und);
router.post('/faldas/:id', Prenda.P_faldas_und);

//JEANS
router.get('/jeans', Prenda.G_jeans);
router.post('/jeans', Prenda.P_jeans);

router.get('/jeans/:id', Prenda.G_jeans_und);
router.post('/jeans/:id', Prenda.P_jeans_und);

module.exports = router;