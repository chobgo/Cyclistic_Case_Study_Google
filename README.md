# Cyclistic_Case_Study_Google
Google Data Analytics Certificate Case Study
# Case Study: CYCLISTIC BIKE-SHARE COMPANY 

## INTROUCTION

In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown
to a fleet of 5,824 bicycles that are geotracked and locked into a network of 692 stations across
Chicago. The bikes can be unlocked from one station and returned to any other station in the
system anytime.

Cyclistic’s finance analysts have concluded that annual members are much more profitable
than casual riders.  Maximizing the number of annual members will be key to future growth. There is a solid opportunity to convert casual riders into members.

The Company wants to design marketing strategies aimed at converting casual riders into
annual members. In order to do that, however, the team needs to better understand how
annual members and casual riders differ, why casual riders would buy a membership, and how
digital media could affect their marketing tactics.

## SCENARIO

I am assuming to be a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, my team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, my team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve our recommendations, so they must be backed up with compelling data insights and professional data visualizations.

## FASE 1: ASK

### Guiding questions
● What is the problem you are trying to solve?

The director of marketing believes the company’s future success
depends on maximizing the number of annual memberships. Therefore, 
the team wants to understand how casual riders and annual members use Cyclistic bikes differently.

● How can your insights drive business decisions?

From these insights, your team will design a new marketing strategy to convert casual riders into annual
members. 

## BUSINESS TASK

Convert casual riders to members.

## Analysis Question

How do annual members and casual riders use Cyclistic bikes differently?

## FASE 2: PREPARE

The project will use the data provided by Google using the following link: [divvy_tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html) The data has been made available by Motivate International Inc. under this [license](https://divvybikes.com/data-license-agreement).

The data is organized into 12 CSV files. Each file is structured by year and month. For example, the file named 202004-divvy-tripdata contains information about the various trips taken by the company's customers in April 2020. The available data includes details such as date, trip ID, start station, end station, and whether the customer is a member or a casual rider, among other attributes.

In this analysis, I have considered the last 12 months of data, from March 2024 to February 2025.

Regarding the credibility of the data, since it is collected and provided by the company itself—meaning it is first-party data—and considering that this is a case study, I assume that the information is reliable and meets the ROCCC analysis criteria.

In other words, it is a reliable source because the data is collected and provided directly by the company. It is original as it comes from the actual usage of the bicycles by the company's customers. It is comprehensive since the data is structured in rows and columns with clear, descriptive names. It is current, as it includes the last 12 months of data, from March 2024 to February 2025. Lastly, it is cited, as it originates from the company itself.

The data belongs to the company and is publicly available under a license. Therefore, there is explicit consent from the company to use this information. Additionally, the data complies with privacy measures by not disclosing any personal information about customers, thereby protecting their identity and sensitive details. The dataset only includes information related to bicycle usage and routes. No sensitive data is included, and all information is fully anonymized.

Regarding data integrity, after reviewing the trip data from February 2025 to March 2024, the data largely meets the characteristics of information integrity. It is accurate and consistent throughout the 12-month evaluation period.

However, while most integrity characteristics are met, it is important to report a deficiency: missing data in the start and end station columns. This missing information accounts for approximately 16% to 20% across all months.

In terms of reliability, since the data is collected directly by the company, we can assume that it is trustworthy for the purposes of this study.

 This information is relevant as it enables the identification of user behavior patterns over a significant period—one year. Additionally, it is important because it clearly distinguishes trip types and user categories, specifically whether a user is casual or a member. This distinction allows for the segmentation of behavior based on membership type, which directly aligns with the objectives of this analysis.

As mentioned earlier, the data contains missing information, specifically in the start and end station details. Additionally, some trip IDs have significantly larger numbers than the norm, which could indicate a data collection error. However, since this is a case study, the analysis will proceed with the appropriate data cleaning to address these issues.

## FASE 3: PROCESS

In the processing stage, I will use PostgreSQL as a processing and analysis tool using SQL due to the difficulty of doing so in tools like Excel and Google Sheets, given the large amount of available data, which exceeds 5 million records for the last year of operation of the company Cyclistic.

## Combining Data

Using the rides data from March 2024 to February 2025, I loaded and renamed each file in PostgreSQL (for example, as march_2024) and generated 12 files. These files were then combined into a single table named 'rides' using the following code to facilitate the data cleaning and analysis process.

<?
        CREATE TABLE rides (
    ride_id VARCHAR,
    rideable_type VARCHAR,
    started_at TIMESTAMP WITHOUT TIME ZONE,
    ended_at TIMESTAMP WITHOUT TIME ZONE,
    start_station_name VARCHAR,
    start_station_id VARCHAR,
    end_station_name VARCHAR,
    end_station_id VARCHAR,
    start_lat NUMERIC,
    start_lng NUMERIC,
    end_lat NUMERIC,
    end_lng NUMERIC,
    member_casual VARCHAR
);

INSERT INTO rides (ride_id, rideable_type, started_at, ended_at, start_station_name, 
                   start_station_id, end_station_name, end_station_id, start_lat, 
                   start_lng, end_lat, end_lng, member_casual)
SELECT * FROM march_2024
UNION ALL
SELECT * FROM april_2024
UNION ALL
SELECT * FROM may_2024
UNION ALL
SELECT * FROM june_2024
UNION ALL
SELECT * FROM july_2024
UNION ALL
SELECT * FROM august_2024
UNION ALL
SELECT * FROM september_2024
UNION ALL
SELECT * FROM october_2024
UNION ALL
SELECT * FROM november_2024
UNION ALL
SELECT * FROM december_2024
UNION ALL
SELECT * FROM january_2025
UNION ALL
SELECT * FROM february_2025;

SELECT
  COUNT(*)
FROM
  RIDES
    ?>













