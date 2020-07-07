# Overhill ETL SQLs
DROP DATABASE IF EXISTS Staging;
CREATE DATABASE Staging;

## Create Staging tables
CREATE TABLE Staging.STG_Agents
(
  `AgentID` VARCHAR(10)
, `Name` VARCHAR(100)
, `CommisionRate` DOUBLE
, `ModifiedTime` DATETIME
)
;

CREATE TABLE Staging.STG_ProductPS
(
  `ProdCode` INT
, `Description` VARCHAR(50)
, `Group` VARCHAR(10)
, `ModifiedTime` DATETIME
)
;

CREATE TABLE Staging.STG_ProductHistory
(
  ProductionID INT
, ProdCode INT
, ProdYear CHAR(4)
, Volume INT
, Cost DOUBLE
, ModifiedTime DATETIME
)
;

CREATE TABLE Staging.STG_ProductSS
(
  `ProdID` INT
, `Description` VARCHAR(50)
, `Group` VARCHAR(10)
, `ProdYear` CHAR(4)
, `Price` DOUBLE
, `ModifiedTime` DATETIME
)
;

CREATE TABLE Staging.STG_Customers
(
  `CustID` INT
, `Name` VARCHAR(45)
, `Address` VARCHAR(200)
, `MarketID` VARCHAR(5)
, `ModifiedTime` DATETIME
)
;

CREATE TABLE Staging.STG_Market
(
  `MarketID` VARCHAR(5)
, `Description` VARCHAR(100)
, `ModifiedTime` DATETIME
)
;

CREATE TABLE Staging.STG_SalesItem
(
  `SaleID` INT
, `LineID` INT
, `ProdID` INT
, `UnitSales` INT
, `UnitPrice` DOUBLE
, `ModifiedTime` DATETIME
)
;

CREATE TABLE Staging.STG_Sales
(
  `SaleID` INT
, `CustID` INT
, `Date` DATETIME
, `AgentID` VARCHAR(10)
, `ModifiedTime` DATETIME
)
;

