setwd("~/Documents/Research")
library(twitteR)#
library(sentiment)#
library(plyr)
library(ggplot2)
library(wordcloud)
library(RColorBrewer)

load("Mar.RData")
data.Mar  <- list()
day_index <- 1
for(one_day in result){
  data.Mar [[day_index]] = one_day$stock
  day_index <- day_index + 1
}

load("Apr.RData")
result[['2015-04-29']] <- NULL
result[['2015-04-31']] <- NULL
data.Apr  <- list()
day_index <- 1
for(one_day in result){
  data.Apr [[day_index]] = one_day$stock
  day_index <- day_index + 1
}


load("May.RData")
data.May  <- list()
day_index <- 1
for(one_day in result){
  data.May [[day_index]] = one_day$stock
  day_index <- day_index + 1
}


load("June.RData")
result[['2015-06-31']] <- NULL
data.June  <- list()
day_index <- 1
for(one_day in result){
  data.June [[day_index]] = one_day$stock
  day_index <- day_index + 1
}

load("July.RData")
result[['2015-07-05']] <- NULL
result[['2015-07-06']] <- NULL
result[['2015-07-07']] <- NULL
result[['2015-07-08']] <- NULL
result[['2015-07-09']] <- NULL
result[['2015-07-10']] <- NULL
result[['2015-07-11']] <- NULL
result[['2015-07-12']] <- NULL
data.July  <- list()
day_index <- 1
for(one_day in result){
  data.July [[day_index]] = one_day$stock
  day_index <- day_index + 1
}


load("Aug.RData")
data.Aug  <- list()
day_index <- 1
for(one_day in result){
  data.Aug [[day_index]] = one_day$stock
  day_index <- day_index + 1
}

#----------------------------------------------------------------------
d = c(data.Mar , data.Apr , data.May , data.June, data.July, data.Aug )
data <- list()
day_index <- 1
for(day in d){
  data[[day_index]] <- data.frame(x=day)
  day_index <- day_index + 1
}


d <- data 
polarity = list()
for (i in 1:length(d)) {
  if (length(d[[i]]$x) != 0) {
    class_pol_i = classify_polarity(d[[i]], algorithm="bayes")  # classify polarity
    polarity_i = class_pol_i[,4] # get polarity best fit
    polarity[[i]] <-polarity_i
  }
}


positive = vector()
negative = vector()
neutral = vector()
for (i in 1:length(polarity)) {
  if(length(polarity[[i]]) == 0){
    positive[i] = 0;
    negative[i] = 0;
    neutral[i] = 0
  }else{
    positive[i] = (count(polarity[[i]][which(polarity[[i]] == "positive")])$freq)/length(polarity[[i]])
    negative[i] = (count(polarity[[i]][which(polarity[[i]] == "negative")])$freq)/length(polarity[[i]])
    neutral[i] = (count(polarity[[i]][which(polarity[[i]] == "neutral")])$freq)/length(polarity[[i]])
  }
}


#---------------------------------------------------------------------
SP = read.table(file = "SP500.txt", header = TRUE)
index = SP$VALUE #raw S&P500 data within required time range
weekend = which(index==0)
index = index[-weekend]
twitter.neg = negative[-weekend]


label = numeric(length(index) - 1)
for (i in 1: (length(index)-1)) {
  if ( (index[i+1] - index[i]) > 0 ) {
    label[i] = 1
  } else {
    label[i] = -1
  }
}


l = length(twitter.neg)
x1 = twitter.neg[c(-1:-4)]                #today's twitter emotion
x2 = twitter.neg[c(-1:-3,-l)]             #yesterday's twitter emotion
x3 = twitter.neg[c(-1:-2,-(l-1):-l)]      #and so on....
x4 = twitter.neg[c(-1,-(l-2):-l)]
x5 = twitter.neg[c(-(l-3):-l)]
x1s = x1^2
x2s = x2^2
x3s = x3^2
x4s = x4^2
x5s = x5^2



#revise label 
newlabel = label[c(-1:-4)] 

data = cbind(x1,x2,x3,x4,x5,x1s,x2s,x3s,x4s,x5s,newlabel)
#write data to a file
write.table(x=data,file = "Mar_to_Aug")



