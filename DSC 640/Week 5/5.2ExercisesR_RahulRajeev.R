# 5.2 Visualizations in R
library(tidyr)
library(mapview)
library(sf)
library(ggplot2)
library(choroplethr)
library(choroplethrMaps)


setwd("C:/Users/rahul/Documents/Bellevue/DSC 640")

education <- read.csv('education.csv')
spatial <- read.csv('spatial_r.csv')

# getting rid of the united states row
education <- education[-1,]
head(education)

# histograms

reading <- education$reading
math <- education$math
writing <- education$writing

par(mfrow=c(2,2))
# Plot 1: Histogram for Reading
hist(reading)
# Plot 2: Histogram for Math
hist(math)
# Plot 3: Histogram for Writing
hist(writing)
title('Histograms of scores in the U.S. (Histogram - R)', 
      line = -1, outer=TRUE)

# box plots
par(mfrow=c(2,2))
# Plot 1: Histogram for Reading
boxplot(reading, main = 'reading')
# Plot 2: Histogram for Math
boxplot(math, main = 'math')
# Plot 3: Histogram for Writing
boxplot(writing, main = 'writing')
title('Boxplots of scores in the U.S. (Boxplots - R)', 
      line = -1, outer=TRUE)

# bullet charts
bullet <- data.frame(
  measure=c("Reading", "Math", "Writing"),
  high=c(572, 572, 558),
  mean=c(523, 526, 510),
  low=c(497 ,505, 488), 
  target=c(500, 513, 498)
)

bullet.graph <- function(bg.data){
  
  # compute max and half for the ticks and labels
  max.bg <- max(bg.data$high)
  mid.bg <- max.bg / 2
  
  gg <- ggplot(bg.data) 
  gg <- gg + geom_bar(aes(measure, high),  fill="goldenrod2", stat="identity", width=0.5, alpha=0.2) 
  gg <- gg + geom_bar(aes(measure, mean),  fill="goldenrod3", stat="identity", width=0.5, alpha=0.2) 
  gg <- gg + geom_bar(aes(measure, low),   fill="goldenrod4", stat="identity", width=0.5, alpha=0.2) 
  #gg <- gg + geom_bar(aes(measure, value), fill="black",  stat="identity", width=0.2) 
  #gg <- gg + geom_errorbar(aes(y=target, x=measure, ymin=target, ymax=target), color="red", width=0.45) 
  gg <- gg + geom_point(aes(measure, target), colour="black", size=5) 
  gg <- gg + scale_y_continuous(breaks=seq(0,max.bg,mid.bg))
  gg <- gg + coord_flip()
  gg <- gg + theme(axis.text.x=element_text(size=5),
                   axis.title.x=element_blank(),
                   axis.line.y=element_blank(), 
                   axis.text.y=element_text(hjust=1, color="black"), 
                   axis.ticks.y=element_blank(),
                   axis.title.y=element_blank(),
                   legend.position="none",
                   panel.background=element_blank(), 
                   panel.border=element_blank(),
                   panel.grid.major=element_blank(),
                   panel.grid.minor=element_blank(),
                   plot.background=element_blank())
  
  return(gg)
  
}

scores.bg <- bullet.graph(bullet)
scores.bg <- scores.bg + ggtitle('California Scores vs. the U.S. Quartiles 
                                 (Bullet Chart - R)')
scores.bg



# choropleth map
c = StateChoropleth$new(spatial)
c$title = "Choropleth Map for dropout rates in US (Spatial Chart - R)"
c$legend = "Dropout Rate"
c$set_num_colors(1)
c$show_labels = FALSE
c$render()