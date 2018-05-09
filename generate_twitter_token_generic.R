## DISCLAIMER --------------

# based on http://rtweet.info/articles/auth.html

## USE ---------------

# its recomemnded that you create a new file with this contents. ( copy / paste / changename )
# in the new file adapt the code to your twitter values.
# in case you share the project via git: ADD THE NEW FILE NAME TO .gitignore
# in case you share the project in other way: remember to delete all the stuff as described on .gitignore
# else you'll be sharing what might be personal data.


## CODE --------------

## whatever name you assigned to your created app
appname <- "your_app_name" 

## api key
key <- "your_api_key"

## api secret
secret <- "your_api_secret"

## create token named "twitter_token"
twitter_token <- create_token(
  app = appname,
  consumer_key = key,
  consumer_secret = secret)

## path of home directory 
# home_directory <- path.expand("~/") 
# i excluded this as i got it on the project folder.
# REMEBER TO ADD IT TO GIT IGNORE, else you'll be sharing your key publicly.

## combine with name for token
# file_name <- file.path(home_directory, "twitter_token.rds")
file_name <- file.path( "twitter_token.rds") # i changed this to store in the project folder.

## save token to directory
saveRDS(twitter_token, file = file_name) 