-- Hospital Management System Schema
-- This file creates the database tables with relationships, constraints, and indexes.

-- Drop existing tables if they exist (for re-running the script)
DROP TABLE IF EXISTS Prescriptions;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS Bills;
DROP TABLE IF EXISTS Appointments;
DROP TABLE IF EXISTS Patients;
DROP TABLE IF EXISTS Doctors;
DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS Users;

-- Users table (for authentication, e.g., admins, doctors, nurses)
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,  -- Store hashed passwords
    role ENUM('admin', 'doctor', 'nurse', 'patient') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Departments table
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    head_doctor_id INT  -- Forward reference to Doctors
);

-- Doctors table
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialty VARCHAR(100),
    dept_id INT,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    hire_date DATE,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id) ON DELETE SET NULL
);

-- Add foreign key to Departments after Doctors is created
ALTER TABLE Departments ADD FOREIGN KEY (head_doctor_id) REFERENCES Doctors(doctor_id) ON DELETE SET NULL;

-- Patients table
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    dob DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other'),
    address VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(100),
    blood_type VARCHAR(5),
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Appointments table
CREATE TABLE Appointments (
    appt_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appt_date DATETIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE
);

-- Bills table
CREATE TABLE Bills (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    appt_id INT,
    amount DECIMAL(10, 2) NOT NULL,
    bill_date DATE NOT NULL,
    status ENUM('Paid', 'Pending', 'Overdue') DEFAULT 'Pending',
    description VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (appt_id) REFERENCES Appointments(appt_id) ON DELETE SET NULL
);

-- Inventory table (for medicines and supplies)
CREATE TABLE Inventory (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    item_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    unit_price DECIMAL(10, 2),
    expiry_date DATE,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id) ON DELETE SET NULL
);

-- Prescriptions table
CREATE TABLE Prescriptions (
    presc_id INT PRIMARY KEY AUTO_INCREMENT,
    appt_id INT NOT NULL,
    item_id INT NOT NULL,
    dosage VARCHAR(100),
    quantity INT NOT NULL,
    prescribed_date DATE NOT NULL,
    FOREIGN KEY (appt_id) REFERENCES Appointments(appt_id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES Inventory(item_id) ON DELETE RESTRICT
);

-- Indexes for performance (makes it look more professional)
CREATE INDEX idx_patient_name ON Patients(first_name, last_name);
CREATE INDEX idx_appt_date ON Appointments(appt_date);
CREATE INDEX idx_doctor_specialty ON Doctors(specialty);
