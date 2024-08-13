
DROP TABLE IF EXISTS TESTING, TESTING2; -- delete tables before operation
CREATE TABLE IF NOT EXISTS TESTING (ID TEXT, PRIMARY KEY (ID)); -- create first table 
INSERT INTO TESTING VALUES ('test'); -- fill with test data
INSERT INTO TESTING VALUES ('test2'); -- fill with test data 
CREATE TABLE IF NOT EXISTS TESTING2 (ID SERIAL PRIMARY KEY, EXT_ID TEXT); -- create second table 
INSERT INTO TESTING2 VALUES (DEFAULT, 'test'); -- fill with test data 
INSERT INTO TESTING2 VALUES (DEFAULT, 'test2'); -- fill with test data 
ALTER TABLE TESTING RENAME COLUMN ID TO NEW_STRING_KEY; -- rename old column
ALTER TABLE TESTING ADD COLUMN ID SERIAL; -- add new id column
ALTER TABLE TESTING ADD CONSTRAINT UNIQUE_NEW_STRING_KEY UNIQUE(NEW_STRING_KEY); -- adding constraint on old column
ALTER TABLE TESTING2 ADD COLUMN NEW_EXT_ID SERIAL; -- add new coolumn to fill with ids from testing
UPDATE TESTING2 T SET NEW_EXT_ID=(SELECT TESTING.ID FROM TESTING INNER JOIN TESTING2 ON TESTING.NEW_STRING_KEY=TESTING2.EXT_ID WHERE T.EXT_ID=TESTING.NEW_STRING_KEY); -- fill with ids from testing
ALTER TABLE TESTING2 DROP COLUMN EXT_ID; -- remove old column
ALTER TABLE TESTING2 RENAME COLUMN NEW_EXT_ID TO EXT_ID; -- rename new column to elders name
ALTER TABLE TESTING DROP CONSTRAINT TESTING_PKEY; -- remove old primary key constraint
ALTER TABLE TESTING ADD CONSTRAINT TESTING_PKEY PRIMARY KEY(ID); -- create new primary key constraint
ALTER TABLE TESTING2 ADD CONSTRAINT FK_EXT_ID FOREIGN KEY (EXT_ID) REFERENCES TESTING(ID); -- add reference from testing2 to testing
