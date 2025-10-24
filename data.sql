-- Sample Data for Hospital Management System
-- Insert data into tables in order to respect foreign keys.

-- Insert Users
INSERT INTO Users (username, password_hash, role) VALUES
('admin1', 'hashed_pass1', 'admin'),
('doc_john', 'hashed_pass2', 'doctor'),
('nurse_anna', 'hashed_pass3', 'nurse'),
('patient_mike', 'hashed_pass4', 'patient');

-- Insert Departments (head_doctor_id will be updated later)
INSERT INTO Departments (dept_name, location) VALUES
('Cardiology', 'Building A, Floor 2'),
('Neurology', 'Building B, Floor 3'),
('Pharmacy', 'Building A, Floor 1');

-- Insert Doctors
INSERT INTO Doctors (first_name, last_name, specialty, dept_id, email, phone, hire_date) VALUES
('John', 'Doe', 'Cardiologist', 1, 'john.doe@hospital.com', '123-456-7890', '2020-01-15'),
('Jane', 'Smith', 'Neurologist', 2, 'jane.smith@hospital.com', '987-654-3210', '2019-05-20');

-- Update Departments with head_doctor_id
UPDATE Departments SET head_doctor_id = 1 WHERE dept_id = 1;
UPDATE Departments SET head_doctor_id = 2 WHERE dept_id = 2;

-- Insert Patients
INSERT INTO Patients (first_name, last_name, dob, gender, address, phone, email, blood_type) VALUES
('Mike', 'Johnson', '1990-03-12', 'Male', '123 Main St', '555-1234', 'mike@patient.com', 'O+'),
('Sara', 'Lee', '1985-07-22', 'Female', '456 Elm St', '555-5678', 'sara@patient.com', 'A-'),
('Alex', 'Brown', '2000-11-05', 'Male', '789 Oak St', '555-9012', 'alex@patient.com', 'B+');

-- Insert Appointments
INSERT INTO Appointments (patient_id, doctor_id, appt_date, status, notes) VALUES
(1, 1, '2025-11-01 10:00:00', 'Scheduled', 'Routine checkup'),
(2, 2, '2025-11-02 14:30:00', 'Scheduled', 'Headache consultation'),
(3, 1, '2025-11-03 09:00:00', 'Scheduled', 'Follow-up');

-- Insert Bills
INSERT INTO Bills (patient_id, appt_id, amount, bill_date, status, description) VALUES
(1, 1, 150.00, '2025-11-01', 'Pending', 'Consultation fee'),
(2, 2, 200.00, '2025-11-02', 'Pending', 'Specialist visit');

-- Insert Inventory
INSERT INTO Inventory (item_name, quantity, unit_price, expiry_date, dept_id) VALUES
('Aspirin', 100, 0.50, '2026-12-31', 3),
('Bandages', 200, 1.00, '2027-06-30', 3),
('MRI Contrast', 50, 10.00, '2025-12-31', 2);

-- Insert Prescriptions
INSERT INTO Prescriptions (appt_id, item_id, dosage, quantity, prescribed_date) VALUES
(1, 1, '1 tablet daily', 30, '2025-11-01'),
(2, 2, 'As needed', 10, '2025-11-02');
