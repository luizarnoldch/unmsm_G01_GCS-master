-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`etiquetas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`etiquetas` (
  `idetiquetas` INT NOT NULL,
  `modelo` VARCHAR(45) NOT NULL,
  `color` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idetiquetas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`imagenes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`imagenes` (
  `idimagenes` INT NOT NULL,
  `ruta` LONGBLOB NOT NULL,
  PRIMARY KEY (`idimagenes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Producto` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(255) NOT NULL,
  `descripcion` VARCHAR(1024) NOT NULL,
  `precioProd` DECIMAL(10,2) NOT NULL,
  `etiquetas_idcaracteristicas` INT NOT NULL,
  `imagenes_idimagenes` INT NOT NULL,
  PRIMARY KEY (`idProducto`),
  INDEX `fk_Producto_etiquetas1_idx` (`etiquetas_idcaracteristicas` ASC) VISIBLE,
  INDEX `fk_Producto_imagenes1_idx` (`imagenes_idimagenes` ASC) VISIBLE,
  CONSTRAINT `fk_Producto_etiquetas1`
    FOREIGN KEY (`etiquetas_idcaracteristicas`)
    REFERENCES `mydb`.`etiquetas` (`idetiquetas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_imagenes1`
    FOREIGN KEY (`imagenes_idimagenes`)
    REFERENCES `mydb`.`imagenes` (`idimagenes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Medidas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medidas` (
  `idMedidas` INT NOT NULL,
  `altura` DECIMAL(10,2) NOT NULL,
  `busto` DECIMAL(10,2) NOT NULL,
  `cintura` DECIMAL(10,2) NOT NULL,
  `cadera` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idMedidas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nomC` VARCHAR(20) NOT NULL,
  `apeC` VARCHAR(20) NOT NULL,
  `apeC2` VARCHAR(20) NOT NULL,
  `dniC` VARCHAR(20) NOT NULL,
  `telfC` VARCHAR(20) NOT NULL,
  `mailC` VARCHAR(20) NOT NULL,
  `pass` VARCHAR(20) NOT NULL,
  `Medidas_idMedidas` INT NOT NULL,
  PRIMARY KEY (`idCliente`),
  INDEX `fk_Cliente_Medidas1_idx` (`Medidas_idMedidas` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Medidas1`
    FOREIGN KEY (`Medidas_idMedidas`)
    REFERENCES `mydb`.`Medidas` (`idMedidas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Carrito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Carrito` (
  `id_sesion` VARCHAR(255) NOT NULL,
  `cantidad` DECIMAL(2) NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Producto_idProducto` INT NOT NULL,
  PRIMARY KEY (`id_sesion`),
  INDEX `fk_Carrito_Cliente_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Carrito_Producto1_idx` (`Producto_idProducto` ASC) VISIBLE,
  CONSTRAINT `fk_Carrito_Cliente`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Carrito_Producto1`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `mydb`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`entrega` (
  `identrega` INT NOT NULL,
  `direccion` VARCHAR(20) NOT NULL,
  `numeroEncargado` VARCHAR(20) NOT NULL,
  `nomEncargado` VARCHAR(45) NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`identrega`),
  INDEX `fk_entrega_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_entrega_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`orden`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`orden` (
  `idorden` INT NOT NULL,
  `total` DECIMAL(10,2) NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `entrega_identrega` INT NOT NULL,
  PRIMARY KEY (`idorden`),
  INDEX `fk_orden_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_orden_entrega1_idx` (`entrega_identrega` ASC) VISIBLE,
  CONSTRAINT `fk_orden_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orden_entrega1`
    FOREIGN KEY (`entrega_identrega`)
    REFERENCES `mydb`.`entrega` (`identrega`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`detalleOrden`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`detalleOrden` (
  `iddetalleOrden` INT NOT NULL,
  `cantOrd` INT NOT NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  `descuento` DECIMAL(10,2) NULL,
  `aumento` DECIMAL(10,2) NULL,
  `orden_idorden` INT NOT NULL,
  `Producto_idProducto` INT NOT NULL,
  PRIMARY KEY (`iddetalleOrden`),
  INDEX `fk_detalleOrden_orden1_idx` (`orden_idorden` ASC) VISIBLE,
  INDEX `fk_detalleOrden_Producto1_idx` (`Producto_idProducto` ASC) VISIBLE,
  CONSTRAINT `fk_detalleOrden_orden1`
    FOREIGN KEY (`orden_idorden`)
    REFERENCES `mydb`.`orden` (`idorden`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalleOrden_Producto1`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `mydb`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`metodoPago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`metodoPago` (
  `idmetodoPago` INT NOT NULL AUTO_INCREMENT,
  `claveTransaccion` VARCHAR(250) NOT NULL,
  `paypalDatos` LONGTEXT NOT NULL,
  `fecha` DATETIME(6) NOT NULL,
  `status` VARCHAR(20) NOT NULL,
  `detalleOrden_iddetalleOrden` INT NOT NULL,
  PRIMARY KEY (`idmetodoPago`),
  INDEX `fk_metodoPago_detalleOrden1_idx` (`detalleOrden_iddetalleOrden` ASC) VISIBLE,
  CONSTRAINT `fk_metodoPago_detalleOrden1`
    FOREIGN KEY (`detalleOrden_iddetalleOrden`)
    REFERENCES `mydb`.`detalleOrden` (`iddetalleOrden`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`valoraciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`valoraciones` (
  `idvaloraciones` INT NOT NULL,
  `comentarios` VARCHAR(255) NOT NULL,
  `estrellas` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Producto_idProducto` INT NOT NULL,
  PRIMARY KEY (`idvaloraciones`),
  INDEX `fk_valoraciones_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_valoraciones_Producto1_idx` (`Producto_idProducto` ASC) VISIBLE,
  CONSTRAINT `fk_valoraciones_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_valoraciones_Producto1`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `mydb`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
