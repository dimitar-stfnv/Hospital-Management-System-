# Hospital Management System (HMS) Database

## Overview
This is a SQL-based database project for managing hospital operations. It includes patient registration, appointments, doctor assignments, billing, inventory, and prescriptions. The project demonstrates advanced SQL features like foreign keys, indexes, stored procedures, triggers, and views—making it suitable for a portfolio to showcase database design skills.

### Features
- **8 Tables**: With relationships (one-to-many, many-to-one) and constraints.
- **Sample Data**: For immediate testing.
- **Queries**: From basic SELECTs to complex joins, subqueries, and aggregations.
- **Stored Procedures**: For adding records and generating reports with transaction handling.
- **Triggers**: Automate inventory updates and logging.
- **Views**: Simplified access to summarized data.

### Technologies
- SQL (Compatible with MySQL, PostgreSQL, etc.)
- No external dependencies; pure SQL scripts.

### Setup Instructions
1. Create a database: `CREATE DATABASE hms_db; USE hms_db;`
2. Run `schema.sql` to create tables.
3. Run `data.sql` to insert sample data.
4. Run `procedures.sql`, `triggers.sql`, and `views.sql` to add advanced features.
5. Test with `queries.sql`.

### Usage Examples
- Add a patient: `CALL AddPatient('New', 'Patient', '1995-01-01', 'Male', 'Address', 'Phone', 'Email', 'AB+');`
- View patient summary: `SELECT * FROM PatientSummary;`

### Future Enhancements
- Integrate with a frontend (e.g., Python Flask or Java Spring).
- Add user authentication logic.
- Implement backups and security audits.

### License
MIT License. Feel free to use and modify.

For questions, contact [your-email@example.com].
