-- Sample Queries for Hospital Management System
-- Includes basic, intermediate, and advanced queries to demonstrate complexity.

-- Basic: Get all patients
SELECT * FROM Patients;

-- Intermediate: Join patients with appointments
SELECT p.first_name, p.last_name, a.appt_date, d.first_name AS doctor_first, d.last_name AS doctor_last
FROM Patients p
JOIN Appointments a ON p.patient_id = a.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id
WHERE a.status = 'Scheduled';

-- Advanced: Subquery for patients with overdue bills
SELECT p.first_name, p.last_name, b.amount
FROM Patients p
JOIN Bills b ON p.patient_id = b.patient_id
WHERE b.status = 'Overdue'
AND b.amount > (SELECT AVG(amount) FROM Bills);  -- Compared to average bill

-- Aggregation: Count appointments per doctor
SELECT d.first_name, d.last_name, COUNT(a.appt_id) AS appt_count
FROM Doctors d
LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id
HAVING appt_count > 1
ORDER BY appt_count DESC;

-- Complex Join: Prescription details with inventory and patient info
SELECT pr.presc_id, p.first_name AS patient, i.item_name, pr.quantity, (pr.quantity * i.unit_price) AS total_cost
FROM Prescriptions pr
JOIN Appointments a ON pr.appt_id = a.appt_id
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Inventory i ON pr.item_id = i.item_id
WHERE i.expiry_date > CURDATE();  -- Only non-expired items
