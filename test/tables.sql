DROP SCHEMA "strongloop" CASCADE;
CREATE SCHEMA "strongloop";

CREATE TABLE "strongloop"."customer" (
	"id" varchar(64),
	"username" varchar(1024),
	"email" varchar(1024),
	"password" varchar(1024),
	"name" varchar(40),
	"military_agency" varchar(20),
	"realm" varchar(1024),
	"emailverified" char(1),
	"verificationtoken" varchar(1024),
	"credentials" varchar(1024),
	"challenges" varchar(1024),
	"status" varchar(1024),
	"created" date,
	"lastupdated" date
);

CREATE TABLE "strongloop"."session" (
	"id" varchar(64),
	"uid" varchar(1024),
	"ttl" integer
);

CREATE TABLE "strongloop"."inventory" (
	"id" varchar(64),
	"product_id" varchar(20),
	"location_id" varchar(20),
	"available" integer,
	"total" integer
);

CREATE TABLE "strongloop"."location" (
	"id" varchar(64),
	"street" varchar(64),
	"city" varchar(64),
	"zipcode" varchar(16),
	"name" varchar(32),
	"geo" varchar(32)
);

CREATE TABLE "strongloop"."product" (
	"id" varchar(64),
	"name" varchar(64),
	"audible_range" integer,
	"effective_range" integer,
	"rounds" integer,
	"extras" varchar(64),
	"fire_modes" varchar(64)
);

CREATE TABLE "strongloop"."reservation" (
	"id" varchar(64),
	"product_id" varchar(20),
	"location_id" varchar(20),
	"customer_id" varchar(20),
	"qty" integer,
	"status" varchar(20),
	"reserve_date" date,
	"pickup_date" date,
	"return_date" date
);


INSERT INTO "strongloop"."customer" ("id","username","email","password","name","military_agency","realm","emailverified","verificationtoken","credentials","challenges","status","created","lastupdated") VALUES ('612','bat','bat@bar.com','$2a$10$BEG18wcYQn7TRkFIc59EB.vmnsEwqJWMlYM4DNG73iZb.MKA1rjAC',null,null,null,null,null,'[]','[]',null,null,null);
INSERT INTO "strongloop"."customer" ("id","username","email","password","name","military_agency","realm","emailverified","verificationtoken","credentials","challenges","status","created","lastupdated") VALUES ('613','baz','baz@bar.com','$2a$10$jkSYF2gLMdI4CwVQh8AStOs0b24lDu9p8jccnmri/0rvhtwsicm9C',null,null,null,null,null,'[]','[]',null,null,null);
INSERT INTO "strongloop"."customer" ("id","username","email","password","name","military_agency","realm","emailverified","verificationtoken","credentials","challenges","status","created","lastupdated") VALUES ('610','foo','foo@bar.com','$2a$10$tn1hN7Xv6x74cCB7tVfwkeaaJTd4/6q4RbCMzgmAJeWe40xqrRSui',null,null,null,null,null,'[]','[]',null,null,null);
INSERT INTO "strongloop"."customer" ("id","username","email","password","name","military_agency","realm","emailverified","verificationtoken","credentials","challenges","status","created","lastupdated") VALUES ('611','bar','bar@bar.com','$2a$10$a8mCol6d5vQXm6vubqXl8e5V66StEg6E8vzjQqPpoyk95Vm3smpiK',null,null,null,null,null,'[]','[]',null,null,null);

INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('441','6','91',8,19);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('442','7','91',21,23);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('443','8','91',35,63);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('444','9','91',0,7);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('445','10','91',0,2);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('446','11','91',1,6);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('447','12','91',67,77);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('448','13','91',7,51);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('449','14','91',39,96);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('450','15','91',36,74);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('451','16','91',15,73);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('453','18','91',0,19);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('452','17','91',36,63);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('454','19','91',24,94);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('455','20','91',8,38);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('456','21','91',41,58);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('457','22','91',18,22);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('458','23','91',25,37);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('459','24','91',39,60);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('460','25','91',30,55);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('461','26','91',4,4);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('462','27','91',6,17);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('463','28','91',63,82);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('464','29','91',30,76);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('465','30','91',13,31);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('466','31','91',10,59);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('467','32','91',39,80);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('468','33','91',69,89);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('469','34','91',62,93);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('470','35','91',13,27);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('471','36','91',8,22);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('472','37','91',0,31);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('473','38','91',9,79);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('474','39','91',6,49);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('475','40','91',39,40);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('476','41','91',1,22);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('477','42','91',12,82);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('478','43','91',1,7);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('479','44','91',15,26);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('480','45','91',22,31);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('481','46','91',64,65);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('482','47','91',10,99);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('483','48','91',26,56);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('484','49','91',14,19);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('485','50','91',51,55);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('486','51','91',25,29);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('487','52','91',31,37);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('488','53','91',35,71);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('489','54','91',5,61);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('490','55','91',4,26);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('491','56','91',29,50);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('492','57','91',15,34);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('493','58','91',30,38);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('494','59','91',54,71);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('495','60','91',6,43);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('496','61','91',40,80);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('497','62','91',32,33);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('498','63','91',44,53);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('499','64','91',10,68);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('500','65','91',11,13);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('501','66','91',7,40);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('502','67','91',5,20);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('503','68','91',30,40);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('504','69','91',6,48);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('505','70','91',7,53);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('506','71','91',2,21);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('507','72','91',25,56);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('508','73','91',13,85);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('509','74','91',63,67);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('510','75','91',9,11);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('511','76','91',18,46);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('512','77','91',7,88);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('513','78','91',36,55);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('514','79','91',8,33);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('515','80','91',63,73);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('517','82','91',2,5);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('516','81','91',36,71);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('518','83','91',11,11);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('519','84','91',21,39);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('520','85','91',90,91);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('521','86','91',1,2);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('522','87','91',36,47);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('523','2','92',6,7);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('524','3','92',15,23);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('525','4','92',1,1);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('527','6','92',22,24);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('526','5','92',37,42);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('528','7','92',12,13);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('529','8','92',4,25);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('531','10','92',9,31);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('530','9','92',32,87);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('532','11','92',2,38);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('533','12','92',66,88);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('534','13','92',4,15);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('535','14','92',9,88);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('536','15','92',18,72);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('537','16','92',13,26);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('538','17','92',20,55);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('539','18','92',17,76);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('540','19','92',28,58);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('542','21','92',7,12);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('541','20','92',78,99);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('543','22','92',4,13);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('544','23','92',12,96);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('545','24','92',82,84);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('546','25','92',29,64);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('547','26','92',5,7);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('548','27','92',3,35);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('549','28','92',23,46);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('550','29','92',21,39);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('551','30','92',19,21);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('552','31','92',24,73);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('553','32','92',51,89);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('554','33','92',22,32);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('555','34','92',56,95);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('556','35','92',47,95);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('557','36','92',17,24);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('558','37','92',0,0);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('559','38','92',14,53);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('560','39','92',65,67);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('561','40','92',64,95);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('562','41','92',5,5);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('563','42','92',7,10);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('564','43','92',34,45);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('565','44','92',0,3);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('566','45','92',20,67);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('567','46','92',58,92);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('568','47','92',21,70);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('569','48','92',56,62);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('570','49','92',0,5);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('571','50','92',16,97);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('572','51','92',6,46);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('573','52','92',58,84);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('574','53','92',25,42);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('575','54','92',13,40);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('576','55','92',18,34);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('577','56','92',44,92);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('578','57','92',0,19);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('579','58','92',13,67);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('580','59','92',18,38);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('581','60','92',7,7);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('582','61','92',6,53);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('583','62','92',4,25);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('584','63','92',31,59);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('585','64','92',25,40);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('586','65','92',2,81);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('587','66','92',23,81);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('588','67','92',9,33);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('589','68','92',2,37);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('590','69','92',53,64);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('591','70','92',21,22);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('592','71','92',7,45);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('593','72','92',9,25);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('594','73','92',0,40);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('595','74','92',21,34);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('596','75','92',33,87);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('597','76','92',44,48);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('598','77','92',64,69);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('599','78','92',31,56);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('600','79','92',11,12);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('601','80','92',3,7);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('602','81','92',26,74);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('603','82','92',29,46);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('604','83','92',1,5);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('605','84','92',35,37);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('606','85','92',12,100);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('607','86','92',9,18);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('608','87','92',49,64);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('95','4','87',18,30);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('97','6','87',10,21);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('96','5','87',3,38);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('98','7','87',43,58);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('99','8','87',6,12);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('100','9','87',0,3);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('101','10','87',0,31);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('102','11','87',73,93);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('103','12','87',22,25);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('104','13','87',44,70);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('105','14','87',26,50);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('106','15','87',36,83);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('107','16','87',20,59);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('108','17','87',28,44);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('109','18','87',5,50);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('110','19','87',2,29);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('111','20','87',38,54);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('112','21','87',4,29);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('113','22','87',1,59);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('114','23','87',20,36);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('115','24','87',10,10);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('116','25','87',58,60);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('117','26','87',0,18);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('118','27','87',29,50);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('119','28','87',24,34);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('120','29','87',36,43);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('121','30','87',43,64);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('122','31','87',79,90);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('123','32','87',13,13);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('124','33','87',9,60);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('125','34','87',7,13);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('126','35','87',43,54);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('127','36','87',67,69);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('128','37','87',1,15);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('129','38','87',36,44);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('130','39','87',1,17);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('131','40','87',13,16);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('132','41','87',24,64);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('133','42','87',87,99);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('134','43','87',27,99);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('135','44','87',71,71);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('136','45','87',9,20);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('137','46','87',9,67);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('138','47','87',19,21);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('139','48','87',5,5);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('140','49','87',82,91);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('141','50','87',27,42);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('142','51','87',51,60);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('143','52','87',8,72);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('145','54','87',3,71);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('144','53','87',5,13);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('146','55','87',55,56);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('147','56','87',9,90);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('148','57','87',3,18);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('149','58','87',2,14);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('150','59','87',54,95);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('151','60','87',62,70);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('152','61','87',18,50);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('153','62','87',60,78);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('154','63','87',23,59);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('155','64','87',14,23);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('156','65','87',2,97);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('157','66','87',49,50);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('158','67','87',47,93);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('159','68','87',34,42);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('160','69','87',3,18);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('161','70','87',37,84);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('162','71','87',22,40);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('163','72','87',8,61);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('164','73','87',2,3);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('165','74','87',10,16);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('166','75','87',53,89);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('167','76','87',35,60);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('168','77','87',57,80);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('169','78','87',53,81);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('170','79','87',32,54);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('171','80','87',1,4);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('172','81','87',78,86);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('173','82','87',11,21);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('174','83','87',28,81);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('175','84','87',2,57);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('176','85','87',30,37);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('177','86','87',17,80);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('179','2','88',10,10);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('178','87','87',1,9);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('180','3','88',1,1);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('181','4','88',8,27);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('182','5','88',3,38);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('183','6','88',28,76);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('184','7','88',40,83);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('185','8','88',1,4);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('186','9','88',87,95);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('187','10','88',29,35);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('188','11','88',10,69);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('189','12','88',32,86);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('190','13','88',27,28);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('191','14','88',59,66);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('192','15','88',59,70);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('193','16','88',43,70);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('194','17','88',50,63);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('195','18','88',8,20);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('196','19','88',20,29);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('197','20','88',36,50);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('198','21','88',40,63);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('199','22','88',4,96);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('200','23','88',70,98);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('201','24','88',1,1);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('202','25','88',17,45);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('203','26','88',52,97);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('204','27','88',0,0);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('205','28','88',97,98);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('206','29','88',26,80);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('207','30','88',11,33);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('208','31','88',10,21);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('209','32','88',14,36);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('210','33','88',71,86);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('211','34','88',85,100);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('212','35','88',3,45);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('213','36','88',0,3);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('214','37','88',17,71);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('215','38','88',41,75);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('216','39','88',37,41);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('217','40','88',37,49);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('218','41','88',1,2);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('219','42','88',49,72);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('220','43','88',24,38);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('221','44','88',6,66);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('222','45','88',31,49);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('223','46','88',9,10);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('224','47','88',57,72);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('225','48','88',17,24);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('226','49','88',41,61);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('227','50','88',33,87);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('228','51','88',11,25);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('229','52','88',1,8);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('230','53','88',14,64);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('231','54','88',50,89);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('232','55','88',16,66);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('233','56','88',0,6);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('234','57','88',18,32);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('235','58','88',6,6);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('236','59','88',68,84);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('237','60','88',50,74);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('238','61','88',7,18);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('239','62','88',14,49);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('240','63','88',3,3);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('241','64','88',21,83);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('242','65','88',48,90);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('243','66','88',11,65);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('244','67','88',29,90);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('245','68','88',44,45);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('246','69','88',23,30);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('247','70','88',53,71);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('248','71','88',50,76);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('249','72','88',13,20);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('250','73','88',6,8);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('251','74','88',7,11);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('252','75','88',0,3);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('253','76','88',49,51);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('254','77','88',37,61);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('255','78','88',4,78);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('257','80','88',23,29);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('256','79','88',1,5);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('259','82','88',1,2);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('258','81','88',3,52);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('260','83','88',65,67);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('261','84','88',41,87);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('262','85','88',20,21);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('93','2','87',43,56);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('94','3','87',27,85);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('263','86','88',46,94);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('264','87','88',64,68);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('265','2','89',5,78);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('266','3','89',29,41);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('267','4','89',2,39);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('268','5','89',57,67);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('269','6','89',1,2);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('270','7','89',68,80);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('271','8','89',22,81);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('272','9','89',9,52);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('273','10','89',26,42);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('274','11','89',42,91);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('275','12','89',23,35);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('276','13','89',38,59);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('277','14','89',43,51);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('278','15','89',19,29);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('279','16','89',21,29);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('280','17','89',18,47);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('281','18','89',26,52);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('282','19','89',18,61);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('283','20','89',33,97);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('284','21','89',1,35);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('285','22','89',41,65);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('286','23','89',16,41);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('287','24','89',26,32);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('288','25','89',0,11);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('289','26','89',30,52);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('290','27','89',29,73);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('291','28','89',26,86);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('292','29','89',48,48);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('293','30','89',0,68);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('294','31','89',25,32);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('295','32','89',37,80);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('296','33','89',12,43);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('297','34','89',34,89);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('298','35','89',54,97);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('299','36','89',2,18);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('300','37','89',13,16);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('301','38','89',19,54);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('302','39','89',16,40);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('303','40','89',10,93);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('304','41','89',35,39);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('305','42','89',24,25);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('306','43','89',5,55);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('307','44','89',9,43);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('308','45','89',36,82);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('309','46','89',5,8);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('310','47','89',18,20);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('311','48','89',2,9);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('312','49','89',34,91);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('313','50','89',27,55);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('314','51','89',11,72);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('315','52','89',8,13);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('316','53','89',4,31);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('317','54','89',1,1);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('318','55','89',7,19);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('319','56','89',3,35);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('320','57','89',58,73);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('321','58','89',2,32);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('322','59','89',51,64);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('323','60','89',34,79);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('324','61','89',44,66);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('325','62','89',37,46);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('326','63','89',10,11);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('327','64','89',15,74);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('328','65','89',8,19);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('329','66','89',13,26);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('330','67','89',0,1);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('331','68','89',5,17);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('332','69','89',0,0);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('333','70','89',1,48);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('334','71','89',13,70);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('335','72','89',24,68);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('336','73','89',21,48);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('337','74','89',17,68);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('338','75','89',72,72);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('339','76','89',6,24);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('340','77','89',18,22);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('341','78','89',8,24);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('342','79','89',26,31);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('343','80','89',14,19);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('344','81','89',10,31);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('345','82','89',88,92);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('346','83','89',5,11);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('347','84','89',13,72);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('348','85','89',18,37);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('349','86','89',6,12);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('350','87','89',79,99);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('351','2','90',10,19);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('353','4','90',8,38);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('352','3','90',3,6);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('354','5','90',26,54);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('355','6','90',20,73);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('356','7','90',30,95);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('357','8','90',32,93);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('358','9','90',4,18);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('359','10','90',32,94);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('360','11','90',57,80);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('361','12','90',3,6);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('362','13','90',40,58);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('363','14','90',54,91);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('364','15','90',10,11);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('365','16','90',34,58);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('366','17','90',34,99);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('367','18','90',72,90);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('368','19','90',13,76);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('369','20','90',37,71);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('370','21','90',21,39);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('371','22','90',4,20);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('372','23','90',11,73);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('373','24','90',18,100);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('375','26','90',0,1);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('374','25','90',26,62);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('376','27','90',10,28);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('377','28','90',68,78);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('378','29','90',10,73);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('379','30','90',73,96);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('380','31','90',35,75);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('381','32','90',58,88);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('382','33','90',14,26);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('383','34','90',22,24);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('384','35','90',23,72);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('385','36','90',23,59);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('387','38','90',51,71);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('386','37','90',3,6);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('388','39','90',48,60);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('389','40','90',44,56);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('390','41','90',25,36);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('391','42','90',32,83);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('392','43','90',77,92);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('393','44','90',30,38);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('394','45','90',43,49);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('395','46','90',23,27);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('396','47','90',78,84);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('397','48','90',26,48);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('398','49','90',15,52);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('399','50','90',4,45);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('400','51','90',53,77);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('401','52','90',5,6);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('402','53','90',17,30);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('403','54','90',4,44);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('404','55','90',12,20);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('405','56','90',15,25);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('406','57','90',1,33);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('407','58','90',22,34);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('408','59','90',6,12);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('409','60','90',3,9);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('410','61','90',41,59);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('411','62','90',16,32);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('412','63','90',7,15);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('413','64','90',49,95);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('414','65','90',41,45);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('416','67','90',11,39);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('415','66','90',18,45);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('417','68','90',26,84);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('418','69','90',3,4);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('419','70','90',72,98);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('420','71','90',26,28);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('421','72','90',2,2);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('422','73','90',57,90);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('423','74','90',12,75);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('424','75','90',23,37);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('425','76','90',22,22);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('426','77','90',30,86);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('427','78','90',44,82);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('428','79','90',13,17);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('429','80','90',38,45);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('430','81','90',26,91);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('431','82','90',34,41);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('432','83','90',19,43);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('433','84','90',43,43);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('434','85','90',34,69);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('435','86','90',10,25);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('436','87','90',18,34);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('437','2','91',25,98);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('438','3','91',15,28);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('439','4','91',56,97);
INSERT INTO "strongloop"."inventory" ("id","product_id","location_id","available","total") VALUES ('440','5','91',20,30);

INSERT INTO "strongloop"."location" ("id","street","city","zipcode","name","geo") VALUES ('87','7153 East Thomas Road','Scottsdale','85251','Phoenix Equipment Rentals','-111.9271738,33.48034450000001');
INSERT INTO "strongloop"."location" ("id","street","city","zipcode","name","geo") VALUES ('91','2799 Broadway','New York','10025','Cascabel Armory','-73.9676965,40.8029807');
INSERT INTO "strongloop"."location" ("id","street","city","zipcode","name","geo") VALUES ('89','1850 El Camino Real','Menlo Park','94027','Military Weaponry','-122.194253,37.459525');
INSERT INTO "strongloop"."location" ("id","street","city","zipcode","name","geo") VALUES ('92','32/66-70 Marine Parade','Coolangatta','4225','Marine Parade','153.536972,-28.167598');
INSERT INTO "strongloop"."location" ("id","street","city","zipcode","name","geo") VALUES ('90','Tolstraat 200','Amsterdam','1074','Munitions Shopmore','4.907475499999999,52.3530638');
INSERT INTO "strongloop"."location" ("id","street","city","zipcode","name","geo") VALUES ('88','390 Lang Road','Burlingame','94010','Bay Area Firearms','-122.3381437,37.5874391');

INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('4','M9',53,75,15,null,'Single');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('3','M1911',53,50,7,null,'Single');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('6','Makarov SD',0,50,8,null,'Single');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('7','PDW',53,75,30,null,'[Single,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('8','Makarov PM',53,50,8,null,'Single');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('9','Double-barreled Shotgun',90,null,2,null,'Single');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('10','Saiga 12K',90,250,8,null,'Single');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('11','Remington 870 (Flashlight)',90,null,8,'Flashlight','Single');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('12','Revolver',53,100,6,null,'Single');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('13','Winchester 1866',125,150,15,null,'Single');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('14','Bizon PP-19 SD',0,100,64,'Silenced','[Single,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('15','MP5SD6',0,100,30,'Silenced','[Single,Burst,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('16','MP5A5',53,100,30,null,'[Single,Burst,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('17','AK-107',80,400,30,'Kobra sight','[Single,Burst,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('18','AK-107 GL',80,null,30,'Kobra sight','[Single,Burst,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('19','AK-107 GL PSO',80,400,30,'[Scope,GP-25 launcher]','[Single,Burst,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('20','AK-107 PSO',80,600,30,'Scope','[Single,Burst,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('21','AK-74',80,300,30,null,'[Single,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('22','AKM',149,400,30,null,'[Single,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('23','AKS',149,200,30,null,'[Single,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('24','AKS (gold)',149,200,30,null,'[Single,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('25','M1014',90,null,8,null,'Single');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('26','AKS-74 Kobra',80,300,30,'Kobra sight','[Single,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('27','AKS-74 PSO',80,400,30,'Scope','[Single,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('28','AKS-74U',80,200,30,null,'[Single,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('29','AKS-74UN Kobra',0,300,30,'[Kobra sight,Silenced]','[Single,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('30','AK-74 GP-25',80,300,30,'GP-25 launcher','[Single,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('31','FN FAL AN/PVS-4',180,400,20,'NV scope','[Single,Burst]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('32','G36',80,400,30,'[Scope,Aimpoint sight]','[Single,Burst,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('33','FN FAL',180,400,20,null,'[Single,Burst]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('34','G36 C',80,300,30,null,'[Single,Burst,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('35','G36-C SD (camo)',0,300,30,'[Aimpoint sight,Silenced]','[Single,Burst,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('36','G36A (camo)',80,400,30,'[Scope,Aimpoint sight]','[Single,Burst,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('37','G36C (camo)',80,300,30,null,'[Single,Burst,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('38','G36 K',80,400,30,'[Scope,Aimpoint sight]','[Single,Burst,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('39','G36C-SD',0,300,30,'Aimpoint sight','[Single,Burst,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('40','G36K (camo)',80,400,30,'[Scope,Aimpoint sight]','[Single,Burst,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('41','L85A2 ACOG GL',80,600,30,'[ACOG scope,M203 launcher]','[Single,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('42','L85A2 SUSAT',80,300,30,'SUSAT optical scope','[Single,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('43','M16A2',80,400,30,null,'[Single,Burst]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('44','L85A2 AWS',80,300,30,'[Thermal scope,NV scope,Laser sight,Variable zoom]','[Single,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('45','L85A2 Holo',80,300,30,'Holographic sight','[Single,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('46','Lee Enfield',162,400,10,null,'Single');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('47','M16A4 ACOG',80,600,30,'ACOG scope','[Single,Burst]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('49','M16A2 M203',80,400,30,'M203 launcher','[Single,Burst]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('48','M4A1',80,300,30,null,'[Single,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('50','M4A1 Holo',80,300,30,'[Holographic sight,M203 launcher]','[Single,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('51','M4A1 CCO',80,300,30,'Aimpoint sight','[Single,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('52','M4A1 CCO SD',0,200,30,'[Aimpoint sight,Silenced]','[Single,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('53','M4A1 M203 RCO',80,600,30,'[ACOG sight,M203 launcher]','[Single,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('54','M4A3 CCO',80,300,30,'[Aimpoint sight,Flashlight]','[Single,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('55','RPK',80,400,30,null,'[Single,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('56','Sa-58 CCO',149,300,30,'Aimpoint sight','[Single,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('57','Sa-58P',149,400,30,null,'[Single,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('58','Sa-58V',149,200,30,null,'[Single,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('59','Sa-58V ACOG',149,400,30,'ACOG sight','[Single,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('60','ER7 RFW',180,2000,25,'[Scope,Aimpoint sight]','Single');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('61','AS50',455,1600,5,'Scope','Single');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('62','KSVK',455,800,5,'Scope','Single');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('63','CZ550',180,800,5,'Scope','Single');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('64','DMR',180,800,20,'Scope','Single');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('65','M107',455,1200,10,'Scope','Single');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('66','M24',180,800,5,'Scope','Single');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('67','M40A3',180,800,5,'[Scope,Camo]','Single');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('68','M14 AIM',180,500,20,'Aimpoint sight','Single');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('69','M240',180,400,100,null,'Full auto');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('70','MG36',80,400,100,'Aimpoint sight','[Single,Burst,Full auto]');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('72','PKM',180,400,100,null,'Full auto');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('71','SVD Camo',180,1200,10,'[Scope,Camo]','Single');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('73','Mk 48 Mod 0',180,400,100,'Aimpoint sight','Full auto');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('74','M249 SAW',80,300,200,null,'Full auto');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('75','Crowbar',2,1,null,null,'Single');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('76','Hatchet',2,1,null,null,'Single');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('77','PKP',180,600,100,'Scope','Full auto');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('78','Machete',2,1,null,null,'Single');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('79','M67 Frag Grenade',null,null,null,null,null);
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('80','Compound Crossbow',3,30,1,null,'Single');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('81','Smoke Grenade',null,null,null,null,null);
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('82','M136 Launcher',160,1000,1,null,'Single');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('83','30Rnd. AK SD',0,null,30,null,null);
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('84','30rnd G36 SD',0,null,30,null,null);
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('85','G36 Mag.',80,null,30,null,null);
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('86','Flashlight',null,null,null,null,null);
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('87','NV Goggles',null,null,null,null,null);
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('2','G17',53,75,15,'Flashlight','Single');
INSERT INTO "strongloop"."product" ("id","name","audible_range","effective_range","rounds","extras","fire_modes") VALUES ('5','M9 SD',0,75,15,'Silenced','Single');

CREATE VIEW "strongloop"."inventory_view" AS
    SELECT  p."name" AS "product",
            l."name" AS "location",
            i."available"
    FROM    "strongloop"."inventory" i,
            "strongloop"."product" p,
            "strongloop"."location" l
    WHERE   p."id" = i."product_id" AND
            l."id" = i."location_id";

ALTER TABLE "strongloop"."customer"    ADD CONSTRAINT "customer_pk" 			 PRIMARY KEY ("id");
ALTER TABLE "strongloop"."inventory"   ADD CONSTRAINT "inventory_pk"		     PRIMARY KEY ("id");
ALTER TABLE "strongloop"."location"    ADD CONSTRAINT "location_pk" 		     PRIMARY KEY ("id");
ALTER TABLE "strongloop"."product"     ADD CONSTRAINT "product_pk"				 PRIMARY KEY ("id");
ALTER TABLE "strongloop"."session"     ADD CONSTRAINT "session_pk"				 PRIMARY KEY ("id");

ALTER TABLE "strongloop"."inventory"   ADD CONSTRAINT "location_fk"              FOREIGN KEY ("location_id")   REFERENCES "strongloop"."location" ("id");
ALTER TABLE "strongloop"."inventory"   ADD CONSTRAINT "product_fk"               FOREIGN KEY ("product_id")    REFERENCES "strongloop"."product" ("id");
ALTER TABLE "strongloop"."reservation" ADD CONSTRAINT "reservation_customer_fk"  FOREIGN KEY ("customer_id")   REFERENCES "strongloop"."customer" ("id");
ALTER TABLE "strongloop"."reservation" ADD CONSTRAINT "reservation_location_fk"  FOREIGN KEY ("location_id")   REFERENCES "strongloop"."location" ("id");
ALTER TABLE "strongloop"."reservation" ADD CONSTRAINT "reservation_product_fk"   FOREIGN KEY ("product_id")    REFERENCES "strongloop"."product" ("id");