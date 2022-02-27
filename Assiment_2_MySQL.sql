--Answer 1
SELECT SUBSTRING_INDEX(Name,' ',1) F_Name,
       SUBSTRING_INDEX(SUBSTRING_INDEX(Name,' ',2),' ',-1) M_Name, 
       SUBSTRING_INDEX(Name,' ',-1) L_Name        
       FROM `dummy1`;

--Answer 2
SELECT SUBSTRING_INDEX(Name,' ',1) F_Name,
       (CASE WHEN LENGTH(SUBSTRING_INDEX(Name,' ',2))+1=LENGTH(SUBSTRING_INDEX(Name,' ',3))+1 THEN '' ELSE
	   SUBSTRING_INDEX(SUBSTRING_INDEX(Name,' ',2),' ',-1) END) M_Name, 
       SUBSTRING_INDEX(Name,' ',-1) L_Name        
       FROM `dummy1`;

--Answer 3
SELECT Student_No,SUM(CASE WHEN Subject='MATHS' THEN MARKS END) AS 'MATHS',
       SUM(CASE WHEN Subject='SCIENCE' THEN MARKS END) AS 'SCIENCE',
       SUM(CASE WHEN Subject='ENGLISH' THEN MARKS END) AS 'ENGLISH'     
	   FROM Dummy2           
	   GROUP BY Student_No

--Answer 4
SELECT MAX(CASE WHEN md=0 THEN Name END) ID
	  ,MAX(CASE WHEN md=1 THEN Name END) FName
	  ,MAX(CASE WHEN md=2 THEN Name END) LName
	 ,MAX(CASE WHEN md=3 THEN Name END) City FROM
(SELECT Name, (CASE WHEN (SELECT COUNT(NAME)/2 FROM dummy1)<rn THEN 1 ELSE 2 END) nt,MOD(rn,4) md FROM 
(SELECT Name, ROW_NUMBER() OVER(ORDER BY (SELECT 0)) rn FROM Dummy1) tbl1)  tbl2
GROUP BY nt ORDER BY ID

--Answer 5
DELIMITER $$
DROP PROCEDURE IF EXISTS SplitStr$$
CREATE PROCEDURE SplitStr(
str VARCHAR(200))
BEGIN
   DECLARE A INT DEFAULT 1;
   #DECLARE Str INT DEFAULT 'INDIA';
   DROP TABLE if EXISTS HT_temp;
   CREATE TABLE HT_temp (Name VARCHAR(2000));
   WHILE A<=5 DO   
      INSERT INTO HT_temp values (SUBSTRING(str,A,1));
      SET A=A+1;
   END WHILE  ;
   Select * from HT_temp;
END$$
DELIMITER $$;
call SplitStr('INDIA');


--Answer 6
SELECT Total FROM (
SELECT tbl1.A*tbl1.B Total,tbl1.C, (ROW_NUMBER() OVER(PARTITION BY tbl1.C)) rn FROM dummy3 as tbl1 join dummy3 as tbl2 join dummy3 as tbl3 join dummy3 as tbl4 ORDER by tbl1.C)  tbl1 JOIN dummy3 tbl2 on tbl1.C=tbl2.C AND  tbl1.rn<=tbl2.C


--Answer 7
DROP TABLE IF EXISTS HT_temp_;
CREATE TABLE HT_temp_ 
SELECT COL,(ROW_NUMBER() OVER ()) rn FROM (
SELECT COL FROM Dummy4
UNION ALL
SELECT COL FROM Dummy4) tbl1 ORDER BY COL;
SELECT COL AS COL1, (SELECT COL FROM HT_temp_ WHERE rn=tbl1.rn+3) AS COL2 FROM HT_temp_ tbl1 WHERE tbl1.rn<4

--Answer 8
SELECT DISTINCT City_1,City_2,DISTANCE FROM (
SELECT (CASE WHEN ASCII(SUBSTRING(City_1,1,1))>ASCII(SUBSTRING(City_2,1,1)) THEN City_1 ELSE City_2 END) City_1,
       (CASE WHEN ASCII(SUBSTRING(City_1,1,1))>ASCII(SUBSTRING(City_2,1,1)) THEN City_2 ELSE City_1 END) CIty_2,
       DISTANCE
       FROM Dummy5) tbl1;





