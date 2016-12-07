# Course project assignment

library(markdown)

shinyUI(navbarPage("Regression Analysis",

# Beginning of Initial documentation

                  tabPanel("Read Me",
                           pre(includeMarkdown("Description.txt"))
                  ),
# End of Initial documentation
                                      
# Beginning of Load File tab 

                   tabPanel("Select Variables",
                     titlePanel("Select File"),
                       sidebarLayout(
                            sidebarPanel(
      fileInput('file1', 'Choose csv file with Header to upload. 1 MByte maximum',
                accept = c(
                  'text/csv',
                  'text/comma-separated-values',
                  'text/tab-separated-values',
                  'text/plain',
                  '.csv',
                  '.tsv'
                )
      ),
#      tags$hr(),
#      checkboxInput('header', 'Header', TRUE),
#      radioButtons('sep', 'Separator',
#                   c(Comma=',',
#                     Semicolon=';',
#                     Tab='\t'),
#                   ','),
      tags$hr(),
      textInput("SelectX", "Select name of the column to be used as Predictor (X-axis)"),
      textInput("SelectY", "Select name of the column to be used as Outcome (Y-axis)"),
      submitButton("Enter"),

      tags$hr(),      
      p('you can find a sample of csv here',
  a(href = 'https://internal.shinyapps.io/gallery/066-upload-file/mtcars.csv', 'mtcars.csv')
  )

    ),
    mainPanel(
      tableOutput('contents')
    )
  )
),
## end of Load File Tab

## Beginning of Plot XY Tab

## tabPanel("Plot XY",
##         plotOutput('dataplot')
## ),

## End of Plot XY Tab

# Beginning of Prediction tab
tabPanel("Prediction",
         sidebarLayout(
           sidebarPanel(
             numericInput("confidence", "Level of Confidence", value = 0.95,
                          min = 0.05, max = 0.99, step = 0.05),
             p("Input the level of confidence (e.g. 0.9)"),
             submitButton("Calcuate and Plot Prediction Area")
           ),
             mainPanel(
               fluidRow(
                 column(12,plotOutput('predictplot'))
                 ),
    
             fluidRow(
                 column(12,plotOutput('predictplot2')))
            
            )
             
           )
           )
## End of Prediction Tab

  ))
