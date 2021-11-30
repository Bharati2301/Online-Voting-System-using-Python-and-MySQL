CREATE TABLE Address(
  DistrictID integer NOT NULL,
  Locality VARCHAR(30) NOT NULL,
  City VARCHAR(30) NOT NULL,
  State VARCHAR(30) NOT NULL, 
  Zip VARCHAR(10) NOT NULL,
  CONSTRAINT PK_District PRIMARY KEY (DistrictID));
  
CREATE TABLE Voter_Table(
  AADHAAR char(15) NOT NULL , 
  FirstName VARCHAR(30) NOT NULL,
  Lastname VARCHAR(50) NOT NULL,
  MotherName VARCHAR(30),
  FatherName VARCHAR(30),
  Sex char(7) not null,
  Birthday DATE NOT NULL,
  Age int not null,
  DistrictID integer NOT NULL, 
  Phone Numeric NOT NULL, 
  CONSTRAINT PK_VOTER PRIMARY KEY (AADHAAR),
  CONSTRAINT FK_DISTRICT FOREIGN KEY (DistrictID) references Address(DistrictID));
  
CREATE TABLE Candidate_Type(
  CandidateTypeID int not null,
  CandidateType varchar(20) not null,
  CONSTRAINT PK_CANDIDATETYPE PRIMARY KEY (CandidateTypeID));
  
CREATE TABLE Election_Table(
  ElectionID int not null,
  ElectionType varchar(20) not null,
  CONSTRAINT PK_ELECTION PRIMARY KEY (ElectionID));
  
CREATE TABLE Party_Table(
  PartyID int not null,
  PartyName varchar(20) not null unique,
  Symbol Varchar(20) not null unique,
  PartyLeader varchar(50) not null,
  CONSTRAINT PK_PARTY PRIMARY KEY (PartyID));

CREATE TABLE User_Type(
  UserTypeID int not null,
  UserType varchar(20) not null,
  CONSTRAINT PK_USERTYPE PRIMARY KEY (UserTypeID));
  
CREATE TABLE Candidate_Table(
  CandidateID int not null,
  AADHAAR char(15) not null,
  CandidateTypeID int not null,
  PartyID int not null,
  ElectionID int not null,
  DistrictID int not null,
  CONSTRAINT PK_CANDIDATE PRIMARY KEY (CandidateID),
  CONSTRAINT FK_VOTER FOREIGN KEY (AADHAAR) references Voter_Table(AADHAAR),
  CONSTRAINT FK_DISTRICT_2 FOREIGN KEY (DistrictID) references Address(DistrictID),
  CONSTRAINT FK_ELECTION FOREIGN KEY (ElectionID) references Election_Table(ElectionID),
  CONSTRAINT FK_PARTY FOREIGN KEY (PARTYID) references Party_Table(PartyID),
  CONSTRAINT FK_CANDIDATETYPE FOREIGN KEY (CandidateTypeID) references Candidate_Type(CandidateTypeID));
  
CREATE TABLE User_Table(
  VoterID varchar(10) not null,
  Def_Password varchar(50) not null,
  isActive BOOLEAN not null,
  AADHAAR char(15) not null,
  UserTypeID int not null,
  CONSTRAINT PK_USER PRIMARY KEY (VoterID),
  CONSTRAINT FK_VOTER_2 FOREIGN KEY (AADHAAR) references Voter_Table(AADHAAR),
  CONSTRAINT FK_USERID FOREIGN KEY (UserTypeID) references User_Type(UserTypeID));
  
  
CREATE TABLE Vote_Table(
  VoteID varchar(7) not null,
  VoterID varchar(10) not null unique,
  PartyID int not null,
  CandidateID int not null,
  DistrictID int not null,
  Def_Password varchar(50) not null,
  password_entered varchar(50) not null,
  CONSTRAINT PK_VOTE PRIMARY KEY (VoteID),
  CONSTRAINT FK_VOTERID FOREIGN KEY (VoterID) references User_Table(VoterID),
  CONSTRAINT FK_CANDIDATEID FOREIGN KEY (CandidateID) references Candidate_Table(CandidateID),
  CONSTRAINT FK_DISTRICT_4 FOREIGN KEY (DistrictID) references Address(DistrictID),
  CONSTRAINT FK_PARTY_2 FOREIGN KEY (PARTYID) references Party_Table(PartyID),
  CHECK (Def_password=password_entered ));
 
 
CREATE TABLE Result(
  ResultID int not null auto_increment,
  CandidateID int not null,
  PartyID int not null,
  DistrictID int not null,
  Vote_Count int not null,
  CONSTRAINT PK_RESULT PRIMARY KEY (ResultID),
  CONSTRAINT FK_CANDIDATEID_2 FOREIGN KEY (CandidateID) references Candidate_Table(CandidateID),
  CONSTRAINT FK_DISTRICT_5 FOREIGN KEY (DistrictID) references Address(DistrictID),
  CONSTRAINT FK_PARTY_3 FOREIGN KEY (PARTYID) references Party_Table(PartyID));
  
DELIMITER //
CREATE TRIGGER Vote_counting
after insert on Vote_Table
FOR EACH ROW
BEGIN 
if not exists (select CandidateID from Result where Result.CandidateID=new.CandidateID)
then
insert into Result(CandidateID,PartyID,DistrictID,Vote_Count) values(new.CandidateID,new.PartyID,new.DistrictID,1);
else
update Result set Result.Vote_Count=Result.Vote_Count+1 where Result.CandidateID=new.CandidateID;
end if; 
END //
DELIMITER ;


show tables;
drop table result;
drop table Vote_Table;
drop table User_Table;
drop table Candidate_Table;
drop table User_Type;
drop table Party_Table;
drop table Election_Table;
drop table Candidate_Type;
drop table Voter_Table;
drop table Address;








