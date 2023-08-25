# 4.2 Visualizations in R
library(tidyr)
library(mapview)
library(sf)
library(ggplot2)
library(choroplethr)
library(choroplethrMaps)


setwd("C:/Users/rahul/Documents/Bellevue/DSC 640")

costco <- read.csv('costcos-geocoded.csv')
costco_grouped <- read.csv('costco_grouped2.csv')
top_ftp <- read.csv('top_ftp.csv')

# heat map
mapview(costco, xcol = "Longitude", ycol = "Latitude", 
        crs = 4269, grid = FALSE)


# choropleth map
c = StateChoropleth$new(costco_grouped)
c$title = "Choropleth Map for Costco Locations in US 
                 (Spatial Chart - R)"
c$legend = "Number"
c$set_num_colors(1)
c$show_labels = FALSE
c$render()


# lollipop chart
ggplot(top_ftp, aes(x=Name, y=FTP)) +
  geom_point() + 
  geom_segment( aes(x=Name, xend=Name, y=0, yend=FTP)) + 
  theme(axis.text.x = element_text(face = "bold", angle = 90)) + 
  ggtitle('Top 25 Free Throw Percentages (Lollipop Chart - R)')