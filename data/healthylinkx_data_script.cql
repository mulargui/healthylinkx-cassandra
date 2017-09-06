
/* create the database */
CREATE KEYSPACE IF NOT EXISTS healthylinkx with replication = { 'class' : 'SimpleStrategy', 'replication_factor' : 1};
use healthylinkx;

/* Health Care Provider */
CREATE TABLE IF NOT EXISTS npidata2 (
	NPI varchar,
	Provider_Last_Name_Legal_Name varchar,
	Provider_First_Name varchar,
	Provider_Middle_Name varchar,
	Provider_Credential_Text varchar,
	Provider_Full_Name varchar,
	Provider_First_Line_Business_Practice_Location_Address varchar,
	Provider_Second_Line_Business_Practice_Location_Address varchar,
	Provider_Full_Street varchar,
	Provider_Business_Practice_Location_Address_City_Name varchar,
	Provider_Business_Practice_Location_Address_State_Name varchar,
	Provider_Business_Practice_Location_Address_Postal_Code varchar,
	Provider_Full_City varchar,
	Provider_Short_Postal_Code varchar,
	Provider_Business_Practice_Location_Address_Telephone_Number varchar,
	Provider_Gender_Code varchar,
	Healthcare_Provider_Taxonomy_Code_1 varchar,
	Classification varchar,
	Specialization varchar,
	PRIMARY KEY (NPI, Provider_Short_Postal_Code)
);

CREATE MATERIALIZED VIEW IF NOT EXISTS npidatabyname
AS SELECT *
FROM npidata2 
WHERE Provider_Last_Name_Legal_Name IS NOT NULL AND Provider_Short_Postal_Code IS NOT NULL AND NPI IS NOT NULL
PRIMARY KEY (Provider_Last_Name_Legal_Name, Provider_Short_Postal_Code, NPI);

CREATE MATERIALIZED VIEW IF NOT EXISTS npidatabyspecialty 
AS SELECT *
FROM npidata2 
WHERE Classification IS NOT NULL AND Provider_Short_Postal_Code IS NOT NULL AND NPI IS NOT NULL
PRIMARY KEY (Classification, Provider_Short_Postal_Code, NPI);

CREATE MATERIALIZED VIEW IF NOT EXISTS npidatabyzipcode 
AS SELECT *
FROM npidata2 
WHERE Provider_Short_Postal_Code IS NOT NULL AND NPI IS NOT NULL
PRIMARY KEY (Provider_Short_Postal_Code, NPI);

/* create a small table to have the classification taxonomy */
CREATE TABLE IF NOT EXISTS taxonomy(
  Classification varchar PRIMARY KEY
);

/* create a table to save the transactions, old format */
CREATE TABLE IF NOT EXISTS transactionsold(
   id int PRIMARY KEY,
   ts timestamp,
   NPI1 varchar, 
   NPI2 varchar,
   NPI3 varchar
);

/* create a table to save the transactions, new format */
CREATE TABLE IF NOT EXISTS transactions(
   id timeuuid,
   NPI1 varchar, 
   NPI2 varchar,
   NPI3 varchar,
   PRIMARY KEY(id)
);

COPY taxonomy FROM '/myapp/data/taxonomy.csv';
COPY transactionsold (id, ts, NPI1, NPI2, NPI3) FROM '/myapp/data/transactions.csv';
COPY npidata2 (NPI, Provider_Last_Name_Legal_Name, Provider_First_Name, Provider_Middle_Name, Provider_Credential_Text,Provider_Full_Name ,
	Provider_First_Line_Business_Practice_Location_Address ,Provider_Second_Line_Business_Practice_Location_Address ,Provider_Full_Street ,
	Provider_Business_Practice_Location_Address_City_Name ,Provider_Business_Practice_Location_Address_State_Name ,
	Provider_Business_Practice_Location_Address_Postal_Code , Provider_Full_City ,Provider_Short_Postal_Code ,
	Provider_Business_Practice_Location_Address_Telephone_Number ,Provider_Gender_Code ,
	Healthcare_Provider_Taxonomy_Code_1 ,Classification ,Specialization) FROM '/myapp/data/npidata2.csv';

/* And that's all */