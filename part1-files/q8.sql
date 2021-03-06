-- Never solo by choice

SET SEARCH_PATH TO markus;
DROP TABLE IF EXISTS q8;

-- You must not change this table definition.
CREATE TABLE q8 (
	username varchar(25),
	group_average real,
	solo_average real
);

-- You may find it convenient to do this for each of the views
-- that define your intermediate steps.  (But give them better names!)

DROP VIEW IF EXISTS groupAssignment CASCADE;
DROP VIEW IF EXISTS soloAssignment CASCADE;
DROP VIEW IF EXISTS groups CASCADE;
DROP VIEW IF EXISTS membersInGroupAssignments CASCADE;
DROP VIEW IF EXISTS groupAllTheWay CASCADE;
DROP VIEW IF EXISTS hardWorkersAndWork CASCADE;
DROP VIEW IF EXISTS hardWorkders CASCADE;
DROP VIEW IF EXISTS group_average CASCADE;
DROP VIEW IF EXISTS solo_average CASCADE;

-- Define views for your intermediate steps here.

-- ======================================================================
-- concerning the assignment percentages for <group, assignment>
DROP VIEW IF EXISTS assignment_outof CASCADE;
DROP VIEW IF EXISTS real_grade CASCADE;

create view assignment_outof as
	select assignment_id, sum(out_of * weight) as assignment_outof
	from RubricItem group by assignment_id;

create view real_grade as 
	select assignment_id, group_id, mark * 100/assignment_outof as r_grade
	from AssignmentGroup natural join assignment_outof natural join Result;

-- ======================================================================


-- find id of all assignments that must be done in groups
create view groupAssignment as
	select assignment_id 
	from Assignment
	where group_max > 1;

-- find id of all assignments that must be done solo
create view soloAssignment as
	select assignment_id
	from assignment 
	where group_max = 1;

-- find id of multi-student groups in group allowing assignments
create view groups as
	select group_id
	from groupAssignment natural join Membership natural join AssignmentGroup
	group by group_id
	having count(username) > 1;

-- get group id, assignment id, username associated with multi-student groups
create view membersInGroupAssignments as
	select group_id, assignment_id, username
	from groups natural join Membership natural join AssignmentGroup natural join groupAssignment;

-- find username of students who stay in groups in all group allowing assignments 
-- by checking how many times they stayed in a group against total number of group allowing assignments
create view groupAllTheWay as 
	select username 
	from membersInGroupAssignments
	group by username
	having count(group_id) >= (select count(distinct assignment_id) from membersInGroupAssignments);

-- from the always-in-group students choose those who submitted in every assignment
-- by checking how many times they submitted for their groups against total number of ALL assignments
create view hardWorkers as 
	select distinct username
	from submissions natural join groupAllTheWay
	group by username
	having count(distinct group_id) >= (select count(distinct assignment_id) from AssignmentGroup);

-- find average mark of group-inclining people across all group assignments
create view group_average as
	select username, avg(r_grade) as group_avg
	from real_grade natural join hardWorkers natural join groupAssignment
	group by username;

-- find average mark of group-inclining people across all solo assignments
create view solo_average as
	select username, avg(r_grade) as solo_avg
	from real_grade natural join hardWorkers natural join soloAssignment
	group by username;

-- Final answer.
INSERT INTO q8
	-- put a final query here so that its results will go into the table.
	select * 
	from group_average natural join solo_average;