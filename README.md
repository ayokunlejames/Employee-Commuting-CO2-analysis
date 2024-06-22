# Employee-Commuting-CO2-analysis

## 1. Introduction
### 1.1 Purpose of the Analysis:
The primary objective of this analysis is to calculate the carbon emissions resulting from university staff commuting. This includes determining the daily and annual emissions, identifying any anomalies in the commuting patterns, and providing insights that can help the university develop strategies to reduce its carbon footprint.

a)	To calculate the carbon emissions from university staff commuting and estimate the impact over the academic year.

b)	To identify any anomalies in the commuting data and provide actionable insights for reducing carbon emissions.

### 1.2 Importance of the Study:
Understanding the environmental impact of staff commuting is crucial for the university’s sustainability efforts. By accurately measuring and analyzing these Scope 3 emissions, the university can implement targeted measures to promote greener commuting options, thus contributing to its overall sustainability goals.
 
## 2. Data Collection and Preparation
### 2.1 Data Collection

This year, staff surveys were run from which an estimate of the university’s commuting CO2 emissions impact could be made. The survey captured information on commuting patterns, distances traveled, and modes of transport used by staff members.
The results of the staff commuting survey were provided in an [excel sheet](https://github.com/ayokunlejames/Employee-Commuting-CO2-analysis/blob/main/Staff%20Travel%20Survey%202023.xlsx) with the following 12 columns: 

A.	in a typical week, what percentage are you on campus

B.	Which campus do you typically spend most time at?

C.	Which building do you primarily work in, when on campus?

D.	When you do work on campus, what is your typical arrival ...	

E.	When you do work on campus, what is your typical departur...	

F.	How long does it typically take you to travel to your pla...	

G.	How many miles do you live from your place of work	

H.	Miles to km 	

I.	What is the main form of transport you usually use to tra...

J.	Are you: SELECT ONE	

K.	Please indicate your type of contract: SELECT ONE	

L.	Which staff category do you belong to? SELECT ONE


Additional information was also provided on Carbon conversion factors for modes of transportation such as Bus, Car, Car Share, Motorbike, Rail, Walk, Cycle, Battery Electric Car, Taxi, and the number of working days in an academic year.

### 2.2 Data Preparation Steps

The data provided was not usable in its raw state and needed to undergo some data cleaning before being used for analysis to ensure high data quality. The following steps were taken first in MS Excel and then in MS Power BI:

•	A Weekly Attendance column was inserted by extracting data from the percentage on campus column using the following formula which also handles any errors due to missing values

=IFERROR((LEFT(A2, SEARCH("%",A2)-1)/100)*5, "N/A")

•	A Yearly attendance column was then created by multiplying the number of working days in an academic year by the percentage availability using the following formula:

=IFERROR(((LEFT(A2, SEARCH("%",A2)-1)/100)*220),0)

•	Blanks and errors in the Mileage (Miles and km) columns were handled by first checking the miles column for values and converting to km, and checking the km column if there are the miles value is missing. A standardized Mileage (in km) column was created from data in both columns using the following excel formula:

= IF(ISBLANK($O2), (IF(ISBLANK($P2), 0, $P2)), IFERROR($O2*1.609344, 0))

•	I then used data from that column to compute a Round-trip mileage (km) for each employee. =Mileage(km) * 2

•	In order to compute hours worked by each employee, the latest arrival time was extracted from the arrival time column using the following formula

=TRIM(RIGHT(F2,7))

•	The following formula was used to extract the earliest departure time from the departure time column: 

=IFS(LEFT($I2,5) = "Later", TRIM(RIGHT($I2, 7)),LEFT($I2,5) = "Befor", TRIM(RIGHT($I2, 7)), TRUE, TRIM(LEFT($I2,7)))

The rest of the data cleaning and transformation was done in Power BI. Upon Importing the excel sheet into Power BI using Power Query, the following steps were taken:

•	A work duration (hours) was calculated for each staff by calculating the difference in number of hours between the latest arrival time and earliest departure time.

•	Blanks and missing values were appropriately handled especially for columns critical for estimating CO2 emissions. Blanks were omitted from the Mode of Transport and mileage columns. Blanks in the campus column were replaced with the ‘Other’ value.

•	Values of 0 in the weekly attendance column were omitted. 

•	Columns were renamed into shorter and more standard column names.

•	An index column was inserted for uniquely identifying each row.

•	A custom Conversion factor column was added using the ‘Transport Mode’ column, assigning the appropriate conversion factor to each row. Conversion factors used were provided in the original excel sheet except the ‘Flight’ transport mode, where the GHG standard protocol conversion factors provided by DEFRA for business travel by air were used. Using the provided conversion factors, the daily emissions for each staff member were calculated.

## 3. Methodology and analysis

Calculated Columns and Measures were created in Power BI using DAX expressions and formulas to estimate the following:

i.	Daily Round trip CO2 emission (kgCO2e): Round Trip Mileage (km) * Conversion factor (kgCO2e/km)

ii.	Weekly CO2 emissions (kgCO2e): Daily Round trip CO2 emission (kgCO2e) * Weekly Attendance

iii. Average Daily CO2 emission (kgCO2e): SUM(Weekly CO2 emissions (kgCO2e))/5

iv.	Annual CO2 emissions (kgCO2e): Daily Round trip CO2 emission (kgCO2e) * Yearly Attendance

v.	Yearly Mileage (km):  Round Trip Mileage (km) * Yearly Attendance

vi.	Hours worked weekly: Work Duration (hours)  * Weekly Attendance

vii.	Hours worked annually: Work Duration (hours)  * Yearly Attendance

viii.	Average round trip mileage (km): SUM(Round Trip Mileage (km))/COUNTROWS(‘Working Sheet’)

ix.	Average round trip Carbon emission: SUM(Daily Round Trip CO2 emission (kgCO2e))/COUNTROWS(‘Working Sheet’)

## 4. Data Analysis and Visualization

The data model was then used to analyse and visualize trends and insights into the carbon emissions from employees commuting to work in 2023. A [comprehensive Power BI report and dashboard](https://app.powerbi.com/view?r=eyJrIjoiNzY3NmYxZmQtMzZjZS00OTVmLWJmNmYtMDhmZTA2MTcyZDdiIiwidCI6IjYwZDBmZTExLTY5MjAtNGM4Zi1hMzA3LTBhMzRkZDQzNDFmYSJ9) was developed with the following insights and interactive visuals: 

### 4.1 Overview dashboard

 ![image](https://github.com/ayokunlejames/Employee-Commuting-CO2-analysis/assets/129544207/b7c6608d-ab2d-4433-998b-f408e79344e8)

Figure 1: Overview Dashboard

### 4.2 Transportation Mode Report
 
 ![image](https://github.com/ayokunlejames/Employee-Commuting-CO2-analysis/assets/129544207/37f9cc17-4a20-4c14-9a64-163dda500662)

Figure 2: Transportation Mode Report

### 4.3 Attendance Report
 
 ![image](https://github.com/ayokunlejames/Employee-Commuting-CO2-analysis/assets/129544207/dd8210cc-c9fa-4f7e-a238-d36a2c98def4)

Figure 3: Attendance Report

### 4.4 Campus Report
 
 ![image](https://github.com/ayokunlejames/Employee-Commuting-CO2-analysis/assets/129544207/6c0477f0-84dc-4f9e-98ff-b5ae35b8245b)

Figure 4: Campus Report

### 4.5	Key Insights and Trends

i.	The overall Carbon emissions impact of staff daily commuting over the whole academic year is 886,035.8 kg of CO2 emissions.

ii.	Commute by Car accounts for 85.11% of CO2 emissions per academic year with over 720,000 kgCO2e, the highest of all transportation modes as shown in Figure 2. This is the most carbon-inefficient mode of transport.

iii.	Each employee who commutes to work in a Car Contributes an average of 1,003 kgCO2e per academic year, more than twice the overall average of 484 kg CO2e

iv.	Overall, employees who commute to work twice a week contribute the greatest to the CO2 emissions, despite the number of these employees being less than those who commute 5 times a week. This is due to a high commute mileage, coupled with the use of carbon-inefficient modes of transportation.

v.	Accounting for 76.75% at 680,016.71 kgCO2e, Streatham had the highest CO2 emissions per academic year and was 143,971% higher than County Hall, which had the lowest CO2 emission at 472 kgCO2e. This is because Streathem has the highest number of employees(1,380), who commute to work an average of 3 times a week, mostly in carbon inefficient transportation modes like Cars and Flight.

vi.	An Electric car is faster to travel over longer distances than a regular Car. An electric car would travel about 95km in 51-60 minutes while a regular car travels an average of 75km in the same time range.

vii.	The most carbon efficient modes of transportation aside walking and cycling are Rail, Electric Vehicle, and Bus

### 4.6	Anomalies

Outliers, and data points which fall outside of the expected ranges were detected through visualizations of the distribution in Power BI and RStudio using the R programming language ([R Script](https://github.com/ayokunlejames/Employee-Commuting-CO2-analysis/blob/main/emission%20outlier%20script.R)). The following anomalies were identified:

i.	One employee (ID: 991) who works on Streatham campus commutes 1658km to work per day, twice a week by flight, contributing 451 kgCO2e per daily commute and 39,762 kgCO2e per academic year

ii.	Another employee (ID: 1657) commuting 3 times a week to Streatham campus by car, drives 772 km to work per day, contributing 128 kgCO2e per daily commute and 17,000 kgCO2e per academic year

iii.	The average distance covered on foot within 21-30 minutes is more than twice the average distance covered in the same time by a taxi. The average distance covered by a taxi in 21-30 minutes is also three times less than the average distance it travels in 11-20 minutes.

iv.	The average distance travelled by train in 11-20 minutes is considerably greater than the average distance travelled in longer travel times, and also very close to the distance travelled in over 60 minutes.

A report on the outliers was also created in order to investigate those specific data points that fall outside the upper and lower bounds of the CO2 emission distribution. 

![image](https://github.com/ayokunlejames/Employee-Commuting-CO2-analysis/assets/129544207/2a7f4b1c-586b-47c5-bc3e-57c2bc9e1953)

Figure 5: Outlier Report

## 5. Summary and Recommendations

### 5.1 Summary

The overall carbon emissions from staff commuting for the academic year amount to 886,035.8 kg of CO2, with car commuting contributing 85.11% of this total, or over 720,000 kg CO2e, making it the most carbon-inefficient mode. Each car commuter emits an average of 1,003 kg CO2e annually, more than double the overall average. Employees commuting twice a week contribute the most to emissions due to longer distances traveled using inefficient transport. Streatham campus, with the highest emissions at 680,016.71 kg CO2e, is 143,971% higher than County Hall due to its larger staff commuting primarily by car and flight. Electric cars are more efficient over longer distances than regular cars, and the most carbon-efficient transport modes are rail, electric vehicles, and buses.

### 5.2 Recommendations

To reduce commuting-related carbon emissions, the university should consider:

a)	Discourage the use of carbon inefficient modes of transportation like cars, flights etc. Instead, carbon efficient modes like use of public transportation buses, Electric cars, and train may be incentivized to lower the carbon emission impact of employees commuting.

b)	Encouraging car-sharing: staff may be encouraged to adopt carpooling, reducing single occupancy car commutes and thus lowering emissions

c)	Remote Work: Increasing incentives for remote work and virtual meetings for staff, especially those who work on Streatham campus reduces the need for staff to commute to work and thus reduces the university’s carbon emissions from staff commuting.

d)	Provision of On-Campus Housing: On-campus housing may be provided for staff, especially those who live a far distance from the university to reduce their commute distance and thus emissions.

e)	Provision of bicycle facilities: additional infrastructure like bicycle racks may be provided all over the campuses to support cycling to work.

f)	Improving data quality: the quality of insights on carbon emissions may be improved by improving the quality of data being collected, through data validation checks to avoid errors in computing and frustrating emission reduction efforts.


