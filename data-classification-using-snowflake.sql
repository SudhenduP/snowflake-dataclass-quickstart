-- Start with using the AccountAdmin Role to create the required roles, datawarehouse, database and grant sufficient privileges.
-- Note, in actual client implementation, you should avoid using ACCOUNTADMIN role and instead use SYSADMIN.

USE ROLE ACCOUNTADMIN;

-- Role creation and premission grants. 
DROP ROLE IF EXISTS IDENTIFIER('"POC_DATACLASSIFICATION"');
CREATE ROLE IDENTIFIER('"POC_DATACLASSIFICATION"') COMMENT = 'Role for Data Classification';

-- Please add your username below instead of USERNAME. 
GRANT ROLE IDENTIFIER('"POC_DATACLASSIFICATION"') TO USER IDENTIFIER('"USERNAME"');

-- Compute resource creation and grants.
DROP WAREHOUSE IF EXISTS DATACLASS_WH;
CREATE WAREHOUSE IDENTIFIER('"DATACLASS_WH"') COMMENT = '' WAREHOUSE_SIZE = 'X-Small' AUTO_RESUME = true AUTO_SUSPEND = 60 MIN_CLUSTER_COUNT = 1 MAX_CLUSTER_COUNT = 1 SCALING_POLICY = 'STANDARD';

GRANT OPERATE ON WAREHOUSE IDENTIFIER('"DATACLASS_WH"') TO ROLE IDENTIFIER('"POC_DATACLASSIFICATION"');
GRANT USAGE ON WAREHOUSE IDENTIFIER('"DATACLASS_WH"') TO ROLE IDENTIFIER('"POC_DATACLASSIFICATION"');
GRANT MONITOR ON WAREHOUSE IDENTIFIER('"DATACLASS_WH"') TO ROLE IDENTIFIER('"POC_DATACLASSIFICATION"');

-- Database creation and grants.
DROP DATABASE IF EXISTS IDENTIFIER('"DATACLASS_DB"');
CREATE DATABASE IDENTIFIER('"DATACLASS_DB"');

GRANT CREATE SCHEMA, MONITOR, USAGE on database IDENTIFIER('"DATACLASS_DB"') to role identifier('POC_DATACLASSIFICATION');
GRANT USAGE, CREATE TABLE ON SCHEMA "DATACLASS_DB"."PUBLIC" TO ROLE "POC_DATACLASSIFICATION" WITH GRANT OPTION;


-- Switch to your new role.
USE ROLE IDENTIFIER('"POC_DATACLASSIFICATION"');

USE DATABASE DATACLASS_DB;
USE SCHEMA PUBLIC;

-- Table creation
DROP TABLE IF EXISTS CUSTOMER_DETAILS;
CREATE TABLE CUSTOMER_DETAILS (
  name varchar(255) default NULL,
  phone varchar(100) default NULL,
  email varchar(255) default NULL,
  address varchar(255) default NULL,
  previlgeid varchar(255) default NULL,
  region varchar(50) default NULL,
  text TEXT default NULL,
  numberrange integer default NULL,
  salary varchar(100) default NULL,
  country varchar(100) default NULL,
  postalZip varchar(10) default NULL,
  creditCard varchar(255),
  pin varchar(4),
  iban varchar(34),
  cvv varchar(255),
  company varchar(255),
  healthissue varchar(255) default NULL
);

-- Adding some random data to table. Generated using: https://generatedata.com/generator

INSERT INTO CUSTOMER_DETAILS (name,phone,email,address,previlgeid,region,text,numberrange,salary,country,postalZip,creditCard,pin,iban,cvv,company,healthissue)
VALUES
  ('Hedy Adkins','(214) 687-7101','vulputate.ullamcorper.magna@protonmail.ca','Ap #534-697 Ultricies Rd.','3','Bourgogne','sem eget massa. Suspendisse eleifend. Cras sed leo. Cras vehicula',8,'$16,854','Canada','7252','214977726627147',2939,'RS49326886140102835656','716','Montes Limited','Yes'),
  ('Tatyana Mcintosh','(845) 984-5314','faucibus@outlook.com','226-6875 Amet Av.','3','Ceuta','lectus sit amet luctus vulputate, nisi sem semper erat, in',0,'$10,043','Ireland','67566','6304636544739265234',6354,'KW5067453262885631331446558849','237','Id Ante Inc.','Yes'),
  ('Burke Burnett','1-858-254-4567','donec@icloud.com','534-7391 Urna Av.','15','Cần Thơ','Donec nibh enim, gravida sit amet, dapibus id, blandit at,',4,'$80,312','Vietnam','9438','349543584714838',7344,'LT107351113714558583','589','Tellus Foundation','No'),
  ('Sopoline Holder','1-367-485-0136','ut@yahoo.com','Ap #392-2977 Quam. Road','3','Chernivtsi oblast','eu nibh vulputate mauris sagittis placerat. Cras dictum ultricies ligula.',9,'$53,366','Costa Rica','249575','6493 4717 2492 4425',5044,'GT78782848471623038541489955','646','In Lobortis Tellus PC','No'),
  ('Omar Galloway','1-632-414-4882','natoque.penatibus@protonmail.org','P.O. Box 358, 1383 Ultricies Road','3','Gangwon','malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis',7,'$49,043','China','42-816','670656 56 2538 7642 195',9731,'AE051760551031198436720','618','Magna Sed LLP','No'),
  ('Xaviera Macdonald','1-502-682-4557','curae.phasellus.ornare@protonmail.com','Ap #779-4894 Non, Street','13','Los Ríos','arcu. Vivamus sit amet risus. Donec egestas. Aliquam nec enim.',4,'$23,198','Vietnam','13911','67612915118438765',9454,'GI52UXRZ820463133378924','690','Enim Nunc Corporation','No'),
  ('Veda Dawson','1-815-963-5456','ac.facilisis.facilisis@yahoo.edu','805-1396 Nisl. Av.','3','Sachsen','pellentesque. Sed dictum. Proin eget odio. Aliquam vulputate ullamcorper magna.',9,'$43,171','Russian Federation','6440','5018227982929787',2461,'GE56007571642781037566','169','Vitae Corp.','No'),
  ('Rinah Randolph','(695) 521-4517','nulla.facilisi@google.ca','Ap #311-1287 Mollis St.','17','Gyeonggi','scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis',1,'$40,111','Nigeria','Q1 5OB','3792 285278 32433',3170,'LB91713591421480678831932585','854','Cursus Nunc Institute','Yes'),
  ('Harriet Nelson','1-782-541-4649','dictum.phasellus@icloud.org','Ap #591-8111 Dolor St.','3','Nordrhein-Westphalen','massa lobortis ultrices. Vivamus rhoncus. Donec est. Nunc ullamcorper, velit',10,'$7,685','United Kingdom','53873','4916 1729 3238 4548',8673,'AD2214748381545647709050','464','Ut Erat Foundation','No'),
  ('Britanney Maddox','1-268-556-4666','fames.ac@icloud.edu','554-8177 Feugiat Avenue','11','Dnipropetrovsk oblast','mollis nec, cursus a, enim. Suspendisse aliquet, sem ut cursus',9,'$5,745','India','72-364','5148 3971 5788 5248',3491,'KZ833038809192194476','656','Dolor Dapibus Inc.','No');
INSERT INTO CUSTOMER_DETAILS (name,phone,email,address,previlgeid,region,text,numberrange,salary,country,postalZip,creditCard,pin,iban,cvv,company,healthissue)
VALUES
  ('Nadine Haney','(419) 526-4040','maecenas@google.ca','Ap #616-9486 Magnis St.','5','Rivers','eros. Nam consequat dolor vitae dolor. Donec fringilla. Donec feugiat',8,'$96,168','Germany','08803','491157674962578250',5905,'SA8531471436105089867647','435','Aliquet Foundation','No'),
  ('Kiona Maddox','(419) 526-4040','amet@icloud.net','Ap #426-2201 Ornare, Rd.','7','Valparaíso','orci, adipiscing non, luctus sit amet, faucibus ut, nulla. Cras',2,'$69,093','Austria','891530','491 78257 23693 240',9645,'DE27186261351873374499','505','Luctus Ipsum Leo Associates','Yes'),
  ('Ayanna Goodwin','1-665-515-1751','et@outlook.ca','5729 Suspendisse Road','1','South Jeolla','pede, malesuada vel, venenatis vel, faucibus id, libero. Donec consectetuer',7,'$28,644','China','8664','644 42228 48528 422',6874,'CH4460614138746687164','526','Ut Ipsum Ac LLC','No'),
  ('Aaron Talley','(419) 526-4040','vel.pede@outlook.couk','P.O. Box 378, 116 Nisl. Rd.','3','Nova Scotia','natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',4,'$84,150','Belgium','857774','5018 151873 36615',1525,'KW8522832987556634767558135726','363','Molestie Corporation','Yes'),
  ('Mariam Holden','1-526-131-0864','et.rutrum.non@google.net','P.O. Box 306, 7616 Vitae St.','7','Emilia-Romagna','non, lobortis quis, pede. Suspendisse dui. Fusce diam nunc, ullamcorper',9,'$38,410','Italy','3545 IJ','303636668652983',8701,'IS866531429316225871066445','563','Vulputate Lacus LLP','Yes'),
  ('Cody Jacobson','(686) 762-6367','pede.suspendisse@outlook.couk','198-6429 Vel Rd.','17','Gauteng','purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam',6,'$30,546','Costa Rica','54504','301735465678779',7448,'SM9396685443307844343157321','919','Non Enim Commodo Limited','No'),
  ('Xaviera Schmidt','1-668-826-8643','vel.arcu@outlook.couk','P.O. Box 394, 9124 Enim, St.','3','Zhōngnán','fames ac turpis egestas. Fusce aliquet magna a neque. Nullam',6,'$30,431','France','8758','4485236561387394',5516,'KZ294397762143514927','343','Libero Mauris Aliquam Associates','Yes'),
  ('Kermit Crosby','1-274-465-8432','sit.amet@google.edu','452-307 Amet Avenue','15','South Gyeongsang','Vivamus euismod urna. Nullam lobortis quam a felis ullamcorper viverra.',3,'$19,310','Australia','24254','647442 4265375815',2150,'GB79XDQX98598614115938','123','Cursus Industries','Yes'),
  ('Roth Fox','(782) 899-0538','ac.ipsum.phasellus@protonmail.net','Ap #247-217 Arcu. Av.','15','Dalarnas län','quis arcu vel quam dignissim pharetra. Nam ac nulla. In',5,'$84,667','South Korea','98633','56411539894264',7310,'LI1135887811778393410','705','Lorem Limited','No'),
  ('Lillith Blankenship','(257) 359-4323','vivamus.molestie.dapibus@aol.ca','P.O. Box 207, 7391 Tortor Av.','7','Lazio','Class aptent taciti sociosqu ad litora torquent per conubia nostra,',10,'$16,820','Spain','331071','633424 4467515756',5069,'DE23233312405188122143','998','Proin Inc.','No');
INSERT INTO CUSTOMER_DETAILS (name,phone,email,address,previlgeid,region,text,numberrange,salary,country,postalZip,creditCard,pin,iban,cvv,company,healthissue)
VALUES
  ('Mannix Compton','1-875-126-9216','eleifend@icloud.couk','P.O. Box 706, 2759 Orci Road','15','Rio Grande do Sul','ut, pellentesque eget, dictum placerat, augue. Sed molestie. Sed id',0,'$75,716','France','20869','214991284663782',3709,'EE200137321513367472','768','In At Industries','Yes'),
  ('Bruce Conrad','(857) 830-7569','nullam.velit@protonmail.net','4967 Ut Avenue','15','Vaupés','eu elit. Nulla facilisi. Sed neque. Sed eget lacus. Mauris',2,'$79,272','Norway','85617','3411 667676 69740',8310,'TR044893114713500217816493','174','A Tortor Consulting','Yes'),
  ('Garrett Hendricks','(301) 303-4148','interdum.ligula@aol.ca','P.O. Box 851, 5806 Nec, St.','1','Niger','tristique aliquet. Phasellus fermentum convallis ligula. Donec luctus aliquet odio.',7,'$47,033','Ireland','588476','366683733983799',4664,'BH71688845412761283744','379','Nunc Foundation','No'),
  ('Bo Richardson','(304) 769-5545','et@aol.couk','Ap #336-3523 Et Av.','13','Leinster','Nullam nisl. Maecenas malesuada fringilla est. Mauris eu turpis. Nulla',7,'$66,685','Sweden','51210','346283756442321',3361,'IS735715536249994228174934','808','Lacus Vestibulum Lorem Incorporated','Yes'),
  ('Eleanor Ayers','1-434-334-5535','et.malesuada.fames@icloud.net','Ap #503-4302 Euismod St.','3','Piemonte','Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut',0,'$8,814','South Africa','69216','365764677522537',9672,'EE608133534523686358','977','Aliquam Ultrices Iaculis Corporation','No'),
  ('Debra Berry','1-611-737-3746','rutrum.eu.ultrices@icloud.org','P.O. Box 401, 7601 Eget Avenue','11','South Island','risus. Duis a mi fringilla mi lacinia mattis. Integer eu',4,'$63,516','Austria','395876','303166353867787',7318,'ES1476994442458617631241','914','Commodo At Consulting','Yes'),
  ('Brian Richardson','1-828-886-2385','fermentum.vel@hotmail.edu','P.O. Box 948, 1428 Proin St.','3','West-Vlaanderen','metus. In lorem. Donec elementum, lorem ut aliquam iaculis, lacus',8,'$13,985','South Africa','1363','6334 7698 7255 6631',8876,'MR0272733857404031731458468','114','Non Egestas Corp.','No'),
  ('Aileen Merritt','(985) 246-1263','ipsum.primis@google.net','Ap #255-7694 Nunc Rd.','11','Northern Mindanao','urna. Nullam lobortis quam a felis ullamcorper viverra. Maecenas iaculis',1,'$49,592','Mexico','79833','484452 522732 2175',4351,'LB32521034042440382763299862','957','Enim Corporation','Yes'),
  ('Hedy Watkins','1-648-253-0055','sapien@yahoo.couk','P.O. Box 792, 1524 Dolor Road','3','Queensland','tellus justo sit amet nulla. Donec non justo. Proin non',4,'$69,045','Russian Federation','531943','371229617746747',3501,'GR6743321352338595224467485','813','Vitae Erat LLP','No'),
  ('Rafael Donovan','(633) 819-6733','nibh@protonmail.ca','Ap #294-2443 Orci Rd.','13','Mykolaiv oblast','urna. Nunc quis arcu vel quam dignissim pharetra. Nam ac',9,'$97,095','Chile','8080','575272 8146595331',7762,'MU3829377572716427542788583905','344','Ac Metus Vitae Consulting','Yes');
INSERT INTO CUSTOMER_DETAILS (name,phone,email,address,previlgeid,region,text,numberrange,salary,country,postalZip,creditCard,pin,iban,cvv,company,healthissue)
VALUES
  ('TaShya Bentley','1-627-527-7881','id.sapien@hotmail.net','P.O. Box 340, 7639 Sit Street','15','Yukon','vitae, sodales at, velit. Pellentesque ultricies dignissim lacus. Aliquam rutrum',9,'$35,113','New Zealand','94313-379','568218572222336',4796,'DO14606712469565352123196055','566','Felis Orci Corporation','No'),
  ('Hilary Kirkland','(826) 634-4747','eget.ipsum.suspendisse@icloud.org','7589 Mauris Av.','15','Delaware','enim. Curabitur massa. Vestibulum accumsan neque et nunc. Quisque ornare',8,'$87,004','United Kingdom','R2T 4T1','6759765572591565639',9501,'PS051714451220236837373639426','208','A Corp.','Yes'),
  ('Stephanie Rhodes','(860) 562-3875','faucibus.id@hotmail.org','228-6465 Sed Avenue','11','Lima','Phasellus at augue id ante dictum cursus. Nunc mauris elit,',8,'$37,902','United States','877244','656 44227 53331 531',7108,'LB93832123538601808386785253','117','Vitae Sodales Corporation','No'),
  ('Wynne Frost','(715) 240-4288','sed@aol.com','P.O. Box 966, 4665 Aliquam Road','13','Hessen','pellentesque. Sed dictum. Proin eget odio. Aliquam vulputate ullamcorper magna.',8,'$64,695','United Kingdom','04627','6304175343249334821',4494,'GR2268083443505122247782897','525','Rhoncus Proin Nisl Institute','No'),
  ('Phelan Merritt','(550) 683-3473','eu.odio.phasellus@yahoo.couk','295-3233 Risus. Av.','19','Berlin','nunc sed libero. Proin sed turpis nec mauris blandit mattis.',1,'$12,188','Indonesia','20504','3411 861658 87827',4546,'ES8456668841614425306746','561','Sagittis Ltd','Yes'),
  ('George Allison','1-263-211-4778','eros.non@icloud.net','Ap #546-6164 A, Street','7','Kherson oblast','ante ipsum primis in faucibus orci luctus et ultrices posuere',1,'$97,912','Ireland','974675','633432245468657788',5989,'AT376345968236074677','408','Placerat Orci Lacus LLP','Yes'),
  ('Graham Morris','(882) 640-2186','non@hotmail.edu','Ap #762-6445 Nullam Avenue','1','Istanbul','viverra. Maecenas iaculis aliquet diam. Sed diam lorem, auctor quis,',9,'$22,955','Mexico','50516','301675337898983',9844,'SI54083381798255782','159','Nulla Limited','No'),
  ('Deborah Kidd','1-365-493-9529','tristique.aliquet@hotmail.net','P.O. Box 237, 5317 Ridiculus Av.','7','Sardegna','nec, malesuada ut, sem. Nulla interdum. Curabitur dictum. Phasellus in',6,'$28,297','Philippines','9152','4917246188353313',8539,'DE92334607582704456755','505','Elementum Sem PC','Yes'),
  ('Allen Gregory','1-805-425-1768','elit.pharetra@outlook.couk','2586 Erat, Road','9','Astrakhan Oblast','egestas, urna justo faucibus lectus, a sollicitudin orci sem eget',3,'$15,353','Indonesia','395687','3653 978719 29792',7501,'GE24951883422387170258','257','Neque Sed Limited','No'),
  ('Rhoda Mercer','1-518-119-1851','libero@outlook.couk','615-9809 Elit Road','15','North Island','massa. Suspendisse eleifend. Cras sed leo. Cras vehicula aliquet libero.',6,'$94,862','Ireland','AV2 3RP','201484342635567',6075,'HR1866567404582661921','652','Aenean Euismod Mauris Limited','Yes');
INSERT INTO CUSTOMER_DETAILS (name,phone,email,address,previlgeid,region,text,numberrange,salary,country,postalZip,creditCard,pin,iban,cvv,company,healthissue)
VALUES
  ('Yoshio Collier','(739) 702-5254','vivamus.rhoncus@yahoo.ca','734-8867 Turpis Ave','1','Yukon','montes, nascetur ridiculus mus. Proin vel nisl. Quisque fringilla euismod',9,'$41,344','Italy','38517','342686759381425',8435,'CZ9013340660611253494652','430','Risus LLC','No'),
  ('Benedict Simon','(767) 554-8841','magna@aol.net','513-8367 Ut Street','15','São Paulo','tempus mauris erat eget ipsum. Suspendisse sagittis. Nullam vitae diam.',5,'$67,549','Colombia','28220','3677 524398 16857',6110,'IT422MGQSI24852828255212557','446','Erat LLP','Yes'),
  ('Heidi Pace','1-734-641-9221','dictum.proin@outlook.net','Ap #809-4485 Integer Rd.','9','Nova Scotia','Vivamus rhoncus. Donec est. Nunc ullamcorper, velit in aliquet lobortis,',1,'$30,147','Austria','63924','4026 9526 3187 6812',5427,'NL95YQED5447126542','204','Sed Et Libero PC','Yes'),
  ('Simone Bowen','1-419-160-5246','amet.consectetuer.adipiscing@aol.couk','958-2697 At, Rd.','17','North Island','enim non nisi. Aenean eget metus. In nec orci. Donec',9,'$83,299','United States','86600','655634 7463244288',4008,'GB41DGTB24970722992541','825','Cursus Et Corp.','No'),
  ('Sebastian Guy','(337) 225-8184','aptent@yahoo.org','442-3149 Mi. Av.','1','Euskadi','velit. Aliquam nisl. Nulla eu neque pellentesque massa lobortis ultrices.',0,'$51,873','India','645759','676154625566892',9468,'GL9236447534564135','412','Curabitur Institute','No'),
  ('Aspen Garza','1-677-584-0326','sagittis.placerat@aol.net','Ap #210-5760 Orci. Rd.','3','Cartago','Vivamus rhoncus. Donec est. Nunc ullamcorper, velit in aliquet lobortis,',9,'$32,431','India','41763-216','201457723849130',1910,'LB41645727773411333953373233','848','Metus Aliquam Corporation','No'),
  ('Tatyana Sears','1-274-504-8482','proin.nisl@yahoo.net','Ap #850-608 Varius. Rd.','7','Luik','nisl. Nulla eu neque pellentesque massa lobortis ultrices. Vivamus rhoncus.',5,'$62,258','United Kingdom','50119','6767 6368 9941 2252',3679,'NL23JLMR6912186265','799','Orci Luctus Et Limited','No'),
  ('Breanna Kane','1-239-834-2242','nulla.tempor.augue@hotmail.couk','P.O. Box 997, 1974 Iaculis, St.','1','Northern Cape','eros non enim commodo hendrerit. Donec porttitor tellus non magna.',3,'$87,147','Poland','542310','676 71542 59852 547',7526,'MK11036848746519515','962','Ornare LLC','No'),
  ('Amir Maddox','(628) 675-1124','rhoncus@protonmail.net','P.O. Box 565, 9901 Pede, Rd.','1','North Island','a feugiat tellus lorem eu metus. In lorem. Donec elementum,',3,'$79,598','Mexico','8481','564 18226 68824 982',5410,'SK1116063657282443422292','243','Lectus Institute','Yes'),
  ('Illiana Roy','(257) 757-6624','ante.dictum.mi@yahoo.couk','Ap #652-7303 Nisl. Rd.','19','Lambayeque','Ut semper pretium neque. Morbi quis urna. Nunc quis arcu',4,'$70,553','Philippines','3701','3752 457197 39311',3104,'DE20676054084425334532','798','In Company','No');
INSERT INTO CUSTOMER_DETAILS (name,phone,email,address,previlgeid,region,text,numberrange,salary,country,postalZip,creditCard,pin,iban,cvv,company,healthissue)
VALUES
  ('Kimberly Wagner','1-603-127-5184','lacus.aliquam@aol.ca','974-1348 Convallis, St.','3','Central Java','sem semper erat, in consectetuer ipsum nunc id enim. Curabitur',8,'$55,577','Germany','22431','3661 867797 26668',1414,'MR2227003783236103668443624','546','Aliquam Eros PC','No'),
  ('Skyler Marquez','(416) 157-6853','mauris.sit.amet@aol.com','4515 Enim. St.','15','Santander','eleifend non, dapibus rutrum, justo. Praesent luctus. Curabitur egestas nunc',8,'$51,551','China','32-332','4508666432742794',9767,'MD8043445453868657816627','571','Malesuada Augue Institute','Yes'),
  ('Armando Goodman','1-463-351-9676','turpis.vitae@protonmail.org','2643 Enim Street','11','Friesland','metus urna convallis erat, eget tincidunt dui augue eu tellus.',6,'$27,791','Ireland','2771','3016 911527 86476',9507,'ME96041235904440303061','488','Fermentum Vel Mauris Industries','No'),
  ('Philip Hayden','(523) 373-4663','lorem.fringilla@icloud.couk','Ap #688-7144 Facilisis St.','19','Vienna','luctus lobortis. Class aptent taciti sociosqu ad litora torquent per',5,'$96,970','Austria','67221','303672878283228',9483,'PL23800784422272184485609649','737','Conubia LLC','Yes'),
  ('Blake Delgado','1-378-144-6604','pede.nunc@protonmail.couk','Ap #971-7053 Sed Road','19','Zamboanga Peninsula','eu, ultrices sit amet, risus. Donec nibh enim, gravida sit',9,'$26,307','Poland','27544','368721261886576',8050,'BA298434060494851748','154','Interdum Sed Corp.','Yes'),
  ('Martena Herrera','1-843-393-1488','tempor.est.ac@yahoo.couk','Ap #258-4867 Dis Street','15','Guerrero','tellus lorem eu metus. In lorem. Donec elementum, lorem ut',7,'$69,564','Costa Rica','74244','4175 0091 7788 6264',8258,'HR9618163677215736951','235','Mollis LLP','Yes'),
  ('Farrah Clark','(774) 905-7195','accumsan@icloud.net','Ap #203-4368 Feugiat Street','5','Thanh Hóa','pharetra nibh. Aliquam ornare, libero at auctor ullamcorper, nisl arcu',10,'$25,100','China','357578','633464669274645276',6694,'AL87262678562369608359871336','195','Arcu Nunc PC','No'),
  ('Karly Calderon','1-761-317-3430','sapien.gravida@protonmail.couk','Ap #153-9549 Metus. St.','3','North Island','egestas. Aliquam fringilla cursus purus. Nullam scelerisque neque sed sem',0,'$47,867','China','494141','6334127324445558724',3880,'KW5415668534384421357085063751','892','Integer Sem Foundation','Yes'),
  ('Tate Thompson','1-956-241-1355','placerat@outlook.net','936-5859 Consectetuer St.','7','Sikkim','imperdiet ornare. In faucibus. Morbi vehicula. Pellentesque tincidunt tempus risus.',4,'$45,484','United Kingdom','36E 9V8','557483 1953934373',5909,'HU54346443455642190700740715','444','Etiam Ligula Ltd','Yes'),
  ('Geoffrey Carter','(724) 787-7288','aenean.eget@yahoo.net','5639 Ultricies Rd.','3','Newfoundland and Labrador','Nulla facilisi. Sed neque. Sed eget lacus. Mauris non dui',8,'$86,993','Vietnam','49107','4347922558379',7277,'CZ8064359884416478375876','870','Magna Incorporated','Yes');
INSERT INTO CUSTOMER_DETAILS (name,phone,email,address,previlgeid,region,text,numberrange,salary,country,postalZip,creditCard,pin,iban,cvv,company,healthissue)
VALUES
  ('Fitzgerald Martin','1-271-797-8130','dignissim@hotmail.net','701-8283 Tortor. St.','1','Emilia-Romagna','vulputate velit eu sem. Pellentesque ut ipsum ac mi eleifend',8,'$10,220','Austria','M5W 4J7','3467 974483 86695',5896,'BE40371551277147','327','Risus Morbi Metus Inc.','Yes'),
  ('Todd Hatfield','(270) 337-2223','semper@hotmail.com','Ap #720-4045 Cras St.','11','Jönköpings län','venenatis lacus. Etiam bibendum fermentum metus. Aenean sed pede nec',1,'$94,849','Ukraine','74283','584448478481',1131,'EE980104746277183294','442','Aliquam Institute','Yes'),
  ('Ethan Barker','1-624-466-6642','nunc.est@yahoo.couk','5491 Nulla. St.','13','Cantabria','lacinia vitae, sodales at, velit. Pellentesque ultricies dignissim lacus. Aliquam',5,'$5,416','Belgium','889061','450863 743442 8633',5007,'FR7787742447193637880645747','719','Justo Nec PC','No'),
  ('Norman Drake','1-289-159-8042','morbi.quis@outlook.couk','107-7692 Aliquam Rd.','19','Chiapas','erat vel pede blandit congue. In scelerisque scelerisque dui. Suspendisse',8,'$41,226','New Zealand','85-83','490346 5762823147',7602,'FR1886113840446183458829413','117','Vel Arcu Corp.','No'),
  ('Odysseus Clay','1-926-355-8783','nullam.velit.dui@google.edu','983-7198 Taciti Av.','5','Midi-Pyrénées','eu, ligula. Aenean euismod mauris eu elit. Nulla facilisi. Sed',1,'$13,032','Nigeria','17-54','3051 517645 35635',8065,'IT023VCECI22181626972303455','196','Non Egestas LLP','Yes'),
  ('Julian Pacheco','1-372-114-5176','nonummy.fusce@google.net','Ap #101-7557 Vel Road','19','Jalisco','amet, risus. Donec nibh enim, gravida sit amet, dapibus id,',6,'$71,534','Netherlands','2482','601188 3272457264',5883,'NL97WXLD4451226618','494','Magna Tellus Faucibus Limited','Yes'),
  ('Caleb Juarez','1-808-435-8135','suspendisse.tristique@aol.couk','758-7942 Suspendisse Rd.','13','Xīběi','nisl. Maecenas malesuada fringilla est. Mauris eu turpis. Nulla aliquet.',5,'$23,379','India','29151','524 56384 46146 757',1467,'LT534285144425049431','796','Pede Industries','Yes'),
  ('Phoebe Kirby','(744) 572-4223','lorem.eu.metus@yahoo.couk','965-5877 Sed Ave','17','Franche-Comté','ultrices a, auctor non, feugiat nec, diam. Duis mi enim,',7,'$25,147','New Zealand','14557','652 86625 27464 846',9681,'GI94PGYG273366483893647','199','Ligula Corp.','Yes'),
  ('Xaviera Short','1-784-209-7583','eu.tellus.phasellus@outlook.com','683-9222 Donec Street','3','North-East Region','mi tempor lorem, eget mollis lectus pede et risus. Quisque',5,'$91,262','Ireland','237676','6767429965279297676',6510,'IS305445875596477551755274','796','Nibh PC','No'),
  ('Brielle Walker','1-237-662-4682','aliquam.iaculis.lacus@hotmail.ca','219-1078 Mus. Rd.','3','Basse-Normandie','ad litora torquent per conubia nostra, per inceptos hymenaeos. Mauris',2,'$28,968','Germany','313312','402634 551335 2376',7672,'GB48UKCF74783342456273','613','Risus Quisque Corp.','No');
INSERT INTO CUSTOMER_DETAILS (name,phone,email,address,previlgeid,region,text,numberrange,salary,country,postalZip,creditCard,pin,iban,cvv,company,healthissue)
VALUES
  ('Keane Harrington','1-358-388-0531','laoreet.posuere.enim@google.couk','Ap #462-4893 Venenatis Avenue','19','Minnesota','mollis. Integer tincidunt aliquam arcu. Aliquam ultrices iaculis odio. Nam',4,'$45,447','New Zealand','75848','305488464476441',2311,'GE68416202253457751561','342','Risus Donec Incorporated','No'),
  ('Hanae Dickerson','1-223-703-6721','tellus.faucibus@yahoo.edu','3661 Nullam St.','17','Ilocos Region','rhoncus. Donec est. Nunc ullamcorper, velit in aliquet lobortis, nisi',2,'$67,890','Netherlands','829364','676783266153916721',5803,'LI7937197916641693475','213','Non Arcu PC','No'),
  ('Barbara Hester','1-858-833-2582','adipiscing.mauris@google.ca','7790 Duis Ave','11','Pennsylvania','aliquet odio. Etiam ligula tortor, dictum eu, placerat eget, venenatis',3,'$66,593','South Korea','28-77','342537873222955',1713,'EE618385345144167763','410','Egestas Urna Justo Inc.','Yes'),
  ('Nathan Wall','(544) 211-6286','gravida.aliquam@outlook.net','Ap #214-6518 Est Rd.','13','Tyumen Oblast','id risus quis diam luctus lobortis. Class aptent taciti sociosqu',8,'$59,721','Colombia','62509','201423227513952',3668,'IS695221058437623778754877','411','Sociis Natoque Penatibus Ltd','No'),
  ('Paula Roach','1-524-235-4222','non@protonmail.couk','1551 Malesuada Rd.','13','Anambra','vulputate, posuere vulputate, lacus. Cras interdum. Nunc sollicitudin commodo ipsum.',3,'$15,597','Vietnam','54783','675966 6826957483',4717,'AZ34412789207418343873323633','975','Egestas Foundation','Yes'),
  ('Mariam Newman','(148) 715-2064','magna.duis.dignissim@hotmail.ca','438-5710 Tincidunt St.','19','Saskatchewan','enim. Etiam imperdiet dictum magna. Ut tincidunt orci quis lectus.',8,'$76,979','Italy','6651','348272446363474',5231,'BE53318667314383','942','Mollis Vitae Corp.','Yes'),
  ('Kyla Colon','(670) 599-1523','sem.eget@outlook.couk','Ap #682-7692 Sit Rd.','11','Alabama','aliquet magna a neque. Nullam ut nisi a odio semper',8,'$67,674','Spain','R5K 2J7','6767852554153182166',4770,'CH2833716155072337825','177','Erat Eget Consulting','No'),
  ('Herrod Rojas','1-782-815-3037','facilisis@outlook.ca','943-6184 Suspendisse St.','1','Meghalaya','interdum enim non nisi. Aenean eget metus. In nec orci.',4,'$11,195','Nigeria','9825 DD','491383 8377383277',8533,'AZ54248680112613616584221185','469','Quisque Porttitor Eros Incorporated','Yes'),
  ('McKenzie Steele','1-662-538-7683','sed.est.nunc@google.com','Ap #458-5411 Etiam Street','9','Michigan','Suspendisse aliquet molestie tellus. Aenean egestas hendrerit neque. In ornare',9,'$9,625','Poland','718662','677 15244 71857 835',2044,'BG83FXJN65131360821551','377','Ipsum Corporation','No'),
  ('Cally Browning','(685) 213-9282','tempus.risus.donec@outlook.net','2937 Suspendisse Street','5','Zamboanga Peninsula','auctor, velit eget laoreet posuere, enim nisl elementum purus, accumsan',4,'$83,493','Chile','816601','677 14825 62883 626',4076,'MC4521279907723329588544067','247','Magna Malesuada Vel LLC','Yes');
INSERT INTO CUSTOMER_DETAILS (name,phone,email,address,previlgeid,region,text,numberrange,salary,country,postalZip,creditCard,pin,iban,cvv,company,healthissue)
VALUES
  ('Gray Washington','1-678-485-1761','quam.curabitur.vel@hotmail.net','Ap #753-3373 Imperdiet St.','3','Poltava oblast','nulla vulputate dui, nec tempus mauris erat eget ipsum. Suspendisse',10,'$34,513','Indonesia','731019','6771 7638 2917 6338',9469,'CH0771843760167126103','849','Et Company','No'),
  ('Bernard Solis','(511) 402-4056','ante.bibendum@hotmail.ca','883-4550 Augue Ave','7','Dadra and Nagar Haveli','mollis dui, in sodales elit erat vitae risus. Duis a',3,'$93,415','Turkey','40W 8P1','677149 866219 7311',2905,'CY32628112565603267883525354','435','Cras LLC','Yes'),
  ('Bert Martinez','1-222-372-8369','eu@icloud.edu','412-7731 Posuere Rd.','9','Gangwon','Proin velit. Sed malesuada augue ut lacus. Nulla tincidunt, neque',6,'$16,356','Austria','73452','6334 8473 2543 3929',8445,'AE709272276368775805515','343','Faucibus Morbi Inc.','No'),
  ('Moses Caldwell','1-845-638-8233','sed.turpis@protonmail.couk','Ap #934-2130 Risus. Rd.','5','Loreto','ultrices sit amet, risus. Donec nibh enim, gravida sit amet,',2,'$85,144','Nigeria','47355','5559 3467 2856 4594',4156,'AE050162389533668145241','865','Nec Euismod Foundation','No'),
  ('Ora Sharpe','(759) 274-4477','aenean.euismod.mauris@google.couk','Ap #313-1390 Arcu. Rd.','11','São Paulo','Proin dolor. Nulla semper tellus id nunc interdum feugiat. Sed',9,'$74,526','Colombia','58-821','4026782776835871',4840,'NL30JIQC6313052753','752','Neque Sed Corp.','Yes'),
  ('Amal Forbes','1-765-757-5661','sed.auctor.odio@hotmail.ca','Ap #167-6687 Ut, Rd.','13','Västra Götalands län','augue malesuada malesuada. Integer id magna et ipsum cursus vestibulum.',3,'$8,841','Vietnam','876795','524224 6625298739',4149,'CR6153163441876317556','148','Porttitor Interdum Corp.','No'),
  ('Eric Marquez','(682) 834-2946','ultricies.ligula@hotmail.ca','Ap #282-7922 Nunc Rd.','19','Namen','rhoncus. Nullam velit dui, semper et, lacinia vitae, sodales at,',8,'$41,172','Turkey','214549','453 95683 74655 864',7053,'CR2894784667505721663','627','Mi Ac Corp.','No'),
  ('Guy Holcomb','1-488-273-9523','libero@google.org','Ap #512-8282 Lobortis, St.','9','Nuevo León','dolor. Fusce mi lorem, vehicula et, rutrum eu, ultrices sit',9,'$68,666','China','63N 2G6','3048 436892 86226',2429,'KW5041676008325636856214436210','410','Auctor Inc.','Yes'),
  ('Ifeoma Knapp','(768) 775-8430','phasellus.nulla@hotmail.org','Ap #263-6216 Luctus Rd.','1','Lower Austria','blandit enim consequat purus. Maecenas libero est, congue a, aliquet',8,'$53,163','Vietnam','9754 HR','493696 32 3158 1716 447',3980,'SM1352908680695468477826128','994','Felis Eget Varius Corp.','Yes'),
  ('Buffy Washington','1-730-838-7541','ante.ipsum@icloud.com','757-3657 Aliquam St.','3','Amur Oblast','dictum sapien. Aenean massa. Integer vitae nibh. Donec est mauris,',1,'$82,908','Indonesia','2436','4844 9853 6252 5729',6161,'BE72383367811236','853','Scelerisque Industries','Yes');
INSERT INTO CUSTOMER_DETAILS (name,phone,email,address,previlgeid,region,text,numberrange,salary,country,postalZip,creditCard,pin,iban,cvv,company,healthissue)
VALUES
  ('Yoshio Torres','1-435-396-5248','eget.venenatis@icloud.com','1189 Lacus. Av.','1','Uttarakhand','erat. Sed nunc est, mollis non, cursus non, egestas a,',7,'$89,826','Australia','32-67','645248 8742148125',8634,'SA3162276358502485635319','675','Egestas Rhoncus LLC','Yes'),
  ('Callie Frederick','(252) 565-8264','eu.dui@aol.org','P.O. Box 245, 2592 Duis Rd.','7','Hatay','quam vel sapien imperdiet ornare. In faucibus. Morbi vehicula. Pellentesque',5,'$55,728','Turkey','167685','301114646596179',4937,'SM9372220581488307357535648','700','Praesent Luctus Curabitur Industries','No'),
  ('Hakeem Grant','1-483-603-5498','luctus.aliquet@icloud.com','Ap #634-9223 Nascetur Rd.','1','Corse','pharetra. Quisque ac libero nec ligula consectetuer rhoncus. Nullam velit',10,'$93,670','Ukraine','317787','670613436347563338',9195,'KZ328621716575253706','324','Ligula Corp.','Yes'),
  ('Freya Knapp','1-316-447-3167','at@protonmail.org','922-192 Nec Av.','11','Aragón','scelerisque neque. Nullam nisl. Maecenas malesuada fringilla est. Mauris eu',7,'$55,535','United Kingdom','88-53','3687 788567 36715',2072,'BE02890344451238','138','In Ltd','Yes'),
  ('Heidi Beck','(107) 683-4520','id.magna@google.edu','Ap #464-9720 Dapibus Road','3','Alberta','diam at pretium aliquet, metus urna convallis erat, eget tincidunt',3,'$39,372','India','481274','554 59153 84469 442',1634,'DK0880228672450725','953','Urna Nunc Incorporated','No'),
  ('Chadwick Randall','1-233-213-8293','fermentum.vel.mauris@google.com','5508 Donec Rd.','3','Staffordshire','Nullam velit dui, semper et, lacinia vitae, sodales at, velit.',2,'$17,873','Pakistan','3880','4917279441194273',5148,'RO50TSAQ1116853226212232','501','Dolor Dolor Corp.','Yes'),
  ('Nell Martinez','1-555-869-3515','donec.est.mauris@protonmail.net','P.O. Box 779, 8369 Integer Rd.','7','İzmir','Phasellus vitae mauris sit amet lorem semper auctor. Mauris vel',2,'$42,841','New Zealand','413417','484428 239644 3347',2975,'LT520522362428271719','897','Tortor Nunc Foundation','No'),
  ('Odette Chase','1-303-322-8615','orci@aol.com','493-2033 Dui St.','1','Borno','Donec egestas. Aliquam nec enim. Nunc ut erat. Sed nunc',9,'$8,855','Australia','832502','647387 7228486717',4900,'GI70RRVI646483742622372','672','Nunc Mauris Industries','Yes'),
  ('Aristotle Mccray','1-927-247-4978','ipsum@google.edu','P.O. Box 808, 3541 Nulla Rd.','3','Huntingdonshire','elit erat vitae risus. Duis a mi fringilla mi lacinia',9,'$60,167','New Zealand','14-66','555 77584 62957 937',7832,'KW1379252340200298661654844666','801','Aliquam Erat Volutpat LLP','Yes'),
  ('Mallory Barr','(452) 481-8376','natoque.penatibus@hotmail.com','Ap #387-2165 Accumsan Rd.','13','Puno','aliquet, metus urna convallis erat, eget tincidunt dui augue eu',7,'$82,042','China','58111-503','4625 4387 6831 2628',3043,'LI1384003562218367872','563','Pellentesque Eget Institute','No');
  
  
-- Extracting semantic categories using built in Snowflake Function. Please note you can always review the output before moving to the next step.
SELECT EXTRACT_SEMANTIC_CATEGORIES('CUSTOMER_DETAILS');

-- In order to access some of the views and function, we have to grant previliges on SNOWFLAKE own DB.
GRANT IMPORTED PRIVILEGES ON DATABASE "SNOWFLAKE" TO ROLE "POC_DATACLASSIFICATION";

-- Once you are confirmed on System Tags, semantic_category and privacy_category, you can apply those by using the following command
CALL ASSOCIATE_SEMANTIC_CATEGORY_TAGS('CUSTOMER_DETAILS',
EXTRACT_SEMANTIC_CATEGORIES('CUSTOMER_DETAILS'));

-- You can later view the results using the following command. Note that the latency for the view may be up to 120 minutes. Go grab some coffee :) 
SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.TAG_REFERENCES 
WHERE OBJECT_NAME = 'CUSTOMER_DETAILS';

