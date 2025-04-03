-- Creating new table with cleaned data.


CREATE TABLE rides_clean AS
SELECT
  *
FROM
  rides
WHERE 
  ride_id IS NOT NULL
  AND rideable_type IS NOT NULL
  AND started_at IS NOT NULL
  AND ended_at IS NOT NULL
  AND start_station_name IS NOT NULL
  AND start_station_id IS NOT NULL
  AND end_station_name 	IS NOT NULL
  AND end_station_id IS NOT NULL
  AND start_lat IS NOT NULL
  AND start_lng IS NOT NULL
  AND end_lat IS NOT NULL
  AND end_lng IS NOT NULL
  AND member_casual IS NOT NULL;


SELECT COUNT(*)
FROM RIDES_CLEAN

-- Checking how many duplicates values are in the rides_id column

SELECT 
  ride_id,
  COUNT(*)
FROM
  rides_clean
GROUP BY
  ride_id
HAVING
  COUNT(*)>1

SELECT
  COUNT(ride_id)-COUNT(DISTINCT ride_id) as ride_id_duplicates
FROM
  rides_clean

DELETE FROM rides_clean
WHERE ctid IN (
    SELECT ctid
    FROM (
        SELECT ctid, 
               ROW_NUMBER() OVER (PARTITION BY ride_id ORDER BY started_at) AS rn
        FROM rides_clean
    ) AS subquery
    WHERE rn > 1
);

-- Cheking for records with the exact same time of start date and same start station

SELECT 
  COUNT(*)
FROM
    (
   SELECT
     started_at,
	 start_station_name
   FROM 
     rides_clean
   GROUP BY
     started_at,
	 start_station_name
   HAVING
     COUNT(*)>1) AS SUBQUERY

SELECT 
  COUNT(*)
FROM
    (
   SELECT
     started_at,
	 start_station_name
   FROM 
     rides_clean
   GROUP BY
     started_at,
	 start_station_name
   HAVING
     COUNT(*)>1) AS SUBQUERY


 -- Deleting records with same start_station name and started_at (3086) and same end_station_name and ended_at (389)

SELECT count(*) FROM rides_clean
WHERE ride_id IN (
    SELECT ride_id
    FROM (
        SELECT ride_id,
               ROW_NUMBER() OVER (
                   PARTITION BY started_at, start_station_name
                   ORDER BY ride_id
               ) AS rn
        FROM rides_clean
    ) AS subquery
    WHERE rn > 1 -- 3,108 records with the same started_at and start_station_name
);

SELECT count(*) FROM rides_clean
WHERE ride_id IN (
    SELECT ride_id
    FROM (
        SELECT ride_id,
               ROW_NUMBER() OVER (
                   PARTITION BY ended_at, end_station_name
                   ORDER BY ride_id
               ) AS rn
        FROM rides_clean
    ) AS subquery
    WHERE rn > 1 -- 890 records with the same ended_at and end_station_name
);

DELETE FROM rides_clean
WHERE ctid IN (
    SELECT ctid FROM (
        SELECT ctid,
               ROW_NUMBER() OVER (
                   PARTITION BY started_at, start_station_name
                   ORDER BY ctid
               ) AS rn
        FROM rides_clean
    ) AS subquery
    WHERE rn > 1 -- 3,108 records eliminated
);

DELETE FROM rides_clean
WHERE ctid IN (
    SELECT ctid FROM (
        SELECT ctid,
               ROW_NUMBER() OVER (
                   PARTITION BY ended_at, end_station_name
                   ORDER BY ctid
               ) AS rn
        FROM rides_clean
    ) AS subquery
    WHERE rn > 1 --889  records eliminated
);

-- Cheking for records with started_at > ended_at

 SELECT COUNT(* )
FROM rides_clean
WHERE started_at > ended_at; -- there are 38 records

DELETE FROM rides_clean
WHERE started_at>ended_at;-- 38 records have been removed

-- removing records with ride duration longer than 24 hours and less than 1 minute

SELECT
  COUNT(ride_id)
FROM
  rides_clean
WHERE
  (ended_at-started_at)>interval'24 hours'-- 121 records

SELECT COUNT(*) AS registros_invalidos
FROM rides_clean
WHERE  EXTRACT(EPOCH FROM (ended_at - started_at)) < 60; -- 35,338 records less than 1 minute

DELETE FROM rides_clean
WHERE EXTRACT(EPOCH FROM (ended_at - started_at)) > 86400 
   OR EXTRACT(EPOCH FROM (ended_at - started_at)) < 60; -- 35,459 records removed








  