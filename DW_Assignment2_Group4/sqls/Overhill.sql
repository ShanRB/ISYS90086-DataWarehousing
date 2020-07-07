# Overhill Design SQLs
#DROP DATABASE IF EXISTS OVERHILL;
#CREATE DATABASE OVERHILL;

USE OVERHILL;

#Create tables
## Date Dimension Table
DROP TABLE IF EXISTS `OVERHILL`.`Date_Dimension`;
CREATE TABLE IF NOT EXISTS `OVERHILL`.`Date_Dimension` (
  `DateID` INT NOT NULL,
  `Date` DATE NOT NULL,
  `Season` VARCHAR(10) NOT NULL,
  `YearNum` INT NOT NULL,
  `YearQuarterNum` INT NOT NULL,
  `QuarterNum` INT NOT NULL,
  `QuarterName` CHAR(5) NOT NULL,
  `YearMonthNum` INT NOT NULL,
  `MonthNum` INT NOT NULL,
  `MonthName` VARCHAR(20) NOT NULL,
  `MonthShortName` CHAR(3) NOT NULL,
  `WeekNum` INT NOT NULL,
  `DayNumOfYear` INT NOT NULL,
  `DayNUmOfQuarter` INT NOT NULL,
  `DayNumOfMonth` INT NOT NULL,
  `DayNumOfWeek` INT NOT NULL,
  `DayName` VARCHAR(10) NOT NULL,
  `DayShortName` CHAR(3) NOT NULL,
  `ModifiedTime` DATETIME NULL)
;
  
DROP TABLE IF EXISTS `OVERHILL`.`Products`;
CREATE TABLE IF NOT EXISTS `OVERHILL`.`Products` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ProdID` INT NULL,
  `ProdCode` INT NULL,
  `Description` VARCHAR(45) NULL,
  `Group` VARCHAR(10) NULL,
  `ProdYear` CHAR(4) NULL,
  `Volume` INT NULL,
  `UnitCost` DECIMAL(8,2) NULL,
  `LabelPrice` DECIMAL(8,2) NULL,
  `Version` INT NULL,
  `StartDate` DATETIME NULL,
  `EndDate` DATETIME NULL,
  `ModifiedTime` DATETIME NULL,
  PRIMARY KEY (`ID`))
;

DROP TABLE IF EXISTS `OVERHILL`.`Agents`;
CREATE TABLE IF NOT EXISTS `OVERHILL`.`Agents` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `AgentID` VARCHAR(5) NULL,
  `FirstName` VARCHAR(45) NULL,
  `LastName` VARCHAR(45) NULL,
  `CommisionRate` DECIMAL(5,2) NULL,
  `Version` INT NULL,
  `StartDate` DATETIME NULL,
  `EndDate` DATETIME NULL,
  `ModifiedTime` DATETIME NULL,
  PRIMARY KEY (`ID`))
;

DROP TABLE IF EXISTS `OVERHILL`.`Customers`;
CREATE TABLE IF NOT EXISTS `OVERHILL`.`Customers` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `CustID` INT NULL,
  `Name` VARCHAR(45) NULL,
  `Address` VARCHAR(200) NULL,
  `MarketID` CHAR(3) NULL,
  `Market` VARCHAR(45) NULL,
  `Version` INT NULL,
  `StartDate` DATETIME NULL,
  `EndDate` DATETIME NULL,
  `ModifiedTime` DATETIME NULL,
  PRIMARY KEY (`ID`))
;

DROP TABLE IF EXISTS `OVERHILL`.`Transactional_Sales`;
CREATE TABLE IF NOT EXISTS `OVERHILL`.`Transactional_Sales` (
  `SaleID` INT NOT NULL,
  `DateID` INT NULL,
  `CustID` INT NULL,
  `ProdID` INT NULL,
  `AgentID` VARCHAR(5) NULL,
  `LineID` INT NULL,
  `UnitSales` INT NULL,
  `LabelPrice` DECIMAL(8,2) NULL,
  `UnitPrice` DECIMAL(8,2) NULL,
  `UnitCost` DECIMAL(8,2) NULL,
  `TotalSales` DECIMAL(10,2) NULL,
  `TotalCost` DECIMAL(10,2) NULL,
  `TotalMargin` DECIMAL(10,2) NULL,
  `AgentCommission` DECIMAL(10,2) NULL,
  `ModifiedTime` DATETIME NULL,
  INDEX `dateid_idx` (`DateID` ASC),
  INDEX `custid_idx` (`CustID` ASC),
  INDEX `agentid_idx` (`AgentID` ASC),
  INDEX `prodid_idx` (`ProdID` ASC),
  CONSTRAINT `DateID`
    FOREIGN KEY (`DateID`)
    REFERENCES `OVERHILL`.`Date_Dimension` (`DateID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `CustID`
    FOREIGN KEY (`CustID`)
    REFERENCES `OVERHILL`.`Customers` (`CustID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ProdID`
    FOREIGN KEY (`ProdID`)
    REFERENCES `OVERHILL`.`Products` (`ProdID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `AgentID`
    FOREIGN KEY (`AgentID`)
    REFERENCES `OVERHILL`.`Agents` (`AgentID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;


CREATE INDEX idx_dateid ON `OVERHILL`.`Date_Dimension`(DateID);
CREATE INDEX idx_custid ON `OVERHILL`.`Customers`(CustID);
CREATE INDEX idx_prodid ON `OVERHILL`.`Products`(ProdID);
CREATE INDEX idx_agentid ON `OVERHILL`.`Agents`(AgentID);
