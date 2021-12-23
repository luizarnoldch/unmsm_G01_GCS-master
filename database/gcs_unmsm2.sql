CREATE SCHEMA `heroku_7acd253dba63c7f`;

USE `heroku_7acd253dba63c7f`;

CREATE TABLE `heroku_7acd253dba63c7f`.`info_cliente` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `nomC` VARCHAR(255) NOT NULL,
    `apeC` VARCHAR(255) NOT NULL,
    `apeC2` VARCHAR(255) NULL,
    `dniC` INT NOT NULL,
    `telC` INT NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `heroku_7acd253dba63c7f`.`user_cliente` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `mailC` VARCHAR(255) NOT NULL UNIQUE,
    `pass` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `heroku_7acd253dba63c7f`.`tamaño` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `busto` DECIMAL(10,2) NOT NULL,
    `cintura` DECIMAL(10,2) NOT NULL,
    `cadera` DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `heroku_7acd253dba63c7f`.`cliente` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `id_info` INT NOT NULL,
    `id_user` INT NOT NULL,
    `id_tamaño` INT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_cliente_info_idx` (`id_info` ASC) ,
    INDEX `fk_cliente_user_idx` (`id_user` ASC) ,
    INDEX `fk_cliente_tamaño_idx` (`id_tamaño` ASC) ,
    CONSTRAINT `fk_cliente_info`
        FOREIGN KEY (`id_info`)
        REFERENCES `heroku_7acd253dba63c7f`.`info_cliente` (`id`)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT `fk_cliente_user`
        FOREIGN KEY (`id_user`)
        REFERENCES `heroku_7acd253dba63c7f`.`user_cliente` (`id`)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT `fk_cliente_tamaño`
        FOREIGN KEY (`id_tamaño`)
        REFERENCES `heroku_7acd253dba63c7f`.`tamaño` (`id`)
        ON DELETE CASCADE
        ON UPDATE CASCADE);

CREATE TABLE `heroku_7acd253dba63c7f`.`colores` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `color` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `heroku_7acd253dba63c7f`.`modelos` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`modelo` VARCHAR(45) NOT NULL,
	`id_colores` INT NOT NULL,
	`ruta_imagen` LONGBLOB NOT NULL,
	PRIMARY KEY (`id`),
	INDEX `modelos_colores_idx` (`id_colores` ASC) ,
	CONSTRAINT `modelos_colores`
		FOREIGN KEY (`id_colores`)
		REFERENCES `heroku_7acd253dba63c7f`.`colores` (`id`)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE `heroku_7acd253dba63c7f`.`comentarios` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `estrellas` INT NULL,
    `comentario` VARCHAR(255) NULL,
    `id_cliente` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_id_cliente_prenda_idx` (`id_cliente` ASC),
    CONSTRAINT `fk_id_cliente_prenda`
        FOREIGN KEY (`id_cliente`)
        REFERENCES `heroku_7acd253dba63c7f`.`cliente` (`id`)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE `heroku_7acd253dba63c7f`.`descripciones` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `descripcion` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `heroku_7acd253dba63c7f`.`estilos` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `estilo` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `heroku_7acd253dba63c7f`.`precios` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `precio` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
);


CREATE TABLE `heroku_7acd253dba63c7f`.`prenda` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`cantidad` INT NOT NULL,
	`id_estilos` INT NOT NULL,
	`id_precios` INT NOT NULL,
	`id_descripciones` INT NOT NULL,
	`id_tamaños` INT NOT NULL,
	`id_modelos` INT NOT NULL,
	`id_comentarios` INT,
	PRIMARY KEY (`id`),
	INDEX `prenda_precio_idx` (`id_precios` ASC) ,
	INDEX `prenda_estilo_idx` (`id_estilos` ASC) ,
	INDEX `prenda_descripcion_idx` (`id_descripciones` ASC) ,
	INDEX `prenda_tamaño_idx` (`id_tamaños` ASC) ,
	INDEX `prenda_modelo_idx` (`id_modelos` ASC) ,
	INDEX `prenda_comentario_idx` (`id_comentarios` ASC) ,
	CONSTRAINT `prenda_precio`
		FOREIGN KEY (`id_precios`)
		REFERENCES `heroku_7acd253dba63c7f`.`precios` (`id`)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT `prenda_estilo`
		FOREIGN KEY (`id_estilos`)
		REFERENCES `heroku_7acd253dba63c7f`.`estilos` (`id`)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT `prenda_descripcion`
		FOREIGN KEY (`id_descripciones`)
		REFERENCES `heroku_7acd253dba63c7f`.`descripciones` (`id`)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT `prenda_tamaño`
		FOREIGN KEY (`id_tamaños`)
		REFERENCES `heroku_7acd253dba63c7f`.`tamaño` (`id`)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT `prenda_modelo`
		FOREIGN KEY (`id_modelos`)
		REFERENCES `heroku_7acd253dba63c7f`.`modelos` (`id`)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT `prenda_comentario`
		FOREIGN KEY (`id_comentarios`)
		REFERENCES `heroku_7acd253dba63c7f`.`comentarios` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION)
;

CREATE TABLE `heroku_7acd253dba63c7f`.`carrito` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `cantidad` INT NOT NULL,
    `id_prenda` INT NOT NULL,
    `id_cliente` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_carrito_prenda_idx` (`id_prenda` ASC) ,
    INDEX `fk_carrito_cliente_idx` (`id_cliente` ASC) ,
    CONSTRAINT `fk_carrito_prenda`
        FOREIGN KEY (`id_prenda`)
        REFERENCES `heroku_7acd253dba63c7f`.`prenda` (`id`)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT `fk_carrito_cliente`
        FOREIGN KEY (`id_cliente`)
        REFERENCES `heroku_7acd253dba63c7f`.`cliente` (`id`)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE `heroku_7acd253dba63c7f`.`metodos` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `metodo` VARCHAR(45) NOT NULL,
    `numeros` BIGINT NULL,
    PRIMARY KEY (`id`));

CREATE TABLE `heroku_7acd253dba63c7f`.`promociones` (
    `id` INT NOT NULL,
    `codigo` BIGINT NOT NULL,
    `porcentaje` INT NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `heroku_7acd253dba63c7f`.`pagos` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `fecha` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `monto` INT NOT NULL,
    `id_cliente` INT NOT NULL,
    `id_metodo` INT NOT NULL,
    `id_promocion` INT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_pago_cliente_idx` (`id_cliente` ASC) ,
    INDEX `fk_pago_metodo_idx` (`id_metodo` ASC) ,
    INDEX `fk_pago_promociòn_idx` (`id_promocion` ASC) ,
    CONSTRAINT `fk_pago_cliente`
        FOREIGN KEY (`id_cliente`)
        REFERENCES `heroku_7acd253dba63c7f`.`cliente` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `fk_pago_metodo`
        FOREIGN KEY (`id_metodo`)
        REFERENCES `heroku_7acd253dba63c7f`.`metodos` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `fk_pago_promociòn`
        FOREIGN KEY (`id_promocion`)
        REFERENCES `heroku_7acd253dba63c7f`.`promociones` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION);

CREATE TABLE `heroku_7acd253dba63c7f`.`orden` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `fecha_emision` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `fecha_entrega` TIMESTAMP NOT NULL,
    `dirección` VARCHAR(255) NOT NULL,
    `encargado` VARCHAR(255) NOT NULL,
    `id_pago` INT NOT NULL,
    `id_cliente` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_orden_pago_idx` (`id_pago` ASC) ,
    INDEX `fk_orden_cliente_idx` (`id_cliente` ASC) ,
    CONSTRAINT `fk_orden_pago`
        FOREIGN KEY (`id_pago`)
        REFERENCES `heroku_7acd253dba63c7f`.`pagos` (`id`)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT `fk_orden_cliente`
        FOREIGN KEY (`id_cliente`)
        REFERENCES `heroku_7acd253dba63c7f`.`cliente` (`id`)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);