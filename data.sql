-- If there is already any data in these tables, empty it out.

TRUNCATE TABLE Result CASCADE;
TRUNCATE TABLE Grade CASCADE;
TRUNCATE TABLE RubricItem CASCADE;
TRUNCATE TABLE Grader CASCADE;
TRUNCATE TABLE Submissions CASCADE;
TRUNCATE TABLE Membership CASCADE;
TRUNCATE TABLE AssignmentGroup CASCADE;
TRUNCATE TABLE Required CASCADE;
TRUNCATE TABLE Assignment CASCADE;
TRUNCATE TABLE MarkusUser CASCADE;


-- Now insert data from scratch.

INSERT INTO MarkusUser VALUES ('i1', 'iln1', 'ifn1', 'instructor');
INSERT INTO MarkusUser VALUES ('s1', 'sln1', 'sfn1', 'student');
INSERT INTO MarkusUser VALUES ('s2', 'sln2', 'sfn2', 'student'); --
INSERT INTO MarkusUser VALUES ('t1', 'tln1', 'tfn1', 'TA');
INSERT INTO MarkusUser VALUES ('t2', 'tln2', 'tln2', 'TA');
INSERT INTO MarkusUser VALUES ('t3', 'tln3', 'tln3', 'TA');
INSERT INTO MarkusUser VALUES ('t4', 'tln4', 'tln4', 'TA');

-- assn id, descp, due, min, max
INSERT INTO Assignment VALUES (1000, 'a1', '2017-01-08 20:00', 1, 2); --
INSERT INTO Assignment VALUES (2000, 'a2', '2017-02-08 20:00', 1, 2);
INSERT INTO Assignment VALUES (3000, 'a3', '2017-03-08 20:00', 1, 2);
INSERT INTO Assignment VALUES (4000, 'a4', '2017-04-08 20:00', 1, 2);
INSERT INTO Assignment VALUES (5000, 'a5', '2017-05-08 20:00', 1, 2);

INSERT INTO Required VALUES (1000, 'A1.pdf');

-- group id, assignment id
INSERT INTO AssignmentGroup VALUES (1, 1000, 'repo_url');--
INSERT INTO AssignmentGroup VALUES (2, 2000, 'repo_url');
INSERT INTO AssignmentGroup VALUES (3, 3000, 'repo_url');
INSERT INTO AssignmentGroup VALUES (4, 4000, 'repo_url');

-- student, group
INSERT INTO Membership VALUES ('s1', 1);
INSERT INTO Membership VALUES ('s2', 1);--
INSERT INTO Membership VALUES ('s1', 2);
INSERT INTO Membership VALUES ('s2', 2);--
INSERT INTO Membership VALUES ('s1', 3);
INSERT INTO Membership VALUES ('s2', 3);
INSERT INTO Membership VALUES ('s1', 4);
INSERT INTO Membership VALUES ('s2', 4);

INSERT INTO Submissions VALUES (3000, 'A1.pdf', 's1', 2000, '2017-02-08 19:59');

-- group id, username
INSERT INTO Grader VALUES (1, 't1');--
INSERT INTO Grader VALUES (2, 't1');--
INSERT INTO Grader VALUES (3, 't1');--
INSERT INTO Grader VALUES (4, 't2');

INSERT INTO RubricItem VALUES (4010, 1000, 'style', 4, 0.25);
INSERT INTO RubricItem VALUES (4011, 1000, 'tester', 12, 0.75);--
INSERT INTO RubricItem VALUES (4020, 2000, 'style', 4, 0.25);
INSERT INTO RubricItem VALUES (4021, 2000, 'tester', 12, 0.75);
INSERT INTO RubricItem VALUES (4030, 3000, 'style', 4, 0.25);
INSERT INTO RubricItem VALUES (4031, 3000, 'tester', 12, 0.75);

INSERT INTO Grade VALUES (1, 4010, 3);
INSERT INTO Grade VALUES (1, 4011, 9);--
INSERT INTO Grade VALUES (2, 4020, 2);
INSERT INTO Grade VALUES (2, 4021, 8);
INSERT INTO Grade VALUES (3, 4030, 1);
INSERT INTO Grade VALUES (3, 4031, 7);

INSERT INTO Result VALUES (2, 12, true);
INSERT INTO Result VALUES (3, 12, true);
INSERT INTO Result VALUES (4, 12, true);
