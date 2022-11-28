Declare @JSON nvarchar(max);
SELECT @JSON=r.BulkColumn
FROM OPENROWSET (BULK N'D:\INNOWISE\Task1\Rooms.json', SINGLE_CLOB) as r
SELECT * 
INTO Rooms
FROM OPENJSON(@JSON)
WITH (
	id INT,
    name NVARCHAR(20) 
);
 

Declare @JSON nvarchar(max);
SELECT @JSON=r.BulkColumn
FROM OPENROWSET (BULK N'D:\INNOWISE\Task1\Students.json', SINGLE_CLOB) as r
SELECT *
INTO Students
FROM OPENJSON(@JSON)
WITH (
	birthday DATE,
	id INT,
    name NVARCHAR(40),
    room INT,
	sex CHAR(1)
);



ALTER TABLE Rooms 
ALTER COLUMN id  int NOT NULL;


ALTER TABLE Rooms 
ADD CONSTRAINT PK_Rooms_id PRIMARY KEY (id)


ALTER TABLE Students
ALTER COLUMN room  int NOT NULL;



ALTER TABLE Students
ADD FOREIGN KEY (room) REFERENCES Rooms(id)


SELECT *
FROM Students


SELECT *
FROM Rooms