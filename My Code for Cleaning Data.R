# This the code I used to clean and merge the Divvy Trips data into one data frame.
# This process is based off the code available in the capstone instructions for using R.
# Original author of the code was written by Kevin Hartman.

#======================================================================
# 1. Download all the packages you need to clean and organize the data.
#======================================================================

install.packages("tidyverse")
install.packages("lubridate")
install.packages("ggplot2")
library(tidyverse)
library(lubridate)
library(ggplot2)

# I first downloaded the quarterly data and imported/named the csv files.

Q1_2019 <- read_csv("Divvy_Trips_2019_Q1.csv")
Q2_2019 <- read_csv("Divvy_Trips_2019_Q2.csv")
Q3_2019 <- read_csv("Divvy_Trips_2019_Q3.csv")
Q4_2019 <- read_csv("Divvy_Trips_2019_Q4.csv")
Q1_2020 <- read_csv("Divvy_Trips_2020_Q1.csv")

# I then checked to see if all the naming conventions were the same throughout the 
# quarterly datasets. 

colnames(Q1_2020)
colnames(Q2_2019)
colnames(Q3_2019)
colnames(Q4_2019)

# They were not the same, so I renamed the columns to make them consistent across all quarters.

(Q4_2019 <- rename(Q4_2019
                   ,ride_id = trip_id
                   ,rideable_type = bikeid 
                   ,started_at = start_time  
                   ,ended_at = end_time  
                   ,start_station_name = from_station_name 
                   ,start_station_id = from_station_id 
                   ,end_station_name = to_station_name 
                   ,end_station_id = to_station_id 
                   ,member_casual = usertype))

(Q3_2019 <- rename(Q3_2019
                   ,ride_id = trip_id
                   ,rideable_type = bikeid 
                   ,started_at = start_time  
                   ,ended_at = end_time  
                   ,start_station_name = from_station_name 
                   ,start_station_id = from_station_id 
                   ,end_station_name = to_station_name 
                   ,end_station_id = to_station_id 
                   ,member_casual = usertype))

(Q2_2019 <- rename(Q2_2019
                   ,ride_id = "01 - Rental Details Rental ID"
                   ,rideable_type = "01 - Rental Details Bike ID" 
                   ,started_at = "01 - Rental Details Local Start Time"  
                   ,ended_at = "01 - Rental Details Local End Time"  
                   ,start_station_name = "03 - Rental Start Station Name" 
                   ,start_station_id = "03 - Rental Start Station ID"
                   ,end_station_name = "02 - Rental End Station Name" 
                   ,end_station_id = "02 - Rental End Station ID"
                   ,member_casual = "User Type"))

# Next I checked that they were all the same data type

str(Q1_2020)
str(Q4_2019)
str(Q3_2019)
str(Q2_2019)

# The columns were not the same data type, so I re-characterized ride_id and rideable_type

Q4_2019 <-  mutate(Q4_2019, ride_id = as.character(ride_id)
                   ,rideable_type = as.character(rideable_type)) 
Q3_2019 <-  mutate(Q3_2019, ride_id = as.character(ride_id)
                   ,rideable_type = as.character(rideable_type)) 
Q2_2019 <-  mutate(Q2_2019, ride_id = as.character(ride_id)
                   ,rideable_type = as.character(rideable_type)) 

# I then created one large dataframe with all the quarterly data. 

all_trips <- bind_rows(Q2_2019, Q3_2019, Q4_2019, Q1_2020)

# To finalize this dataframe, I dropped lat, long, birthyear, and gender fields 
# as this data was dropped beginning in 2020, and therefore, not applicable to all the data. 

all_trips <- all_trips %>%  
  select(-c(start_lat, start_lng, end_lat, end_lng, birthyear, gender, "01 - Rental Details Duration In Seconds Uncapped", "05 - Member Details Member Birthday Year", "Member Gender", "tripduration"))

table(all_trips$member_casual)

# I saw that the merged data frame has different names for Members and Casual riders
# so I fixed that to be uniform throughout the data set. 

all_trips <-  all_trips %>% 
  mutate(member_casual = recode(member_casual
                                ,"Subscriber" = "member"
                                ,"Customer" = "casual"))

# I check to make sure it worked properly

table(all_trips$member_casual)

# I added columns that list the month, day, and year, allowing for deeper analysis later on. 

all_trips$date <- as.Date(all_trips$started_at) #The default format is yyyy-mm-dd
all_trips$month <- format(as.Date(all_trips$date), "%m")
all_trips$day <- format(as.Date(all_trips$date), "%d")
all_trips$year <- format(as.Date(all_trips$date), "%Y")
all_trips$day_of_week <- format(as.Date(all_trips$date), "%A")

# Then I calculated the length of rides by minute.

all_trips$ride_length <- difftime(all_trips$ended_at,all_trips$started_at, units = c("mins"))

# The structure of the columns needs to be changed for ride_length. I changed it to numerical
# so that the length of the ride can be calculated. 
str(all_trips)
is.factor(all_trips$ride_length)
all_trips$ride_length <- as.numeric(as.character(all_trips$ride_length))
is.numeric(all_trips$ride_length)

# I save a new copy of the data after it has been cleaned and merged. 
all_trips_v2 <- all_trips[!(all_trips$start_station_name == "HQ QR" | all_trips$ride_length<0),]

# Descriptive analysis on ride_length (all figures in minutes)

summary(all_trips_v2$ride_length)

# Compare members and casual users

aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = mean)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = median)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = max)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = min)

# Order the days of the week and show the average ride length broken out by
# rider type and days of the week. 

all_trips_v2$day_of_week <- ordered(all_trips_v2$day_of_week, levels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN = mean)

all_trips_v2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%  #creates weekday field using wday()
  group_by(member_casual, weekday) %>%  #groups by usertype and weekday
  summarise(number_of_rides = n()							#calculates the number of rides and average duration 
            ,average_duration = mean(ride_length)) %>% 		# calculates the average duration
  arrange(member_casual, weekday)								# sorts

all_trips_v2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%  #creates weekday field using wday()
  group_by(member_casual, month) %>%  #groups by usertype and weekday
  summarise(number_of_rides = n()							#calculates the number of rides and average duration 
            ,average_duration = mean(ride_length)) %>% 		# calculates the average duration
  arrange(member_casual, month)								# sorts

# Here are some sample graphs included in the original code to get an idea of
# any patterns within the data. 
# I created my visualizations in Tableau. 

all_trips_v2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge")

all_trips_v2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge")

# Lastly, I saved the data on my personal laptop for further use in Tableau.

counts <- aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN = mean)
write.csv(counts, file = '~/Downloads/Bike Trip Data/CSV/avg_ride_length.csv')
write.csv(all_trips_v2, file = '~/Downloads/Bike Trip Data/CSV/cleaned_merged_trip_data.csv')


