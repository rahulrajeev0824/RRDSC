# Assignment: Experimenting with Plyr on the Housing Dataset
# Name: Rajeev, Rahul
# Date: 2023-01-03

# importing libraries
library(ggplot2)
library(plyr)
library(dplyr)
library(readxl)
library(pastecs)
library(scales)
library(purrr)
library(tidyr)
install.packages('tidyr')

theme_set(theme_minimal())

# loading housing dataset
setwd("C:/Users/rahul/Documents/Bellevue/DSC 520")

# reading in xlsx file, then transferring the format into a data frame
housing_xl <- read_excel("data/week-7-housing.xlsx")
housing_df <- data.frame(housing_xl)

# just checking whether the data frame loaded properly
head(housing_df)

# 1.Use the 6 different operations to analyze/transform 
# - GroupBy, Summarize, Mutate, Filter, Select, and Arrange – 
# – understand your dataset in more detail

# Mutate Example: created a price/sq foot living, price/sq foot lot, total baths
new_housing_df <- housing_df %>%
  mutate(price_per_sqft_living = Sale.Price/square_feet_total_living,
         price_per_sqft_lot = Sale.Price/sq_ft_lot,
         total_bath_count = bath_full_count + bath_half_count + bath_3qtr_count)

head(new_housing_df)

# Group By and Summarize Example:
new_housing_df %>% group_by(zip5) %>% 
  summarise(sqft_mean=round(mean(square_feet_total_living), 2), 
            sqft_sd=round(sd(square_feet_total_living), 2),
            price_per_sqft_mean=round(mean(price_per_sqft_living), 2),
            price_per_sqft_sd=round(sd(price_per_sqft_living), 2))

# the data is returned as a tibble, which automatically accounts for 3 sig figs
# I'm not entirely sure why the sq_sd and price_per_sqft_sd does not return
# anything, I might have to ask about this

# Filter Example:
filtered_housing_df <- new_housing_df %>% filter(Sale.Price > 100000)
head(filtered_housing_df)
apply(filtered_housing_df['Sale.Price'], MARGIN=2, FUN=min)

# filtered out house prices with less than 100,000 to avoid outliers in the 
# data, and used an apply statement to find the minimum after


# Select Example:
selected_housing_df <- filtered_housing_df %>% select(Sale.Price, 
                                                square_feet_total_living,
                                                bedrooms,
                                                total_bath_count)
head(selected_housing_df)

# selected sale price, living square feet, bedrooms, and total bath count
# as a new data frame

# Arrange Example:
arranged_housing_df <- filtered_housing_df %>% arrange(Sale.Price)
head(arranged_housing_df)

# arrange the data set with Sale Price ascending, with the previous filter
# of prices greater than $100,000.

# 2. Using the purrr package – perform 2 functions on your dataset.  
# You could use zip_n, keep, discard, compact, etc.

# a. nest()
n_filtered_df <- filtered_housing_df %>% group_by(zip5) %>% nest()
head(n_filtered_df)
# created nested groups of housing into cells as data frames

# b. map()
m_filtered_df <- n_filtered_df %>% mutate(n=map(data, dim))
head(m_filtered_df)

# using the map function to apply the dim function to each of the nested groups

# 3. use the cbind and rbind function on your dataset
saleprice_df = housing_df$Sale.Price
sq_ft_living_df = housing_df$square_feet_total_living

combined_column_df = cbind(saleprice_df, sq_ft_living_df)
head(combined_column_df)

# combined columns of sale price and square foot living

houses_05_df = housing_df[housing_df$year_built == 2005,]
houses_07_df = housing_df[housing_df$year_built == 2007,]

combined_row_df <- rbind(houses_05_df, houses_07_df)
head(combined_row_df)
tail(combined_row_df)

# combined rows of houses built in 2005 and 2007

# 4. split a string then concatenate the results back together
shopping_list <- 'salad, chicken, corn, soap'
split_str <- strsplit(shopping_list, split = ', ')[[1]]
split_str
combined_str <- paste(split_str, collapse = ', ')
combined_str

# split and combined a shopping list using ','
