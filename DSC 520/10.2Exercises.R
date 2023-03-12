# Assignment: 10.2 Exercises - Thoracic Surgery Binary Logistic Model
# Name: Rajeev, Rahul
# Date: 2023-02-13

## Set the working directory to the root of your DSC 520 directory
library(ggplot2)
library(foreign)
library(dplyr)
library(stringr)
library(caTools)
theme_set(theme_minimal())

## Set the working directory to the root of your DSC 520 directory
setwd("C:/Users/rahul/Documents/Bellevue/DSC 520")

## loading data
surgery_df<- read.arff("data/ThoraricSurgery.arff")
head(surgery_df)

# adjusting the non-numerical values to numerical values except for the ones
# that are binary (diagnosis from DGN, zubrod scale from PRE6, and tumor size
# from PRE14). Everything else should be fine.

adjusted_surgery_df <- surgery_df %>%
  mutate(diagnosis = str_sub(DGN, -1), zubrod = str_sub(PRE6, -1), 
         tumor_size = str_sub(PRE14, -2, -1)) %>%
  select(diagnosis, PRE4, PRE5, zubrod, PRE7, PRE8, PRE9, PRE10, PRE11, tumor_size,
         PRE17, PRE19, PRE25, PRE30, PRE32, AGE, Risk1Yr)

head(adjusted_surgery_df)

# general linear model for binary logistic
binary_log <- glm(Risk1Yr ~ diagnosis + PRE4 + PRE5 + zubrod + PRE7 + PRE8 + 
                    PRE9 + PRE10 + PRE11 + tumor_size + PRE17 + PRE19 + PRE25 + 
                    PRE30 + PRE32 + AGE, family = 'binomial', data=adjusted_surgery_df)
summary(binary_log)

# according to the summary, teh variables that had the greatest effect on survival
# were PRE9 with dysnopea before surgery, PRE14 with tumor size of 14, PRE17 with
# type 2 diabetes mellitus, and PRE30 with smoking. With meaning that the 
# condition was true. 

# creating test dataset and testing against model
split <- sample.split(adjusted_surgery_df, SplitRatio = 0.65)
train <- subset(adjusted_surgery_df, split == TRUE)
test <- subset(adjusted_surgery_df, split == FALSE)
my_model <- glm(Risk1Yr ~ diagnosis + PRE4 + PRE5 + zubrod + PRE7 + PRE8 + 
                PRE9 + PRE10 + PRE11 + tumor_size + PRE17 + PRE19 + PRE25 + 
                PRE30 + PRE32 + AGE, family = 'binomial', data=train)
summary(my_model)

# running the test data through the model
res <- predict(my_model, test, type = 'response')
res <- predict(my_model, train, type='response')

# confusion matrix
length(train$Risk1Yr)
length(res[res > 0.5])
confmatrix <- table(Actual_Value = train$Risk1Yr, Predicted_Value = res > 0.5)
confmatrix

# accuracy
(confmatrix[[1,1]] + confmatrix[[2,2]]) / sum(confmatrix)

# the accuracy of my model is 84.3%

#------------------------------------------------------------------------------
# Assignment: 10.2 Exercises - Binary Classifier Dataset
# Name: Rajeev, Rahul
# Date: 2023-02-13

# additional libraries
library(tidyr)

# loading data
classifier_data <- read.csv('data/binary-classifier-data.csv')
head(classifier_data)

# general linear model for binary logistic
binary_log2 <- glm(label ~ x + y, family = 'binomial', data=classifier_data)
summary(binary_log2)

# splitting data
split2 <- sample.split(classifier_data, SplitRatio = 0.65)
train2 <- subset(classifier_data, split2 == TRUE)
test2 <- subset(classifier_data, split2 == FALSE)
my_model2 <- glm(label ~ x + y, family = 'binomial', data=train2)
summary(my_model2)

# running the test data through the model
res2 <- predict(my_model2, test2, type = 'response')
res2 <- predict(my_model2, train2, type='response')

# confusion matrix
confmatrix2 <- table(Actual_Value = train2$label, Predicted_Value = res2 > 0.5)
confmatrix2

# accuracy
(confmatrix2[[1,1]] + confmatrix2[[2,2]]) / sum(confmatrix2)

# the accuracy of the logistic regression classifier is 54.3% which is very low.

