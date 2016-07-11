#This is the server script that contains the instructions that server needs to build the application.
#author Apoorva Balasubramanian

getwd()
#setwd("C:\\Users\\apoorva\\Desktop\\ProjectDocumentation\\Code")
library(shiny)
install.packages("randomForest")
library(randomForest)


shinyServer(
  function(input, output){
    
    # Importing Dataset
    Newtrain <- read.csv("Newtrain.csv", stringsAsFactors=FALSE)
    Newtest <- read.csv("Newtest.csv", stringsAsFactors=FALSE)
    
    #Random-forest algorithm implementation
    ########################################################
    
    #setting correct column datatype
    Newtrain$TweetsPerDay <- as.numeric(Newtrain$TweetsPerDay)
    Newtrain$SimilarTweets <- as.numeric(Newtrain$SimilarTweets)
    Newtrain$AccountType <- as.factor(Newtrain$AccountType)
    Newtrain$Account <- as.factor(Newtrain$Account)
    
    
    # Set a random seed
    set.seed(107)
  
    # Build the model
    rf_mod <- randomForest(AccountType~TweetsPerDay+SimilarTweets, 
                           data = Newtrain, 
                           ntree = 100, 
                           na.action = na.omit)
    
    # Predict using the test set
    prediction <- predict(rf_mod, Newtest, type = 'vote')
    
    # Save the solution to a dataframe
    solution <- data.frame('Account' = Newtest$Account, prediction)
    
    ########################################################
    
    #Reactive input for choosing the dropdown input
    choicetype = reactive(as.numeric(input$var))
    
    #Summary
    output$summ <- renderPrint({
      if(choicetype() == 1){
        summary(Newtrain)
      }else{
        summary(Newtest)
      }
    })
    
    #Structure
    output$struct <- renderPrint({
      if(choicetype() == 1){
        str(Newtrain)
      }else{
        str(Newtest)
      }
    })
    
    #Data
    output$data <- renderTable({
    if(choicetype() == 1){
      Newtrain
    }else{
      Newtest
    }
    })
    
    output$sol <- renderTable({
      solution
    })
    
    # "Test yourself" section begins
    
    reactive({
    Tweets <- renderText({input$TweetsPerDay})
   # df <- renderTable(x)
    SimilarTweets <- renderText({input$SimilarTweets})
  #  df <- data.frame(Tweets,SimilarTweets)
    
    })
    
    # Predict using the user input
  # useroutput <- predict(rf_mod, df, type = 'vote')
    
    # Save the solution to a dataframe
  # predicteduser <- data.frame(useroutput)
  }
)
