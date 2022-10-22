Create Database Project1;
Use Project1;

-------------Login Table----------------
Create Table Login
(
AdminID  varchar(5)  primary  key,
Password varchar(15),
);

-----Triggers-----
CREATE TRIGGER 
NEW_ADMIN_ADD on Login
After Insert as 
begin print 'New Admin Added' 
end;

CREATE TRIGGER 
Admin_Delete on Login
After Delete as 
begin print 'Admin Deleted' 
end;

CREATE TRIGGER 
Admin_Updated on Login
After Update as 
begin print 'Admin Updated' 
end;

Insert into Login values
('Fm001', '12345'),
('Fm002', '54321'),
('Fm003', '13579'),
('Fm004', '24680');

Select * from Login;

---------------Test Data----------------------------------------------
Insert into Login  values('Fm122', '123@#$#6');
Select * from Login;
Update Login SET Password='43534!@$#11111' where  AdminID='Fm122';
Delete from Login where AdminID='Fm122';
Select * from Login;
Select * from Travellers;

-----------Flight Manager Table--------------
Create  Table  FlightManager
(
AdminID  varchar(5)  primary  key,
FName    varchar(15)  not  null,
LName    varchar(15),
Age      int  check(age>=18)  not  null,
TellNo   varchar(15),
Password varchar(15)
);

-----Triggers-----
CREATE TRIGGER 
New_FlightManager_ADD on FlightManager
After Insert as 
begin print 'New FlightManager Added' 
end;

CREATE TRIGGER 
FlightManager_Delete on FlightManager
After Delete as 
begin print 'FlightManager Deleted' 
end;

CREATE TRIGGER 
FlightManager_Updated on FlightManager
After Update as 
begin print 'FlightManager Updated' 
end;

Insert  into  FlightManager  values 
('Fm001','Azfar','Asif',    21,'03211-841227', '12345'),
('Fm002','Abdul','Rehman',  35,'0309-6124112', '54321'),
('Fm003','Muzzamil','Habib',20,'0322-8123441', '13579'),
('Fm004','Muhammad','Asad', 23,'0345-9188221', '24680');

Select * from  FlightManager;
Drop Table FlightManager;

----------------------------Views for ALL DATA from Login & Flight Manager table-------------------------------------------------

SELECT  L.ADMINID, L.PASSWORD, F.ADMINID, F.FNAME, F.LNAME FROM LOGIN L FULL OUTER JOIN FlightManager F ON L.ADMINID =F.ADMINID  


---------------Test Data----------------------------------------------
Insert into FlightManager  values('Fm324','Junaid','Asif',    71,'03211-841227', '12@R$%45');
Select * from FlightManager;
Update FlightManager SET Password='43534!@$#11111' where  AdminID='Fm324';
Select * from FlightManager;
Delete from FlightManager where AdminID='Fm324';
Select * from FlightManager;



----------AirPlane Table-----------------
Create Table  AirPlane
(
AirBusNo  varchar(5)  primary  key,
AirBusType  varchar(15)  check  (airbustype  ='domestic'  or  airbustype  ='foreign'),
AirlineName  varchar(40)  not  null,
Seats  int  check(seats>0  and  seats<500)	not  null,
MealNumber  int  foreign  key  references  Meal(MealNumber)  not  null
);

-----Triggers-----
CREATE TRIGGER 
New_AirPlane_ADD on AirPlane
After Insert as 
begin print 'New AirPlane Added' 
end;

CREATE TRIGGER 
AirPlane_Delete on AirPlane
After Delete as 
begin print 'AirPlane Deleted' 
end;

CREATE TRIGGER 
AirPlane_Updated on AirPlane
After Update as 
begin print 'AirPlane Updated' 
end;
 

Insert  into  AirPlane  values 
('Sh225','Domestic', 'Shaheen',100,1),
('Pia12','Domestic', 'Pakistan  International  Airline',120,4),
('Qtr12','Foreign',  'Qatar  Airlines',300,2),
('Emr11','Foreign',  'Emirates',320,2),
('Ab123','Domestic', 'Air  Blue',150,1),
('Sa123','Foreign',  'Saudi  Airline',250,2),
('As123','Foreign',  'AirSian',250,5),
('TK714','Foreign',  'Turkish  Airline',250,2),
('DAL12','Foreign',  'Delta Air Lines',250,5),
('BA12', 'Foreign',  'British Airways',300,2);

Drop Table AirPlane;
Select * from AirPlane;

---------------Test Data----------------------------------------------
Insert into  AirPlane   values('xyx','Domestic', 'lolo',100,1);
Select * from  AirPlane ;
Update  AirPlane  SET AirBusType='Foreign' where  AirBusNo='xyx';
Select * from  AirPlane ;
Delete from  AirPlane  where  AirBusNo='xyx';
Select * from  AirPlane ;

------------------Join to see FlightManger, Airplanr-----------------------------------
SELECT  F.ADMINID, F.FNAME, F.LNAME, A.AIRBUSNO, A.AIRBUSTYPE FROM FlightManager F FULL OUTER JOIN  AirPlane A  ON  F.ADMINID= A.AIRBUSNO 


------------Meal Table--------------------
Create  Table  Meal
(
MealNumber  int  primary  key NOT NULL  ,
MealType  varchar  (30)  
);

-----Triggers-----
CREATE TRIGGER 
New_Meal_ADD on Meal
After Insert as 
begin print 'New Meal Added' 
end;

CREATE TRIGGER 
Meal_Delete on Meal
After Delete as 
begin print 'Meal Deleted' 
end;

CREATE TRIGGER 
Meal_Updated on Meal
After Update as 
begin print 'Meal Updated' 
end;


Insert into Meal Values
(1, 'Bevrages with  fast  food'),
(2, 'CHINESE  FOOD'),
(3, 'MEXICAN  FOOD'),
(4, 'Biryani  with  soft  drink'),
(5, 'Snacks   with  soft  drink');

Drop Table Meal;
Select * from Meal;

---------------Test Data----------------------------------------------
Insert into  Meal  values(6, 'Food');
Select * from  Meal;
Update  Meal SET MealType='NO FOOD' where  MealNumber='6';
Select * from  Meal;
Delete from  Meal where  MealNumber='6';
Select * from  Meal;

------------------Join to see Airplanr, Meal -----------------------------------
SELECT   A.AIRBUSNO, A.AIRBUSTYPE, M.MEALNUMBER, M.MEALTYPE FROM AirPlane A FULL OUTER JOIN   Meal M  ON   A.AIRBUSNO =M.MEALTYPE;


---------------Flight Table-----------------
Create  Table  Flight
(
FlightNo           varchar(5)  primary  key, 
DepartureLocation  varchar(25)  not  null,
DeparturedatenTime datetime  not  null,
ArrivalLocation    varchar(25)  not  null, 
ArrivaldatenTime   datetime  not  null,
FlightStatus       varchar(25)  check(FlightStatus  ='Not Delayed'  or  FlightStatus='Delayed'),
FightType          varchar(25)  check  (FightType='Connecting'  or  FightType='Direct'), 
AdminID            varchar(5)  foreign  key  references  FlightManager(AdminID),
AirBusNo           varchar(5)  foreign  key  references  Airplane(AirBusNo)
);
-----Triggers-----
CREATE TRIGGER 
New_Flight_ADD on Flight
After Insert as 
begin print 'New Flight Added' 
end;

CREATE TRIGGER 
Flight_Delete on Flight
After Delete as 
begin print 'Flight Deleted' 
end;

CREATE TRIGGER 
Flight_Updated on Flight
After Update as 
begin print 'Flight Updated' 
end;

Select * from Flight;
Drop Table Flight

Insert  into Flight  values
('Fl001','Gilgit-Baltistan','2022-2-17 3:00:00', 'Islamabad','2022-2-17  4:00:00',  'Delayed',    'Direct',    'Fm001','Sh225'),
('Fl002','Gilgit-Baltistan','2022-2-18 12:00:00','USA',      '2022-2-18 00:00:00',  'Delayed',    'Connecting','Fm001','Qtr12'), 
('Fl003','Gilgit-Baltistan','2022-2-20 3:00:00', 'Dubai',    '2022-2-20  5:30:00',  'Not Delayed','Direct',    'Fm002','Emr11'),
('Fl004','Gilgit-Baltistan','2022-2-11 4:00:00', 'Karachi',  '2022-2-11  5:30:00',  'Not Delayed','Direct',    'Fm002','Sh225'),
('Fl005','Gilgit-Baltistan','2022-2-15 12:00:00','China',    '2022-2-15  14:00:00', 'Not Delayed','Direct',    'Fm003','As123'),
('Fl006','Gilgit-Baltistan','2022-2-22 14:00:00','Saudia',   '2022-2-22 17:00:00',  'Delayed',    'Direct',    'Fm003','Sa123'),
('Fl007','Gilgit-Baltistan','2022-2-18 10:00:00','Peshawar', '2022-2-18  11:30:00', 'Not Delayed','Direct',    'Fm004','Pia12'),
('Fl008','Gilgit-Baltistan','2022-2-25 15:00:00','Quetta',   '2022-2-25  16:30:00', 'Not Delayed','Direct',    'Fm004','Ab123'),
('Fl009','Gilgit-Baltistan','2022-2-25 13:00:00','Turkey',   '2022-2-25  17:30:00', 'Not Delayed','Direct',    'Fm004','TK714'),
('Fl010','Gilgit-Baltistan','2022-2-17 12:00:00','Australia','2022-2-17  18:00:00', 'Not Delayed','Connecting','Fm004','Qtr12');

Select * from Flight;

---------------Test Data----------------------------------------------
Insert into  Flight   values('Fl999','Gilgit-Baltistan','2022-2-17 3:00:00', 'Islamabad','2022-2-17  4:00:00',  'Delayed',    'Direct',    'Fm001','Sh225');
Select * from  Flight ;
Update  Flight  SET DepartureLocation='Lahore' where  FlightNo='Fl999';
Select * from  Flight ;
Delete from  Flight  where  FlightNo='Fl999';
Select * from  Flight ;

------------------Join to see  Meal, Flight -----------------------------------
SELECT M.MEALNUMBER, M.MEALTYPE, F.FlightNo, F.DepartureLocation, F.DeparturedatenTime, F.ArrivalLocation, F.ArrivaldatenTime, F.FlightStatus, F.FightType, F.AdminID, F.AirBusNo FROM Meal M FULL OUTER JOIN Flight F  ON   M.MEALTYPE=F.FlightNo;


---------------Travellers Table--------------------
Create  Table  Travellers
(
TravellersID  varchar(5)  primary  key,
FName    varchar(15)  not null,
LName    varchar(15),
IDcard   varchar(15)  not null unique,
Passport  varchar(55)  not null unique,
Address  varchar(1000) ,
ReservationStatus  varchar(8)  check(reservationstatus  ='booked'  or  reservationstatus='paid'),
FlightNo varchar(5)  foreign  key  references  Flight(FlightNo), 
AirBusNo varchar(5)  foreign  key  references  Airplane(AirBusNo) ,
AdminID  varchar(5)  foreign  key  references  FlightManager(AdminID)
);

Select * from Travellers;
Drop table Travellers

--------------Triggers-----------------------------------------
CREATE TRIGGER 
NEW_ADD on Travellers
After Insert as 
begin print 'New Travellers Added' 
end;

CREATE TRIGGER 
Traveller_Delete on Travellers
After Delete as 
begin print 'Travellers Deleted' 
end;

CREATE TRIGGER 
Traveller_Updated on Travellers
After Update as 
begin print 'Travellers Updated' 
end;

Insert  into  Travellers  values
('Tr001','Munib','Majid','lhr2','lhr1', 'Architect  Lahore  ','Booked','Fl001','Sh225','Fm001')

Insert  into  Travellers  values
('Tr002','Umar','Butt', 'lhr123','lhr2','Punjab  Society  Lahore','Paid','Fl001','Sh225','Fm002')

Insert  into  Travellers  values
('Tr003','Umer','Malik','skp891','lhr3','Central  Park  SKP','Booked','Fl001','Sh225','Fm001')

Insert  into  Travellers  values
('Tr004','Junaid','Farooq','lhr221','lhr4', 'Model  Town  Block  B Lahore','Paid','Fl007','Pia12','Fm003')

Insert  into  Travellers  values 
('Tr005','Shahreyar','Zaka','lhr981','lhr5','Model  Town  Block  F Lahore','Booked','Fl007','Pia12','Fm002')

Insert  into  Travellers  values 
('Tr006','Shahryar','Shabbir','lhr781','lhr6', 'Hanjerval  Multan  Chungi Lahore','Booked','Fl008','Ab123','Fm004')

Insert  into  Travellers  values
('Tr007','Mahad','Imran','lhr213','lhr7','Punjab  Society  Lahore','Paid','Fl008','Ab123','Fm004')

Insert  into  Travellers  values 
('Tr008','Shayan','Rao','lhr571','lhr8','Abdalians Society Lahore','Paid','Fl002','Qtr12','Fm002')

Insert  into  Travellers  values 
('tr009','zuhair','baig','lhr561','lhr9','revenue  society  lahore ','booked','fl007','pia12','fm001')

Insert  into  Travellers  values
('Tr010','Rafey','Amir','lhr153','lhr10','Model  Block  1  Lahore','Booked','Fl006','Sa123','Fm003')

Insert  into  Travellers  values
('Tr011','Shahgil','Jutt','skp871','lhr11','Jinnah  Park  SKP','Booked','Fl008','Ab123','Fm002')

Insert  into  Travellers  values
('Tr012','Shahreyar','Zaka','lhr001','lhr12','Model Town  Block  F Lahore','Booked','Fl007','Pia12','Fm002')

Insert  into  Travellers  values
('Tr013','Usman','Mughal','isl761','lhr13','Secotr  F11  Islamabad','Paid','Fl004','Sh225','Fm002')

Insert  into  Travellers  values
('Tr014','Peerzada','Ali','isl198','lhr14','Sector  A10  Islamabad','Paid','Fl001','Sh225','Fm003')

Insert  into  Travellers  values
('Tr015','Imran','Khan','psw912','lhr15','Alirazabad  Peshawar','Booked','Fl008','Ab123','Fm004')

Insert  into  Travellers  values
('Tr016','Aiza','Ali','khi120','lhr16','Sadar  Cant  Karachi','Paid','Fl006','Sa123','Fm004')

Insert  into  Travellers  values 
('Tr017','Junejo','Khan','isl124','lhr17','Sector  G12 Islamabad','Booked','Fl006','Sa123','Fm004')

Insert  into  Travellers  values
('Tr018','Ayesha','Ali','khi214','lhr18','Upper  Town  Karachi','Paid','Fl006','Sa123','Fm001')

Insert  into  Travellers  values
('Tr019','David','Scotch','us123','lhr19','California  USA','Paid','Fl002','Qtr12','Fm002')

Insert  into  Travellers  values
('Tr020','David','Viese','us412','lhr20','Uptown  USA','Booked','Fl002','Qtr12','Fm002')

Insert  into  Travellers  values 
('Tr021','Faisal','Quereshi','khi212','kh1','Liyari  Town Karachi','Paid','Fl004','Sh225','Fm001')

Insert  into  Travellers  values
('Tr022','Rabia','Faisal','lhr219','kh2','Tariq  Garden  Lahore','Paid','Fl004','Sh225','Fm004')

Insert  into  Travellers  values
('Tr023','DJ','Bravo','wi421','kh3','Kulkarni  West  Indies','Booked','Fl008','Ab123','Fm003')

Insert  into  Travellers  values
('Tr024','Bella','Ciao','us871','kh4','La Down Town  USA','Paid','Fl002','Qtr12','Fm003')

Insert  into  Travellers  values
('Tr025','Billie','Dumb','us345','kh5','La Down Town USA','Paid','Fl002','Qtr12','Fm003')

Insert  into  Travellers  values
('Tr026','Lil','Wayne','us872','kh6','Uptown  USA','Booked','Fl002','Qtr12','Fm003')

Insert  into  Travellers  values
('Tr027','Umer','Akmal','lhr671','kh7','Wapda Town  Lahore','Paid','Fl003','Emr11','Fm002')

Insert  into  Travellers  values
('Tr028','Imad','Wasim','lhr241','kh8','Samanabad  Lahore','Booked','Fl003','Emr11','Fm002')

Insert  into  Travellers  values 
('Tr029','Hadi','Majid','lhr211','kh9','Architect  Society Lahore','Booked','Fl003','Emr11','Fm002')

Insert  into  Travellers  values
('Tr030','Majdid','Ali','lhr200','kh10','Architect  Society Lahore','Paid','Fl003','Emr11','Fm002')

Insert  into  Travellers  values
('Tr031','Ammar','Khalid','lhr220','kh11','B Block Model Town Lahore','Booked','Fl003','Emr11','Fm002')

Insert  into  Travellers  values
('Tr032','Ghulab','Khan','Qu222','kh12','Wadi  Ahmad  Quetta','Booked','Fl008','Ab123','Fm003')

Insert  into  Travellers  values
('Tr033','Pistool','Khan','Qu252','kh13','Wadi  Pani  Quetta','Paid','Fl008','Ab123','Fm003')

Insert  into  Travellers  values
('Tr034','Jamal','Khan','Qu122','kh14','Pind  Khan  Quetta','Booked','Fl008','Ab123','Fm003')

 Insert  into  Travellers  values
('Tr035','Bandook','Khan','qu287','kh15','Mir Town  Quetta','Paid','Fl008','Ab123','Fm003')

Insert  into  Travellers  values
('Tr036','Jan ','Khan','qu214','kh16','Ali  Town  Quetta','Booked','Fl008','Ab123','Fm003')

Insert  into  Travellers  values
('Tr037','Umeed','Khan','qu987','kh17','Alirazabad  Pind  Quetta','Paid','Fl008','Ab123','Fm003')

Insert  into  Travellers  values
('Tr038','Toota','Khan','quo971','kh18','Al Hamra  Town  Quetta','Booked','Fl008','Ab123','Fm003')

Insert  into  Travellers  values
('Tr039','Zulam','Khan','qu291','kh19','Ameer  Town  Quetta','Paid','Fl008','Ab123','Fm003')

Insert  into  Travellers  values 
('Tr040','Isaaq','Qureshi','lhr12','kh20','Valancia  Town Lahore','Booked','Fl006','Sa123','Fm001')

Insert  into  Travellers  values
('Tr041','Ali','Qureshi','lhr911','kh21','Valancia  Town Lahore','Booked','Fl006','Sa123','Fm001')

Insert  into  Travellers  values
('Tr042','Hajra','Qureshi','lhr991','kh22','Valancia  Town Lahore','Booked','Fl006','Sa123','Fm001')

Insert  into  Travellers  values 
('Tr043','Hamid','Qureshi','lhr214','kh23','Valancia  Town Lahore','Booked','Fl006','Sa123','Fm001')

Insert  into  Travellers  values
('Tr044','Shahreyar','Zaka','ar787','kh24','Model  Town  Block  F Lahore','Booked','Fl007','Pia12','Fm002')

Insert  into  Travellers  values
('Tr045','Jin','Kazama','ew222','kh25','Wohaan  China','Booked','Fl005','As123','Fm003')

Insert  into  Travellers  values
('Tr046','Nina','Kim','ou555','kh26','Kipu  Chain  China','Booked','Fl005','As123','Fm003')

Insert  into  Travellers  values
('Tr047','Xiong','Cinchu','ch124','kh27','Omni  Wara  China','Booked','Fl005','As123','Fm003')

Insert  into  Travellers  values
('Tr048','Muchi','Kinku','Ch134','kh28','Hiu  Riyo  China','Booked','Fl005','As123','Fm003')

Insert  into  Travellers  values
('Tr049','Mushiya','Pinwa','ch674','kh39','Omni  Wara  China','Paid','Fl005','As123','Fm003')

Insert  into  Travellers  values
('Tr050','Asanu','Tiwana','ch021','kh40','Hiroshima  China','Booked','Fl005','As123','Fm003')

Insert  into  Travellers  values
('Tr051','Jin','Kazama','ch920','kh41','Wohaan  China','Booked','Fl005','As123','Fm003')

Insert  into  Travellers  values 
('Tr052','Law','Kipu','ch0982','kh42','Loop  Town  China','Booked','Fl005','As123','Fm003')

Insert  into  Travellers  values
('Tr053','Asanu','Tiwana','ch221','kh43','Hiroshima  China','Booked','Fl005','As123','Fm003')

Insert  into  Travellers  values
('Tr054','Yushi','Mitsu','ch098','kh44','Cape  Town  China','Paid','Fl005','As123','Fm003')

Insert  into  Travellers  values
('Tr055','Nina','Kim','ch082','kh45','Kipu  Chain  China','Booked','Fl005','As123','Fm003')

Insert  into  Travellers  values
('Tr056','Juju','Awin','ch091','kh46','Lili  Chip  China','Booked','Fl005','As123','Fm003')

Insert  into  Travellers  values 
('Tr057','Kashi','Berooni','Khi761','kh47','Chambeli  Town Karachi','Paid','Fl004','Sh225','Fm002')

Insert  into  Travellers  values 
('Tr058','Azaad','Chaiwala','khi771','kh48','Orangi  Town Karachi','Booked','Fl004','Sh225','Fm001')

Insert  into  Travellers  values 
('Tr059','Usama','Peerza','khi661','kh49','Chambeli  Town Karachi','Paid','Fl004','Sh225','Fm002')

Insert  into  Travellers  values
('Tr060','Huda','Khan','Khi161','kh50','Dha Karachi','Booked','Fl004','Sh225','Fm001')

Insert  into  Travellers  values
('Tr061','Laiba','Rauf','khi131','kh51','Defence  Karachi','Booked','Fl004','Sh225','Fm001')

Insert  into  Travellers  values
('Tr062','Rubina','Rauf','khi111','kh52','Defence Karachi','Booked','Fl004','Sh225','Fm001')

Insert  into  Travellers  values
('Tr063','Kianat','Rauf','khi101','kh53','Defence Karachi','Booked','Fl004','Sh225','Fm001')

Insert  into  Travellers  values
('Tr064','Rameen','Afzal','isl541','kh54','G10  Islamabad','Paid','Fl001','Sh225','Fm004')

Insert  into  Travellers  values
('Tr065','Rameez','Afzal','isl542','kh55','G10  Islamabad','Paid','Fl001','Sh225','Fm004')

Insert  into  Travellers  values
('Tr066','Ayesha','Mughal','isl544','kh56','I8  Sector  Islamabad','Paid','Fl001','Sh225','Fm004')

Insert  into  Travellers  values
('Tr067','Abrar','Mughal','isl549','kh57','I8  Sector  Islamabad','Paid','Fl001','Sh225','Fm003')

Insert  into  Travellers  values
('Tr068','Aleeza','Rana','isl539','kh58','Nooshera  Wala Rawalpindi','Paid','Fl001','Sh225','Fm003')

Insert  into  Travellers  values
('Tr069','Rana','Mahad Imran','rwp239','kh59','Nooshera  Wala Rawalpindi','Paid','Fl001','Sh225','Fm003')

Insert  into  Travellers  values
('Tr070','Alexa','Holmes','usa712','kh59','Kup Cup  USA','Booked','Fl002','Qtr12','Fm002')

Insert  into  Travellers  values
('Tr071','Katy','Parry','usa772','kh60','Ling Kong  USA','Paid','Fl002','Qtr12','Fm001')

Insert  into  Travellers  values
('Tr072','Drake','Rex','usa722','kh61','Up Town Alley  USA','Paid','Fl002','Qtr12','Fm002')

Insert  into  Travellers  values
('Tr073','Muyurial','Kip','usa012','kh62','Veerana  Valley  USA','Booked','Fl002','Qtr12','Fm002')

Insert  into  Travellers  values
('Tr074','Sihong','Karate','Chi771','kh63','Vuhan  China','Paid','Fl005','As123','Fm001')

Insert  into  Travellers  values
('Tr075','Haji','Ashgar','skp231','kh64','Satadium  SKP  ','Booked','Fl006','Sa123','Fm003')

Insert  into  Travellers  values
('Tr076','Haji','Jeera','skp222','kh65','Jinnah  Park  SKP  ','Paid','Fl006','Sa123','Fm003')

Insert  into  Travellers  values 
('Tr077','Haji','Rustam','lhr429','kh66','Model  Town  Link  Road Lahore','Paid','Fl006','Sa123','Fm004')

Insert  into  Travellers  values
('Tr078','Hakim','Ali','lhr428','kh67','Model  Town  Link  Road Lahore','Booked','Fl007','Pia12','Fm002')

Insert  into  Travellers  values
('Tr079','Huda','Khan','ke61','kh68','DHA  Karachi','Booked','Fl004','Sh225','Fm001')

Insert  into  Travellers  values
('Tr080','Anees','Rafiq','lhr420','kh69','Awan  Town  Lahore','Booked','Fl007','Pia12','Fm002')

Insert  into  Travellers  values 
('Tr081','Arsalan','Shah','lhr490','kh70','Bhatti  Colony Lahore','Booked','Fl007','Pia12','Fm002')

Insert  into  Travellers  values 
('Tr082','Rizwan','Qureshi','lhr493','kh71','Defense  Road Lahore','Booked','Fl007','Pia12','Fm002')

Insert  into  Travellers  values
('Tr083','Muf','Aladin','fsl493','kh72','Ghanti  Ghar  Faisalabad','Paid','Fl003','Emr11','Fm003')

Insert  into  Travellers  values
('Tr084','Ruf','Aladin','fsl494','kh73','Ghanti  Ghar  Faisalabad','Paid','Fl003','Emr11','Fm003')

Insert  into  Travellers  values
('Tr085','Kashi','Berooni','aus761','kh74','Chambeli  Town Karachi','Paid','Fl004','Sh225','Fm002')

Insert  into  Travellers  values 
('Tr086','Huda','Khan','aus61','kh75','DHA  Karachi','Booked','Fl004','Sh225','Fm001')

Insert  into  Travellers  values
('Tr087','Anees','Rafiq','lhr780','kh76','Awan  Town  Lahore','Booked','Fl007','Pia12','Fm002')

Insert  into  Travellers  values 
('Tr088','Junejo','Khan','isl1524','kh77','Sector  G12 Islamabad','Booked','Fl006','Sa123','Fm004')

Insert  into  Travellers  values
('Tr089','Ayesha','Ali','khi2142','kh78','Upper  Town  Karachi','Paid','Fl006','Sa123','Fm001')

Insert  into  Travellers  values
('Tr090','David','Scotch','us1231','kh79','California  USA','Paid','Fl002','Qtr12','Fm002')

Insert  into  Travellers  values
('Tr091','David','Viese','us4122','kh80','Uptown  USA','Booked','Fl002','Qtr12','Fm002')

Insert  into  Travellers  values 
('Tr092','Faisal','Quereshi','khi5212','kh81','Liyari  Town Karachi','Paid','Fl004','Sh225','Fm001')

Insert  into  Travellers  values
('Tr093','Rabia','Faisal','lhr2159','kh82','Tariq  Garden  Lahore','Paid','Fl004','Sh225','Fm004')

Insert  into  Travellers  values
('Tr094','DJ','Bravo','wi4251','kh83','Kulkarni  West Indies','Booked','Fl008','Ab123','Fm003')

Insert  into  Travellers  values
('Tr095','Bella','Ciao','us8571','kh84','La Down Town  USA','Paid','Fl002','Qtr12','Fm003')

Insert  into  Travellers  values
('Tr096','Billie','Dumb','us3545','kh85','La  Down Town  USA','Paid','Fl002','Qtr12','Fm003')

Insert  into  Travellers  values
('Tr097','Lil','Wayne','us8725','kh86','Uptown  USA','Booked','Fl002','Qtr12','Fm003')

Insert  into  Travellers  values
('Tr098','Umer','Akmal','lhr6751','kh87','Wapda  Town  Lahore','Paid','Fl003','Emr11','Fm002')

Insert  into  Travellers  values
('Tr099','Imad','Wasim','lhr2415','kh88','Samanabad  Lahore','Booked','Fl003','Emr11','Fm002')

Insert  into  Travellers  values 
('Tr100','Hadi','Majid','lhr2115','kh89','Architect  Society Lahore','Booked','Fl003','Emr11','Fm002')
;

Delete from Travellers where Travellersid= 'Tr101'
Select * from  Travellers;

---------------Test Data----------------------------------------------
Insert  into   Travellers  values
('Tr000','Azfar','Asif', 'lhr224','lhr0' ,'Mughalpura  Lahore  ','Booked','Fl001','Sh225','Fm001');
Select * from  Travellers ;
Update  Travellers  SET FName='XYZ' where TravellersID='Tr000';
Select * from  Travellers ;
Delete from Travellers where TravellersID='Tr000'
Select * from  Travellers ;

 
------------------Join to see  Flight, Travellers -----------------------------------
SELECT F.FlightNo, F.DepartureLocation, F.DeparturedatenTime, F.ArrivalLocation, F.ArrivaldatenTime, F.FlightStatus, F.FightType, F.AdminID, F.AirBusNo,
T.TravellersID, T.FName, T.LName, T.IDcard, T.Passport, T.Address
FROM Flight F FULL OUTER JOIN Travellers T  ON   F.FlightNo=T.TravellersID;


------------------- Create Function---------------------------------------------------------

--1
--  returns  which  meal  is  served  by  which  airplane
select  a.*,m.MealType  from AirPlane  a  ,Meal  m where  a.MealNumber=m.MealNumber


--2
--  returns  all  the  flights  that  are  domestic
select  *  from Flight where  AirBusNo  in  (select  AirBusNo  from  AirPlane  where  Airplane.AirBusType='Domestic');
--  returns  all  the  flights  that  are  foreign
select  *  from Flight where  AirBusNo  in  (select  AirBusNo  from  AirPlane  where  Airplane.AirBusType='Foreign');

--3
--returns  the  flights  that  are  delayed
select * from Flight where  FlightStatus='DELAYED'

--returns  the  flights  that  are  not delayed
select * from Flight where  FlightStatus='NOT DELAYED'

--4
--  return  those  travellers  who  had  paid  for  their  tickets
select * from Travellers where  travellers.reservationStatus='PAID'
--  the  total  entries  are  43  so  pasting  only  14 entries

--  return  those  travellers  who  had  booked  their  tickets
select * from Travellers where  travellers.reservationStatus='BOOKED'
--  the  total  entries  are  43  so  pasting  only  14 entries

--5
--  returns  how  many  flights  are  booked or paid
select  RESERVATIONSTATUS  ,COUNT(*)  AS  'NO  OF  FLIGHTS'  from Travellers GROUP  BY  reservationStatus

--6
--  returns  those  travllers  who  are  from  lahore
select * from  Travellers where address  LIKE  '%LAHORE%' ORDER  BY  reservationStatus
--  total  entries  returned  are  31

--  returns  those  travllers  who  are  from  karachi
select * from  Travellers where address  LIKE  '%KARACHI%' ORDER  BY  reservationStatus
--  total  entries  returned  are  10

--7
--return  those  flight  which  are  departuring  on  18  feburary
select  * from  Flight where  day(DeparturedatenTime)  ='18'

--8
--return  which  admin  is  managing  the  specific  travller
select  * from  FlightManager where  AdminID=(select  AdminID  from  Travellers  where  TravellersID  ='Tr078')





