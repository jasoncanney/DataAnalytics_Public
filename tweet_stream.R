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
install.packages("RJSONIO", repos='http://cran.cnr.Berkeley.edu')

#load the libraries
#Highlight and run the next four lines to load the libraries into the session
# After you run these lines then run sessionInfo() in the console to see that the packages
# are now active in your session as well as any other required packages for these libraries

library('ROAuth')
library('twitteR')
library('wordcloud')
library('tm')
library('RJSONIO')

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

#Capture the tweets
tweet_stats<- searchTwitter("TWD", n=1500, cainfo="cacert.pem")

#save just the text from the tweets
tweet_stats_text <- sapply(tweet_stats, function(x) x$getText())