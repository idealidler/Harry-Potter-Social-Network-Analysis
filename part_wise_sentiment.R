data <- read.csv('Final_script.csv')
library(syuzhet)
library(lubridate)
library(ggplot2)
library(scales)
library(reshape2)
library(dplyr)

Dialogue <- iconv(data$Sentence[1:247])
s <- get_nrc_sentiment(Dialogue)

barplot(colSums(s),
        las = 2,
        col = rainbow(10),
        ylab = 'Count',
        main = 'Sentiment Scores for Part 1', ylim = c(0,200), xlab = '')
Dialogue <- iconv(data$Sentence[248:494])
s <- get_nrc_sentiment(Dialogue)

barplot(colSums(s),
        las = 2,
        col = rainbow(10),
        ylab = 'Count',
        main = 'Sentiment Scores for Part 2', ylim = c(0,200), xlab = '')
Dialogue <- iconv(data$Sentence[495:740])
s <- get_nrc_sentiment(Dialogue)

barplot(colSums(s),
        las = 2,
        col = rainbow(10),
        ylab = 'Count',
        main = 'Sentiment Scores for Part 3', ylim = c(0,200), xlab = '')

