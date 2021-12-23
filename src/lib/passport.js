const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;

const pool = require('../database');
const helpers = require('./helpers');

passport.use('local.signin', new LocalStrategy({
    usernameField: 'mailC',
    passwordField: 'pass',
    passReqToCallback: true
}, async(req, mailC, pass, done) => {
    const rows = await pool.query('SELECT * FROM user_cliente WHERE mailC = ?', [mailC]);
    if (rows.length > 0) {
        const user = rows[0];
        const validPassword = await helpers.matchPassword(pass, user.pass);
        if (validPassword) {
            done(null, user);
        } else {
            done(null, false);
        }
    } else {
        return done(null, false);
    }
}));

passport.use('local.signup', new LocalStrategy({
    usernameField: 'mailC',
    passwordField: 'pass',
    passReqToCallback: true
}, async(req, mailC, pass, done) => {
    const { 
        nomC,
        apeC,
        apeC2,
        dniC,
        telfC 
    } = req.body;
    
    const Info = {
        nomC,
        apeC,
        apeC2,
        dniC,
        telfC
    };

    const User = {
        mailC,
        pass
    };

    
    const rows = await pool.query('SELECT * FROM user_cliente WHERE mailC = ?', [mailC]);
    if (rows.length > 0) {
        return done(null,false);
    } else {
        /**
         * Insertar Info + Recoger ID de Info
         */
        const infoCliente = await pool.query("INSERT INTO info_cliente SET ?",[Info]);
        const idInfoCliente= infoCliente.insertId;
        /**
         * Insertar usuario + Recorger ID de usuario
         */
        User.pass = await helpers.encryptPassword(pass);
        const userCliente = await pool.query("INSERT INTO user_cliente SET ?",[User]);
        const idUserCliente = userCliente.insertId;
        /**
         * Insetar info + usuario -> cliente
         */
        let newUser = {
            id_info: idInfoCliente,
            id_user: idUserCliente,
            id_tamaño: null
        }
        
        const result = await pool.query("INSERT INTO cliente SET ?",[newUser]);
        newUser.id = result.insertId;
        return done(null, newUser);
    }
}));

passport.serializeUser((user, done) => {
    done(null, user.id);
});

passport.deserializeUser(async(id, done) => {
    const rows = await pool.query('SELECT * FROM user_cliente WHERE id = ?', [id]);
    done(null, rows[0]);
});