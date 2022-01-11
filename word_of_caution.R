data <- read.csv('Final_script.csv')
length(data$Sentence)
data$total_words <- sapply(data$Sentence, function(x) length(unlist(strsplit(as.character(x), "\\W+"))))
head(data)
x <- data$total_words 
h<-hist(x, breaks=8, col="red", xlab="Number of Words", ylab = 'Number of Dialogues',
        main="Frequency Analysis", ylim = c(0,500)) 
xfit<-seq(min(x),max(x),length=60) 
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x)) 
yfit <- yfit*diff(h$mids[1:2])*length(x) 
lines(xfit, yfit, col="black", lwd=2)

#before the sentiment analysis
#WORD OF CAUTION
#DATA is Skewed