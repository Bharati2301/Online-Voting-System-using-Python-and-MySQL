# Online-Voting-System-using-Python-and-MySQL

## INTRODUCTION
Since US elections are right around the corner and Corona virus is still spreading all across the world.
Assuming that India had its elections this year during the pandemic, going to a Voting centre would be impractical.
Because of India’s high population density maintaining social distancing and other precautionary measures during voting would be difficult.
To overcome this issue we wanted to come up with an alternative online voting system for elections in India.

## BENEFITS
The online voting system – India shall reduce the time spend making long queues at the voting centres. 
It shall also enable the voters to vote from any part of the globe since this is an online application available on the internet. 
Cases of vote miscounts shall also be solved since at the backend of this system resides a well developed database using MYSQL that can provide the correct data once it’s correctly queried. 
Since the voting process shall be online, the voters can vote at anytime on that day and there won’t be a need for declaring  the day of the election as a holiday



## ENTITY RELATIONSHIP DIAGRAM
* ENTITY RELATIONAL (ER) MODEL is a high-level conceptual data model diagram. ER modelling helps you to analyse data requirements systematically to produce a well-designed database.
* ERD displays the relationships of entity set stored in a database.

<p align="center">
  <img src="https://user-images.githubusercontent.com/71218441/154513498-5882feec-6974-4839-a7c2-267fd48ca161.jpg" width="700" height="600"/>
</p>

## TABLES
1) Election Table:
* Type: Type of election happening. (In our case: STATE ASSEMBLY - CM)
* Id: Id for type of election
2) Party Table:
* Id: Party ID
* Name: Party Name
* Symbol: Party Symbol
* Leader: Party Leader
3) Candidate Type:
* Type: Candidate is applying for which post. (In our case: MLA-Member of Legislative Assembly)
* Type ID: Id of post applied for
4) Candidate Table:
* ID: Id for each Candidate
* Aadhaar: Candidate’s Aadhaar no.
* Type ID: Id of post he is standing for
* Party ID: Id of which party he belongs to
* Election ID: Id of which type of election is he nominated in
* District ID: Id of District in which he is standing for
5) User Type: 
* Type: Who is voting Citizen / Candidate
* Type ID: Id of Voter
6) User Table:
* It basically Contains Voter information required during login
* Is Active: Is the registered voter Alive or Dead
* User Type ID: Id of User Type (Citizen / Candidate)
* Voter Id: Voter Id of every user
* Def_Password: The system generated password that was initially given to the user, which can later be changed
* Aadhaar: Aadhaar no. for reference from the Voter Table and connect information of both tables
* NOTE: User table is linked with the Voter Table with the common column Aadhaar no. It basically includes the above details every person with the given Aadhaar no.
7) Voter Table:
* Contains Aadhaar No., First Name, Last Name, Mother’s Name, Father’s Name, Sex, Birthday, Age, District ID, Phone No.
* It basically contains information during registration of voter
* It is linked with the User table with Aadhaar Id
8) Address:
* District ID: Area-wise Id
* Locality: Area from where he/she is voting
* City & State: City and State of User
* Pin code: Pin code of locality of the user
* NOTE: This table contains information about the Permanent Address of the Voter
9) Vote Table:
* Vote ID: Auto-assigned Id. (Nothing to do with Citizen)
* Voter ID: Who voted, that person’s Voter Id
* Party ID: Whom the person voted to 
* District ID: District ID for the region the person has voted for
* Candidate ID: The ID of candidate of the party they voted for
