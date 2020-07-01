#' ---
#' title: "meptweets"
#' author: "Paul Bradshaw"
#' date: "15/05/2019"
#' output: html_document
#' ---
#' 
#' # Analysing MEP tweets
#' 
#' We want to find out what MEPs have been talking about on Twitter. We have two potential data sources: an export from the social media monitoring tool Crowdtangle; and a Twitter scraper we have written in Python. We need to check which one is the best to use, filter the data to UK MEPs, and then identify the most frequently occurring words used by those (and how often).
#' 
#' ## Import the list of accounts
#' 
## ----import json---------------------------------------------------------
#We need the jsonlite package to parse JSON
library(jsonlite)
#Store the API query URL which pulls a list of accounts in JSON format
ukmepaccountsurl <- "https://premium.scraperwiki.com/3epab2y/iyjilhnvxo69dnp/sql/?q=select%20screenname%2C%20name%20from%20mepaccounts%20group%20by%20screenname%20"
#Import that
ukmepaccountlist <- jsonlite::fromJSON(mepaccountsurl)
write.csv(ukmepaccountlist, "ukmepaccounts.csv")

#' 
#' 
#' ## Import the Crowdtangle tweets
#' 
#' Crowdtangle allows you to export all tweets by members of a particular collection of Twitter or Facebook accounts. Although they have no UK MEP collection, they do have a collection of MEP accounts. 
#' 
#' We have generated an export, and then import that into R below:
#' 
## ----read in csv---------------------------------------------------------
meptweetsfile <- "All-MEPs-2014-2019-2018-05-08--2019-05-08.csv"
meptweets <- read.csv(meptweetsfile)

#' 
#' We then generate a list of all the accounts covered by that large dataset, and store that separately to compare:
#' 
## ----create table of usernames-------------------------------------------
mepusernames <- data.frame(table(meptweets$User.Name))

#' 
#' ## Compare the two lists
#' 
#' Next we perform a comparison by joining the two lists.
#' 
## ----inner join Crowdtangle vs scrape------------------------------------
#Import the dplyr library so we can match
library(dplyr)
#Rename the column to match
colnames(mepusernames) <- c("screenname","freq")
#User inner_join from dplyr to merge
ukaccountsmatched <- dplyr::inner_join(mepaccountsjson,mepusernames)

#' 
#' There are only 54 matches, which suggests that the Crowdtangle list is missing quite a few UK MEPs.
#' 
#' In addition, the frequencies suggest that there are more tweets in our scraped version (3,300 in most cases) than the Crowdtangle import for the last 12 months.
#' 
#' ## Importing the tweets from the scraper
#' 
#' Now we start to analyse the tweets grabbed by the scraper. The dataset is very large so we use an API query to only fetch two columns: account name, and tweet text.
#' 
## ----import scrape-------------------------------------------------------
#Store the query URL to get just tweet text and account
ukmeptweetsurl <- "https://premium.scraperwiki.com/3epab2y/iyjilhnvxo69dnp/sql/?q=select%20account%2C%20tweettxt%20from%20meptweets"
ukmeptweets <- jsonlite::fromJSON(ukmeptweetsurl)
head(ukmeptweets)

#' 
#' Let's check what we have, using the package `sqldf` which allows us to use SQL queries on data frames:
#' 
## ----sqldf to generate count by account----------------------------------
library(sqldf)
sqldf::sqldf("SELECT count(*) as tweets, account 
             FROM ukmeptweets
             GROUP BY account
             ORDER BY tweets")

#' 
#' We can also check which ones are not in the list of accounts:
#' 
## ----use setdiff to look for missing MEPs--------------------------------
#Store the results of that query in a data frame
ukmeptweetfreq <- sqldf::sqldf("SELECT count(*) as tweets, account 
             FROM ukmeptweets
             GROUP BY account
             ORDER BY account")

#Check the difference
setdiff(ukmepaccountlist$screenname ,ukmeptweetfreq$account)
#Store
missingmeps <- setdiff(ukmepaccountlist$screenname ,ukmeptweetfreq$account)
print(missingmeps)

#' 
#' ## Filtering out non-serving MEPs
#' 
#' Some of those on that Twitter list are no longer serving MEPs, and in one case the MEP has two accounts, only one of which is verified.
#' 
#' We have manually checked that list and added a column to verify the ones we want to keep. Now we import it and use it as a filter:
#' 
## ----subset to remove non-serving MEPs-----------------------------------
#Import data
ukmepfilter <- read.csv("ukmepaccountsfilter.csv")
#Create a subset for those which are not 'N' in the 'serving' column
servingukmeps <- subset(ukmepfilter, ukmepfilter$serving != "N")
#Reduce to just accountname column
servingukmeps <- servingukmeps[c(2)]

#' 
#' Now we filter the tweets in the same way:
#' 
## ----filter out tweets by non-serving------------------------------------
#First add a column
ukmeptweets.join <- dplyr::inner_join(ukmeptweets,ukmepfilter, by = c("account" = "screenname"))
ukmeptweets.join <- subset(ukmeptweets.join, ukmeptweets.join$serving != "N")
ukmeptweets.join <- ukmeptweets.join[c(1,2,4)]

#' 
#' 
#' 
#' ## Which terms are most common?
#' 
#' We are expecting that words like 'Brexit' might occur particularly frequently. Let's find out which ones.
#' 
#' First, we need to export the column of keywords:
#' 
## ----export as txt-------------------------------------------------------
#This is based on steps outlined in a [blog post by John Victor Anderson](http://johnvictoranderson.org/?p=115). 
write.csv(ukmeptweets.join$tweettxt, 'tweetsastext.txt')

#' 
#' Now we re-import that data as a character object using `scan`:
#' 
## ----import and clean----------------------------------------------------
tweettext <- scan('tweetsastext.txt', what="char", sep=",")
# We convert all text to lower case to prevent any case sensitive issues with counting
tweettext <- tolower(tweettext)
#Repace quotes because each tweet starts and ends with one
tweettext <- gsub('"', '', tweettext)
#Replace new line code with a space
tweettext <- gsub('\n', ' ', tweettext)
#Unescape HTML - first activate the htmltools package
library(htmltools)
#Then run the htmlEscape function
tweettext <- htmltools::htmlEscape(tweettext)
#This doesn't seem to work 100%

#' 
#' We now need to put this through a series of conversions before we can generate a table:
#' 
## ----split on spaces, convert to table-----------------------------------
#Split the text on every space
tweettext.split <- strsplit(tweettext, " ")
#Create a vector
tweettextvec <- unlist(tweettext.split)
#Convert that to a table
tweettexttable <- table(tweettextvec)
#remove the objects created that we no longer need
rm(tweettext.split, tweettextvec)

#' 
#' That table is enough to create a CSV from:
#' 
## ----export and read back as CSV-----------------------------------------
write.csv(tweettexttable, 'tweettexttable.csv')
#read it back in
tweetdata <- read.csv('tweettexttable.csv')
summary(tweetdata)
#rename the columns
colnames(tweetdata) <- c('index', 'word', 'freq' )
summary(tweetdata)

#' 
#' ### Removing stopwords
#' 
#' We could strip out stopwords from our data [using `tidytext`'s stop words](https://stackoverflow.com/questions/43441884/removing-stop-words-with-tidytext?rq=1).
#' 
## ----remove stopwords----------------------------------------------------
#Install tidytext which is needed for get_stopwords() 
library(tidytext)
#Use anti_join with stopwords fetched using get_stopwords to remove those stopwords from tweetdata and put in new object
cleaned_tweetdata <- tweetdata %>%
  anti_join(get_stopwords())

#' 
#' Let's use a simpler approach with `gsub` to remove punctuation
#' 
## ----gsub to replace characters------------------------------------------
#gsub is used to replace any comma with nothing ""
#the results are used to create a new column
cleaned_tweetdata$wordnopunc <- gsub(",","",cleaned_tweetdata$word)
#That new column is overwritten with each new clean
cleaned_tweetdata$wordnopunc <- gsub("-","",cleaned_tweetdata$wordnopunc)
cleaned_tweetdata$wordnopunc <- gsub("!","",cleaned_tweetdata$wordnopunc)
cleaned_tweetdata$wordnopunc <- gsub("'","",cleaned_tweetdata$wordnopunc)
cleaned_tweetdata$wordnopunc <- gsub('"',"",cleaned_tweetdata$wordnopunc)
#This has to be escaped or it replaces all characters
cleaned_tweetdata$wordnopunc <- gsub("\\.","",cleaned_tweetdata$wordnopunc)
cleaned_tweetdata$wordnopunc <- gsub("\\?","",cleaned_tweetdata$wordnopunc)
cleaned_tweetdata$word2 <- NULL

#' 
#' 
#' 
#' ### SQL query: most common words
#' 
#' We can bring the most frequent words to the top using `sqldf`:
#' 
## ----top 100 occurring words---------------------------------------------
sqldf::sqldf('SELECT wordnopunc, freq 
             FROM cleaned_tweetdata
             ORDER BY freq DESC
             LIMIT 100')

#' 
#' And export that as a CSV:
#' 
## ----export frequency list as CSV----------------------------------------
wordfreq <- sqldf::sqldf('SELECT wordnopunc, freq 
             FROM cleaned_tweetdata
             ORDER BY freq DESC
             LIMIT 100')
#
write.csv(wordfreq, "wordfreq.csv")

#' 
#' ## Adding back capitalisation 
#' 
#' There are some words where capitalisation may be meaningful. For example 'EU' vs 'eu' (most likely in a URL) and 'may' versus (Theresa) 'May'. Let's re-run some code but with the `tolower()` function removing capitalisation commented out:
#' 
## ------------------------------------------------------------------------
tweettext <- scan('tweetsastext.txt', what="char", sep=",")
# We convert all text to lower case to prevent any case sensitive issues with counting
#tweettext <- tolower(tweettext)
#Repace quotes because each tweet starts and ends with one
tweettext <- gsub('"', '', tweettext)
#Replace new line code with a space
tweettext <- gsub('\n', ' ', tweettext)
#Unescape HTML - first activate the htmltools package
library(htmltools)
#Then run the htmlEscape function
tweettext <- htmltools::htmlEscape(tweettext)
#This doesn't seem to work 100%

#' 
#' 
## ------------------------------------------------------------------------
#Split the text on every space
tweettext.split <- strsplit(tweettext, " ")
#Create a vector
tweettextvec <- unlist(tweettext.split)
#Convert that to a table
tweettexttable <- table(tweettextvec)
#remove the objects created that we no longer need
rm(tweettext.split, tweettextvec)

#' 
#' That table is enough to create a CSV from:
#' 
## ------------------------------------------------------------------------
write.csv(tweettexttable, 'tweettexttable.csv')
#read it back in
tweetdata <- read.csv('tweettexttable.csv')
summary(tweetdata)
#rename the columns
colnames(tweetdata) <- c('index', 'word', 'freq' )
summary(tweetdata)

#Install tidytext which is needed for get_stopwords() 
library(tidytext)
#Use anti_join with stopwords fetched using get_stopwords to remove those stopwords from tweetdata and put in new object
cleaned_tweetdata <- tweetdata %>%
  anti_join(get_stopwords())

#gsub is used to replace any comma with nothing ""
#the results are used to create a new column
cleaned_tweetdata$wordnopunc <- gsub(",","",cleaned_tweetdata$word)
#That new column is overwritten with each new clean
cleaned_tweetdata$wordnopunc <- gsub("-","",cleaned_tweetdata$wordnopunc)
cleaned_tweetdata$wordnopunc <- gsub("!","",cleaned_tweetdata$wordnopunc)
cleaned_tweetdata$wordnopunc <- gsub("'","",cleaned_tweetdata$wordnopunc)
cleaned_tweetdata$wordnopunc <- gsub('"',"",cleaned_tweetdata$wordnopunc)
#This has to be escaped or it replaces all characters
cleaned_tweetdata$wordnopunc <- gsub("\\.","",cleaned_tweetdata$wordnopunc)
cleaned_tweetdata$wordnopunc <- gsub("\\?","",cleaned_tweetdata$wordnopunc)
cleaned_tweetdata$word2 <- NULL

#' 
#' Again, bring the most frequent words to the top using `sqldf`:
#' 
## ------------------------------------------------------------------------
wordfreq.capitalised <- sqldf::sqldf('SELECT wordnopunc, freq 
             FROM cleaned_tweetdata
             ORDER BY freq DESC
             LIMIT 100')
#
write.csv(wordfreq.capitalised, "wordfreqcap.csv")

#' 
#' ## Combining lower case and capitalised counts
#' 
#' We can also combine the two:
#' 
## ----inner join to combine lower case and mixed case freqs---------------
wordfreq.capitalised$lower <- tolower(wordfreq.capitalised$wordnopunc)
wordfreq.both <- dplyr::inner_join(wordfreq, wordfreq.capitalised, by = c("wordnopunc" = "lower"))
write.csv(wordfreq.both, "wordfrequpperandlower.csv")

#' 
#' ## Tweets, not mentions
#' 
#' So far we've counted mentions of terms rather than how many tweets might contain a term. For example, a single tweet might mention a word more than once.
#' 
## ------------------------------------------------------------------------
#Generate a TRUE/FALSE column which returns true if 'rexit' is anywhere in the text
ukmeptweets.join$brexit <- grepl("Brexit|brexit", ukmeptweets.join$tweettxt)
#Show a summary
table(ukmeptweets.join$brexit)

#' 
#' This is surprisingly high - there are only around 16,000 mentions of Brexit and #Brexit. Perhaps variations like brexiteer are being picked up?
#' 
## ------------------------------------------------------------------------
#Generate a TRUE/FALSE column which returns true if 'rexit' is anywhere in the text
ukmeptweets.join$brexiteer <- grepl("rexiteer", ukmeptweets.join$tweettxt)
#Show a summary
table(ukmeptweets.join$brexiteer)

#' 
#' That accounts for some. What if we add a space?
#' 
## ------------------------------------------------------------------------
#Generate a TRUE/FALSE column which returns true if 'rexit' is anywhere in the text
ukmeptweets.join$brexit <- grepl("Brexit |brexit ", ukmeptweets.join$tweettxt)
#Show a summary
table(ukmeptweets.join$brexit)

#' 
#' That's more like what we are expecting.
#' 
#' So what are these mentions of Brexit where the next character is not a space, and it's not 'brexiteer'? We can create an extract and then export it to quickly analyse.
#' 
## ------------------------------------------------------------------------
#Generate a TRUE/FALSE column which returns true if 'rexit' is anywhere in the text
ukmeptweets.join$brexit <- grepl("Brexit|brexit", ukmeptweets.join$tweettxt)
#Show a summary
table(ukmeptweets.join$brexit)

brexitmentions <- subset(ukmeptweets.join, ukmeptweets.join$brexit)
write.csv(brexitmentions, "brexitmentions.csv")

#' 
#' Analysis in Excel shows that many of the mentions not followed by a space are usernames (@BrexitBattalion), and hashtags (#brexitbetrayal).
#' 
#' ## Analysing hashtags
#' 
#' There are less than 10 hashtags in the top 1000 most frequently occurring words, but we can focus specifically on hashtags by using the `LEFTSTR` command in SQL to extract the first character of each word, and then only looking at those where that character is a hash:
#' 
## ----only hashtags-------------------------------------------------------
wordfreq1 <- sqldf::sqldf('SELECT wordnopunc, LEFTSTR(wordnopunc, 1) as firstchar, freq 
             FROM cleaned_tweetdata
            WHERE firstchar = "#"
             ORDER BY freq DESC
             LIMIT 100')

print(wordfreq1)

