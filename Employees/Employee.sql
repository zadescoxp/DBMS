CREATE DATABASE IF NOT EXISTS Employees;

USE Employees;

CREATE TABLE IF NOT EXISTS Dept (
    DeptNo int PRIMARY KEY,
    DName varchar(225),
    DLoc varchar(225)
);

CREATE TABLE IF NOT EXISTS Employee (
    EmpNo int PRIMARY KEY,
    EName varchar(225),
    MgrNo int,
    HireDate date,
    Sal int,
    DeptNo int,
    FOREIGN KEY (DeptNo) REFERENCES Dept(DeptNo) 
);

CREATE TABLE IF NOT EXISTS Project (
    PNo int PRIMARY KEY,
    PLoc varchar(225),
    PName varchar(225)
);

CREATE TABLE IF NOT EXISTS AssignedTo (
    EmpNo int,
    PNo int,
    JobRole varchar(225),
    PRIMARY KEY (EmpNo, PNo),
    FOREIGN KEY (EmpNo) REFERENCES Employee(EmpNo),
    FOREIGN KEY (PNo) REFERENCES Project(PNo)
);

CREATE TABLE IF NOT EXISTS Incentives (
    EmpNo int,
    IncentiveDate date,
    IncentiveAmount int,
    PRIMARY KEY (EmpNo, IncentiveDate),
    FOREIGN KEY (EmpNo) REFERENCES Employee(EmpNo)
);

INSERT INTO Dept VALUES
(1, 'HR', 'Bengaluru'),
(2, 'Engineering', 'Hyderabad'),
(3, 'Marketing', 'Mysuru'),
(4, 'Finance', 'Mumbai'),
(5, 'Operations', 'Delhi'),
(6, 'Support', 'Chennai');

INSERT INTO Employee VALUES
(101, 'Alice', NULL, '2020-01-15', 70000, 1),
(102, 'Bob', 101, '2019-03-22', 85000, 2),
(103, 'Charlie', 102, '2021-07-10', 60000, 3),
(104, 'Diana', 101, '2022-05-18', 75000, 4),
(105, 'Ethan', 104, '2023-02-01', 72000, 5),
(106, 'Farah', 102, '2023-06-12', 68000, 6);

INSERT INTO Project VALUES
(201, 'Bengaluru', 'Website Redesign'),
(202, 'Hyderabad', 'AI Development'),
(203, 'Mysuru', 'Ad Campaign'),
(204, 'Mumbai', 'Budget Analysis'),
(205, 'Delhi', 'Logistics Optimization'),
(206, 'Chennai', 'Customer Support');

INSERT INTO AssignedTo VALUES
(101, 201, 'Designer'),
(102, 202, 'Developer'),
(103, 203, 'Analyst'),
(104, 204, 'Financial Planner'),
(105, 205, 'Operations Lead'),
(106, 206, 'Support Engineer');

INSERT INTO Incentives VALUES
(101, '2023-12-01', 5000),
(102, '2023-12-01', 7000),
(104, '2023-12-01', 4500),
(105, '2023-12-01', 4000),
(106, '2023-12-01', 3000);

SELECT * FROM Dept;
SELECT * FROM Employee;
SELECT * FROM Project;
SELECT * FROM AssignedTo;
SELECT * FROM Incentives;

SELECT EmpNo FROM AssignedTo 
JOIN Project ON AssignedTo.PNo = Project.PNo
WHERE Project.PLoc IN ('Bengaluru', 'Hyderabad', 'Mysuru');

SELECT EmpNo FROM Employee
where EmpNo NOT IN (SELECT EmpNo from Incentives);

SELECT E.EmpNo, E.EName, D.DName, A.JobRole, D.DLoc AS DeptLocation, P.PLoc AS ProjectLocation
FROM Employee E
JOIN Dept D ON E.DeptNo = D.DeptNo
JOIN AssignedTo A ON E.EmpNo = A.EmpNo
JOIN Project P ON A.PNo = P.PNo
WHERE D.DLoc = P.PLoc;
