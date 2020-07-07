# Assignment 1 #
DROP DATABASE IF EXISTS OVERHILL;
CREATE DATABASE OVERHILL;

USE OVERHILL;

-- DROP TABLES
DROP TABLE IF EXISTS PRODUCT_HISTORY;
DROP TABLE IF EXISTS CUSTOMERS;
DROP TABLE IF EXISTS DATEDIM;
DROP TABLE IF EXISTS AGENT;
DROP TABLE IF EXISTS SALES;

-- Create Tables
CREATE TABLE IF NOT EXISTS `OVERHILL`.`PRODUCTIONS` (
  `ProdID` INT NOT NULL AUTO_INCREMENT,
  `Description` VARCHAR(45) NULL,
  `Group` VARCHAR(10) NULL,
  `Year` CHAR(4) NULL,
  `Volume` INT NULL,
  `UnitCost` DECIMAL(8,2) NULL,
  `LabelPrice` DECIMAL(8,2) NULL,
  PRIMARY KEY (`ProdID`),
  INDEX `prodid_idx` (`ProdID` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `OVERHILL`.`CUSTOMERS` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `CustID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Address1` VARCHAR(45) NULL,
  `Address2` VARCHAR(45) NULL,
  `MKT` CHAR(3) NULL,
  `StartDate` INT NULL,
  `EndDate` INT NULL,
  `Flag` CHAR(1) NULL,
  PRIMARY KEY (`ID`),
  INDEX `custid_idx` (`CustID` ASC) VISIBLE,
  INDEX `startdate_idx` (`StartDate` ASC) VISIBLE,
  INDEX `endate_idx` (`EndDate` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `OVERHILL`.`DATEDIM` (
  `DateID` INT NOT NULL,
  `Date` DATE NULL,
  `Season` ENUM('Spring', 'Summer', 'Fall', 'Winter') NULL,
  `YearNo` CHAR(4) NULL,
  `QuarterNo` CHAR(1) NULL,
  `MonthNo` CHAR(2) NULL,
  `MonthName` VARCHAR(20) NULL,
  `WeekNo` CHAR(2) NULL,
  `DayNo` CHAR(3) NULL,
  PRIMARY KEY (`DateID`),
  INDEX `dateid_idx` (`DateID` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `OVERHILL`.`AGENTS` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `AgentID` INT NULL,
  `Name` VARCHAR(45) NULL,
  `CommisionRate` DECIMAL(5,4) NULL,
  `StartDate` INT NULL,
  `EndDate` INT NULL,
  `Flag` CHAR(1) NULL,
  PRIMARY KEY (`ID`),
  INDEX `agentid_idx` (`AgentID` ASC) VISIBLE,
  INDEX `startdate_idx` (`StartDate` ASC) VISIBLE,
  INDEX `enddate_idx` (`EndDate` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `OVERHILL`.`SALES` (
  `SalesID` INT NOT NULL,
  `DateID` INT NULL,
  `CustID` INT NULL,
  `ProdID` INT NULL,
  `AgentID` INT NULL,
  `Line` INT NULL,
  `QTY` INT NULL,
  `UnitPrice` DECIMAL(10,2) NULL,
  PRIMARY KEY (`SalesID`),
  INDEX `dateid_idx` (`DateID` ASC) VISIBLE,
  INDEX `custid_idx` (`CustID` ASC) VISIBLE,
  INDEX `agentid_idx` (`AgentID` ASC) VISIBLE,
  INDEX `prodid_idx` (`ProdID` ASC) VISIBLE,
  CONSTRAINT `DateID`
    FOREIGN KEY (`DateID`)
    REFERENCES `OVERHILL`.`DATEDIM` (`DateID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CustID`
    FOREIGN KEY (`CustID`)
    REFERENCES `OVERHILL`.`CUSTOMERS` (`CustID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ProdID`
    FOREIGN KEY (`ProdID`)
    REFERENCES `OVERHILL`.`PRODUCTIONS` (`ProdID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `AgentID`
    FOREIGN KEY (`AgentID`)
    REFERENCES `OVERHILL`.`AGENTS` (`AgentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

# business problems#

-- 1. what products are most profitable?
select b.Description as ProductName, b.Group, sum(a.QTY) as TotalQuantity,
sum(a.UnitPrice*a.QTY) as TotalSales, sum(b.UnitCost*a.QTY) as TotalCost,
sum((a.UnitPrice-b.UnitCost)*a.QTY) as TotalProfit from SALES a 
left join PRODUCTIONS b on a.ProdID = B.ProdID
left join DATEDIM c on a.DateID = c.DateID
where c.YearNo = '2019'
Group by b.Description, b.Group
Order by sum((a.UnitPrice-b.UnitCost)*a.QTY) Desc;

-- 2. Who are the key customers?
select b.Name as CustomerName, sum(a.QTY) as TotalQuantity,
sum(a.UnitPrice*a.QTY) as TotalSales from SALES a
left join CUSTOMERS b on a.CustID = b.CustID
left join DATEDIM c on a.DateID = c.DateID
where c.YearNo = '2019' and c.Season = 'Spring'
Group by b.Name
Order by sum(a.UnitPrice*a.QTY) Desc 