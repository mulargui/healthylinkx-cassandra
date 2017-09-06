
use healthylinkx;

/* basic, individual fields */
select * from npidatabyzipcode where Provider_Short_Postal_Code = '98052' limit 2 ;
select * from npidatabyzipcode where Provider_Short_Postal_Code IN ('98052','98074') limit 2 ;
select * from npidatabyzipcode where Provider_Short_Postal_Code IN ('98052') limit 2 ;
select * from npidatabyname where Provider_Last_Name_Legal_Name = 'ANDERSON' limit 2 ;
select * from npidatabyname where Provider_Last_Name_Legal_Name IN ('ANDERSON','YOKE', 'ZINK') limit 2 ;
select * from npidatabyname where Provider_Last_Name_Legal_Name IN ('ANDERSON') limit 2 ;
select * from npidatabyspecialty where Classification = 'Counselor' limit 2 ;
select * from npidatabyspecialty where Classification IN ('Counselor' ,'Prosthetist', 'Eye Bank') limit 2 ;
select * from npidatabyspecialty where Classification IN ('Counselor') limit 2 ;

/* now including gender */
select * from npidatabyzipcode where Provider_Short_Postal_Code = '98052' AND Provider_Gender_Code = 'F' limit 2 ALLOW FILTERING;
select * from npidatabyzipcode where Provider_Short_Postal_Code IN ('98052','98074') AND Provider_Gender_Code = 'F' limit 2 ALLOW FILTERING ;
select * from npidatabyname where Provider_Last_Name_Legal_Name = 'ANDERSON' AND Provider_Gender_Code = 'F' limit 2 ALLOW FILTERING;
select * from npidatabyname where Provider_Last_Name_Legal_Name IN ('ANDERSON','YOKE', 'ZINK') AND Provider_Gender_Code = 'F' limit 2 ALLOW FILTERING;
select * from npidatabyspecialty where Classification = 'Counselor' AND Provider_Gender_Code = 'F' limit 2 ALLOW FILTERING;
select * from npidatabyspecialty where Classification IN ('Counselor' ,'Prosthetist', 'Eye Bank') AND Provider_Gender_Code = 'F' limit 2 ALLOW FILTERING;

/* now including zipcode always */
select * from npidatabyname where Provider_Last_Name_Legal_Name = 'ANDERSON' AND Provider_Short_Postal_Code = '98052' limit 2 ;
select * from npidatabyname where Provider_Last_Name_Legal_Name IN ('ANDERSON','YOKE', 'ZINK') AND Provider_Short_Postal_Code = '98052' limit 2 ;
select * from npidatabyspecialty where Classification = 'Counselor' AND Provider_Short_Postal_Code = '98052' limit 2 ;
select * from npidatabyspecialty where Classification IN ('Counselor' ,'Prosthetist', 'Eye Bank') AND Provider_Short_Postal_Code = '98052' limit 2 ;

/* now including classification always */
select * from npidatabyzipcode where Provider_Short_Postal_Code = '98052' AND Classification = 'Counselor' limit 2 ALLOW FILTERING;
select * from npidatabyzipcode where Provider_Short_Postal_Code IN ('98052','98074') AND Classification = 'Counselor' limit 2 ALLOW FILTERING;
select * from npidatabyname where Provider_Last_Name_Legal_Name = 'ANDERSON' AND Classification = 'Counselor' limit 2 ALLOW FILTERING;
select * from npidatabyname where Provider_Last_Name_Legal_Name IN ('ANDERSON','YOKE', 'ZINK') AND Classification = 'Counselor' limit 2 ALLOW FILTERING;

/* now including lastname always */
select * from npidatabyzipcode where Provider_Short_Postal_Code = '98052' AND Provider_Last_Name_Legal_Name = 'ANDERSON' limit 2 ALLOW FILTERING;
select * from npidatabyzipcode where Provider_Short_Postal_Code IN ('98052','98074') AND Provider_Last_Name_Legal_Name = 'ANDERSON' limit 2 ALLOW FILTERING;
select * from npidatabyspecialty where Classification = 'Counselor' AND Provider_Last_Name_Legal_Name = 'ANDERSON' limit 2 ALLOW FILTERING;
select * from npidatabyspecialty where Classification IN ('Counselor' ,'Prosthetist', 'Eye Bank') AND Provider_Last_Name_Legal_Name = 'ANDERSON' limit 2 ALLOW FILTERING;

/*now all three */
select * from npidatabyzipcode where Provider_Short_Postal_Code = '98052' AND Provider_Last_Name_Legal_Name = 'ANDERSON' AND Classification = 'Counselor' limit 2 ALLOW FILTERING;
select * from npidatabyzipcode where Provider_Short_Postal_Code IN ('98052','98074') AND Provider_Last_Name_Legal_Name = 'ANDERSON' AND Classification = 'Counselor' limit 2 ALLOW FILTERING;
select * from npidatabyname where Provider_Last_Name_Legal_Name = 'ANDERSON' AND Classification = 'Counselor' AND Provider_Short_Postal_Code = '98052' limit 2 ALLOW FILTERING;
select * from npidatabyname where Provider_Last_Name_Legal_Name IN ('ANDERSON','YOKE', 'ZINK') AND Classification = 'Counselor' AND Provider_Short_Postal_Code = '98052' limit 2 ALLOW FILTERING;
select * from npidatabyspecialty where Classification = 'Counselor' AND Provider_Last_Name_Legal_Name = 'ANDERSON'  AND Provider_Short_Postal_Code = '98052' limit 2 ALLOW FILTERING;
select * from npidatabyspecialty where Classification IN ('Counselor' ,'Prosthetist', 'Eye Bank') AND Provider_Last_Name_Legal_Name = 'ANDERSON' AND Provider_Short_Postal_Code = '98052' limit 2 ALLOW FILTERING;

/*now all four*/
select * from npidatabyzipcode where Provider_Short_Postal_Code = '98052' AND Provider_Last_Name_Legal_Name = 'ANDERSON' AND Classification = 'Counselor' AND Provider_Gender_Code = 'F' limit 2 ALLOW FILTERING;
select * from npidatabyzipcode where Provider_Short_Postal_Code IN ('98052','98074') AND Provider_Last_Name_Legal_Name = 'ANDERSON' AND Classification = 'Counselor' AND Provider_Gender_Code = 'F' limit 2 ALLOW FILTERING;
select * from npidatabyname where Provider_Last_Name_Legal_Name = 'ANDERSON' AND Classification = 'Counselor' AND Provider_Short_Postal_Code = '98052' AND Provider_Gender_Code = 'F' limit 2 ALLOW FILTERING;
select * from npidatabyname where Provider_Last_Name_Legal_Name IN ('ANDERSON','YOKE', 'ZINK') AND Classification = 'Counselor' AND Provider_Short_Postal_Code = '98052' AND Provider_Gender_Code = 'F' limit 2 ALLOW FILTERING;
select * from npidatabyspecialty where Classification = 'Counselor' AND Provider_Last_Name_Legal_Name = 'ANDERSON'  AND Provider_Short_Postal_Code = '98052' AND Provider_Gender_Code = 'F' limit 2 ALLOW FILTERING;
select * from npidatabyspecialty where Classification IN ('Counselor' ,'Prosthetist', 'Eye Bank') AND Provider_Last_Name_Legal_Name = 'ANDERSON' AND Provider_Short_Postal_Code = '98052' AND Provider_Gender_Code = 'F' limit 2 ALLOW FILTERING;

/* other queries */
select * from taxonomy limit 2;
SELECT * FROM npidata2 WHERE NPI = '1003002379';
SELECT * FROM npidata2 WHERE NPI IN ('1003002379', '1003002536', '1003003153');
SELECT * FROM npidata2 WHERE NPI IN ('1003002379');

INSERT INTO transactions (id, NPI1, NPI2, NPI3) VALUES (now(),'1003002379', '1003002536', '1003003153');
INSERT INTO transactions (id, NPI1, NPI2, NPI3) VALUES (now(),'1003002379', '1003002536', '');
INSERT INTO transactions (id, NPI1, NPI2, NPI3) VALUES (now(),'1003002379', '' , '');
