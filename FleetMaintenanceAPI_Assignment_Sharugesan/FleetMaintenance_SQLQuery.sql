--Database creation
CREATE DATABASE FleetMaintenanceDb;

--Tables Creations
CREATE TABLE Vehicles
(
 VehicleId INT IDENTITY(1,1) PRIMARY KEY,
 VehicleNumber VARCHAR(20) NOT NULL,
 VehicleType VARCHAR(50) NOT NULL,
 Brand VARCHAR(50) NOT NULL,
 Model VARCHAR(50) NOT NULL,
 PurchaseYear INT NOT NULL,
 IsActive BIT NOT NULL
);


CREATE TABLE Drivers
(
 DriverId INT IDENTITY(1,1) PRIMARY KEY,
 DriverName VARCHAR(100) NOT NULL,
 LicenseNumber VARCHAR(50) NOT NULL,
 PhoneNumber VARCHAR(15) NOT NULL,
 City VARCHAR(50) NOT NULL,
 IsAvailable BIT NOT NULL
);

CREATE TABLE MaintenanceRecords
(
 MaintenanceId INT IDENTITY(1,1) PRIMARY KEY,
 VehicleId INT NOT NULL,
 DriverId INT NOT NULL,
 ServiceDate DATE NOT NULL,
 ServiceType VARCHAR(100) NOT NULL,
 ServiceCost DECIMAL(18,2) NOT NULL,
 ServiceStatus VARCHAR(30) NOT NULL,
 Remarks VARCHAR(250) NULL,
 CreatedDate DATETIME NOT NULL,
 CONSTRAINT FK_MaintenanceRecords_Vehicles FOREIGN KEY (VehicleId) REFERENCES
Vehicles (VehicleId),
 CONSTRAINT FK_MaintenanceRecords_Drivers FOREIGN KEY (DriverId) REFERENCES
Drivers (DriverId)
);






--Inserting values
INSERT INTO Vehicles
(VehicleNumber, VehicleType, Brand, Model, PurchaseYear, IsActive)
VALUES
('TN38AB1234', 'Truck', 'Tata', 'Ace', 2021, 1),
('TN38CD2345', 'Van', 'Mahindra', 'Bolero Pickup', 2020, 1),
('TN38EF3456', 'Truck', 'Ashok Leyland', 'Dost', 2022, 1),
('TN38GH4567', 'Mini Truck', 'Tata', 'Intra V30', 2023, 1),
('TN38IJ5678', 'Van', 'Force', 'Traveller', 2021, 1),
('TN38KL6789', 'Truck', 'Eicher', 'Pro 2049', 2019, 1),
('TN38MN7890', 'Pickup', 'Mahindra', 'Jeeto', 2020, 1),
('TN38OP8901', 'Truck', 'BharatBenz', '1217R', 2022, 1),
('TN38QR9012', 'Van', 'Maruti', 'Eeco Cargo', 2024, 1),
('TN38ST0123', 'Truck', 'Tata', 'Signa', 2023, 1);


INSERT INTO Drivers
(DriverName, LicenseNumber, PhoneNumber, City, IsAvailable)
VALUES
('Ramesh Kumar', 'DL2026TN1001', '9876543210', 'Coimbatore', 1),
('Suresh Babu', 'DL2026TN1002', '9876543211', 'Salem', 1),
('Vignesh Raj', 'DL2026TN1003', '9876543212', 'Erode', 1),
('Arun Prakash', 'DL2026TN1004', '9876543213', 'Madurai', 1),
('Karthik M', 'DL2026TN1005', '9876543214', 'Chennai', 1),
('Praveen Kumar', 'DL2026TN1006', '9876543215', 'Trichy', 1),
('Manoj Kumar', 'DL2026TN1007', '9876543216', 'Tiruppur', 1),
('Dinesh Babu', 'DL2026TN1008', '9876543217', 'Namakkal', 1),
('Senthil Raj', 'DL2026TN1009', '9876543218', 'Karur', 1),
('Balaji S', 'DL2026TN1010', '9876543219', 'Pollachi', 1);


INSERT INTO MaintenanceRecords
(VehicleId, DriverId, ServiceDate, ServiceType, ServiceCost,
 ServiceStatus, Remarks, CreatedDate)
VALUES
(1,1,'2026-06-01','Oil Change',2500,'Completed','Regular oil replacement',GETDATE()),
(2,2,'2026-06-02','Brake Inspection',3500,'Completed','Brake pads checked',GETDATE()),
(3,3,'2026-06-03','Engine Repair',12000,'InProgress','Engine vibration issue',GETDATE()),
(4,4,'2026-06-04','Tyre Replacement',8000,'Completed','Front tyres replaced',GETDATE()),
(5,5,'2026-06-05','Battery Check',1500,'Scheduled','Battery performance check',GETDATE()),
(6,6,'2026-06-06','General Service',5000,'Completed','Periodic service',GETDATE()),
(7,7,'2026-06-07','Oil Change',2300,'Completed','Oil filter changed',GETDATE()),
(8,8,'2026-06-08','Brake Inspection',3200,'Cancelled','Vehicle unavailable',GETDATE()),
(9,9,'2026-06-09','Engine Repair',15000,'InProgress','Injector repair',GETDATE()),
(10,10,'2026-06-10','Tyre Replacement',9000,'Completed','Rear tyres replaced',GETDATE()),
(1,2,'2026-06-11','Battery Check',1800,'Completed','Battery replaced',GETDATE()),
(2,3,'2026-06-12','General Service',4500,'Completed','General maintenance',GETDATE()),
(3,4,'2026-06-13','Oil Change',2400,'Scheduled','Awaiting spare parts',GETDATE()),
(4,5,'2026-06-14','Brake Inspection',3300,'Completed','Brake oil changed',GETDATE()),
(5,6,'2026-06-15','Engine Repair',17000,'InProgress','Turbo repair',GETDATE()),
(6,7,'2026-06-16','Tyre Replacement',8500,'Completed','All tyres changed',GETDATE()),
(7,8,'2026-06-17','Battery Check',1600,'Completed','Battery health good',GETDATE()),
(8,9,'2026-06-18','General Service',5200,'Scheduled','Monthly service',GETDATE()),
(9,10,'2026-06-19','Oil Change',2600,'Completed','Engine oil replaced',GETDATE()),
(10,1,'2026-06-20','Brake Inspection',3400,'Completed','Brake tuning done',GETDATE()),
(1,3,'2026-06-21','Engine Repair',14500,'Cancelled','Parts unavailable',GETDATE()),
(2,4,'2026-06-22','Tyre Replacement',7800,'Completed','Tyre wear issue',GETDATE()),
(3,5,'2026-06-23','Battery Check',1400,'Completed','Battery terminals cleaned',GETDATE()),
(4,6,'2026-06-24','General Service',4900,'InProgress','Ongoing service',GETDATE()),
(5,7,'2026-06-25','Oil Change',2550,'Completed','Synthetic oil used',GETDATE()),
(6,8,'2026-06-26','Brake Inspection',3600,'Scheduled','Inspection pending',GETDATE()),
(7,9,'2026-06-27','Engine Repair',13500,'Completed','Engine overhaul done',GETDATE()),
(8,10,'2026-06-28','Tyre Replacement',8700,'Completed','Tyres aligned',GETDATE()),
(9,1,'2026-06-29','Battery Check',1700,'Completed','Battery serviced',GETDATE()),
(10,2,'2026-06-30','General Service',5500,'Scheduled','Quarterly maintenance',GETDATE());