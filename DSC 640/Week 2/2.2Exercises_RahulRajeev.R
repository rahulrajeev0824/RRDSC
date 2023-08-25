# 2.2 Exercises: Charts in R
# Name: Rahul Rajeev

# loading packages
library(ggplot2)
library(readxl)
library(treemap)

setwd("C:/Users/rahul/Documents/Bellevue/DSC 640")

# loading datasets
expenditures_grouped <- read.csv('expenditures_grouped.csv')
expenditures <- read.csv('expenditures.csv')
expenditures_t <- read.csv('expenditures_t.csv')
unemployment <- read.csv('unemployment_grouped.csv')
postage <- read_excel('us-postage.xlsm')

head(expenditures)
# treemap (expenditures df, category vs. expenditure)
treemap(expenditures_grouped, index="category", vSize="expenditure", type="index",
        palette = "Set2", bg.labels=c("white"), border.col="black",
        title = 'Percent Expenditures by Category (Tree Map - R)')

# step chart (postage cost per year)
ggplot(postage, aes(x = Year, y = Price)) + geom_step()+ 
  ggtitle('Price of Postage Per Year (Step Chart - R)')


# area chart (average unemployment rates per year)
ggplot(unemployment, aes(x=Year, y=Value)) + geom_area() + 
  ggtitle('Average Unemployment Rate 1948-2010 (Area Chart - R)') +
  ylab('Percentage Rate')

# stacked area chart (expenditures by year per category)
ggplot(expenditures, aes(x=year, y=expenditure, fill=category)) + 
  geom_area(alpha=0.6 , linewidth=0.5, colour="black") +
  ggtitle('Cumulative Expenditure Per Year (Stacked Area Chart - R)') +
  xlab('Year') + ylab('Cumulative Expenditure')