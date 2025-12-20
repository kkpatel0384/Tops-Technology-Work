create database testhospital;
use testhospital;

CREATE TABLE patient (
    pid VARCHAR(5) PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    age INT NOT NULL,
    weight INT NOT NULL,
    gender VARCHAR(10) NOT NULL,
    address VARCHAR(50) NOT NULL,
    phoneno INT NOT NULL,
    disease VARCHAR(20) NOT NULL,
    doctorid VARCHAR(5) NOT NULL
);



CREATE TABLE doctor (
    doctorid VARCHAR(5) PRIMARY KEY,
    doctorname VARCHAR(15) NOT NULL,
    dept VARCHAR(15) NOT NULL
);



CREATE TABLE lab (
    labno VARCHAR(5) PRIMARY KEY,
    pid VARCHAR(5) NOT NULL,
    weight INT NOT NULL,
    doctorid VARCHAR(5) NOT NULL,
    date DATETIME NOT NULL,
    category VARCHAR(15) NOT NULL,
    patient_type VARCHAR(15) NOT NULL,
    amount INT NOT NULL,
    FOREIGN KEY (doctorid) REFERENCES doctor(doctorid)
);



CREATE TABLE inpatient (
    pid VARCHAR(5) PRIMARY KEY,
    room_no VARCHAR(50) NOT NULL,
    date_of_adm DATETIME NOT NULL,
    date_of_dis DATETIME NOT NULL,
    advance INT NOT NULL,
    labno VARCHAR(5),
    FOREIGN KEY (labno) REFERENCES lab(labno)
);



CREATE TABLE outpatient (
    pid VARCHAR(5) PRIMARY KEY,
    date DATETIME NOT NULL,
    labno VARCHAR(5),
    FOREIGN KEY (labno) REFERENCES lab(labno)
);



CREATE TABLE room (
    room_no VARCHAR(50) PRIMARY KEY,
    room_type VARCHAR(10) NOT NULL,
    status VARCHAR(10) NOT NULL
);



CREATE TABLE bill (
    bill_no VARCHAR(50) PRIMARY KEY,
    pid VARCHAR(5),
    patient_type VARCHAR(10),
    doctor_charge INT NOT NULL,
    medicine_charge INT NOT NULL,
    room_charge INT NOT NULL,
    oprtn_charge INT,
    no_of_days INT,
    nursing_charge INT,
    advance INT,
    health_card VARCHAR(50),
    lab_charge INT,
    bill INT NOT NULL,
    FOREIGN KEY (pid) REFERENCES patient(pid)
);




INSERT INTO doctor (doctorid, doctorname, dept) VALUES
('1', 'Dr Amit', 'Cardio'),
('2', 'Dr Neha', 'Ortho'),
('3', 'Dr Raj', 'Neuro'),
('4', 'Dr Meena', 'ENT'),
('5', 'Dr Kiran', 'Dental'),
('6', 'Dr Ravi', 'Skin'),
('7', 'Dr Pooja', 'Eye'),
('8', 'Dr Sanjay', 'General'),
('9', 'Dr Anil', 'Cancer'),
('10', 'Dr Rina', 'Gynec');

ALTER TABLE patient
MODIFY phoneno VARCHAR(15);


INSERT INTO patient
(pid, name, age, weight, gender, address, phoneno, disease, doctorid)
VALUES
('1','Amit',25,65,'Male','Ahmedabad',1111111111,'Fever','1'),
('2','Neha',30,55,'Female','Surat',2222222222,'Fracture','2'),
('3','Raj',45,70,'Male','Vadodara',3333333333,'Migraine','3'),
('4','Meena',28,52,'Female','Rajkot',4444444444,'Ear Pain','4'),
('5','Kiran',35,68,'Male','Bhavnagar',5555555555,'Tooth Pain','5'),
('6','Ravi',40,75,'Male','Junagadh',6666666666,'Skin Allergy','6'),
('7','Pooja',22,50,'Female','Anand',7777777777,'Eye Check','7'),
('8','Sanjay',55,80,'Male','Gandhinagar',8888888888,'BP','8'),
('9','Anil',60,78,'Male','Nadiad',9999999999,'Cancer','9'),
('10','Rina',32,58,'Female','Valsad',1010101010,'Pregnancy','10');



INSERT INTO lab
(labno, pid, weight, doctorid, date, category, patient_type, amount)
VALUES
('1','1',65,'1','2025-01-01 10:00','Blood','OP',500),
('2','2',55,'2','2025-01-02 11:00','XRay','IP',800),
('3','3',70,'3','2025-01-03 12:00','MRI','IP',2000),
('4','4',52,'4','2025-01-04 09:30','ENT','OP',600),
('5','5',68,'5','2025-01-05 10:15','Dental','OP',700),
('6','6',75,'6','2025-01-06 11:45','Skin','OP',500),
('7','7',50,'7','2025-01-07 12:30','Eye','OP',400),
('8','8',80,'8','2025-01-08 09:00','BP','IP',300),
('9','9',78,'9','2025-01-09 10:00','CT','IP',2500),
('10','10',58,'10','2025-01-10 11:00','Scan','OP',1200);



INSERT INTO inpatient
(pid, room_no, date_of_adm, date_of_dis, advance, labno)
VALUES
('1','1','2025-01-01','2025-01-03',2000,'1'),
('2','2','2025-01-02','2025-01-06',5000,'2'),
('3','3','2025-01-03','2025-01-10',8000,'3'),
('4','4','2025-01-04','2025-01-05',1500,'4'),
('5','5','2025-01-05','2025-01-07',2500,'5'),
('6','6','2025-01-06','2025-01-08',1800,'6'),
('7','7','2025-01-07','2025-01-09',1200,'7'),
('8','8','2025-01-08','2025-01-12',3000,'8'),
('9','9','2025-01-09','2025-01-20',10000,'9'),
('10','10','2025-01-10','2025-01-12',4000,'10');



INSERT INTO outpatient 
(pid, date , labno)
VALUES
('1','2025-01-01','1'),
('2','2025-01-02','2'),
('3','2025-01-03','3'),
('4','2025-01-04','4'),
('5','2025-01-05','5'),
('6','2025-01-06','6'),
('7','2025-01-07','7'),
('8','2025-01-08','8'),
('9','2025-01-09','9'),
('10','2025-01-10','10');


INSERT INTO room (room_no, room_type, status) VALUES
('1','AC','Occupied'),
('2','NonAC','Available'),
('3','ICU','Occupied'),
('4','AC','Available'),
('5','NonAC','Occupied'),
('6','ICU','Available'),
('7','AC','Occupied'),
('8','NonAC','Available'),
('9','ICU','Occupied'),
('10','AC','Available');


INSERT INTO bill (bill_no, pid, patient_type, doctor_charge, medicine_charge, room_charge, oprtn_charge, no_of_days, nursing_charge, advance, health_card, lab_charge, bill) VALUES
('1','1','OP',500,300,200,150,2,250,100,'HC1',500,2000),
('2','2','IP',1000,600,2000,1500,4,800,500,'HC2',800,7200),
('3','3','IP',1500,700,3000,2000,7,1200,800,'HC3',2000,11200),
('4','4','OP',400,200,300,100,1,200,50,'HC4',600,1850),
('5','5','OP',600,300,400,200,2,300,100,'HC5',700,2600),
('6','6','OP',500,250,350,150,1,250,100,'HC6',500,2100),
('7','7','OP',300,200,250,120,1,180,80,'HC7',400,1530),
('8','8','IP',800,400,1800,600,5,700,300,'HC8',300,4900),
('9','9','IP',2000,1000,5000,3000,10,2000,1000,'HC9',2500,16500),
('10','10','OP',700,350,450,200,2,300,150,'HC10',1200,3650);

select * from bill;
select * from doctor;
select * from inpatient;
select * from lab;
select * from outpatient;
select * from patient;
select * from room;


SELECT * FROM patient WHERE age > 40;
SELECT * FROM patient WHERE weight > 70 OR gender = 'Female';
SELECT * FROM patient WHERE NOT disease = 'Fever';
SELECT gender, COUNT(*) AS total_patients FROM patient GROUP BY gender;
SELECT SUM(advance) AS total_advance FROM inpatient;

select pid, name ,age , age +5 as new_age from patient;

SELECT pid, name, weight, weight - (weight * 0.10) AS new_weight FROM patient;

SELECT * FROM patient WHERE age > 50;

select patient_type , count(*) as total_patient from bill group by patient_type having total_patient >2;

select patient_type , count(*) as total_patient from bill group by patient_type having count(*) between 1 and 6;

SELECT SUM(advance) AS total_advance FROM inpatient;

SELECT patient_type, SUM(amount) AS total_lab_amount
FROM lab
GROUP BY patient_type
HAVING total_lab_amount > 1000;

SELECT pid, name, age FROM patient ORDER BY age ASC LIMIT 5;

SELECT pid, name, age FROM patient ORDER BY age DESC LIMIT 5;

SELECT DISTINCT doctorid FROM patient;

SELECT DISTINCT patient_type FROM lab;

SELECT DISTINCT status FROM room;

SELECT * FROM patient WHERE name LIKE 'A%';

SELECT * FROM patient WHERE address LIKE '%Ahmedabad%';

SELECT * FROM patient WHERE age BETWEEN 25 AND 40;

SELECT * FROM inpatient WHERE labno IS NULL;

SELECT * FROM inpatient WHERE labno IS NOT NULL;


SELECT p.name AS patient_name, d.doctorname AS doctor_name
FROM patient p
INNER JOIN doctor d
ON p.doctorid = d.doctorid;


SELECT i.pid, i.room_no, i.date_of_adm, l.category, l.amount
FROM inpatient i
LEFT JOIN lab l
ON i.labno = l.labno;

SELECT i.pid, i.room_no, i.date_of_adm, l.category, l.amount
FROM inpatient i
Right JOIN lab l
ON i.labno = l.labno;

SELECT l.labno, l.category, p.name AS patient_name
FROM lab l
LEFT JOIN patient p
ON l.pid = p.pid;

SELECT i.pid, i.room_no, i.date_of_adm, l.category, l.amount
FROM inpatient i
LEFT JOIN lab l
ON i.labno = l.labno
union
SELECT i.pid, i.room_no, i.date_of_adm, l.category, l.amount
FROM inpatient i
Right JOIN lab l
ON i.labno = l.labno;

SELECT patient_type, SUM(amount) AS total_amount
FROM lab
GROUP BY patient_type
HAVING total_amount > 500;



delimiter //
create procedure show_patient()
begin
	 SELECT * FROM patient;
end //
delimiter ;

call show_patient();


DELIMITER //

CREATE PROCEDURE insert_patient(
    IN pname VARCHAR(20),
    IN pgender VARCHAR(10),
    IN paddress VARCHAR(50),
    IN pphoneno VARCHAR(15)
)
BEGIN
    INSERT INTO customers (name, gender, address, phoneno)
    VALUES (pname, pgender, paddress, pphoneno);
END//

DELIMITER ;

CALL insert_patient('Amit', 'Male', 'Ahmedabad', '9876543210');





