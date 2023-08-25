# 1.2 Exercises: Charts in R
# Name: Rahul Rajeev

# loading packages
library(ggplot2)
library(readxl)
library(tidyr)
library(dplyr)
library(plotrix)
library(webr)
theme_set(theme_minimal())

# set the working directory
setwd("C:/Users/rahul/Documents/Bellevue/DSC 640")

# loading the datasets
contestwinners <- read_excel('hotdogcontestwinners.xlsm')
hotdogplaces <- read.csv('hotdogplaces_t.csv')
obamaratings <- read_excel('obamaapprovalratings.xls')

# bar chart - R
# values per column of hotdog places per year (adjusted in python)
# creating a pivot table for easier access
pivot <- pivot_longer(hotdogplaces, cols = c('col1', 'col2', 'col3'))

# changing years to a string for correct labels
ggplot(pivot, aes(x=(as.character(year)), y=value, fill = name))+
  geom_bar(stat = 'identity', position = 'dodge2')+
  xlab('Year')+
  ggtitle("Bar Chart of Values Per Year (Bar Chart - R)", )+
  theme(plot.title = element_text(hjust = 0.5))

# stacked bar chart - R
# votes for each issue, approve, disapprove, none
pivot2 <- pivot_longer(obamaratings, cols = c('Approve', 'Disapprove', 'None'))
ggplot(pivot2, aes(x=Issue, y=value, fill = name)) +
  scale_fill_manual(values=c("darkgreen","blue","red")) +
  geom_bar(stat = 'identity') +
  theme(axis.text.x=element_text(angle=90,hjust=1)) +
  xlab('Issue') +
  ggtitle("Stacked Bar Chart of Ratings Per Issue (Stacked Bar Chart - R)") +
  theme(plot.title = element_text(hjust = 0.5))

# pie chart - R
# percents of votes for approve, disapprove, and none
# creating a numeric object with totals of votes in approval/disapproval/none
total <- colSums(obamaratings[,-1])
pie(total, labels = paste0(round(total/sum(total)*100, 2), '%'))
legend('topleft', legend = c('Approve', 'Disapprove', 'None'),
       fill = c("white", "lightblue", "mistyrose"))
title(main = 'Percents of Ratings for Obama (Pie Chart - R)')

# donut - R
# countries where the contest was held
agg_tbl<-contestwinners%>%group_by(Country)%>%
  summarize(total_count=n(), .groups = 'drop')
agg_df<-agg_tbl%>%as.data.frame()
PieDonut(agg_df, aes(Country, count = total_count),
         title = "Locations of Hot Dog Eating Contests (Donut Chart - R)",
         explode = 4, explodeDonut = TRUE)


# line chart - R
# hotdogs eaten in contests per year
colnames(contestwinners) <- c('year', 'winner', 'hotdogs', 'country', 'newrecord')
ggplot(contestwinners, aes(x=year, y=hotdogs)) + geom_line() +
  ggtitle("Hot dogs eaten in contests per year (Line Chart - R)") +
  theme(plot.title = element_text(hjust = 0.5))

