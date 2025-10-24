-- Stored Procedures for Hospital Management System
-- These encapsulate operations with error handling for robustness.

DELIMITER //

-- Procedure to add a new patient
CREATE PROCEDURE AddPatient(
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_dob DATE,
    IN p_gender ENUM('Male', 'Female', 'Other'),
    IN p_address VARCHAR(255),
    IN p_phone VARCHAR(20),
    IN p_email VARCHAR(100),
    IN p_blood_type VARCHAR(5)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error adding patient';
    END;
    
    START TRANSACTION;
    INSERT INTO Patients (first_name, last_name, dob, gender, address, phone, email, blood_type)
    VALUES (p_first_name, p_last_name, p_dob, p_gender, p_address, p_phone, p_email, p_blood_type);
    COMMIT;
END //

-- Procedure to generate a bill report for a patient
CREATE PROCEDURE GetPatientBillReport(IN p_patient_id INT)
BEGIN
    SELECT b.bill_id, b.amount, b.bill_date, b.status, a.appt_date
    FROM Bills b
    LEFT JOIN Appointments a ON b.appt_id = a.appt_id
    WHERE b.patient_id = p_patient_id
    ORDER BY b.bill_date DESC;
END //

DELIMITER ;
