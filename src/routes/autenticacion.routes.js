const express = require('express');
const router = express.Router();
const passport = require('passport');
const { isLoggedIn, isNotLoggedIn } = require('../lib/auth');
const Auth = require('../controllers/autenticacion.controller')

/**
 * Registro de usuario
 */
// GET
router.get('/registro', Auth.Rget);
// POST
router.post('/registro', passport.authenticate('local.signup', {
    successRedirect: '/',
    failureRedirect: '/registro',
    failureFlash: true
}));

/**
 * Inicio de sesión por usuario
 */
// GET
router.get('/ingreso',Auth.Iget);
// POST
router.post('/ingreso', (req, res, next) => {
    passport.authenticate('local.signin', {
        successRedirect: '/',
        failureRedirect: '/ingreso',
        failureFlash: true
    })(req, res, next);
});

/**
 * Cambio de Contraseña
 */
// GET
router.get('/recuperar-pass', Auth.Rpget);
// POST
router.post('/recuperar-pass', Auth.Rppost);

/**
 * Recuperar Contraseña
 */
// GET
router.get('/cambio-pass', Auth.Cget);
// POST
router.post('/cambio-pass', Auth.Cpost);

/**
 * Cerrar sessión
 */
// GET
router.get('/salir', Auth.Out);

module.exports = router;