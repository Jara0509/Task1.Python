--Запросы к базе данных чтобы вернуть:

SELECT *
FROM Students


SELECT *
FROM Rooms



--список комнат и количество студентов в каждой из них
SELECT r.name, 
       count(s.id) as count_students
FROM [dbo].[Rooms] as r 
	LEFT JOIN [dbo].[Students] as s
	ON r.id=s.room
GROUP BY r.name
ORDER BY count(s.id)


--top 5 комнат, где самый маленький средний возраст студентов

DECLARE @Now  date
SET @Now=GETDATE()


SELECT name, avg_age
	   
FROM (

		SELECT TOP 5 r.name,
		       AVG(CONVERT(int,CONVERT(char(8),@Now,112))-CONVERT(char(8),s.[birthday],112))/10000 as avg_age,
			   DENSE_RANK() OVER (PARTITION BY r.name 
				ORDER BY (AVG(CONVERT(int,CONVERT(char(8),@Now,112))-CONVERT(char(8),s.[birthday],112))/10000)) as rank
	    FROM [dbo].[Rooms] as r 
			LEFT JOIN [dbo].[Students] as s
			ON r.id=s.room
		WHERE s.[birthday] IS NOT NULL
		GROUP BY r.name
		ORDER BY  AVG(CONVERT(int,CONVERT(char(8),@Now,112))-CONVERT(char(8),s.[birthday],112))/10000
         ) t

WHERE rank <= 5 




--top 5 комнат с самой большой разницей в возрасте студентов
DECLARE @Now  date
SET @Now=GETDATE()

SELECT [room], difference

FROM (
	SELECT TOP 5 [room],
		(MAX(CONVERT(int,CONVERT(char(8),@Now,112))-CONVERT(char(8),[birthday],112))/10000) -
		(MIN(CONVERT(int,CONVERT(char(8),@Now,112))-CONVERT(char(8),[birthday],112))/10000) as difference,
		DENSE_RANK () OVER (ORDER BY ((MAX(CONVERT(int,CONVERT(char(8),@Now,112))-CONVERT(char(8),[birthday],112))/10000) -
									  (MIN(CONVERT(int,CONVERT(char(8),@Now,112))-CONVERT(char(8),[birthday],112))/10000)) DESC) as  max_difference
	FROM [dbo].[Students]
	GROUP BY [room]
	) t

WHERE max_difference <= 5



--список комнат где живут разнополые студенты.
SELECT DISTINCT room
FROM (
	SELECT room,
	       sex,
           count(sex) as count_sex,
		   rank() over (partition by room order by sex desc) as rank
	FROM [dbo].[Students] as s 
	GROUP BY room, sex
	) t
WHERE rank=2
