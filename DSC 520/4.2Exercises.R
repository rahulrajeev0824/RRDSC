# Assignment 1: Test Scores
# Name: Rajeev, Rahul
# Date: 2023-01-02

# libraries and minimal theme
library(ggplot2)
library(plyr)
library(dplyr)
theme_set(theme_minimal())

# loading scores dataset
setwd("C:/Users/rahul/Documents/Bellevue/DSC 520")

scores_df <- read.csv("data/scores.csv")

# 1. determining variables
str(scores_df)

# 2. There are three variables: count (numerical), score (numerical), 
# and section (categorical, binary)
# Count and Score are both quantitative variables, and section is qualitative.
# The section specifies the grades in each course, the sports course vs.
# the non-sports or regular course. Both sections have different values of 
# scores.

# 3. creating subsets for regular vs. sports sections
sports_df = scores_df[scores_df$Section == 'Sports',]
regular_df = scores_df[scores_df$Section == 'Regular',]

# 4. plot each data frame using ggplot and compare and contrast

# Sports class score distribution
ggplot(sports_df) + geom_bar(aes(x=Score, y=Count), stat="identity",
                             fill="skyblue", colour="black") + 
  ggtitle('Score Distribution for "Sports" Class')

# Regular class score distribution
ggplot(regular_df) + geom_bar(aes(x=Score, y=Count), stat="identity",
                             fill="lightgreen", colour="black") + 
  ggtitle('Score Distribution for the "Regular" Class')

# a. Comparing and contrasting the point distributions between the two section, 
# looking at both tendency and consistency: Can you say that one section tended 
# to score more points than the other? Justify and explain your answer.

# first let's calculate tendency and consistency as mean and standard deviation
# for both data sets

# sports tendency and consistency summary
sports_df %>%
  summarise(
    mean = mean(rep(Score,Count)),
    median = median(rep(Score,Count)),
    std = sd(rep(Score,Count)),
    min = min(rep(Score,Count)),
    max = max(rep(Score,Count)),
    students = sum(Count)
  )

# regular tendency and consistency summary
regular_df %>%
  summarise(
    mean = mean(rep(Score,Count)),
    median = median(rep(Score,Count)),
    std = sd(rep(Score,Count)),
    min = min(rep(Score,Count)),
    max = max(rep(Score,Count)),
    students = sum(Count)
  )

# The class with regular applications tended to score higher than the class
# with sports applications, comparing 335 to about 310. 
# The regular class also had a tighter spread of data with a standard deviation
# of around 31 while the sports class had a standard deviation of around 53.
# Students in the regular section tended to score higher than people in the 
# sports section. Students in the sport section had the lowest scores, in the 
# range of 200 - 265 in the sports section. The regular section however,
# had a smaller maximum score than the sports section. In addition,
# the median of the sports class was about 313 whereas the median of the regular
# section matched the mean of 335. 

# b. Did every student in one section score more points than every student 
# in the other section? If not, explain what a statistical tendency means 
# in this context.

# No, some sports students scored more points than some regular students. 
# The statistical tendency is defined by a student in the regular 
# section section scored more than a student in the sports section. 
# Since the data seems to overlap, it doesn't necessarily mean that students
# in one section scored more points than the other.

# c. What could be one additional variable that was not mentioned in the 
# narrative that could be influencing the point distributions between the 
# two sections?

# If students signed up for the sports section, but the professor used
# applications from sports the student is unfamiliar with, it might
# cause the student to score lower than just answering questions about
# regular applications. So knowledge of particular sports could be a variable.
# Although, since the section was advertised as a sports section, it could
# be dependent on the depth of the advertisement.

# Another variable that could be influencing the point distributions between
# the two sections could be the times at which the course was offered. 
# Even though the class was advertised as a sports section, students who are 
# following a particular academic plan may not have a choice in enrolling in 
# one section or the other. This in turn could result in a lower range of 
# scores.

#==============================================================================
# Assignment: Experimenting with Plyr on the Housing Dataset
# Name: Rajeev, Rahul
# Date: 2023-01-03

# importing libraries
library(readxl)
library(pastecs)
library(scales)

# reading in xlsx file, then transferring the format into a data frame
housing_xl <- read_excel("data/week-7-housing.xlsx")
housing_df <- data.frame(housing_xl)

# just checking whether the data frame loaded properly
head(housing_df)

# 1. Use the apply function on a variable in your dataset
# I used the apply function to find the min and max of sale price

apply(housing_df['Sale.Price'], MARGIN=2, FUN=min)
apply(housing_df['Sale.Price'], MARGIN=2, FUN=max)

# Apparently the minimum house price in this dataset was $698 dollars, which
# I believe is an error in the dataset, and can be corrected when working with
# the data. Apparently this particular house was actually sold for $2.25M 
# in 2018. The maximum house price in this data set is $4.4M. 

# 2. Use the aggregate function on a variable in your dataset
aggregate(housing_df$Sale.Price, by = list(housing_df$zip5),
          FUN = mean)

# I used the aggregate function to find the mean sale price by zip code.

# 3. Use the plyr function on a variable in your dataset
ddply(housing_df, .(zip5), summarize, 
      mean=round(mean(square_feet_total_living), 2), 
      sd = round(sd(square_feet_total_living), 2)) 

# I used ddply to find the average square feet  and the standard deviation
# for houses in the data set, organized by zip code.

# 4. Check distributions of the data

# I will look at distributions of sale price and total square feet.
ggplot(housing_df, aes(x=Sale.Price)) + 
  geom_histogram(fill="aquamarine2", colour="black",binwidth=100000, bins=10) + 
  ggtitle('Housing Prices in Richmond 1964 - 2016') + ylab("Frequency") + 
  xlab('Housing Prices ($)') + 
  scale_x_continuous(breaks = scales::pretty_breaks(n = 10), 
                     labels = label_comma())

# distribution of total square feet
ggplot(housing_df, aes(x=square_feet_total_living)) + 
  geom_histogram(fill="skyblue", colour="black",binwidth=1000, bins=10) + 
  ggtitle('Square Feet of Homes in Richmond 1964 - 2016') + ylab("Frequency") + 
  xlab('Area (square feet)')+
  scale_x_continuous(breaks = scales::pretty_breaks(n = 10))

# Both distributions appear to be skew left and not normal. 
# Housing prices peak around $600K to $700K.
# The square feet distribution peaks at about 2000-3000 square feet.
# The data is heavy tailed, sharp peaks and tails at each end.

# 5. Identify if there are any outliers
# For the housing prices distributions, the outliers appear to be houses priced
# higher than about $2.5M or higher. The points are spread out near the right 
# end of the distribution. There are also houses in the $0 to $500k range
# that could be either errors in entry or very cheap houses. As discussed above, 
# the minimum in the housing prices was $698 which is too low for a house.

# For the square feet distribution, there aren't any outstanding big outliers
# from the distributions, but there are a few houses that are within some 
# questionable ranges in the bins. Performing a quick apply won't hurt:

apply(housing_df['square_feet_total_living'], MARGIN=2, FUN=min)
apply(housing_df['square_feet_total_living'], MARGIN=2, FUN=max)

# We find that the minimum square feet in living is 240, and the maximum is 
# 13450 square feet which are quite shocking. To live in 240 square feet could 
# also be an error in the system, but 13450 could be a possibility of a very
# wealthy person.

# 6. Create at least 2 new variables

# created a price/sq foot living, price/sq foot lot, and total bath count
new_housing_df <- housing_df %>%
  mutate(price_per_sqft_living = Sale.Price/square_feet_total_living,
         price_per_sqft_lot = Sale.Price/sq_ft_lot,
         total_bath_count = bath_full_count + bath_half_count + bath_3qtr_count)

head(new_housing_df)

# Not really sure if the total_bath_count would be entirely important, but 
# it seemed like another variable I could try creating.