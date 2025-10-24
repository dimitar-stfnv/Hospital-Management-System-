-- Views for Hospital Management System
-- Simplify complex queries for users/reports.

-- View: Patient Summary (joins patients, appointments, bills)
CREATE VIEW PatientSummary AS
SELECT p.patient_id, CONCAT(p.first_name, ' ', p.last_name) AS full_name,
       COUNT(a.appt_id) AS total_appointments,
       SUM(b.amount) AS total_billed,
       MAX(a.appt_date) AS last_appointment
FROM Patients p
LEFT JOIN Appointments a ON p.patient_id = a.patient_id
LEFT JOIN Bills b ON p.patient_id = b.patient_id
GROUP BY p.patient_id;

-- View: Doctor Workload
CREATE VIEW DoctorWorkload AS
SELECT d.doctor_id, CONCAT(d.first_name, ' ', d.last_name) AS full_name,
       dep.dept_name,
       COUNT(a.appt_id) AS appointments_this_month
FROM Doctors d
JOIN Departments dep ON d.dept_id = dep.dept_id
LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id AND MONTH(a.appt_date) = MONTH(CURDATE())
GROUP BY d.doctor_id;
