# Description: This file is meant to recreate the tweet_sentiment.py in R.
#              It loads a function to do the sentiment scoring
#              Needs work beyond function
# Author: Jason Canney
# Date: 11/05/2014

# ------ Execute sections of code as instructed by highlighting and running each section


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



