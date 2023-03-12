# Assignment: 8.2 Exercises - Assignment 6
# Name: Rajeev, Rahul
# Date: 2023-01-30

## Set the working directory to the root of your DSC 520 directory
library(ggplot2)
theme_set(theme_minimal())

## Set the working directory to the root of your DSC 520 directory
setwd("C:/Users/rahul/Documents/Bellevue/DSC 520")

## Load the `data/r4ds/heights.csv` to
heights_df <- read.csv("data/r4ds/heights.csv")

## Fit a linear model using the `age` variable as the predictor 
# and `earn` as the outcome
age_lm <-  lm(heights_df$earn~heights_df$age)

## View the summary of your model using `summary()`
summary(age_lm)

## Creating predictions using `predict()`
age_predict_df <- data.frame(earn = 
                               predict(age_lm, heights_df), age=heights_df$age)

## Plot the predictions against the original data
ggplot(data =  heights_df, aes(y = earn, x = age)) +
  geom_point(color='blue') +
  geom_line(color='red',data = age_predict_df, aes(y= earn, x=age))

mean_earn <- mean(heights_df$earn)
## Corrected Sum of Squares Total
sst <- sum((mean_earn - heights_df$earn)^2)
## Corrected Sum of Squares for Model
ssm <- sum((mean_earn - age_predict_df$earn)^2)
## Residuals
residuals <- heights_df$earn - age_predict_df$earn
## Sum of Squares for Error
sse <- sum(residuals^2)
## R Squared R^2 = SSM\SST
r_squared <- ssm/sst

## Number of observations
n <- length(heights_df$age)
## Number of regression parameters
p <- 2
## Corrected Degrees of Freedom for Model (p-1)
dfm <- p-1
## Degrees of Freedom for Error (n-p)
dfe <- n-p
## Corrected Degrees of Freedom Total:   DFT = n - 1
dft <- n-1

## Mean of Squares for Model:   MSM = SSM / DFM
msm <- ssm/dfm
## Mean of Squares for Error:   MSE = SSE / DFE
mse <- sse/dfe
## Mean of Squares Total:   MST = SST / DFT
mst <- sst/dft
## F Statistic F = MSM/MSE
f_score <- msm/mse

## Adjusted R Squared R2 = 1 - (1 - R2)(n - 1) / (n - p)
adjusted_r_squared <- 1 - (1 - r_squared)*(n - 1)/(n - p)

## Calculate the p-value from the F distribution
p_value <- pf(f_score, dfm, dft, lower.tail=F)

# -----------------------------------------------------------------------------
# Assignment: 8.2 Exercises - Assignment 7
# Name: Rajeev, Rahul
# Date: 2023-30-01

# Fit a linear model
earn_lm <-  lm(earn ~ height + sex + ed + age + race, data=heights_df)

# View the summary of your model
summary(earn_lm)

predicted_df <- data.frame(earn = predict(earn_lm, heights_df), 
                           ed=heights_df$ed, race=heights_df$race, 
                           height=heights_df$height, age=heights_df$age, 
                           sex=heights_df$sex)

## Compute deviation (i.e. residuals)
mean_earn <- mean(heights_df$earn)
## Corrected Sum of Squares Total
sst <- sum((mean_earn - heights_df$earn)^2)
## Corrected Sum of Squares for Model
ssm <- sum((mean_earn - predicted_df$earn)^2)
## Residuals
residuals <- heights_df$earn - predicted_df$earn
## Sum of Squares for Error
sse <- sum(residuals^2)
## R Squared
r_squared <- ssm/sst
r_squared

## Number of observations
n <- length(heights_df$earn)
## Number of regression paramaters
p <- 8
## Corrected Degrees of Freedom for Model
dfm <- p - 1
## Degrees of Freedom for Error
dfe <- n - p
## Corrected Degrees of Freedom Total:   DFT = n - 1
dft <- n - 1

## Mean of Squares for Model:   MSM = SSM / DFM
msm <- ssm/dfm
## Mean of Squares for Error:   MSE = SSE / DFE
mse <- sse/dfe
## Mean of Squares Total:   MST = SST / DFT
mst <- sst/dft
## F Statistic
f_score <- msm/mse

## Adjusted R Squared R2 = 1 - (1 - R2)(n - 1) / (n - p)
adjusted_r_squared <- 1 - (1 - r_squared)*(n - 1)/(n - p)

#------------------------------------------------------------------------------
# Assignment: 8.2 Exercise - Housing Dataset
# Name: Rajeev, Rahul
# Date: 2023-01-30

# importing libraries
library(plyr)
library(dplyr)
library(readxl)
library(pastecs)
library(scales)
library(purrr)
library(tidyr)

# loading dataset
housing_xl <- read_excel("data/week-7-housing.xlsx")
housing_df <- data.frame(housing_xl)

# just checking whether the data frame loaded properly
head(housing_df)

## i) Explain any transformations or modifications you made to the dataset

# filtering data
filtered_housing_df <- housing_df %>% filter(Sale.Price > 100000)
length(housing_df$Sale.Price)
length(filtered_housing_df$Sale.Price)
# filtered out house prices with less than 100,000 to avoid outliers that don't
# make any sense

# selecting columns that would be useful for analysis
selected_housing_df <- filtered_housing_df %>% select(Sale.Price, 
                                                      square_feet_total_living,
                                                      bedrooms,
                                                      sq_ft_lot,
                                                      year_built, 
                                                      building_grade)
head(selected_housing_df)

## ii) creating variables and predictors 

# creating a variable for linear model of sale price vs square foot lot
saleprice_lm <-  lm(Sale.Price ~ 
                      sq_ft_lot, data=selected_housing_df)

# creating a variable for linear model of sale price vs additional variables
multi_lm <- lm(Sale.Price ~ sq_ft_lot + square_feet_total_living + 
                 bedrooms + year_built + building_grade, data=selected_housing_df)

# I chose square feet total living, bedrooms and year_built as additional 
# parameters because I feel like they are all factors that influence
# a house price. Having bigger, newer homes I expect should be the costliest,
# but I also think that some ancient houses may be also costly depending on
# renovation. Since there isn't a great variable for renovation in the dataset
# I can't really use it. 

## iii) execute summary to compare model results

# summary of single linear regression
summary(saleprice_lm)

# R-squared is 0.00298, and the adjusted r-squared is 0.02291

# summary of multiregression
summary(multi_lm)

# the r-squared statistic has increased to 0.2292, and the adjusted r-squared
# is 0.2289.

# significance of the difference between models in r-squared and adjusted
# r-squared:

# Since the model we are using is trying to predict the variance in sale price
# based on a number of factors, we would need a larger r-squared to demonstrate
# that the model shows this variance. 
# The simple linear model has a very low r-squared and adjusted r-squared values
# compared to the multiregression model, leading me to believe that the 
# multi-regression model that includes the extra parameters fits the data 
# better. 

## iv) calculating the standard beta coefficients for the multiregression model

# standardized coefficients
library(lm.beta)
lm.beta(multi_lm)

# scaling the original model to check whether the function works
standard_multi_lm <- lm(scale(Sale.Price) ~ scale(sq_ft_lot) + 
                          scale(square_feet_total_living) + 
                          scale(bedrooms) + scale(year_built) + 
                          scale(building_grade), data=selected_housing_df)
summary(standard_multi_lm)

# looks like we are good to go!

# the beta coefficients for each variable in the multi-regression model
# are shown above. From a glance, all variables
# have a positive coefficient except for bedrooms, which has a negative. The 
# positive coefficients show that there is a positive relationship between
# sq_ft_lot, square_feet_total_living, year_built, and building_grade on 
# the sale.price of the house. The negative relationship between bedrooms and 
# sale price is interesting considering I would've expected that more bedrooms
# would have resulted in a higher house price


## v) confidence intervals for each of the parameters in the model

confint(standard_multi_lm, level = 0.95)

# the confidence intervals are pretty narrow except for bedrooms which suggests
# that 95% of all samples that can be drawn, the beta coefficients of
# the other variables will cover the true value in relationship to the entire
# regression model.

## vi) assess the improvement of the new model using an analysis of variance
anova(saleprice_lm, multi_lm)
# Null hypothesis: there is no difference in the models, adding more variables
# does not improve the relationship with Sale Price.
# Alternative hypothesis: The coefficients of both models are not the same

# Setting a significance level of 0.05. The F-statistic of the multi-linear 
# model is 868.52 on 5 and with 12780 DF, while the F-statistic of the linear
# model is 300 on 1 and 12784 DF

# if the null hypothesis were true, the F-statistic of each model would be 
# closer to 1 which they aren't. Although both have very small p-values below
# the significance level, the multi-regression model has a higher f-statistic
# which means that there is larger variation between the models than within
# the models. Which leads to my conclusion that the multi-regression model
# fits the data better.

## vii) outliers and influential cases
outlier_points <- hatvalues(multi_lm) > 3 * mean(hatvalues(multi_lm))
outliers <- selected_housing_df[outlier_points,]
head(outliers)
length(outliers$Sale.Price)

# there are 447 outliers

cooks_crit = 0.5
influential_points <- cooks.distance(multi_lm)
influential_cases <- selected_housing_df[which(abs(influential_points) > cooks_crit),]
influential_cases

# there is one influential case

## viii) calculate standardized residuals
std_res <- rstandard(multi_lm)

# storing results
selected_res_df <- cbind(selected_housing_df, std_res)
head(selected_res_df)
# ordering to look at magnitude of residuals
head(selected_res_df[order(-std_res),])

# picking points that have large residuals > or < than +2, -2
large_res_df <- subset(selected_res_df, selected_res_df$std_res > 2 | 
                                  selected_res_df$std_res < -2)

# checking lengths
length(selected_res_df$Sale.Price)
length(large_res_df$Sale.Price)

# there are 321 points with large residuals

## ix) show the sum of large residuals
sum(large_res_df$std_res)

# the sum of the large standardized residuals is 1237.564

## x) what specific variables have large residuals
res = resid(multi_lm)

# I plotted the residuals of the model vs each variable and found the variables
# with the largest residuals are sale price, square feet lot, 
# and square foot living

plot(selected_housing_df$Sale.Price, res)
plot(selected_housing_df$sq_ft_lot, res)
plot(selected_housing_df$square_feet_total_living, res)
plot(selected_housing_df$bedrooms, res)
plot(selected_housing_df$year_built, res)
plot(selected_housing_df$building_grade, res)

# calculating cook's distance, leverage, and covariance rations
cooks_distance <- cooks.distance(multi_lm)
leverage <- hatvalues(multi_lm)
covariance_rations <- covratio(multi_lm)

# creating dataframe with all the new columns in addition to teh standardized
# residuals

library(tibble)
diagnostics_df <- selected_res_df %>% add_column(cooks_distance, leverage, covariance_rations)
head(diagnostics_df)


# interpreting any wild cases

# large cooks distance
lg_cooks <- subset(diagnostics_df, diagnostics_df$cooks_distance > 1)
length(lg_cooks$Sale.Price)

# there are no values with a cook_distance greater than 1

# average leverage = k+1/n = 6/12786
boundary_avg_leverage <- 3 * 6/12786
large_lev <- subset(diagnostics_df, diagnostics_df$leverage > boundary_avg_leverage)
length(large_lev$Sale.Price)

# there are 447 values with leverages above the upper bound, basically outliers

upper_cvr <- 1 + 3*6/12786
lower_cvr <- 1 - 3*6/12786

cvr <- subset(diagnostics_df, diagnostics_df$covariance_rations > upper_cvr | 
                diagnostics_df$covariance_rations < lower_cvr)
length(cvr$Sale.Price)

# there are 781 data points that are outide of the boundaries of covariance rations

## xii) assumption of independence test
library(car)
dwt(multi_lm)

# the d-value is less than 1.5 which indicates positive autocorrelation,
# and therefore the errors are not independent, which is a cause for concern.

## xiii) multi-collinearity test

# variance inflation factor
vif(multi_lm)

# the only two variables that have a vif close to one are sq_ft_lot and year_built
# building_grade and square_feet_total_living have higher inflation factors, 
# which could indicate moderate correlation, but nothing is higher than 5

# tolerance
1/vif(multi_lm)

# there are no tolerance below 0.25

# average vif
mean(vif(multi_lm))

# average vif is 1.95 which is pretty close to 1

# so by the tests here, I conclude there isn't any collinearity with our data.

## xiv) visual residuals

# so I did plot the residual plots above comparing each variable to the residuals
# but I can also plot the residuals on a histogram
library(ggplot2)
ggplot(diagnostics_df, aes(x=diagnostics_df$std_res)) + 
  geom_histogram(fill = 'blue', color = 'black') + 
  labs(title = 'Histogram of Residuals', x = 'Residuals', y = 'Frequency')

plot(multi_lm)

# most of the residuals are in the 0-2 range, but there are many anomalies outside
# of the main distribution.From the residuals and fitted graph, the plot doesn't
# behave well, it doesn't form a tight horizontal band after a certain point
# and the plot appears to be parabolic in nature
# the qq plot follows a tight band as well up to a certain point
# the scale-location graph is also kind of sad, it doesn't have equal variability
# at all fitted values

## xv) checking for bias using bootstrapping
library(boot)

# boot function
bootReg <- function(formula, data, i)
{ 
  d<- data[i,]
  fit <- lm(formula, data=d)
  return(coef(fit))
}

# boot results
bootResults<-boot(statistic = bootReg, formula = Sale.Price ~ sq_ft_lot + square_feet_total_living + 
                    bedrooms + year_built + building_grade, data = selected_housing_df, R=100,)

# checking the difference between model confint and boot conf int
bootResults
# boot confidence intervals, I don't know how to combine results into a nice
# data frame
boot.ci(boot.out = bootResults, type = 'norm', index= 1)
boot.ci(boot.out = bootResults, type = 'norm', index= 2)
boot.ci(boot.out = bootResults, type = 'norm', index= 3)
boot.ci(boot.out = bootResults, type = 'norm', index= 4)
boot.ci(boot.out = bootResults, type = 'norm', index= 5)
boot.ci(boot.out = bootResults, type = 'norm', index= 6)

# confidence intervals of the model
confint(multi_lm)

# plotting the bootstrap results, very normalized and standardized
plot(bootResults)

# the confidence intervals for the beta coefficients 
# of the bootstrap model and the normal model are not very close which could 
# demonstrate that there could be some bias in the model. The intervals for 
# the intercept, bedrooms, year built, and building grade are closer in the 
# bootstrap to the original model, and the square_ft_lot and square_feet_total_living
# confidence intervals are tighter in the model than in the boostrapped.

# conclusion: there could be slight bias due to the difference in confidence
# intervals
