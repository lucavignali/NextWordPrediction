
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(markdown)
library(nlme)
library(mgcv)


shinyUI(navbarPage("Natural Language Processing",
                   
                   # Beginning of Prediction page
                   tabPanel("Predict Next Word",
                      titlePanel("Write your sentence"),
                      sidebarLayout(
                        sidebarPanel(
                          textInput("textid", label = "Text Input", value = NULL),
                          submitButton("Predict Next Word"),
                          tags$hr(),
                          p('Please read Description and Instructions tabs.'),
                          p('Want to have fun? Read the Have Fun tab.')
                        ),
                        mainPanel(h1("Prediction:"),
                          h3(textOutput("predict"))
                        )
                      )
                   ),
                   # End of Prediction page
                   
                   # Beginning of Welcome Page
                   
                   tabPanel("Description",
                            pre(includeMarkdown("Description.txt"))
                   ),
                   # End of Welcome Page
                   
                   # Beginning of INstructions page
                   tabPanel("Instructions",
                            pre(includeMarkdown("Instructions.txt"))
                   ),
                   # End of Instructions page
                   
                   # Beginning of Have Fun page
                   tabPanel("Have Fun",
                            pre(includeMarkdown("HaveFun.txt"))
                   )
                   # End of Have Fun page
                   
))         

  
                
