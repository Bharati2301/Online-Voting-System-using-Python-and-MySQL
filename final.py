import mysql.connector as connector
from datetime import date
import random
import datetime


class voting_system:
    def __init__(self):
        self.db=connector.connect(host='127.0.0.1',port = 3306,user='root',password='*******', database='voting_system')
        
    def sign_up(self):
        while True:
            Aadhaar=input('Aadhaar number: ')
            if len(Aadhaar)!=12:
                print("Invalid length of Aadhaar no.!\n")
            elif Aadhaar.isnumeric():
                break
            else:
                print("Aadhaar no. can only contain numbers!\n")
        query="Select FirstName from voter_table where Aadhaar={}".format(Aadhaar)
        cur=self.db.cursor()
        cur.execute(query)
        for r in cur:
            if r==None:
                break
            else:
                print("You are already registered!\n")
                return 
        while True:
            Fname=input("First Name: ").upper()
            Mname=input("Middle Name: ").upper()
            Lname=input("Last Name: ").upper()
            if Fname.isalpha() and Mname.isalpha() and Lname.isalpha():
                break
            else: print("Name can only contain characters!\n")
        while True:   
            Sex=input("Gender(F/M/Other): ").upper()
            if Sex=='F' or Sex=='M' or Sex=='Other': break
            else : print("Please enter valid input!\n")
        while True:
            Birthday=input("Date of birth(YYYY-MM-DD): ")
            format = "%Y-%m-%d"
            isValidDate = True
            try :
                datetime. datetime. strptime(Birthday, format)
            except ValueError :
                isValidDate = False
            if(isValidDate) : break
            else:
                print("This is the incorrect date string format. It should be YYYY-MM-DD\n")
        year, month, day = map(int, Birthday.split("-"))
        Age=date.today().year - year - 1
        if Age < 18:
            print("\nYou are not eligible to vote. Sorry!\n")
            print("Bye!")
            quit()
        while True:
            Phone=input("Phone Number: ")
            if len(Phone)!=10:
                print("Invalid length of Phone no.!\n")
            elif Phone.isnumeric():
                Phone=int(Phone)
                break
            else:
                print("Phone no. can only contain numbers!\n")
        while True:        
            Email=input("Email address: ")
            if ('@' and '.' in Email) and (Email.index("@")<Email.index(".") and (Email.index(".") < len(Email)-1) ) : 
                break
            else:
                print("Invalid Email Id !\n")
        print("\nEnter permanent address:")
        while True:
            locality=input("Locality: ")
            city=input("City: ")
            state=input("State: ")
            zipCode=input("Zip Code: ")
            DistrictId=self.districtId(locality,city,state)
            if DistrictId==None:
                print("Please enter valid address\n")
                continue
            break
            
        while True:
            Password=input("Password: ")
            Confirm_pass=input("Confirm password: ")
            if Confirm_pass==Password:
                break
            else:
                print("Password doesn't match! Enter again!\n")
        
        query="insert into voter_table values('{}','{}','{}','{}','{}','{}',{},{},'{}',{})".format(Aadhaar,Fname.upper(),Mname.upper(),Lname.upper(),Sex.upper(),Birthday,Age,Phone,Email.lower(),DistrictId)
        cur=self.db.cursor()
        cur.execute(query)
        self.db.commit()
        VoterId=self.user_table(Fname,Lname,Aadhaar,Password)
        print("\nRegistration completed!\nPlease save the following voterId for future login\nVoterID: ",VoterId)
    
    def districtId(self,locality,city,state):
        query="select DistrictId from address where locality='{}' and city='{}' and state='{}'".format(locality.upper(),city.upper(),state.upper())
        cur=self.db.cursor()
        cur.execute(query)
        for distId in cur:
            return distId[0]
    
    def user_table(self,Fname,Lname,Aadhaar,Password):
        vid=Fname[:2].upper()+Lname[0].upper()+str(random.randint(1000001,9999999))
        #check that vid isn't repeating --- voterid and aadhar combination will be unique during login
        query="insert into user_table values('{}','{}','{}')".format(vid,Aadhaar,Password)
        cur=self.db.cursor()
        cur.execute(query)
        self.db.commit()
        return vid
    

    def login(self):
        while True:
            Aadhaar=input("Aadhaar Number: ")
            VoterId=input("VoterId: ")
            Password=input("Password: ")
            query="select _Password from user_table where VoterId='{}' and Aadhaar='{}'".format(VoterId,Aadhaar)
            cur=self.db.cursor()
            cur.execute(query)          
            for p in cur:
                if Password==p[0]:
                    print("Login succesfull!")
                    self.after_login(Aadhaar)            
                    break
                else:
                    print("Invalid password")
            leave=input("\nDo you want to leave?(YES/NO) ")
            if leave.upper()=="YES":
                    print("Bye!!!")
                    quit()
            print("\nPlease Try Again!\n")
    
    def after_login(self,Aadhaar):
        while True:
            query="select PartyLeader from party_table where LeaderAadhaar='{}'".format(Aadhaar)
            cur=self.db.cursor()
            cur.execute(query)
            print("\n\nWhat do you want to do now?\n") 
            UserType="Citizen"
            for r in cur:
                if r[0]:
                    UserType="Leader"
            if UserType=="Leader":
                process=input("Update personal details or party details or Vote: ")
            else:
                process=input("Update personal details or Vote: ")
            if process.upper()=="VOTE":
                query="select VoteID from vote_table where Aadhaar='{}'".format(Aadhaar)
                cur=self.db.cursor()
                cur.execute(query)
                alredy_voted="No"
                for r in cur:
                    if r[0]:
                        alredy_voted="yes"
                if alredy_voted=="yes":
                    print("\nYou have already submitted your vote!\n")
                    result=input("Do you want to see the current ranking?(YES/NO)\n ")
                    if result.upper()=="YES":
                        self.show_result()
                else:
                    self.vote(Aadhaar)
                
            elif process.upper()=="PERSONAL DETAILS" or process.upper()=="UPDATE PERSONAL DETAILS" or process.upper()=="UPDATE":
                self.update(Aadhaar)
            elif UserType=="Leader" and process.upper()=="PARTY DETAILS":
                update=input("Add/Remove/View candidate/s or Edit party details: ")
                if update.upper()=="ADD":
                    self.add_candidate(Aadhaar)
                elif update.upper()=="REMOVE":
                    self.remove_candidate()
                elif update.upper()=="EDIT":
                    self.edit_party_details(Aadhaar)
                elif update.upper()=="VIEW":
                    self.party_candidate(Aadhaar)
            else:
                print("Invalid Input!")
                leave=input("Do you want to leave?(YES/NO) ")
                if leave.upper()=="YES":
                    print("Bye!")
                    quit()
    
    def vote(self,Aadhaar):
        query="select DistrictId from voter_table where Aadhaar='{}'".format(Aadhaar)
        cur=self.db.cursor()
        cur.execute(query)          
        for distId in cur:
            DistrictId=distId[0]
        ###print all parties and their candidates for particular district(radio button for front-end)
        ###add candidatename in candidate table
        query="select PartyName,CandidateName from party_table,candidate_table where candidate_table.PartyID=party_table.PartyID and DistrictId={}".format(DistrictId)
        cur=self.db.cursor()
        cur.execute(query)
        print("Party Name\t Candidate Name")
        for row in cur:
            print(row[0],"\t ",row[1],"\n")
        v=input("Enter name of Party you are voting for: ")
        query="select party_table.PartyId,CandidateId from party_table,candidate_table where candidate_table.PartyID=party_table.PartyID and DistrictId={} and PartyName='{}'".format(DistrictId,v.upper())
        cur=self.db.cursor()
        cur.execute(query)
        for r in cur:
            PartyId=r[0]      #party id 
            CandidateId=r[1]      #candidate id
        query="insert into vote_table(Aadhaar,PartyId,CandidateId,DistrictId) values('{}',{},{},{})".format(Aadhaar,PartyId,CandidateId,DistrictId)
        cur=self.db.cursor()
        cur.execute(query)
        self.db.commit()
        print("\nTHANK YOU FOR VOTING :)\n")
        result=input("Do you want to see the current ranking?(YES/NO) ")
        if result.upper()=="YES":
            self.show_result()
        
        
    def party_registration(self):
        while True:
            PartyName=input("Party Name: ").upper()
            if PartyName.isalpha() or (' ' in PartyName):break
            else: print("Party Name can only contain characters!\n")
        while True:
            Symbol=input("Enter Party Symbol: ").upper()
            if Symbol.isalpha() or (' ' in Symbol):break
            else: print("Party Symbol can only contain characters!\n")
        while True:
            PartyLeader=input("Party Leader's Name: ").upper()
            if PartyLeader.isalpha() or (' ' in PartyLeader):break
            else: print("Party Leader can only contain characters!\n")
        while True:
            LeaderAadhaar=input("Enter party leader's aadhaar number: ")
            if len(LeaderAadhaar)!=12:
                print("Invalid length of Leader's Aadhaar no.!\n")
            elif LeaderAadhaar.isnumeric():
                break
            else:
                print("Leader's Aadhaar no. can only contain numbers!\n")
        
        leader_register=input("Is leader already registered? ")
        if leader_register.upper()=="NO":
            self.sign_up()
            print("\n\n")
        
        query="insert into party_table(PartyName,Symbol,PartyLeader,LeaderAadhaar) values('{}','{}','{}','{}')".format(PartyName,Symbol,PartyLeader,LeaderAadhaar)
        cur=self.db.cursor()
        cur.execute(query)
        self.db.commit()
        print("\nYour party has been registered!\n")
        
    def edit_party_details(self,Aadhaar):
        edit=input("What do you want to edit:\nParty Leader\t Party Name\t Party Symbol: ")        #Party Leader,Party Name,Party Symbol
        if edit.upper()=="PARTY LEADER":
            leader_register=input("Is leader already registered? ")
            if leader_register.upper()=="NO":
                self.sign_up()
                print("\n\n")
            while True:
                NewName=input("Enter new leader's name: ").upper()
                if NewName.isalpha() or (' ' in NewName):break
                else: print("Name can only contain characters!\n")
            while True:
                NewAadhaar=input("Enter new leader's Aadhaar: ")
                if len(NewAadhaar)!=12 : print("Invalid length of Leader's Aadhaar no.!\n")
                elif NewAadhaar.isnumeric() : break
                else : print("Leader's Aadhaar no. can only contain numbers!\n")
            query_1="update party_table set PartyLeader='{}', LeaderAadhaar='{}' where LeaderAadhaar='{}'".format(NewName,NewAadhaar,Aadhaar)
        elif edit.upper()=="PARTY NAME":
            while True:
                NewPartyName=input("Enter new party name: ").upper()
                if NewPartyName.isalpha() or (' ' in NewPartyName):break
                else: print("Party Name can only contain characters!\n")
            query_1="update party_table set PartyName='{}' where LeaderAadhaar='{}'".format(NewPartyName,Aadhaar)
        elif edit.upper()=="PARTY SYMBOL":
            while True:
                NewSymbol=input("Enter new symbol: ").upper()
                if NewSymbol.isalpha() or (' ' in NewSymbol):break
                else: print("Party Symbol can only contain characters!\n")
            query_1="update party_table set Symbol='{}' where LeaderAadhaar='{}'".format(NewSymbol,Aadhaar)
        try:
            cur=self.db.cursor()
            cur.execute(query_1)
            self.db.commit()
            print("\nYour '{}' has been changed\n".format(edit.upper()))
        except:
            print("Invalid Input!")
            
    def add_candidate(self,Aadhaar):
        query_partyid="select PartyId from party_table where LeaderAadhaar='{}'".format(Aadhaar)
        cur=self.db.cursor()
        cur.execute(query_partyid)
        for r in cur:
            PartyId=r[0]
        candidate_register=input("Is candidate already registered? ")
        if candidate_register.upper()=="NO":
            self.sign_up()
        
        while True:
            CandidateAadhaar=input("Enter candidates's aadhaar number: ")
            if len(CandidateAadhaar)!=12 : print("Invalid length of Leader's Aadhaar no.!\n")
            elif CandidateAadhaar.isnumeric() : break
            else : print("Candidate's Aadhaar no. can only contain numbers!\n")
        print("Enter address where candidate is standing for election:\n")
        while True:
            locality=input("Locality: ")
            city=input("City: ")
            state=input("State: ")
            zipCode=input("Zip Code: ")
            DistrictId=self.districtId(locality,city,state)
            if DistrictId==None:
                print("Please enter valid address\n")
                continue
            break
        query_1="select FirstName,LastName from voter_table where Aadhaar='{}'".format(CandidateAadhaar)
        cur=self.db.cursor()
        cur.execute(query_1)
        for r in cur:
            CandidateName=r[0]+" "+r[1]
        query="insert into candidate_table(Aadhaar,CandidateName,PartyId,DistrictId) values('{}','{}',{},{})".format(CandidateAadhaar,CandidateName,PartyId,DistrictId)
        cur=self.db.cursor()
        cur.execute(query)
        self.db.commit()
        print("\nCandidate added successfully!\n") 
        
    def remove_candidate(self):
        while True:
            CandidateAadhaar=input("Enter candidates's aadhaar number: ")
            if len(CandidateAadhaar)!=12 : print("Invalid length of Leader's Aadhaar no.!\n")
            elif CandidateAadhaar.isnumeric() : break
            else : print("Candidate's Aadhaar no. can only contain numbers!\n")
        query="delete from candidate_table where Aadhaar='{}'".format(CandidateAadhaar)
        cur=self.db.cursor()
        cur.execute(query)
        self.db.commit()
        print("\nCandidate removed successfully!\n")
    
    def update(self,Aadhaar):
        inp=input("What do you want to update:\nName\t Phone\t Email\t Address: ")       #Name,Phone,Email,Address
        if inp.upper()=="NAME":
            while True:
                first=input("Enter first name: ").upper()
                middle=input("Enter middle name: ").upper()
                last=input("Enter last name: ").upper()
                if first.isalpha() and middle.isalpha() and last.isalpha():break
                else: print("Name can only contain characters!\n")
            query_2="update voter_table set FirstName='{}', MiddleName='{}' ,LastName='{}' where Aadhaar='{}'".format(first,middle,last,Aadhaar)
           
        elif inp.upper()=="PHONE":
            while True:
                phone=input("Enter new phone number: ")
                if len(phone)!=10 : print("Invalid length of Phone no.!\n")
                elif phone.isnumeric():
                    phone=int(phone)
                    break
                else : print("Phone no. can only contain numbers!\n")
            query_2="update voter_table set Phone={} where Aadhaar='{}'".format(phone,Aadhaar)
        elif inp.upper()=="EMAIL":
            while True:
                email=input("Enter new email id: ")
                if ('@' and '.' in email) and (email.index("@") < email.index(".") and (email.index(".") < len(email)-1) ) : break
                else : print("Invalid Email Id !\n")
            query_2="update voter_table set Email='{}' where Aadhaar='{}'".format(email,Aadhaar)
        elif inp.upper()=="ADDRESS":
            while True:
                locality=input("Enter new locality: ")
                city=input("Enter new city: ")
                state=input("Enter new state: ")
                zipcode=input("Enter new zipcode: ")
                DistrictId=self.districtId(locality,city,state)
                if DistrictId==None:
                    print("Please enter valid address")
                    continue
                break
            query_2="update voter_table set DistrictId={} where Aadhaar='{}'".format(DistrictId,Aadhaar)
        elif inp.upper()==None:
            return
        try:
            cur=self.db.cursor()
            cur.execute(query_2)
            self.db.commit()
            print("\n Your '{}' has been updated\n".format(inp.upper()))
            again=input("Do you want to update something else: ")
            if again.upper()=="YES":
                self.update(Aadhaar)
            else:
                return
        except:
            print("Invalid Input!")
            self.update(Aadhaar)
            
    def show_result(self):
        query="SELECT Result.PartyID, party_table.PartyName,SUM(Vote_Count) AS 'Total_Count' FROM Result,party_table WHERE Party_table.Partyid = Result.partyID GROUP BY result.PartyID ORDER BY Total_Count DESC"
        cur=self.db.cursor()
        cur.execute(query)
        print("\n\tVOTES FOR EACH PARTY\n")
        print("Party ID   Party Name   Count")
        for i in cur:
            print("  ", i[0],"\t\t ",i[1],"\t  ",i[2],'\n')
            
    def party_candidate(self,Aadhaar):
        query="select PartyId,PartyName from party_table where LeaderAadhaar='{}'".format(Aadhaar)
        cur=self.db.cursor()
        cur.execute(query)
        for r in cur:
            PartyId=r[0]
            PartyName=r[1]
        print("\nShowing candidate details for '{}' party\n".format(PartyName))
        query_2="select voter_table.FirstName,voter_table.LastName,address.Locality,address.City,address.State from address,candidate_table,voter_table where candidate_table.DistrictId=address.DistrictId and candidate_table.Aadhaar=voter_table.Aadhaar and candidate_table.PartyId={}".format(PartyId)
        cur2=self.db.cursor()
        cur2.execute(query_2)
        #print("  Name\t\t \t\tLocality\t\t \t\tCity\t\t \t\tState")
        print("\t{:<15} {:<15} {:<10} {:10}".format("Name","Locality","City","State"))
        for r in cur2:
            name=r[0]+" "+r[1]
            print("{:<15} \t{:<15} {:<10} {:<10}".format(name,r[2],r[3],r[4]))

vs=voting_system()
while True:
    print("What do you want to do?\n")
    print("SIGN UP\t LOGIN\t PARTY REGISTRATION\tVIEW RESULT\t LEAVE") 
    task=input("What do you want to do? ")
    if task.upper()=="SIGN UP":
        print("\n\n\nSIGN UP:\n")
        vs.sign_up()
    elif task.upper()=="PARTY REGISTRATION":
        print("\n\n\nPARTY REGISTRATION:\n")
        vs.party_registration()
    elif task.upper()=="LOGIN":
        print("\n\n\nLOGIN:\n")
        vs.login()
    elif task.upper()=="VIEW RESULT":
        vs.show_result()
    elif task.upper()=="LEAVE":
        print("\n\n\nBYE!!!")
        quit()
    else:
        print("Invalid Input!")

