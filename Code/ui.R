#this is the UI script that controls the layout and appearance of the application. 
#author Apoorva Balasubramanian


library(shiny)

shinyUI(fluidPage(
  titlePanel(title = h1("PREDICTING HUMAN OR BOT", align ="center")),
  sidebarLayout(
    #Left side panel for user input
    sidebarPanel(("Select from the following dataset"),
                 selectInput("var", "Dataset", choices = c("Training Data" = 1, "Test Data" = 2)),
                 br(),
                 br(),
                 ("Test Yourself:"),
                 numericInput("TweetsPerDay", "Enter the number of average tweets per day", ""),
                 numericInput("SimilarTweets","Enter the count of similar tweets", ""),
                 submitButton("Submit")
                 ),
    
    #Right side panel for displaying output
      mainPanel(
                textOutput("tweetsperdayoutput"),
                textOutput("Similartweetsoutput"),
                
                tabsetPanel(type ="tab",
                            tabPanel("Summary",verbatimTextOutput("summ")),
                            tabPanel("Structure", verbatimTextOutput("struct")),
                            tabPanel("Data",tableOutput("data")),
                            tabPanel("Result", tableOutput("sol")),
                            tabPanel("Plot")
                )
                )
    )
  )
)
  
