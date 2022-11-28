CREATE DATABASE Dormitory

USE Dormitory;

GO
CREATE SCHEMA Schema_Dormitory 


GO
CREATE TABLE Students (
    Birstday Datetime NOT NULL,
	Id INT NOT NULL,
    Name NVARCHAR(40) NULL,
    Room INT CHECK (Room > 0),
	Sex NCHAR(3) NOT NULL,
	FOREIGN KEY(Room) REFERENCES Rooms(Id)
);


GO
CREATE TABLE Rooms (
    Id INT CHECK (Id > 0),
	--Room INT REFERENCES Students(Room) ON DELETE SET NULL,
    Name NVARCHAR(20) NOT NULL,
    CONSTRAINT PK_Rooms_Id PRIMARY KEY(Id)
);


DROP TABLE Rooms

DROP TABLE Students

SELECT *
FROM Students


SELECT *
FROM Rooms