CREATE SCHEMA `gcs_unmsm`;

USE `gcs_unmsm`;

CREATE TABLE `gcs_unmsm`.`info_cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nomC` VARCHAR(255) NOT NULL,
  `apeC` VARCHAR(255) NOT NULL,
  `apeC2` VARCHAR(255) NULL,
  `dniC` INT NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `gcs_unmsm`.`user_cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `mailC` VARCHAR(255) NOT NULL UNIQUE,
  `pass` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `gcs_unmsm`.`tamaño` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `busto` DECIMAL(10,2) NOT NULL,
    `cintura` DECIMAL(10,2) NOT NULL,
    `cadera` DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `gcs_unmsm`.`cliente` (
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
    REFERENCES `gcs_unmsm`.`info_cliente` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cliente_user`
    FOREIGN KEY (`id_user`)
    REFERENCES `gcs_unmsm`.`user_cliente` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cliente_tamaño`
    FOREIGN KEY (`id_tamaño`)
    REFERENCES `gcs_unmsm`.`tamaño` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE `gcs_unmsm`.`modelos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `modelo` VARCHAR(255) NOT NULL,
  `color` VARCHAR(255) NOT NULL,
  `ruta_imagen` LONGBLOB NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `gcs_unmsm`.`comentarios` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `estrellas` INT NULL,
    `comentario` VARCHAR(255) NULL,
    `id_cliente` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_id_cliente_prenda_idx` (`id_cliente` ASC),
    CONSTRAINT `fk_id_cliente_prenda`
        FOREIGN KEY (`id_cliente`)
        REFERENCES `gcs_unmsm`.`cliente` (`id`)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE `gcs_unmsm`.`prenda` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `precio` DECIMAL(10,2) NOT NULL DEFAULT 0,
    `cantidad` INT NOT NULL DEFAULT 0,
    `descripcion` VARCHAR(255) NULL,
    `id_tamaño` INT NOT NULL,
    `id_modelo` INT NOT NULL,
    `id_comentario` INT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_prenda_tamaño_idx` (`id_tamaño` ASC) ,
    INDEX `fk_prenda_modelo_idx` (`id_modelo` ASC) ,
    INDEX `fk_prenda_comentario_idx` (`id_comentario` ASC) ,
    CONSTRAINT `fk_prenda_tamaño`
        FOREIGN KEY (`id_tamaño`)
        REFERENCES `gcs_unmsm`.`tamaño` (`id`)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT `fk_prenda_modelo`
        FOREIGN KEY (`id_modelo`)
        REFERENCES `gcs_unmsm`.`modelos` (`id`)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT `fk_prenda_comentario`
        FOREIGN KEY (`id_comentario`)
        REFERENCES `gcs_unmsm`.`comentarios` (`id`)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE `gcs_unmsm`.`carrito` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `cantidad` INT NOT NULL,
    `id_prenda` INT NOT NULL,
    `id_cliente` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_carrito_prenda_idx` (`id_prenda` ASC) ,
    INDEX `fk_carrito_cliente_idx` (`id_cliente` ASC) ,
    CONSTRAINT `fk_carrito_prenda`
        FOREIGN KEY (`id_prenda`)
        REFERENCES `gcs_unmsm`.`prenda` (`id`)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT `fk_carrito_cliente`
        FOREIGN KEY (`id_cliente`)
        REFERENCES `gcs_unmsm`.`cliente` (`id`)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE `gcs_unmsm`.`metodos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `metodo` VARCHAR(45) NOT NULL,
  `numeros` BIGINT NULL,
  PRIMARY KEY (`id`));

CREATE TABLE `gcs_unmsm`.`promociones` (
  `id` INT NOT NULL,
  `codigo` BIGINT NOT NULL,
  `porcentaje` INT NOT NULL,
  PRIMARY KEY (`id`));
  
CREATE TABLE `gcs_unmsm`.`pagos` (
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
    REFERENCES `gcs_unmsm`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pago_metodo`
    FOREIGN KEY (`id_metodo`)
    REFERENCES `gcs_unmsm`.`metodos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pago_promociòn`
    FOREIGN KEY (`id_promocion`)
    REFERENCES `gcs_unmsm`.`promociones` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `gcs_unmsm`.`orden` (
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
        REFERENCES `gcs_unmsm`.`pagos` (`id`)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT `fk_orden_cliente`
        FOREIGN KEY (`id_cliente`)
        REFERENCES `gcs_unmsm`.`cliente` (`id`)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);