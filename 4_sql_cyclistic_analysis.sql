CREATE TABLE rides_clean_2 AS 
SELECT * FROM rides_clean;

SELECT COUNT(*) 
FROM rides_clean_2

-- Create new columns for started_day_week, started_month, ride_length, started_number_day

ALTER TABLE rides_clean_2 ADD COLUMN ride_length_min NUMERIC;

UPDATE rides_clean_2
SET ride_length_min = ROUND(EXTRACT(EPOCH FROM (ended_at - started_at)) / 60);

SELECT started_at, ended_at, ride_length_min FROM rides_clean_2 ORDER BY ride_length_min asc LIMIT 10 

ALTER TABLE rides_clean_2 
ADD COLUMN started_day_week TEXT, 
ADD COLUMN started_month TEXT, 
ADD COLUMN started_day_number INTEGER;

UPDATE rides_clean_2
SET started_day_week = TRIM(TO_CHAR(started_at, 'Day')),   -- Nombre del día sin espacios
    started_month = TRIM(TO_CHAR(started_at, 'Month')),    -- Nombre del mes sin espacios
    started_day_number = EXTRACT(DAY FROM started_at);     -- Número del día del mes

SELECT 
  started_at,
  started_day_week,
  started_day_number,
  started_month,
  ride_length_min
FROM
  rides_clean_2
ORDER BY
  ride_length_min
LIMIT 10





