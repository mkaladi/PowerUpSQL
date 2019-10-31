
-- List temp tables, columns, and column types
SELECT (SELECT CASE WHEN (select len(t1.name) - len(replace(t1.name,'#',''))) > 1 THEN 1 END) as GlobalTempTable, 
	   (SELECT CASE WHEN t1.name like '%[_]%' AND (select len(t1.name) - len(replace(t1.name,'#',''))) = 1 THEN 1 END) as LocalTempTable,
	   (SELECT CASE WHEN t1.name not like '%[_]%' AND (select len(t1.name) - len(replace(t1.name,'#',''))) = 1 THEN 1 END) as TableVariable,
	   (SELECT CASE WHEN t1.name like '#%' THEN 1 END) as TempTable, 
	   t1.name as 'tablename',
	   t2.name as 'columnname',
	   t3.name 
FROM tempdb.sys.objects AS t1
JOIN tempdb.sys.columns AS t2 ON t1.OBJECT_ID = t2.OBJECT_ID
JOIN sys.types AS t3 ON t2.system_type_id = t3.system_type_id
WHERE t1.name like '#%';
