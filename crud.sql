# PRE-REQUISITES
-- Table Batch( bid,name,start_dt) should exist in myworld database. 
-- bid int AI PK 
-- name varchar(50) 
-- start_dt timestamp

#-----------------------------------------------------------------------
#  DEMONSTRATING CREATE(INSERT) OPERATION
#-----------------------------------------------------------------------

# Creating a new table 
use myworld;
DROP TABLE IF EXISTS myworld.scaler_student;
CREATE TABLE myworld.scaler_student (
    id INT AUTO_INCREMENT,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    dateOfBirth DATE NOT NULL,
    enrollmentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    psp DECIMAL(5, 2) CHECK (psp BETWEEN 0.00 AND 100.00),
    batchId INT,
    isActive BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (id),
    FOREIGN KEY(batchId) REFERENCES batch(bid) ON UPDATE SET NULL ON DELETE SET NULL
);
DESC myworld.scaler_student;
COMMIT; 

# Creating/inserting a new row/record into existing table. 
# NOTE: Good practice to mention columns while insert records as some columns might have default values, autogenerated values.

-- Scenario 1: Putting date in wrong format(default is yyyy-mm-dd)
INSERT INTO scaler_student (firstName, LastName, email, dateOfBirth, psp, batchId) 
VALUES ('Razat','Aggarwal','razat.javaprogrammer@gmail.com','09-11-1996',97.4,2);
-- Error Code: 1292. Incorrect date value: '09-11-1996' for column 'dateOfBirth' at row 1

INSERT INTO scaler_student (firstName, LastName, email, dateOfBirth, psp, batchId) 
VALUES ('Razat','Aggarwal','razat.javaprogrammer@gmail.com','1996-11-09',97.40,2);

#------------------------- IMPORTANT QUERY -----
# DEEP COPY table1 to table1_copy
-- creating a new copy table. 
DROP TABLE IF EXISTS myworld.scaler_student_copy;
CREATE TABLE myworld.scaler_student_copy (
    id INT AUTO_INCREMENT,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    dateOfBirth DATE NOT NULL,
    enrollmentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    psp DECIMAL(5, 2) CHECK (psp BETWEEN 0.00 AND 100.00),
    batchId INT,
    isActive BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (id),
    FOREIGN KEY(batchId) REFERENCES batch(bid) ON UPDATE SET NULL ON DELETE SET NULL
);
-- performing deep copy
INSERT INTO myworld.scaler_student_copy(`id`, `firstName`, `lastName`, `email`, `dateOfBirth`,`enrollmentDate`, `psp`, `batchId`, `isActive`)
SELECT `id`, `firstName`, `lastName`, `email`, `dateOfBirth`,`enrollmentDate`, `psp`, `batchId`, `isActive` 
FROM myworld.scaler_student;

#-----------------------------------------------------------------------
#  DEMONSTRATING READ(PRINT/SELECT) OPERATION
#-----------------------------------------------------------------------
use sakila;

# Scenario 0: printing data. 
SELECT 'Hello, World!' AS 'columnName';
SELECT 4*3 ; 

# Scenario 1: print all columns from film table. 
#----------------- USE OF * KEYWORD
SELECT *          -- select all columns. 
FROM sakila.film; -- select all rows.

# Scenario 2: Use of Aliases 
# ---------------  AS keyword  is optional. 
SELECT f.*
FROM sakila.film AS f;

SELECT f.*
FROM sakila.film f;

# Scenario 3: Use of back Tick operator `
--  to reuse reserve keywords in mysql as database,table,column names  
SELECT `TABLE`.*
FROM sakila.film `TABLE`;

# Scenario 4: print only title,rating,release_year for all records from film table. 
SELECT f.title,f.rating,f.release_year 
FROM sakila.film f;

# Scenario 5: Print distinct(rating,release_year) records from film table. 
#----------------- USE OF DISTINCT KEYWORD
SELECT DISTINCT f.rating, f.release_year 
FROM sakila.film f;

-- Scenario 6: print rating , distinct(release_year) records from film table. 
SELECT f.rating
-- , DISTINCT f.release_year 
FROM sakila.film f;
-- Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'DISTINCT f.release_year  FROM sakila.film f' at line 1
-- Why it didn't work ? Ambiguous for SQL as different column lengths. 5 types of ratings but only 1 year 2006. 

#-----------------------------------------------------------------------
#  DEMONSTRATING UPDATE OPERATION
#-----------------------------------------------------------------------


#-----------------------------------------------------------------------
#  DEMONSTRATING DELETE OPERATION
#-----------------------------------------------------------------------