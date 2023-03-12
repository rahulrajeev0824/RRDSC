# Assignment: 11.2 Exercises - Introduction to Machine Learning
# Name: Rajeev, Rahul
# Date: 2023-02-20

## Set the working directory to the root of your DSC 520 directory
library(ggplot2)
library(foreign)
library(dplyr)
library(stringr)
library(caTools)
theme_set(theme_minimal())

## Set the working directory to the root of your DSC 520 directory
setwd("C:/Users/rahul/Documents/Bellevue/DSC 520")
bi_data <- read.csv('data/binary-classifier-data.csv')
tri_data <- read.csv('data/trinary-classifier-data.csv')

# scaling data
#bi_data[c(2,3)] <- scale(bi_data[c(2,3)])
#tri_data[c(2,3)] <- scale(tri_data[c(2,3)])

# I scaled the data and my accuracy of my model was 100% each time
# so I wasn't sure if that was a good way of demonstrating my results
# so I commented these lines out. 

head(bi_data)
head(tri_data)

ggplot(bi_data, aes(x=x, y=y)) + geom_point() + ggtitle('Binary')
ggplot(tri_data, aes(x=x, y=y)) + geom_point() + ggtitle('Trinary')

# classification library
library(class)

# running knn for binary data
split <- sample.split(bi_data, SplitRatio = 0.7)
bi_train <- subset(bi_data, split == "TRUE")
bi_test <- subset(bi_data, split == "FALSE")

# creating list of k values and initializing accuracy list
k_val <- c(3, 5, 10, 15, 20, 25)
acc_list <- c()

# iterating through each k value for the model, calculating accuracy,
# and storing it into a list
# printing the accuracy each iteration as well
for (k in k_val){
  k_class <- knn(train = bi_train,
                 test = bi_test,
                 cl = bi_train$label,
                 k = k)
  k_error <- mean(k_class != bi_test$label)
  accuracy <- 1-k_error
  resp <- paste('The accuracy for k =', k, 'was', accuracy)
  print(resp)
  acc_list <- append(acc_list, accuracy)
}

# storing the values and accuracy into a data frame
results_df <- data.frame(k_val, acc_list)
head(results_df)

# plotting results
ggplot(results_df, aes(x=k_val, y=acc_list)) + geom_point() + 
  ggtitle('Binary Accuracy vs. K-val') + 
  scale_x_continuous('k_val', labels = as.character(k_val), breaks = k_val)

# looking back at the plots of the data, a linear classifier would not work here
# because the accuracy is way better than the one we used before

# compared to my previous accuracy of around a 57% I would say using the KNN
# model has substantially improved accuracy to more than 40 percent above.

# repeating the process for the trinary data
tri_train <- subset(tri_data, split == "TRUE")
tri_test <- subset(tri_data, split == "FALSE")
acc_list2 <- c()

for (k in k_val){
  k_class <- knn(train = tri_train,
                 test = tri_test,
                 cl = tri_train$label,
                 k = k)
  k_error2 <- mean(k_class != tri_test$label)
  accuracy2 <- 1-k_error2
  resp2 <- paste('The accuracy for k =', k, 'was', accuracy2)
  print(resp2)
  acc_list2 <- append(acc_list2, accuracy2)
}

results_df2 <- data.frame(k_val, acc_list2)
head(results_df2)

ggplot(results_df2, aes(x=k_val, y=acc_list2)) + geom_point() + 
  ggtitle('Trinary Accuracy vs. K-val') + 
  scale_x_continuous('k_val', labels = as.character(k_val), breaks = k_val)

# from this particular run of knn model for the trinary data set, the accuracy
# seems to lower for each increasing k-value which is interesting, but the 
# accuracy is still well above 90% which is good news.

# ------------------------------------------------------------------------------

# Assignment: 11.2 Exercises - Clustering
# Name: Rajeev, Rahul
# Date: 2023-02-20

# install
library(factoextra)


# loading data
raw <- read.csv('data/clustering-data.csv')
head(raw)

# plotting original data
ggplot(raw, aes(x=x, y=y)) + geom_point() + ggtitle('Clustering Data')

k_list <- c(2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)

# testing the k means clustering with each k and visualizing
kmcluster2 <- kmeans(raw, 2, n=25)
fviz_cluster(kmcluster2, raw, geom = 'point') + ggtitle('k=2')
kmcluster3 <- kmeans(raw, 3, n=25)
fviz_cluster(kmcluster3, raw, geom = 'point') + ggtitle('k=3')
kmcluster4 <- kmeans(raw, 4, n=25)
fviz_cluster(kmcluster4, raw, geom = 'point') + ggtitle('k=4')
kmcluster5 <- kmeans(raw, 5, n=25)
fviz_cluster(kmcluster5, raw, geom = 'point') + ggtitle('k=5')
kmcluster6 <- kmeans(raw, 6, n=25)
fviz_cluster(kmcluster6, raw, geom = 'point') + ggtitle('k=6')
kmcluster7 <- kmeans(raw, 7, n=25)
fviz_cluster(kmcluster7, raw, geom = 'point') + ggtitle('k=7')
kmcluster8 <- kmeans(raw, 8, n=25)
fviz_cluster(kmcluster8, raw, geom = 'point') + ggtitle('k=8')
kmcluster9 <- kmeans(raw, 9, n=25)
fviz_cluster(kmcluster9, raw, geom = 'point') + ggtitle('k=9')
kmcluster10 <- kmeans(raw, 10, n=25)
fviz_cluster(kmcluster10, raw, geom = 'point') + ggtitle('k=10')
kmcluster11 <- kmeans(raw, 11, n=25)
fviz_cluster(kmcluster11, raw, geom = 'point') + ggtitle('k=11')
kmcluster12 <- kmeans(raw, 12, n=25)
fviz_cluster(kmcluster12, raw, geom = 'point') + ggtitle('k=12')

# calculate the average distance from the center of each cluster
# for each value of k and plot it as a line chart
# and average distance is the y-axis

labeled_k <- cbind(raw, k2 = kmcluster2$cluster, k3 = kmcluster3$cluster, 
                   k4 = kmcluster4$cluster, k5 = kmcluster5$cluster, 
                   k6 = kmcluster6$cluster, k7 = kmcluster7$cluster, 
                   k8 = kmcluster8$cluster, k8 = kmcluster8$cluster,
                   k9 = kmcluster9$cluster, k10 = kmcluster10$cluster,
                   k11 = kmcluster11$cluster, k12 = kmcluster12$cluster)
head(labeled_k)

<- kmcluster2$totss
k2dist <- 
mean()
a



