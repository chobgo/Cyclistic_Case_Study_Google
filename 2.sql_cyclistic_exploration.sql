
-- Information schema

SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'rides';

-- Knowing the total number of nulls in each column (2 options of code for doing it)

SELECT
  SUM(CASE WHEN ride_id IS NULL THEN 1 ELSE 0 END) AS ride_id,
  SUM(CASE WHEN rideable_type IS NULL THEN 1 ELSE 0 END) AS rideable_type,
  SUM(CASE WHEN started_at IS NULL THEN 1 ELSE 0 END) AS started_at,
  SUM(CASE WHEN ended_at IS NULL THEN 1 ELSE 0 END) AS ended_at,
  SUM(CASE WHEN start_station_name IS NULL THEN 1 ELSE 0 END) AS start_station_name,
  SUM(CASE WHEN start_station_id IS NULL THEN 1 ELSE 0 END) AS start_station_id,
  SUM(CASE WHEN end_station_name IS NULL THEN 1 ELSE 0 END) AS end_station_name,
  SUM(CASE WHEN end_station_id IS NULL THEN 1 ELSE 0 END) AS end_station_id,
  SUM(CASE WHEN start_lat IS NULL THEN 1 ELSE 0 END) AS start_lat,
  SUM(CASE WHEN start_lng IS NULL THEN 1 ELSE 0 END) AS start_lng,
  SUM(CASE WHEN end_lat IS NULL THEN 1 ELSE 0 END) AS end_lat,
  SUM(CASE WHEN end_lng IS NULL THEN 1 ELSE 0 END) AS end_lng,
  SUM(CASE WHEN member_casual IS NULL THEN 1 ELSE 0 END) AS member_casual
FROM
  rides

SELECT
  COUNT(*)-COUNT(ride_id) as ride_id,
  COUNT(*)-COUNT(rideable_type) as rideable_type,
  COUNT(*)-COUNT(started_at) as started_at,
  COUNT(*)-COUNT(ended_at) as ended_at,
  COUNT(*)-COUNT(start_station_name) as start_station_name,
  COUNT(*)-COUNT(start_station_id) as start_station_id,
  COUNT(*)-COUNT(end_station_name) as end_station_name,
  COUNT(*)-COUNT(end_station_id) as end_station_id,
  COUNT(*)-COUNT(start_lat) as start_lat,
  COUNT(*)-COUNT(start_lng) as start_lng,
  COUNT(*)-COUNT(end_lat) as end_lat,
  COUNT(*)-COUNT(end_lng) as end_lng,
  COUNT(*)-COUNT(member_casual) as member_casual
FROM
  rides

-- Checking for qty of records with null values in both end_station_name AND end_station_name	

SELECT
  COUNT(ride_id)
FROM
  rides
WHERE
  start_station_name IS NULL AND end_station_name IS NULL

-- Cheking for duplicate values in ride_id column wich has no NULL values

SELECT
  COUNT(ride_id)-COUNT(DISTINCT ride_id) as ride_id_duplicates
FROM
  rides

-- Checking the number of characters in the values of the ride_id column

SELECT 
  AVG(LENGTH(ride_id))
FROM
  rides

SELECT 
  ride_id
FROM
  rides
WHERE
  LENGTH(ride_id)<>16

-- Cheking for different values in the rideable_type and member_casual columns

SELECT
 DISTINCT(rideable_type)
FROM
 rides

SELECT
 DISTINCT(member_casual)
FROM
 rides

-- Cheking started_at and ended_at column format

SELECT
  DISTINCT pg_typeof(started_at) AS started_at_type, 
           pg_typeof(ended_at) AS ended_at_type
FROM
  rides;

SELECT
  DISTINCT started_at, ended_at
FROM
  rides
LIMIT 10;

-- Cheking started_at and ended_at values for NULL values

SELECT
  COUNT(*)
FROM
  rides
WHERE
  started_at IS NULL; -- there are no NULL values in started_at

SELECT
  COUNT(*)
FROM
  rides
WHERE
  ended_at IS NULL; -- there are no NULL values in ended_at

-- Checking for duplicates in started_at and ended_at columns

SELECT
  COUNT(started_at)-COUNT(DISTINCT started_at) AS "Duplicates"
FROM 
  rides  -- There are  186,055 duplicates in started_at column

SELECT
  COUNT(ended_at)-COUNT(DISTINCT ended_at) AS "Duplicates"
FROM 
  rides  -- There are  183,873 duplicates in ended_at column

-- Cheking for duplicate values in started_at and start_station_name

SELECT
  started_at,
  start_station_name,
  COUNT(*)
FROM
  rides
GROUP BY
  started_at,
  start_station_name
HAVING
  COUNT(*)>1; -- There are 9,527 duplicates with same started_at AND same start_station_name.

SELECT
  ended_at,
  end_station_name,
  COUNT(*)
FROM
  rides
GROUP BY
  ended_at,
  end_station_name
HAVING
  COUNT(*)>1; -- There are 7,082 duplicates with same ended_at AND same end_station_name. 

-- Checking for inconsistencies in the started_at and ended_at columns.

SELECT
  ride_id,
  started_at,
  ended_at
FROM
 rides
WHERE
  started_at>ended_at; -- There are 202 records where the started_at values are greater than the ended_at values, which is not possible.


-- Cheking for ride length

SELECT
  COUNT(ride_id)
FROM
  rides
WHERE
  (ended_at-started_at)>interval'24 hours'; -- There are 7,028 records with a ride length with more than 24 hours

SELECT COUNT(*) AS registros_invalidos
FROM rides
WHERE  EXTRACT(EPOCH FROM (ended_at - started_at)) < 60; -- There are 128,791 records with a ride length shorter than 1 minute

 
-- Cheking the start_station_name and sart_station_id columns

SELECT
  COUNT(*)
FROM
  rides
WHERE
  start_station_name IS NULL AND start_station_id IS NULL; -- There are 1,080,148 records with null values

SELECT
  COUNT(*)
FROM
  rides
WHERE
  end_station_id IS NULL AND end_station_name IS NULL; -- There are 1,110,075 records with null values

-- Cheking the start_lat, start_lng, end_lat, end_lng columns

SELECT
  COUNT(*)
FROM
  rides
WHERE
  start_lat IS NULL OR start_lng IS NULL OR end_lat IS NULL OR end_lng IS NULL; -- There are 6744 null values

-- Cheking the member_casual column

SELECT
  DISTINCT(member_casual)
FROM
  rides
  



