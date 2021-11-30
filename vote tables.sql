CREATE TABLE if not exists address(
  DistrictId integer NOT NULL,
  Locality VARCHAR(30) NOT NULL,
  City VARCHAR(30) NOT NULL,
  State VARCHAR(30) NOT NULL, 
  Zip VARCHAR(10) NOT NULL,
  CONSTRAINT PK_District PRIMARY KEY (DistrictId));
  
CREATE TABLE if not exists voter_table(
  Aadhaar char(15) NOT NULL unique, 
  FirstName VARCHAR(30) NOT NULL,
  MiddleName VARCHAR(30) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  Sex char(7) not null,
  Birthday DATE NOT NULL,
  Age int not null,
  Phone Numeric NOT NULL, 
  Email varchar(50) NOT NULL,
  DistrictId integer NOT NULL, 
  CONSTRAINT PK_VOTER PRIMARY KEY (Aadhaar),
  CONSTRAINT FK_DISTRICT FOREIGN KEY (DistrictId) references Address(DistrictId));
  
  
CREATE TABLE if not exists party_table(
  PartyId int not null auto_increment ,
  PartyName varchar(20) not null unique,
  Symbol Varchar(20) not null unique,
  PartyLeader varchar(50) not null,
  LeaderAadhaar char(15) not null unique,
  CONSTRAINT PK_PARTY PRIMARY KEY (PartyId),
  CONSTRAINT FK_VOTER_3 FOREIGN KEY (LeaderAadhaar) references voter_table(Aadhaar));

  
CREATE TABLE if not exists candidate_table(
  CandidateId int not null auto_increment ,
  Aadhaar char(15) not null unique,
  CandidateName varchar(100),
  PartyId int not null,
  DistrictId int not null,
  CONSTRAINT PK_CANDIDATE PRIMARY KEY (CandidateId),
  CONSTRAINT FK_VOTER FOREIGN KEY (Aadhaar) references voter_table(Aadhaar),
  CONSTRAINT FK_DISTRICT_2 FOREIGN KEY (DistrictId) references address(DistrictId),
  CONSTRAINT FK_PARTY FOREIGN KEY (PartyId) references party_table(PartyId));
  
CREATE TABLE if not exists user_table(
  VoterId varchar(10) not null,
  Aadhaar char(15) not null unique,
  _Password varchar(50) not null,
  CONSTRAINT PK_USER PRIMARY KEY (VoterId),
  CONSTRAINT FK_VOTER_2 FOREIGN KEY (Aadhaar) references voter_table(Aadhaar));
  
  
CREATE TABLE if not exists vote_table(
  VoteId int not null auto_increment,
  Aadhaar char(15) not null unique,
  PartyId int not null,
  CandidateId int not null,
  DistrictId int not null,
  CONSTRAINT PK_VOTE PRIMARY KEY (VoteID),
  CONSTRAINT FK_VOTERID FOREIGN KEY (Aadhaar) references user_table(Aadhaar),
  CONSTRAINT FK_CANDIDATEID FOREIGN KEY (CandidateId) references candidate_table(CandidateId),
  CONSTRAINT FK_DISTRICT_4 FOREIGN KEY (DistrictId) references address(DistrictId),
  CONSTRAINT FK_PARTY_2 FOREIGN KEY (PartyId) references party_table(PartyId));
 
 
CREATE TABLE if not exists result(
  ResultId int not null auto_increment,
  CandidateId int not null,
  PartyId int not null,
  DistrictId int not null,
  Vote_Count int not null,
  CONSTRAINT PK_RESULT PRIMARY KEY (ResultId),
  CONSTRAINT FK_CANDIDATEID_2 FOREIGN KEY (CandidateId) references candidate_table(CandidateId),
  CONSTRAINT FK_DISTRICT_5 FOREIGN KEY (DistrictId) references address(DistrictId),
  CONSTRAINT FK_PARTY_3 FOREIGN KEY (PartyId) references party_table(PartyId));
  
DELIMITER //
CREATE TRIGGER Vote_counting
after insert on vote_table
FOR EACH ROW
BEGIN 
if not exists (select CandidateId from result where result.CandidateId=new.CandidateId)
then
insert into result(CandidateId,PartyId,DistrictId,Vote_Count) values(new.CandidateId,new.PartyId,new.DistrictId,1);
else
update result set result.Vote_Count=result.Vote_Count+1 where result.CandidateId=new.CandidateId;
end if; 
END //
DELIMITER ;
