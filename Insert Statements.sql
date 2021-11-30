#Candidate_Type
insert into Candidate_Type values(100,"MP");
insert into Candidate_Type values(101,"MLA");

#User_Type
insert into User_Type values(1,"Candidate");
insert into User_Type values(2,"Citizen");

#Party_Table
insert into Party_Table values(11,"BJP","Lotus","Narendra Modi");
insert into Party_Table values(12,"INC","Hand","Rahul Gandhi");
insert into Party_Table values(13,"AAP","Broom","Arvind Kejriwa");
insert into Party_Table values(14,"BSP","Elephant","Mayawati");

#Election_Table
insert into Election_Table values(200,"General Elections");
insert into Election_Table values(201,"State Assembly");

#Address
insert into Address values(234,"Andheri","mumbai","Maharashtra",400059);
insert into Address values(235,"Hadapsar","Pune","Maharashtra",411013);
insert into Address values(236,"Malviya","Lucknow","Uttar Pradesh",226004);
insert into Address values(237,"Depalpur","Indore","Madhya Pradesh",453115);

#Voter_Table
insert into Voter_Table values("3591 4628 3661","Akash","Singh","Aishwarya","Bhavesh","M","1984-02-16",37,234,"9623412913");
insert into Voter_Table values("5773 7940 7366","Dipti","Kumar","Gayatri","Dheeraj","F","1998-01-13",23,235,9222325956);
insert into Voter_Table values("7820 3429 4038","Shlok","Agarwal","Aparna","Girish","M","1988-02-04",33,234,9722768470);
insert into Voter_Table values("6169 5028 5641","Rashid","Khan","Indira","Abhay","M","1976-10-17",44,235,9414321457);
insert into Voter_Table values("7367 4166 6818","Nicole","Dias","Juhi","Deepak","F","1991-12-08",29,234,9913542379);
insert into Voter_Table values("5698 6323 9187","Muskan","Gupta","Latika","Harmeet","F","1990-07-14",30,235,9406269045);
insert into Voter_Table values("3552 8455 9830","Saima","Shaikh","Anushree","Bipin","F","1975-12-02",45,234,9251125952);
insert into Voter_Table values("4616 8141 8774","Mayur","Chauhan","Mallika","Mahendra","M","1998-06-01",22,235,9445560413);
insert into Voter_Table values("5629 4547 8360","Aniket","Mali","Namrata","Aditya","M","1977-08-30",43,234,9353628848);
insert into Voter_Table values("9159 9075 6877","Priti","Krishna","Niharika","Rakesh","F","1984-02-03",37,235,9357732303);
insert into Voter_Table values("9996 7085 3995","Bhavna","Wadhwani","Arpita","Mehul","F","1986-05-18",34,234,9600223943);
insert into Voter_Table values("3904 9051 4118","Shrishti","Shetty","Pallavi","Mukesh","F","1993-04-04",28,235,9661640359);
insert into Voter_Table values("6219 8659 3521","Harsh","Chougle","Rashmi","Akshat","M","1990-04-25",30,234,9978862736);
insert into Voter_Table values("8683 3592 5077","Rehmat","Khan","Saloni","Nitish","M","1981-04-27",39,235,9673536403);
insert into Voter_Table values("6179 3483 8162","Joey","Dsouza","Priyanka","Prakash","M","1980-06-21",40,234,9533089508);
insert into Voter_Table values("8199 8865 9927","Celina","Dias","Eva","Thomas","F","1975-01-27",46,235,9356542209);
insert into Voter_Table values("5307 8510 8738","Binita","Soni","Anjali","Aniket","F","1992-02-04",29,234,9472486996);
insert into Voter_Table values("5039 9340 8931","Aasim","Moulvi","Jasbir","Rahul","M","1971-12-06",49,235,9995661892);
insert into Voter_Table values("4413 5402 5058","Vinit","Rajput","Sneha","Randhir","M","1972-11-23",48,234,9254284523);
insert into Voter_Table values("5308 9629 6615","Neha","Bhatt","Tanushree","Arun","F","1975-08-12",45,235,9358443022);
insert into Voter_Table values("8392 3921 0192","Aditi","Kharat","Simran","Jitendra","F","1948-06-06",72,234,9821009201);

#Candidate_Table
insert into Candidate_Table values(1034,"3904 9051 4118",101,11,201,235);
insert into Candidate_Table values(1035,"6219 8659 3521",101,11,201,234);
insert into Candidate_Table values(1036,"8683 3592 5077",101,13,201,235);
insert into Candidate_Table values(1037,"6179 3483 8162",101,12,201,234);
insert into Candidate_Table values(1038,"8199 8865 9927",101,12,201,235);
insert into Candidate_Table values(1039,"7820 3429 4038",101,13,201,234);
insert into Candidate_Table values(1040,"6169 5028 5641",101,14,201,235);
insert into Candidate_Table values(1041,"7367 4166 6818",101,14,201,234);

#User_Table
insert into User_Table values("ABC659753","ABC@3661",1,"3591 4628 3661",2);
insert into User_Table values("JID563930","JID@7366",1,"5773 7940 7366",2);
insert into User_Table values("KOF752745","KOF@4038",1,"7820 3429 4038",1);
insert into User_Table values("KFL505615","KFL@5641",1,"6169 5028 5641",1);
insert into User_Table values("OKF618375","OKF@6818",1,"7367 4166 6818",1);
insert into User_Table values("LPK191656","LPK@9187",1,"5698 6323 9187",2);
insert into User_Table values("JIJ126650","JIJ@9830",1,"3552 8455 9830",2);
insert into User_Table values("PLD990405","PLD@8774",1,"4616 8141 8774",2);
insert into User_Table values("KPF247360","KPF@8360",1,"5629 4547 8360",2);
insert into User_Table values("KLP662421","KLP@6877",1,"9159 9075 6877",2);
insert into User_Table values("OKF192549","OKF@3995",1,"9996 7085 3995",2);
insert into User_Table values("PXS330426","PXS@4118",1,"3904 9051 4118",1);
insert into User_Table values("DKS350620","DKS@3521",1,"6219 8659 3521",1);
insert into User_Table values("DKM595147","DKM@5077",1,"8683 3592 5077",1);
insert into User_Table values("UHD596266","UHD@8162",1,"6179 3483 8162",1);
insert into User_Table values("DAK821391","DAK@9927",1,"8199 8865 9927",1);
insert into User_Table values("CDK501224","CDK@8738",1,"5307 8510 8738",2);
insert into User_Table values("LFP359677","LFP@8931",1,"5039 9340 8931",2);
insert into User_Table values("LDK886759","LDK@5058",1,"4413 5402 5058",2);
insert into User_Table values("OKD930875","OKD@6615",1,"5308 9629 6615",2);
insert into User_Table values("UDJ092345","UDJ@0192",0,"8392 3921 0192",2);

#Vote_Table
insert into Vote_Table values("V1","ABC659753",11,1035,234,"ABC@3661","ABC@3661");
insert into Vote_Table values("V2","JID563930",11,1034,235,"JID@7366","JID@7366");
insert into Vote_Table values("V3","KOF752745",13,1039,234,"KOF@4038","KOF@4038");
insert into Vote_Table values("V4","KFL505615",14,1040,235,"KFL@5641","KFL@5641");
insert into Vote_Table values("V5","OKF618375",14,1041,234,"OKF@6818","OKF@6818");
insert into Vote_Table values("V6","LPK191656",12,1038,235,"LPK@9187","LPK@9187");
insert into Vote_Table values("V7","JIJ126650",11,1035,234,"JIJ@9830","JIJ@9830");
insert into Vote_Table values("V8","PLD990405",11,1034,235,"PLD@8774","PLD@8774");
insert into Vote_Table values("V9","KPF247360",12,1037,234,"KPF@8360","KPF@8360");
insert into Vote_Table values("V10","KLP662421",13,1036,235,"KLP@6877","KLP@6877");
insert into Vote_Table values("V11","OKF192549",11,1035,234,"OKF@3995","OKF@3995");
insert into Vote_Table values("V12","PXS330426",11,1034,235,"PXS@4118","PXS@4118");
insert into Vote_Table values("V13","DKS350620",11,1035,234,"DKS@3521","DKS@3521");
insert into Vote_Table values("V14","DKM595147",13,1036,235,"DKM@5077","DKM@5077");
insert into Vote_Table values("V15","UHD596266",12,1037,234,"UHD@8162","UHD@8162");
insert into Vote_Table values("V16","DAK821391",12,1038,235,"DAK@9927","DAK@9927");
insert into Vote_Table values("V17","CDK501224",11,1035,234,"CDK@8738","CDK@8738");
insert into Vote_Table values("V18","LFP359677",13,1036,235,"LFP@8931","LFP@8931");
insert into Vote_Table values("V19","LDK886759",12,1037,234,"LDK@5058","LDK@5058");
insert into Vote_Table values("V20","OKD930875",11,1034,235,"OKD@6615","OKD@6615");

select * from vote_table;
select * from result;
select * from voter_table;