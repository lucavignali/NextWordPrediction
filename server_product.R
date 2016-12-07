
# By default, the file size limit is 5MB. It can be changed by
# setting this option. Here we'll raise limit to 1MB.
options(shiny.maxRequestSize =1*1024^2)
library(caret)
library(ggplot2)
library(markdown)

shinyServer(function(input, output) {
  
  
  output$contents <- renderTable({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    read.csv(inFile$datapath)
  })

# Reactive Function to load Predictor x and Outcome y in data frame XY BEGIN
  load_data <- reactive({
    
    inFile <- input$file1
    if (is.null(inFile))
      return(NULL)
    
    
    dataframe <- read.csv(inFile$datapath)
    inX <- input$SelectX
    inY <- input$SelectY
    if(is.null(inX) | is.null(inY))
      return(NULL)
    
    x <- as.numeric(dataframe[,inX])
    y <- as.numeric(dataframe[,inY])
    
    out <- data.frame(x,y)
    names(out) <- c(inX,inY)
    return(list(out))
    
    })
  # Reactive Function to load Predictor x and Outcome y in data frame XY BEGIN  
  
  output$predictplot <- renderPlot({
   
    XY <- as.data.frame(load_data()[1])
    if(nrow(XY) == 0)
      return(NULL)
    
    
#    inX <- input$SelectX
#    inY <- input$SelectY
#    if(is.null(inX) | is.null(inY))
#      return(NULL)
    
#    x <- as.numeric(dataframe[,inX])
#    y <- as.numeric(dataframe[,inY])
#    XY <- data.frame(x=x,y=y)

# Create a Local Polynomial Regression Model
    yname <- names(XY)[2]
    xname <- names(XY)[1]
    names(XY) <- c("x","y")
    
    loess_model <- loess(y ~ x, data = XY)
    
 ##   lin_model <- train(y ~ x, data=XY, method = "lm")
   
#  conf_level <- input$confidence
    
  conf_level <- input$confidence
 
  
  g <-  ggplot(data=XY, aes(x,y)) + geom_point() + 
      labs(x = xname, y = yname) +
      ggtitle("Plot of selected variables, confidence interval and fitted values")
  g <- g + geom_smooth(method="loess", level = conf_level, linetype = 0)  
  
# plot the fitted point from loess
  df <- data.frame(x = loess_model$x, ydf = loess_model$fitted)
  g <- g + geom_point(data = df, aes(x,ydf), col = "red", size = 1)
    
  plot(g)
  
  })
  
#end of predict1  
  
  output$predictplot2 <- renderPlot({
    
    XY <- as.data.frame(load_data()[1])
    if(nrow(XY) == 0)
      return(NULL)
    
    yname <- names(XY)[2]
    xname <- names(XY)[1]
    names(XY) <- c("x","y")
    
    loess_model <- loess(y ~ x, data = XY)

    
######### Change this part    
    
    # plot the fitted point from loess
    
    df <- data.frame(x = loess_model$fitted, ydf = loess_model$residuals)
    g <- ggplot(df,aes(x,ydf)) + geom_point() +
      labs(x = "Fitted Values", y = "Residuals") +
      ggtitle("Plot of Residuals")
    
    plot(g)
########## Change this part
        
    
  })
# end of predict2  
  
})