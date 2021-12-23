CREATE SCHEMA `mydb`;

USE `mydb`;

CREATE TABLE `mydb`.`info_cliente` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `nomC` VARCHAR(255) NOT NULL,
    `apeC` VARCHAR(255) NOT NULL,
    `apeC2` VARCHAR(255) NULL,
    `dniC` INT NOT NULL,
    `telfC` INT NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `mydb`.`user_cliente` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `mailC` VARCHAR(255) NOT NULL UNIQUE,
    `pass` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `mydb`.`tamaño` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `busto` DECIMAL(10,2) NOT NULL,
    `cintura` DECIMAL(10,2) NOT NULL,
    `cadera` DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `mydb`.`cliente` (
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
        REFERENCES `mydb`.`info_cliente` (`id`)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT `fk_cliente_user`
        FOREIGN KEY (`id_user`)
        REFERENCES `mydb`.`user_cliente` (`id`)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT `fk_cliente_tamaño`
        FOREIGN KEY (`id_tamaño`)
        REFERENCES `mydb`.`tamaño` (`id`)
        ON DELETE CASCADE
        ON UPDATE CASCADE);

CREATE TABLE `mydb`.`colores` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `color` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `mydb`.`modelos` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`modelo` VARCHAR(45) NOT NULL,
	`id_colores` INT NOT NULL,
	`ruta_imagen` LONGBLOB NOT NULL,
	PRIMARY KEY (`id`),
	INDEX `modelos_colores_idx` (`id_colores` ASC) VISIBLE,
	CONSTRAINT `modelos_colores`
		FOREIGN KEY (`id_colores`)
		REFERENCES `mydb`.`colores` (`id`)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE `mydb`.`comentarios` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `estrellas` INT NULL,
    `comentario` VARCHAR(255) NULL,
    `id_cliente` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_id_cliente_prenda_idx` (`id_cliente` ASC),
    CONSTRAINT `fk_id_cliente_prenda`
        FOREIGN KEY (`id_cliente`)
        REFERENCES `mydb`.`cliente` (`id`)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE `mydb`.`descripciones` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `descripcion` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `mydb`.`estilos` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `estilo` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `mydb`.`precios` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `precio` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
);


CREATE TABLE `mydb`.`prenda` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`cantidad` INT NOT NULL,
	`id_estilos` INT NOT NULL,
	`id_precios` INT NOT NULL,
	`id_descripciones` INT NOT NULL,
	`id_tamaños` INT NOT NULL,
	`id_modelos` INT NOT NULL,
	`id_comentarios` INT,
	PRIMARY KEY (`id`),
	INDEX `prenda_precio_idx` (`id_precios` ASC) VISIBLE,
	INDEX `prenda_estilo_idx` (`id_estilos` ASC) VISIBLE,
	INDEX `prenda_descripcion_idx` (`id_descripciones` ASC) VISIBLE,
	INDEX `prenda_tamaño_idx` (`id_tamaños` ASC) VISIBLE,
	INDEX `prenda_modelo_idx` (`id_modelos` ASC) VISIBLE,
	INDEX `prenda_comentario_idx` (`id_comentarios` ASC) VISIBLE,
	CONSTRAINT `prenda_precio`
		FOREIGN KEY (`id_precios`)
		REFERENCES `mydb`.`precios` (`id`)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT `prenda_estilo`
		FOREIGN KEY (`id_estilos`)
		REFERENCES `mydb`.`estilos` (`id`)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT `prenda_descripcion`
		FOREIGN KEY (`id_descripciones`)
		REFERENCES `mydb`.`descripciones` (`id`)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT `prenda_tamaño`
		FOREIGN KEY (`id_tamaños`)
		REFERENCES `mydb`.`tamaño` (`id`)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT `prenda_modelo`
		FOREIGN KEY (`id_modelos`)
		REFERENCES `mydb`.`modelos` (`id`)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT `prenda_comentario`
		FOREIGN KEY (`id_comentarios`)
		REFERENCES `mydb`.`comentarios` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION)
;

CREATE TABLE `mydb`.`carrito` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `cantidad` INT NOT NULL,
    `id_prenda` INT NOT NULL,
    `id_cliente` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_carrito_prenda_idx` (`id_prenda` ASC) ,
    INDEX `fk_carrito_cliente_idx` (`id_cliente` ASC) ,
    CONSTRAINT `fk_carrito_prenda`
        FOREIGN KEY (`id_prenda`)
        REFERENCES `mydb`.`prenda` (`id`)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT `fk_carrito_cliente`
        FOREIGN KEY (`id_cliente`)
        REFERENCES `mydb`.`cliente` (`id`)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE `mydb`.`metodos` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `metodo` VARCHAR(45) NOT NULL,
    `numeros` BIGINT NULL,
    PRIMARY KEY (`id`));

CREATE TABLE `mydb`.`promociones` (
    `id` INT NOT NULL,
    `codigo` BIGINT NOT NULL,
    `porcentaje` INT NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `mydb`.`pagos` (
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
        REFERENCES `mydb`.`cliente` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `fk_pago_metodo`
        FOREIGN KEY (`id_metodo`)
        REFERENCES `mydb`.`metodos` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `fk_pago_promociòn`
        FOREIGN KEY (`id_promocion`)
        REFERENCES `mydb`.`promociones` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION);

CREATE TABLE `mydb`.`orden` (
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
        REFERENCES `mydb`.`pagos` (`id`)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT `fk_orden_cliente`
        FOREIGN KEY (`id_cliente`)
        REFERENCES `mydb`.`cliente` (`id`)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);