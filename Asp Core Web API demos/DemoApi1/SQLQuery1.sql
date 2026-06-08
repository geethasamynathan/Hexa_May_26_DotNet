CREATE DATABASE HospitalAppointmentDb;

use HospitalAppointmentDb;

CREATE TABLE Doctors
(
    DoctorId INT IDENTITY(1,1) PRIMARY KEY,
    DoctorName NVARCHAR(100) NOT NULL,
    Specialization NVARCHAR(100) NOT NULL,
    ConsultationFee DECIMAL(18,2) NOT NULL,
    PhoneNumber NVARCHAR(15) NOT NULL,
    IsAvailable BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE Patients
(
    PatientId INT IDENTITY(1,1) PRIMARY KEY,
    PatientName NVARCHAR(100) NOT NULL,
    Gender NVARCHAR(10) NOT NULL,
    Age INT NOT NULL,
    PhoneNumber NVARCHAR(15) NOT NULL,
    Email NVARCHAR(150) NULL,
    City NVARCHAR(100) NOT NULL
);
GO

CREATE TABLE Appointments
(
    AppointmentId INT IDENTITY(1,1) PRIMARY KEY,
    DoctorId INT NOT NULL,
    PatientId INT NOT NULL,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,
    AppointmentStatus NVARCHAR(30) NOT NULL DEFAULT 'Booked',
    Symptoms NVARCHAR(300) NULL,
    CreatedDate DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_Appointments_Doctors
        FOREIGN KEY (DoctorId)
        REFERENCES Doctors(DoctorId),

    CONSTRAINT FK_Appointments_Patients
        FOREIGN KEY (PatientId)
        REFERENCES Patients(PatientId)
);
GO

/* ============================================================
   DATABASE FIRST EF CORE CONSOLE APPLICATION DEMO
   Use Case : Hospital Appointment Management System
   Database : HospitalAppointmentDb
   Tables   : Doctors, Patients, Appointments
   ============================================================ */

IF DB_ID('HospitalAppointmentDb') IS NOT NULL
BEGIN
    ALTER DATABASE HospitalAppointmentDb SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE HospitalAppointmentDb;
END;
GO

CREATE DATABASE HospitalAppointmentDb;
GO

USE HospitalAppointmentDb;
GO

/* ============================================================
   TABLE 1: Doctors
   ============================================================ */

CREATE TABLE Doctors
(
    DoctorId INT IDENTITY(1,1) PRIMARY KEY,
    DoctorName NVARCHAR(100) NOT NULL,
    Specialization NVARCHAR(100) NOT NULL,
    ConsultationFee DECIMAL(18,2) NOT NULL,
    PhoneNumber NVARCHAR(15) NOT NULL,
    IsAvailable BIT NOT NULL DEFAULT 1
);
GO

/* ============================================================
   TABLE 2: Patients
   ============================================================ */

CREATE TABLE Patients
(
    PatientId INT IDENTITY(1,1) PRIMARY KEY,
    PatientName NVARCHAR(100) NOT NULL,
    Gender NVARCHAR(10) NOT NULL,
    Age INT NOT NULL,
    PhoneNumber NVARCHAR(15) NOT NULL,
    Email NVARCHAR(150) NULL,
    City NVARCHAR(100) NOT NULL
);
GO

/* ============================================================
   TABLE 3: Appointments
   ============================================================ */

CREATE TABLE Appointments
(
    AppointmentId INT IDENTITY(1,1) PRIMARY KEY,
    DoctorId INT NOT NULL,
    PatientId INT NOT NULL,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,
    AppointmentStatus NVARCHAR(30) NOT NULL DEFAULT 'Booked',
    Symptoms NVARCHAR(300) NULL,
    CreatedDate DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_Appointments_Doctors
        FOREIGN KEY (DoctorId)
        REFERENCES Doctors(DoctorId),

    CONSTRAINT FK_Appointments_Patients
        FOREIGN KEY (PatientId)
        REFERENCES Patients(PatientId)
);
GO

/* ============================================================
   OPTIONAL CONSTRAINTS
   ============================================================ */

ALTER TABLE Patients
ADD CONSTRAINT CK_Patients_Age
CHECK (Age > 0 AND Age <= 120);
GO

ALTER TABLE Appointments
ADD CONSTRAINT CK_Appointments_Status
CHECK (AppointmentStatus IN ('Booked', 'Completed', 'Cancelled'));
GO

INSERT INTO Doctors
(DoctorName, Specialization, ConsultationFee, PhoneNumber, IsAvailable)
VALUES
('Dr. Arjun Kumar', 'Cardiology', 700.00, '9876543210', 1),
('Dr. Meena Ravi', 'Dermatology', 500.00, '9876543211', 1),
('Dr. Suresh Babu', 'Orthopedics', 650.00, '9876543212', 1),
('Dr. Priya Anand', 'Pediatrics', 450.00, '9876543213', 1),
('Dr. Kavitha Raj', 'Neurology', 900.00, '9876543214', 0);
GO


INSERT INTO Patients
(PatientName, Gender, Age, PhoneNumber, Email, City)
VALUES
('Geetha S', 'Female', 32, '9000011111', 'geetha@gmail.com', 'Coimbatore'),
('Arun Kumar', 'Male', 40, '9000011112', 'arun@gmail.com', 'Chennai'),
('Priya M', 'Female', 28, '9000011113', 'priya@gmail.com', 'Madurai'),
('Ramesh V', 'Male', 55, '9000011114', 'ramesh@gmail.com', 'Salem'),
('Anitha R', 'Female', 8, '9000011115', 'anitha@gmail.com', 'Coimbatore');
GO

INSERT INTO Appointments
(DoctorId, PatientId, AppointmentDate, AppointmentTime, AppointmentStatus, Symptoms)
VALUES
(1, 1, '2026-06-10', '10:00:00', 'Booked', 'Chest pain and tiredness'),
(2, 3, '2026-06-11', '11:30:00', 'Booked', 'Skin allergy'),
(3, 4, '2026-06-12', '09:30:00', 'Completed', 'Knee pain'),
(4, 5, '2026-06-13', '12:00:00', 'Booked', 'Fever and cough'),
(1, 2, '2026-06-14', '15:00:00', 'Cancelled', 'Regular heart checkup');
GO

select * from Doctors;
select * from Patients;
select * from Appointments;