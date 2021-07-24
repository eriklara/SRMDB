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
-- Table `mydb`.`sale_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sale_product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `key` VARCHAR(100) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `price` VARCHAR(100) NOT NULL,
  `model` VARCHAR(100) NULL,
  `stock` INT NOT NULL,
  `type` VARCHAR(10) NOT NULL,
  `status` VARCHAR(10) NOT NULL,
  `qr_code` VARCHAR(1500) NULL,
  `discount_percent` INT NULL,
  `lot` VARCHAR(45) NOT NULL,
  `update_date` DATE NULL,
  `create_date` DATE NULL,
  `fk_store_id` INT NULL,
  `fk_providerId` INT NULL,
  `fk_create_user_id` INT NULL,
  `fk_image_id` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`stock_inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`stock_inventory` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NULL,
  `state` VARCHAR(45) NOT NULL,
  `exhausted` TINYINT NULL,
  `product_qty` INT NOT NULL,
  `inventory_date` DATE NOT NULL,
  `company_id` INT NULL,
  `location_id` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`stock_location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`stock_location` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'locación de inventario',
  `name` VARCHAR(45) NOT NULL,
  `full_name` VARCHAR(100) NOT NULL,
  `status` VARCHAR(3) NOT NULL,
  `comment` VARCHAR(45) NULL,
  `pos_x` INT NULL,
  `pos_y` INT NULL,
  `pos_z` INT NULL,
  `company_id` INT NULL,
  `create_uid` INT NULL,
  `create_date` DATE NULL,
  `update_date` DATE NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`stock_warehouse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`stock_warehouse` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(3) NULL,
  `company_id` INT NULL,
  `loc_stock_id` INT NOT NULL,
  `wh_input_stock` INT NOT NULL,
  `wh_output_stock` INT NOT NULL,
  `create_uid` INT NULL,
  `create_date` DATE NULL,
  `update_date` DATE NULL,
  PRIMARY KEY (`id`),
  INDEX `stock_warehouse_location_id_fkey_idx` (`loc_stock_id` ASC) VISIBLE,
  CONSTRAINT `stock_warehouse_location_id_fkey`
    FOREIGN KEY (`loc_stock_id`)
    REFERENCES `mydb`.`stock_location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`stock_backorder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`stock_backorder` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NULL,
  `picking_id` INT NULL,
  `status` VARCHAR(3) NULL,
  `description` VARCHAR(500) NULL,
  `create_uid` INT NULL,
  `create_date` DATE NULL,
  `update_date` DATE NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`stock_picking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`stock_picking` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(45) NULL,
  `origin` VARCHAR(45) NULL,
  `note` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `priority` TINYINT NULL,
  `scheduled_date` DATE NULL,
  `date_deadline` DATE NULL,
  `has_deadline_issue` TINYINT NULL,
  `date_done` DATE NULL,
  `fk_company_id` INT NULL,
  `fk_user_id` INT NULL,
  `fk_backorder_id` INT NULL,
  `is_labeled` TINYINT NULL,
  `is_locked` TINYINT NULL,
  `immediate_transfer` TINYINT NULL,
  `fk_create_user_id` INT NULL,
  `create_date` DATE NULL,
  `update_date` DATE NULL,
  `fk_sale_id` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`stock_scrap`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`stock_scrap` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NULL,
  `company_id` INT NULL,
  `scrap_qty` INT NULL,
  `state` VARCHAR(45) NULL,
  `move_id` INT NULL,
  `date_done` DATE NULL,
  `create_uid` INT NULL,
  `create_date` DATE NULL,
  `update_date` DATE NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`stock_move`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`stock_move` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NULL,
  `company_id` INT NULL,
  `priority` TINYINT NULL,
  `stock_movecol` VARCHAR(45) NULL,
  `description_picking` VARCHAR(45) NULL,
  `product_qty` INT NULL,
  `location_id` INT NULL,
  `inventory_id` INT NULL,
  `warehouse_id` INT NULL,
  `origin` VARCHAR(45) NULL,
  `picking_id` INT NULL,
  `cancel_move` TINYINT NULL,
  `delay_alert_date` DATE NULL,
  `reference` VARCHAR(45) NULL,
  `sale_id` INT NULL,
  `create_uid` INT NULL,
  `create_date` DATE NULL,
  `update_date` DATE NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`stock_immediate_transfer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`stock_immediate_transfer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `picking_id` INT NULL,
  `to_immediate` TINYINT NULL,
  `show_transfers` TINYINT NULL,
  `create_uid` INT NULL,
  `create_date` DATE NULL,
  `update_date` DATE NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`stock_orderpoint_snooze`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`stock_orderpoint_snooze` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `predefined_date` DATE NULL,
  `snoozed_until` DATE NULL,
  `create_uid` INT NULL,
  `create_date` DATE NULL,
  `update_date` DATE NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`stock_warehouse_orderpoint`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`stock_warehouse_orderpoint` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `status` VARCHAR(3) NULL,
  `snoozed_until` DATE NULL,
  `warehouse_id` INT NULL,
  `location_id` INT NULL,
  `product_id` INT NULL,
  `product_min_qty` INT NULL,
  `product_max_qty` INT NULL,
  `company_id` INT NULL,
  `qty_to_order` INT NULL,
  `create_uid` INT NULL,
  `create_date` DATE NULL,
  `update_date` DATE NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`sale_product_stock_warehouse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sale_product_stock_warehouse` (
  `product_id` INT NULL,
  `warehouse_id` INT NULL,
  INDEX `stock_warehouse_id_fkey_idx` (`warehouse_id` ASC, `product_id` ASC) VISIBLE,
  CONSTRAINT `product_warehouse_warehouse_id_fkey`
    FOREIGN KEY (`warehouse_id` , `product_id`)
    REFERENCES `mydb`.`stock_warehouse` (`id` , `id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `product_warehouse_product_id_fkey`
    FOREIGN KEY ()
    REFERENCES `mydb`.`sale_product` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
