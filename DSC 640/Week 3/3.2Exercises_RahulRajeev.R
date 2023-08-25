# 3.2 Exercises: Charts in R
# Name: Rahul Rajeev

# loading packages
library(ggplot2)
library(readxl)
library(dplyr)
library(tidyr)

setwd("C:/Users/rahul/Documents/Bellevue/DSC 640")

crimerates_bubbles <- read.csv('crimerates_bubbles.csv')
tv_sizes <- read.csv('tv_sizes_fixed.csv')
birthrates <- read.csv('birthrates_t.csv')

birthrates2 = select(birthrates, -X)
crimerates_bubbles2 = select(crimerates_bubbles, -X)

# scatter plot
birthrates2 %>% pivot_longer(., - Year, names_to = "Variable", 
                            values_to = "Value") %>%
  ggplot(aes(x = Year, y = Value, color = Variable))+
  geom_point() + 
  ggtitle('Birth Rate vs. Year in Different Countries (Scatterplot - R)')

# bubble chart
ggplot(crimerates_bubbles2, aes(x=murder, y=robbery, size = population, 
                                color = state)) + geom_point(alpha=0.7) +
  ggtitle('Robbery Rates and Murder Rates for the 10 most populated states 
          (Bubble Chart - R)')

# density chart
ggplot(data=tv_sizes, aes(x=size, group=year, fill=year)) +
  geom_density(adjust=1.5) +
  facet_wrap(~year) +
  theme(
    legend.position="none",
    panel.spacing = unit(0.1, "lines"),
    axis.ticks.x=element_blank()
  ) + ggtitle('TV Size Density Plot Per Year (Density Plot - R)')



