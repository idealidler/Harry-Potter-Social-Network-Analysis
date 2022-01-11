reviews <- read.csv('reviews.csv')
head(reviews)
hist(reviews$Rating)
library(ggplot2)
library(plyr)
library(scales)
p<-ggplot(reviews, aes(x=Rating, color=Gender)) +geom_histogram(fill="white", position="dodge", binwidth = 0.5)+
  theme(legend.position="top")+scale_x_continuous(breaks= c(0,1,2,3,4,5,6,7,8,9,10))+
  scale_color_brewer(palette="Dark2")
p