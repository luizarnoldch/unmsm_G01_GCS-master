const passport = require('passport');
const pool = require('../database');
const {transporter} = require('../lib/mailer');
const helpers = require('../lib/helpers');
const { getMaxListeners } = require('../database');

/**
 * GET: registro de usuario
 */
const Rget = async(req, res) => {
    res.render('auten/registro');
}


/**
 * GET: inicio de cesion
 */
const Iget = async(req, res) => {
    res.render('auten/ingreso');
}


/**
 * GET + POST: recuperar contraseña
 * Rp : recuperar contraseña
 */
const Rpget = async(req,res) =>{
    res.render('auten/recuperar_pass');
}

const Rppost = async(req,res) =>{
    const {mailC} = req.body;
    let host = req.hostname;
    let subhost = req.subdomains;
    subhost = subhost[0];
    const usuario = await pool.query('SELECT * FROM user_cliente WHERE mailC = ?',[mailC]);
    const user = usuario[0];
    /*
    console.log(user.mailC);
    console.log(host);
    console.log(req.originalUrl);
    console.log(req.subdomains)
    */
    if(usuario.length > 0){
        /**
         * Enviar contraseña a su correo
         */
        try{
            await transporter.sendMail({
                from: "'Recuperación de contraseña' <g1.gcs.unmsm@gmail.com>",
                //to: user.mailC,
                to: user.mailC, 
                subject: 'Recuperación de contraseña',
                html: 
                    `
                    <table
                        style="
                        max-width: 600px;
                        padding: 10px;
                        margin: 0 auto;
                        border-collapse: collapse;
                        "
                    >
                        <tr>
                        <td style="background-color: white; text-align: center; padding: 0">
                            <img
                            style="display: block; margin: 2% 0%"
                            src="https://i.postimg.cc/G2jFSRZZ/Portada-Cambio-Contrase-a-2.png"
                            />
                        </td>
                        </tr>
                        <tr>
                        <td style="background-color: white">
                            <div
                            style="
                                color: black;
                                margin: 4% 10% 4%;
                                text-align: justify;
                                font-family: sans-serif;
                            "
                            >
                            <h2 style="color: black; margin: 0 0 7px; font-size: 30px">
                                ¡Hola, Petición aprobada!
                            </h2>
                            <p style="margin: 2px; font-size: 15px">
                                ¡Hubo una solicitud para cambiar su contraseña!<br />
                                Si no realizó esta solicitud, ignore este correo electrónico.<br />
                                De lo contrario, haga clic en este botón para cambiar su
                                contraseña:<br /><br />
                            </p>
                            <a href="http://localhost:5500/cambio-pass">
                                <img
                                style="display: block"
                                src="https://i.postimg.cc/bwsS16KP/Bot-n-cambio-contrase-a-5.png"
                                />
                            </a>
                            <br />
                            <img
                                style="display: block"
                                src="https://i.postimg.cc/HxBMCjK0/Portada-Cambio-Contrase-a-7.png"
                            />
                            </div>
                        </td>
                        </tr>
                        <tr>
                        <td style="background-color: white; text-align: center; padding: 0">
                            <img
                            style="display: block; margin: 2% 0%"
                            src="https://i.postimg.cc/4dWvPKNH/Portada-Cambio-Contrase-a-3.png"
                            />
                        </td>
                        </tr>
                    </table>
                    `
                // falta método de recuperar contraseña
            });
        } catch (error) {
            emailStatus = error;
            return res.status(400).json({ 
                message:'Algo salio mal',
                error: emailStatus
            });
        }
        res.redirect('/ingreso');
    } else {
        res.status(400).json({
            message: 'No se envio el correo',
            mailC: `${mailC}`
        });
        /**
         * req.flash('El usuario no ha sido registrado');
         */
    }
    //res.redirect('/ingreso');
}

/**
 * GET + POST: cambio de contraseña
 */
const Cget = async(req, res) => {
    res.render('auten/cambio_pass');
}

const Cpost = async(req, res) => {
    //const { id } = req.params;
    //const { id } = req.user.id;
    //const user = pool.query("SELECT * FROM cliente WHERE id = ?",[id]);
    //const userid = user[0].id_user;

    const { mailC,pass } = req.body;
    pass = await helpers.encryptPassword(pass);
    await pool.query("UPDATE user_cliente set pass = ? WHERE mailC = ?",[pass,mailC]);
    //await pool.query("UPDATE user_cliente set pass = ? WHERE id = ?",[pass,userid]);
    res.redirect('/ingreso');
}

/**
 * GET: Cerrar Sesion
 */
const Out = async(req, res, next) => {
    req.logOut();
    res.redirect('/');
}

module.exports = { Rget, Iget, Cget, Cpost, Rpget, Rppost, Out };