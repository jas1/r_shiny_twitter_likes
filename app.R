
# install.packages("rtweet")
# install.packages("magrittr")
# install.packages("dplyr")
# install.packages("DT")
# install.packages("shiny")
# install.packages("tidyr")

library(rtweet)
library(magrittr)
library(dplyr)
library(DT)
library(tidyr)
library(shiny)

# -------------------------- r twitter setup

# look at how to generate twitter token to an RDS file.
# http://rtweet.info/articles/auth.html

tw_token <- readRDS("twitter_token.rds")

# -------------------------- data preparation

populate_for_user <- function( user_name ){
  # issue 1: as limited to 199 @ 20201509-1052 : i'll try to paginate the searches.
  # colnames(lookup_users(user_name))
  # http://rtweet.info/reference/lookup_users.html
  my_like_count <- lookup_users(user_name)$favourites_count
  current_api_max <- 199 # trial and error: 500 > 400 > 300 > 200 > 100 > 150 > 199
  
  # amount of searches needed to get all likes.
  max_pages <- ceiling(my_like_count / current_api_max) 
  
  
  like_acumulator <- data.frame(status_id=c(),created_at=c(), screen_name=c(), text=c(), urls_expanded_url=c()) %>% as_tibble()
  # TODO: help on vectorizing this U_U
  # problem 2: issue wit the rtweet: https://github.com/mkearney/rtweet/issues/200 
  offset <- NA
  for (idx in 1:max_pages) {
    
    if (is.na(offset)) {
      my_likes  <- get_favorites(user_name,n=current_api_max) %>% 
        select("status_id","created_at", "screen_name", "text", "urls_expanded_url") %>%
        arrange(desc(created_at))
      
      like_acumulator <- like_acumulator %>% bind_rows(my_likes)
    }else{
      
      my_likes  <- get_favorites(user_name,n=current_api_max,max_id = offset) %>% 
        select("status_id","created_at", "screen_name", "text", "urls_expanded_url") %>%
        arrange(desc(created_at))
      
      like_acumulator <- like_acumulator %>% bind_rows(my_likes)
      
    }
    offset <- max(like_acumulator$status_id)
    
  }
  # like_acumulator %>% group_by(status_id) %>% tally() %>% filter(n>1)
  df_data <-  like_acumulator %>% unique() %>%
    unnest(urls_expanded_url) %>% 
    mutate(url=if_else(is.na(urls_expanded_url),"",
                       paste0("<p><a href='",urls_expanded_url,"'>",urls_expanded_url,"</a></p>"))) %>% 
    group_by(status_id,created_at,screen_name,text) %>% 
    summarise(urls = paste(url,collapse='') )
  
  df_data
}

# -------------------------- shiny app


# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Twitter Likes: Warning this queries twitter directly!"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        textInput("user_name", "User"),
        actionButton("get_tweets", "Get Tweets!")
      ),
      # Show a plot of the generated distribution
      mainPanel( DT::dataTableOutput("twitter_data") )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  values <- reactiveValues(df_data = NULL)
  
  # https://stackoverflow.com/questions/29716868/r-shiny-how-to-get-an-reactive-data-frame-updated-each-time-pressing-an-actionb
  observeEvent(input$get_tweets, {
    req(input$user_name)
    req(input$get_tweets)
    
    input$get_tweets
    user_name <- input$user_name

    # like_acumulator %>% group_by(status_id) %>% tally() %>% filter(n>1)
    values$df_data <- populate_for_user(user_name)
  })
  
  output$twitter_data <- DT::renderDataTable({
   DT::datatable(values$df_data,escape = FALSE)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
