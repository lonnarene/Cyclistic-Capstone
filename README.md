# Cyclistic-Capstone
This was a final case study project in order to complete the Google Data Analytics Certificate. 

The project looked at Divvy Bike Trip data and asked how Annual subscribers differ from casual riders. 

## 1: Company Overview

In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown to a fleet of 5,824 bicycles that are geotracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and returned to any other station in the system anytime.
Cyclistic has multiple ride options: single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers who purchase annual memberships are Cyclistic members.
Cyclistic sets itself apart by also offering reclining bikes, hand tricycles, and cargo bikes, making bike-share more inclusive to people with disabilities and riders who can’t use a standard two-wheeled bike. The majority of riders opt for traditional bikes; about 8% of riders use the assistive options. Cyclistic users are more likely to ride for leisure, but about 30% use them to commute to work each day.

## 2: Process
Using Cyclistic's available data, I analyzed 2019_Q2 - 2021_Q1 data, allowing for a full year's worth of analysis. 
The data is available here: https://divvy-tripdata.s3.amazonaws.com/index.html and it's available throught this license: https://www.divvybikes.com/data-license-agreement. 
R has been used to clean and analyze the data due to the size of the datasets.
The code for the cleaning process was originally created by Kevin Hartman. He is also cited in the code itself. 
The cleaning process involved removing rides less than 60 seconds, latitutude and longitude, birth year, and gender. 
I then merged all quarters into one cohesive data frame named "all_trips_v2" and saved the file as a csv named "cleaned_merged_trip_data". 

