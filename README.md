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

Using the rides data from March 2024 to February 2025, I loaded and renamed each file in PostgreSQL (for example, as march_2024) and generated 12 files. These files were then combined into a single table named 'rides' using the following [code](Data_Combining_sql) to facilitate the data cleaning and analysis process.

The new table "rides" contain 5,783,100 records.

## Data Exploration

Next, as part of the processing phase and prior to the data cleaning stage, I will make some brief observations about the data. The SQL query used: exploration

**1. The following table shows the column names of the resulting table rides and the different data types it contains.**

![](https://github.com/chobgo/Cyclistic_Case_Study_Google/blob/main/1_data_type_table.jpg?raw=true)

**2. The following table shows the number of null values in each column.**

![](https://github.com/chobgo/Cyclistic_Case_Study_Google/blob/main/2_null_per_column.jpg?raw=true)

More than 1.6 million records contain NULL values in at least one of their columns.

**3. ride_id column:**

As ride_id is our Primary Key and has no null values, we will check it for duplicates

![](https://github.com/chobgo/Cyclistic_Case_Study_Google/blob/main/3_ride_id_duplicates.jpg?raw=true)   

There are 211 duplicate values in the ride_id column.

All values in the ride_id column have a length of 16 characters.

**4. rideable_type column:**

There are three different types of values in the rideable_type column, which indicate the types of rides the company offers. 

![](https://github.com/chobgo/Cyclistic_Case_Study_Google/blob/main/4_rideable_type_table.jpg?raw=true)

There are no NULL values.


**5. started_at and ended_at columns:**

Both started_at and ended_at columns have a timestamp without time zone format. And indicates the date and time at where the different rides started and ended. The format is YYYY-MM-DD hh:mm:ss

There are no NULL values in this columns

There are 9,527 duplicate records where both started_at and start_station_name are identical, and 7,082 duplicate records where both ended_at and end_station_name are identical. These will be considered errors and will be removed during the data cleaning process.

There are 202 records where the started_at values are greater than the ended_at values, which is not possible, and will be removed during the data cleaning process.

There are 7,028 records with a ride length greater than 24 hours, and also will be removed during the cleaning process.

**6. start_sation_name, start_station_id, end_station_name, end_station_id**

There are 1,080,148 null values in start_station_name and start_station_id

There are 1,110,075 null values in end_station_name and end_station_id

**7. start_lat, start_lng, end_lat, end_lng**

There are 6,744 total null values in the 4 columns.

**8. member_casual column**

There are 2 diferent types of values for the member_casual column: member and casual. No null values in this column.

![](https://github.com/chobgo/Cyclistic_Case_Study_Google/blob/main/5_types_member_casual.jpg?raw=true)  

## FASE 4: DATA CLEANING

SQL QUERY: DATA CLEANING

1. All recors with null values have been eliminated, in total: 1,662,526.
2. A total of 121 duplicate records from the ride_id column have been removed.
3. A total of 3,997 records have been removed due to identical started_at, start_station_name, ended_at, and end_station_name, as they were considered errors.
4. 38 records were removed where the started_at values were greater than the ended_at values, which is not logically possible.
5. 35,459 records were removed where the trip duration was greater than 24 hours or shorter than 1 minute.

1,702,141 total recors where removed

New rides_clean table left with 4,080,959 records.

## FASE 5: ANALYSIS.

SQL Query: [Data Analysis](  )

Data Visualization: [Tableau](https://public.tableau.com/app/profile/roberto.gonz.lez2082/viz/280325-cyclistic-tableau/Cyclistic).

After analyzing the data using SQL code and creating relevant visualizations in Tableau, I present the resulting dashboard below, which highlights the key findings of the analysis. 
The analysis question is: How do annual members and casual riders use Cyclistic bikes differently?


![](https://github.com/chobgo/Cyclistic_Case_Study_Google/blob/main/Cyclistic.png )

### Key Insights

The analysis question is: How do annual members and casual riders use Cyclistic bikes differently?

Analysis of over 4 million Cyclistic bike rides (March 2024 - February 2025) reveals a fundamental behavioral distinction between member and casual riders: usage purpose. The data demonstrates that casual riders primarily use bikes for tourism and leisure activities, while members predominantly utilize them for work-related commuting.

Geospatial analysis pinpoints tourism hotspots as the epicenters of casual rider activity, with station usage volumes directly mirroring Chicago's attraction density. The Streeter Dr hub alone accounts for 3% of all casual rider trips, strategically positioned to serve visitors to Navy Pier and downtown landmarks.

Other significant differences in bike usage between members and casual riders can be summarized as follows:


|    | Member  | Casual | Comments| 
| :------------: |:---------------:|:------:|:------:|
| Number of Rides      | 2,595,127 | 1,485,832 | Nearly two-thirds (63%) of Cyclistic's ridership comes from members, confirming the subscription model's stability. However, the 37% casual rider segment represents a strategic opportunity for membership convertion programs |
| Average Ride length   |  12 minutes    |   24 minutes |  Casual riders' trips are twice as long as members' (24 vs. 12 minutes), strongly suggesting distinct usage patterns, Members: Likely short, efficient trips for commuting (aligns with weekday peaks), Casual Riders: Leisurely tourism/recreation use (consistent with weekend/holiday patterns and tourist-area station dominance) | 
| Rides per month | Peaks in august-september with 319,053 rides, lowest in january with 83,616 rides    |   Peaks in august-september with 214,249, lowest in january with  16,938 rides | Ridership follows predictable seasonal patterns, but with critical differences: while both groups peak in late summer, casual riders virtually disappear in winter (↓92% vs. members' ↓74%). This 5x weather sensitivity confirms tourism-driven casual demand versus members' commute-focused resilience. |
| Rides per day of the week |  Peaks in wednesday with 427,313 rides, lowest in sunday with 286,658 rides   |    Peaks in saturdat with 313,234 rides, lowest in tuesday with 157,474 rides | Member ridership peaks midweek (427K rides Wednesday) for commuting, while casual riders surge on weekends (313K rides Saturday) for leisure, revealing distinct usage patterns requiring tailored operational strategies.  |
| Rides per hour | Peaks at 8 am (187,269) and 5 pm (282,267) lowest at 3 am (4,100) | Peaks at 8 am (53,325) and 5 pm (143,151) lowest at 3 am (4,683) |Members dominate rush hours (5 PM peak: 282K rides) with 2X stronger commute spikes than casual riders, whose flatter daytime patterns suggest flexible leisure use|
| Rides by bike type | 1.6 millions classic bik rides and 0.9 millions electric bikes      | 0.9 millions classic bik rides and 0.5 millions electric bikes | Both members and casual riders choose classic bikes twice as often as electric bikes, but members take more total rides overall|

## FASE 6: ACT

1. Target Casual Riders for Membership Conversion

    Why: Casual riders show strong weekend/leisure patterns (2X longer rides, tourist-area usage).

    Action: Launch "Weekend Commuter" plans:

        Discounted monthly memberships valid only Sat-Sun

        Partner with tourist attractions (Navy Pier, Magnificent Mile) for promo codes

2. Optimize Bike Distribution

    Why: Members dominate weekdays (AM/PM peaks), casual riders spike weekends.

    Action:

        Weekdays: Prioritize electric bikes near business districts (members’ 5 PM peak = 282K rides)

        Weekends: Boost classic bikes at tourist hubs (casuals’ Sat peak = 313K rides)

3. Weather-Proof Revenue

    Why: January ridership drops 74% (members) and 92% (casuals).

    Action:

        Offer "Winter Warrior" rewards for cold-weather member rides

        Install covered bike docks at top tourist stations

4. Capitalize on Bike Type Preferences

    Why: Both groups prefer classic bikes (64% of rides), but electric bikes have growth potential.

    Action:

        Test "Electric Weekday Pass" for members (faster commutes)

        Promote e-bikes to casual riders as "Tourist Explorers" (higher per-ride revenue)

5. Data-Driven Expansion

    Why: Top stations (Streeter Dr & Grand Ave) serve tourists.

    Action:

        Add stations near under-served tourist attractions

        Use August-Sept peaks (319K member rides) to test new pricing tiers















