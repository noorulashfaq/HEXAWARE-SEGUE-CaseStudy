-- DB Crime Analysis and Reporting System (CARS)
CREATE DATABASE CARSDB
USE CARSDB

-- Creating schema for the entities

-- Incidents
CREATE TABLE Incidents(
IncidentID INT PRIMARY KEY IDENTITY,
IncidentType VARCHAR(50),
IncidentDate DATETIME,
Location VARCHAR(100),
Description TEXT,
Status VARCHAR(50),
AgencyID INT,
);

-- Victims
CREATE TABLE Victims(
VictimID INT PRIMARY KEY IDENTITY,
IncidentID INT,
FirstName VARCHAR(255),
LastName VARCHAR(255),
DateOfBirth DATETIME,
Gender VARCHAR(10),
PhoneNumber BIGINT,
Address VARCHAR(255),
FOREIGN KEY (IncidentID) REFERENCES Incidents(IncidentID)
);

-- Suspects
CREATE TABLE Suspects(
SuspectID INT PRIMARY KEY IDENTITY,
IncidentID INT,
FirstName VARCHAR(255),
LastName VARCHAR(255),
DateOfBirth DATETIME,
Gender VARCHAR(10),
PhoneNumber BIGINT,
Address VARCHAR(255),
FOREIGN KEY (IncidentID) REFERENCES Incidents(IncidentID)
);

-- Law Enforcement Agencies
CREATE TABLE LawEnforcementAgencies(
AgencyID INT PRIMARY KEY IDENTITY,
AgencyName VARCHAR(255),
Jurisdiction VARCHAR(255),
PhoneNumber BIGINT,
Address VARCHAR(255),
);

-- Officers
CREATE TABLE Officers(
OfficerID INT PRIMARY KEY IDENTITY,
FirstName VARCHAR(255),
LastName VARCHAR(255),
BadgeNumber INT,
[Rank] INT,
PhoneNumber BIGINT,
Address VARCHAR(255),
AgencyID INT,
FOREIGN KEY (AgencyID) REFERENCES LawEnforcementAgencies(AgencyID)
);

-- Evidences
CREATE TABLE Evidences(
EvidenceID INT PRIMARY KEY IDENTITY,
Description TEXT,
LocationFound VARCHAR(255),
IncidentID INT,
FOREIGN KEY (IncidentID) REFERENCES Incidents(IncidentID)
);

-- Reports
CREATE TABLE Reports(
ReportID INT PRIMARY KEY IDENTITY,
IncidentID INT,
ReportingOfficer INT,
ReportDate DATETIME,
ReportDetails TEXT,
Status VARCHAR(50),
FOREIGN KEY (IncidentID) REFERENCES Incidents(IncidentID)
);

-- Creating Incident -> Agency relation
ALTER TABLE Incidents
ADD CONSTRAINT FK_Incident_Agency
FOREIGN KEY (AgencyID) REFERENCES LawEnforcementAgencies(AgencyID);

ALTER TABLE Incidents
ADD CONSTRAINT Check_IncidentStatus
CHECK (Status IN ('Open', 'Closed', 'Under Investigation'));

ALTER TABLE Reports
ADD CONSTRAINT Check_Reports
CHECK (Status IN ('Draft', 'Finalized'));

ALTER TABLE Incidents
ADD CONSTRAINT Def_IncidentStatus
DEFAULT 'Open' FOR Status;

ALTER TABLE Officers
ALTER COLUMN Rank VARCHAR(50);

