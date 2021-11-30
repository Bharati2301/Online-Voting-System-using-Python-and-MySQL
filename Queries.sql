#What if a person changes there number permanently?
update voter_table set Phone=9283478293 where AADHAAR="5773 7940 7366";


#What will you do if for some political reason voting needs to occur again and you have to delete all rows from the vote and result table?
truncate result;
truncate vote_table;
select * from result;
select * from vote_table;


#Do you want to know how many people from voted from a particular district?
CREATE VIEW district_vote_count AS
SELECT DistrictID, SUM(Vote_Count)
FROM Result
GROUP BY DistrictID;

drop view district_vote_count;
select* from district_vote_count;


#Do you know how many a votes each party got from all the districts combined?
CREATE VIEW party_vote_count AS
SELECT Result.PartyID, party_table.PartyName,SUM(Vote_Count) AS 'Total_Count'
FROM Result,party_table
WHERE Party_table.Partyid = Result.partyID
GROUP BY result.PartyID
ORDER BY Total_Count DESC;


drop view party_vote_count;
select* from party_vote_count;


#What will we do with a person’s information who dies? 
delete voter_table,user_table from Voter_Table,User_Table where Voter_Table.Aadhaar=User_table.Aadhaar and User_Table.isActive=0;
#OR 
delete Voter_Table,User_Table From Voter_Table INNER JOIN User_Table on Voter_Table.Aadhaar=User_table.Aadhaar where User_Table.isActive=0;

select count(*) from user_table where User_Table.isActive=0;
insert into User_Table values("UDJ092345","UDJ@0192",0,"8392 3921 0192",2);
insert into Voter_Table values("8392 3921 0192","Aditi","Kharat","Simran","Jitendra","F","1948-06-06",72,234,9821009201);


#Want all the details related to each candidate?
create view candidate_detail as
SELECT CandidateID, party_table.PartyName, voter_table.*
FROM candidate_table LEFT JOIN voter_table 
ON candidate_table.AADHAAR = voter_table.AADHAAR
INNER JOIN party_table 
ON Party_table.Partyid = candidate_table.partyID;

drop view candidate_detail;
select * from candidate_detail;
