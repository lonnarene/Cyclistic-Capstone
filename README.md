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

## 3: Analyze and Visualize
With 30% of Cyclistic rides commuting to work each day, this is clearly accountable when looking at the data. 
My visualization on Tableau show this trend effectively. 
https://public.tableau.com/views/CyclisticCaseStudy_16552447953180/Dashboard1?:language=en-US&:display_count=n&:origin=viz_share_link
It's clear to see that despite the average ride length for members being shorter, they are taking many more trips. It appears that most member commuters using the bikes Monday-Friday are roughly a 15 minute ride from their end point. 
Casual riders take much longer trips, but without having invidual consumer data to see if they purchase more than one day pass, we can't get an idea of how many people are repeat customers (ie: spending more money on two day passes than the total monthly membership price would cost). 
It's easy to spot a trend regarding tourism as well, with more trips occurring in the summer months and on the weekends for casual riders.  

## 4: Suggestions
  1: Make the prices readily available to casual riders so they can quickly calculate the benefits of an annual membership. 
  2: For annual members, start a "refer-a-friend" program. If they convert a casual rider to a member, they get a month free. This will lead to a higher conversion rate for the casual riders who use Cyclistic for work or pleasure that live in Chicago. 
  3: Convert the annual membership to a monthly membership, allowing for higher conversions during peak tourism. 
