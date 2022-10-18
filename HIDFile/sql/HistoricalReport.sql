DECLARE @cols AS NVARCHAR(MAX);
DECLARE @query AS NVARCHAR(MAX);

IF OBJECT_ID('HID..HID_Archive') IS NOT NULL 
BEGIN 
    DROP TABLE HID_Archive
END

select @cols =  STUFF(( SELECT distinct ',' +
                       QUOTENAME(DataMonth) 
                      FROM HID_Historical 
                      ORDER BY 1 DESC FOR XML PATH(''), TYPE 
                     ).value('.', 'NVARCHAR(MAX)') 
                        , 1, 1, '') ;

						Print @cols 
--set @cols = '[C.11.a.1]'
SELECT @query =

'SELECT  * INTO HID_Archive
FROM
(
  SELECT
    o.QuestionNum,
	o.DataMonth,
    o.DMISID,
    CASE WHEN  LEN(o.Value2)=0 THEN o.value1 
	ELSE CASE WHEN LEN(o.Value1)>0 and LEN(o.Value2)>0 THEN CAST(o.value1 as varchar(5))+'' / ''+ cast(o.value2 as varchar(5))END END AS val
  FROM HID_Historical AS o
  
) AS t
PIVOT 
(
  max(val)
  FOR DataMonth IN( ' + @cols + ' )' +
' ) AS p ORDER BY questionNum, DMISID ; ';

--print @query
 execute(@query);