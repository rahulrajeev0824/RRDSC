
## Set the working directory to the root of your DSC 520 directory
library(ggplot2)
library(dplyr)
theme_set(theme_minimal())

## Set the working directory to the root of your DSC 520 directory
setwd("C:/Users/rahul/Documents/Bellevue/DSC 520")

## loading data
pha1 <- read.csv("data/pha1.csv", fileEncoding = 'latin1')
pha2 <- read.csv('data/pha2.csv', fileEncoding = 'latin1')
pha3 <- read.csv('data/pha3.csv', fileEncoding = 'latin1')

# I am only going to use the second dataset, because it is the one updated
# the latest and has many points in the sample. The other two share datapoints,
# but the dataset contains everything I need

head(pha2)

# selecting interesting parameters with labels and making sure that the
# asteroid is near earth as that is one of the necessary conditions for a pha
selected <- pha2 %>% select(name, neo, pha, H, diameter, albedo, 
                            e, a, q, i, moid_ld) %>% filter(neo == 'Y')

length(selected$pha)
selected$phad <- ifelse(selected$pha == 'Y', 1, 0)
binary_log <- glm(phad ~ H + diameter + albedo + e + a + q + i + moid_ld, 
                  family = 'binomial', data=selected)
summary(binary_log)
