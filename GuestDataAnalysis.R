rm(list=ls())

library(lubridate)
library(stringi)


data<-read.csv("~/Downloads/reservations (1).csv")

df<-data
df$Booked<- as.Date(df$Booked)
df$BookedMonths<- month(as.POSIXlt(df$Booked))


df$Start.date <- as.Date(df$Start.date,format = "%m/%d/%Y")
df$StartMonth<-month(as.POSIXlt(df$Start.date))

df$End.date <- as.Date(df$End.date,format="%m/%d/%Y")
df$DurationOfStay<-as.numeric(df$End.date-df$Start.date)


df$DurationOfAdvncedBooking <- ifelse(df$BookedMonths<=df$StartMonth, df$StartMonth-df$BookedMonths, 
                                      abs((df$StartMonth)-df$BookedMonths+12))


df$AdvancedBookingDays<- as.numeric(df$Start.date-df$Booked)

df$Profit <-  as.numeric(gsub(",","",gsub("\\$","" ,df$Earnings)))

df %>% group_by(StartMonth)  %>% summarise(Me=mean(Profit))

#df$StartMonth <- factor(df$StartMonth,levels = paste0(1:12),ordered = TRUE)
df$StartMonth <- as.character(df$StartMonth)
write_csv(df,"/Volumes/Macintosh HD/Users/joe/Documents/Data Analysis/Gitrepos/24. Airbnb/Data.csv")



