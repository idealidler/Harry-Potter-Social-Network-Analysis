data <- read.csv('reviews.csv')
head(data)
head(data$Review)
library(tm)
corpus <- iconv(data$Review)
corpus <- Corpus(VectorSource(corpus))
corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
cleanset <- tm_map(corpus, removeWords, stopwords('english'))
cleanset <- tm_map(cleanset, removeWords, c('aapl', 'data'))
cleanset <- tm_map(cleanset, gsub,
                   pattern = 'stocks',
                   replacement = 'stock')
#cleanset <- tm_map(cleanset, stemDocument)
cleanset <- tm_map(cleanset, stripWhitespace)
#inspect(cleanset[1:5])
tdm <- TermDocumentMatrix(cleanset)
tdm <- as.matrix(tdm)
w <- rowSums(tdm)
w <- subset(w, w>=30)
barplot(w,
        las = 2,
        col = rainbow(55), ylim = c(0,75), xlab = 'Word', ylab = 'Frequency', main = 'Word Count Frequency' )
library(wordcloud)
w <- sort(rowSums(tdm), decreasing = TRUE)
set.seed(2)
wordcloud(words = names(w),
          freq = w,
          max.words = 130,
          random.order = F,
          min.freq = 6,
          colors = brewer.pal(8, 'Dark2'),
          scale = c(5, 0.3),
          rot.per = 0.7)
library(syuzhet)
library(lubridate)
library(ggplot2)
library(scales)
library(reshape2)
library(dplyr)

Review<- iconv(data$Review)
s <- get_nrc_sentiment(Review)
head(s)
barplot(colSums(s),
        las = 1,
        col = rainbow(10),
        ylab = 'Count',
        main = 'Sentiment Scores', ylim = c(0,700), xlab = 'Sentiment')
