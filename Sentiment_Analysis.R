data <- read.csv('Final_script.csv')
head(data)
head(data$Sentence)
library(tm)
corpus <- iconv(data$Sentence)
corpus <- Corpus(VectorSource(corpus))
#inspect(corpus[1:5])
corpus <- tm_map(corpus, tolower)
#inspect(corpus[1:5])
corpus <- tm_map(corpus, removePunctuation)
#inspect(corpus[1:5])
corpus <- tm_map(corpus, removeNumbers)
#inspect(corpus[1:5])
cleanset <- tm_map(corpus, removeWords, stopwords('english'))
#inspect(cleanset[1:5])
cleanset <- tm_map(cleanset, removeWords, c('aapl', 'data'))
#inspect(cleanset[1:5])
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
          min.freq = 5,
          colors = brewer.pal(8, 'Dark2'),
          scale = c(5, 0.3),
          rot.per = 0.7)
library(syuzhet)
library(lubridate)
library(ggplot2)
library(scales)
library(reshape2)
library(dplyr)

Dialogue<- iconv(data$Sentence)
s <- get_nrc_sentiment(Dialogue)
head(s)
barplot(colSums(s),
        las = 1,
        col = rainbow(10),
        ylab = 'Count',
        main = 'Sentiment Scores', ylim = c(0,500), xlab = 'Sentiment')
