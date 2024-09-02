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
-- -----------------------------------------------------
-- Schema LemonDatabase
-- -----------------------------------------------------
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bookings` (
  `idBookings` INT NOT NULL AUTO_INCREMENT,
  `Date` DATETIME NOT NULL,
  `TableNumber` INT NOT NULL,
  PRIMARY KEY (`idBookings`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customer` (
  `idCustomer` INT NOT NULL,
  `fullName` VARCHAR(200) NULL,
  `ContactNumber` VARCHAR(45) NULL,
  `Email` VARCHAR(255) NULL,
  PRIMARY KEY (`idCustomer`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Orders` (
  `idOrders` INT NOT NULL,
  `Date` DATETIME NULL,
  `Quantity` INT NULL,
  `TotalCost` DECIMAL(10,2) NULL,
  `customerId` INT NULL,
  `menuId` INT NULL,
  `deliveryId` INT NULL,
  PRIMARY KEY (`idOrders`),
  CONSTRAINT `BookingsId`
    FOREIGN KEY ()
    REFERENCES `mydb`.`Bookings` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `customerId`
    FOREIGN KEY ()
    REFERENCES `mydb`.`Customer` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DeliveryStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DeliveryStatus` (
  `idDeliveryStatus` INT NOT NULL,
  `DeliveryDate` DATETIME NULL,
  PRIMARY KEY (`idDeliveryStatus`),
  CONSTRAINT `delivery`
    FOREIGN KEY (`idDeliveryStatus`)
    REFERENCES `mydb`.`Orders` (`idOrders`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Menu` (
  `idMenu` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Description` VARCHAR(200) NULL,
  `Menucol` VARCHAR(45) NULL,
  PRIMARY KEY (`idMenu`),
  CONSTRAINT `order`
    FOREIGN KEY (`idMenu`)
    REFERENCES `mydb`.`Orders` (`idOrders`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Staff` (
  `idStaff` INT NOT NULL,
  `fullName` VARCHAR(45) NULL,
  `contactNumber` VARCHAR(45) NULL,
  `Role` VARCHAR(45) NULL,
  `Salary` DECIMAL(10,2) NULL,
  `customerId` INT NULL,
  PRIMARY KEY (`idStaff`),
  INDEX `customerId_idx` (`customerId` ASC) VISIBLE,
  CONSTRAINT `customerId`
    FOREIGN KEY (`customerId`)
    REFERENCES `mydb`.`Customer` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
