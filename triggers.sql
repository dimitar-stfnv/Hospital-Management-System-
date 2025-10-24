-- Triggers for Hospital Management System
-- Automate actions like updating inventory on prescriptions.

DELIMITER //

-- Trigger: Update inventory quantity after inserting a prescription
CREATE TRIGGER AfterInsertPrescription
AFTER INSERT ON Prescriptions
FOR EACH ROW
BEGIN
    UPDATE Inventory
    SET quantity = quantity - NEW.quantity
    WHERE item_id = NEW.item_id;
    
    IF (SELECT quantity FROM Inventory WHERE item_id = NEW.item_id) < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient inventory';
    END IF;
END //

-- Trigger: Log appointment cancellations (example for auditing)
CREATE TRIGGER AfterCancelAppointment
AFTER UPDATE ON Appointments
FOR EACH ROW
BEGIN
    IF OLD.status != 'Cancelled' AND NEW.status = 'Cancelled' THEN
        -- Could insert into a log table here; for simplicity, just signal
        SIGNAL SQLSTATE '01000' SET MESSAGE_TEXT = 'Appointment cancelled';
    END IF;
END //

DELIMITER ;
