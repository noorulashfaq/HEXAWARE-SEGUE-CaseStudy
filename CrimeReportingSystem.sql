-- DB Crime Analysis and Reporting System (CARS)
CREATE DATABASE CARSDB
USE CARSDB

-- Creating schema for the entities

-- Incidents
CREATE TABLE Incidents(
IncidentID INT PRIMARY KEY IDENTITY,
IncidentType VARCHAR(50) CHECK(IncidentType IN ('Robbery', 'Homicide', 'Theft')),
IncidentDate DATETIME NOT NULL,
Location VARCHAR(100) NOT NULL,
Description TEXT,
Status VARCHAR(50) CHECK(Status IN ('Open', 'Closed', 'Under Investigation')),
AgencyID INT,
);

-- Victims
CREATE TABLE Victims(
VictimID INT PRIMARY KEY IDENTITY,
IncidentID INT NOT NULL,
FirstName VARCHAR(255) NOT NULL,
LastName VARCHAR(255) NOT NULL,
DateOfBirth DATETIME,
Gender VARCHAR(10) NOT NULL,
PhoneNumber BIGINT NOT NULL,
Address VARCHAR(255),
FOREIGN KEY (IncidentID) REFERENCES Incidents(IncidentID)
);

-- Suspects
CREATE TABLE Suspects(
SuspectID INT PRIMARY KEY IDENTITY,
IncidentID INT NOT NULL,
FirstName VARCHAR(255) NOT NULL,
LastName VARCHAR(255) NOT NULL,
DateOfBirth DATETIME,
Gender VARCHAR(10) NOT NULL,
PhoneNumber BIGINT,
Address VARCHAR(255),
FOREIGN KEY (IncidentID) REFERENCES Incidents(IncidentID)
);

-- Law Enforcement Agencies
CREATE TABLE LawEnforcementAgencies(
AgencyID INT PRIMARY KEY IDENTITY,
AgencyName VARCHAR(255) NOT NULL,
Jurisdiction VARCHAR(255) NOT NULL,
PhoneNumber BIGINT NOT NULL,
Address VARCHAR(255),
);

-- Officers
CREATE TABLE Officers(
OfficerID INT PRIMARY KEY IDENTITY,
FirstName VARCHAR(255) NOT NULL,
LastName VARCHAR(255) NOT NULL,
BadgeNumber INT NOT NULL,
[Rank] INT,
PhoneNumber BIGINT NOT NULL,
Address VARCHAR(255) NOT NULL,
AgencyID INT,
FOREIGN KEY (AgencyID) REFERENCES LawEnforcementAgencies(AgencyID)
);

-- Evidences
CREATE TABLE Evidences(
EvidenceID INT PRIMARY KEY IDENTITY,
Description TEXT,
LocationFound VARCHAR(255) NOT NULL,
IncidentID INT NOT NULL,
FOREIGN KEY (IncidentID) REFERENCES Incidents(IncidentID)
);

-- Reports
CREATE TABLE Reports(
ReportID INT PRIMARY KEY IDENTITY,
IncidentID INT NOT NULL,
ReportingOfficer INT NOT NULL,
ReportDate DATETIME NOT NULL,
ReportDetails TEXT,
Status VARCHAR(50),
FOREIGN KEY (IncidentID) REFERENCES Incidents(IncidentID)
);

-- Creating Incident -> Agency relation
ALTER TABLE Incidents
ADD CONSTRAINT FK_Incident_Agency
FOREIGN KEY (AgencyID) REFERENCES LawEnforcementAgencies(AgencyID);






--

DROP DATABASE CARSDB