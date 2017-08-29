# Description: This file is meant to recreate the tweetstream.py in R.
#              It loads necessary packages, makes a connection to Twitter api and
#              then captures tweets based on your search string
# Author: Jason Canney
# Date: 11/05/2014

# ------ Execute sections of code as instructed by highlighting and running each section

#install the necessary packages
# Run sessionInfo() from your RStudio console to make sure the following packages are not loaded
# Highlight and run the next four lines

install.packages('ROAuth',repos='http://cran.cnr.Berkeley.edu')
install.packages('twitteR', repos='http://cran.cnr.Berkeley.edu')
install.packages('wordcloud', repos='http://cran.cnr.Berkeley.edu')
install.packages('tm', repos='http://cran.cnr.Berkeley.edu')

#load the libraries
#Highlight and run the next four lines to load the libraries into the session
# After you run these lines then run sessionInfo() in the console to see that the packages
# are now active in your session as well as any other required packages for these libraries

library('ROAuth')
library('twitteR')
library('wordcloud')
library('tm')

#download the cert file - Run this single line next
download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.pem")


#to get your consumerKey and consumerSecret see the twitteR documentation for instructions
# put your consumerkey and consumersecret values in here and then highlight next five lines and run
cred <- OAuthFactory$new(consumerKey='z7Fw4JCMnO2haKXljvyyXNGqg',
                         consumerSecret='KfOxmOQXSPS4nJ1rxBuU9oP76jPezWKsPHDMN2g6emZlU6n637',
                         requestURL='https://api.twitter.com/oauth/request_token',
                         accessURL='https://api.twitter.com/oauth/access_token',
                         authURL='https://api.twitter.com/oauth/authorize')

#Required to make the connection with twitter
#highlight and run the next line.  You will be prompted to copy a URL, put it in your web browser
# and approve the authorization of your twitter app.  Do that and then enter the numeric value in your
# RStudio console window and hit enter
cred$handshake(cainfo="cacert.pem")


#Highlight and run next line
save(cred, file="twitter authentication.Rdata")
#Highlight and run next line.  Checks whether your Rstudio session is now ready to search twitter via R
#Should return a TRUE value.  If it does not, go back and run previous steps until you get a TRUE response
registerTwitterOAuth(cred)

#the cainfo parameter is necessary on Windows
twd_stats<- searchTwitter("TWD", n=1500, cainfo="cacert.pem")



#highlight entire function and run next
# function score.sentiment
score.sentiment <- function(sentences, pos.words, neg.words, .progress='none')
{
  # Parameters
  # sentences: vector of text to score
  # pos.words: vector of words of postive sentiment
  # neg.words: vector of words of negative sentiment
  # .progress: passed to laply() to control of progress bar
  
  # create simple array of scores with laply
  scores = laply(sentences,
                 function(sentence, pos.words, neg.words)
                 {
                   # remove punctuation
                   sentence = gsub("[[:punct:]]", "", sentence)
                   # remove control characters
                   sentence = gsub("[[:cntrl:]]", "", sentence)
                   # remove digits?
                   sentence = gsub('\\d+', '', sentence)
                   
                   # define error handling function when trying tolower
                   tryTolower = function(x)
                   {
                     # create missing value
                     y = NA
                     # tryCatch error
                     try_error = tryCatch(tolower(x), error=function(e) e)
                     # if not an error
                     if (!inherits(try_error, "error"))
                       y = tolower(x)
                     # result
                     return(y)
                   }
                   # use tryTolower with sapply 
                   sentence = sapply(sentence, tryTolower)
                   
                   # split sentence into words with str_split (stringr package)
                   word.list = str_split(sentence, "\\s+")
                   words = unlist(word.list)
                   
                   # compare words to the dictionaries of positive & negative terms
                   pos.matches = match(words, pos.words)
                   neg.matches = match(words, neg.words)
                   
                   # get the position of the matched term or NA
                   # we just want a TRUE/FALSE
                   pos.matches = !is.na(pos.matches)
                   neg.matches = !is.na(neg.matches)
                   
                   # final score
                   score = sum(pos.matches) - sum(neg.matches)
                   return(score)
                 }, pos.words, neg.words, .progress=.progress )
  
  # data frame with scores for each sentence
  scores.df = data.frame(text=sentences, score=scores)
  return(scores.df)
}  #Function ends here, this is the end of your highlight



#save text
twd_stats_text <- sapply(twd_stats, function(x) x$getText())
# load in the positive and negative word lists
pos = readLines("positive_words.txt")
neg = readLines("negative_words.txt")
#capture length of stats
nd = c(length(twd_stats))
scores <- score.sentiment(twd_stats, pos, neg, .progress='text')


#create corpus
twd_stats_text_corpus <- Corpus(VectorSource(twd_stats_text))
#clean up
twd_stats_text_corpus <- tm_map(twd_stats_text_corpus, tolower) 
twd_stats_text_corpus <- tm_map(twd_stats_text_corpus, removePunctuation)
twd_stats_text_corpus <- tm_map(twd_stats_text_corpus, function(x)removeWords(x,stopwords()))
wordcloud(twd_stats_text_corpus)


