
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(tm)
library(ngram)
library(stringr)
library(tau)


corpus_en <- readRDS("optimized_corpus")
ngram1.df <- readRDS("ngram1.rds")


shinyServer(function(input, output) {

  
  output$predict <- renderText({
  
    if(input$textid == ""){
    
      return(NULL)
    }
      
    S <- input$textid
    
    
    
    
    ######### BEGIN OF ALGORITHM ################
    
    
    ### FIRST MATCH  try to match 4-grams with stopwords
    last_4_gram <- preprocess(word(gsub("[[:punct:]]", "",S),-4,-1), case = "lower")
    last_4_gram <- paste0(" ",last_4_gram, " ")
    match_4 <- grep(last_4_gram,corpus_en)
    match <- match_4
    last_n_ngram <- last_4_gram
    next_word <- character()
    predict_n <- 1L
    for(i in match) {
      next_word <- rbind(next_word,
                         word(unlist(str_split(corpus_en[i], last_n_ngram, 2))[2],1,predict_n))
    }
    
    r<-textcnt(next_word, method="string",n=predict_n,split = "[[:space:][:punct:]]+", 
               decreasing = TRUE)
    r.df<-data.frame(counts = unclass(r), size = nchar(names(r)))
    
    guess <- data.frame(word = row.names(r.df), prob = r.df$counts / sum(r.df$counts))
    
    # if the probability of the first word is  higher than twice the second then select it
    # if (nrow(best_4) > 1) {
    #  if(best_4$prob[1] > 2*best_4$prob[2]) guess <- rbind(guess,best_4)
    # }
    
    # if (nrow(best_4) == 1) {
    #  guess <- rbind(guess,best_4[1,])
    # }
    
    ### SECOND MATCH  try to match 3-grams with stopwords
    if(nrow(guess) <= 10) {
      last_3_gram <- preprocess(word(gsub("[[:punct:]]", "",S),-3,-1), case = "lower")
      last_3_gram <- paste0(" ",last_3_gram, " ")
      match_3 <- grep(last_3_gram,corpus_en)
      match <- match_3
      last_n_ngram <- last_3_gram
      next_word <- character()
      predict_n <- 1L
      for(i in match) {
        next_word <- rbind(next_word,
                           word(unlist(str_split(corpus_en[i], last_n_ngram, 2))[2],1,predict_n))
      }
      
      r<-textcnt(next_word, method="string",n=predict_n,split = "[[:space:][:punct:]]+", 
                 decreasing = TRUE)
      r.df<-data.frame(counts = unclass(r), size = nchar(names(r)))
      
      best_3 <- data.frame(word = row.names(r.df), prob = r.df$counts / sum(r.df$counts))
      guess <- rbind(guess,best_3)
    }
    
    # if the probability of the first word is  higher than other mathes then propose it.
    # if (nrow(best_3) > 1) {
    # if(best_3$prob[1] > 2*best_3$prob[2]) guess <- rbind(guess,best_3[1,])
    # }
    # if (nrow(best_3) == 1) {
    #  guess <- rbind(guess,best_3[1,])
    # }
    
    ### THIRD MATCH  try to match 2-grams with stopwords
    if(nrow(guess) <=10){
      last_2_gram <- preprocess(word(gsub("[[:punct:]]", "",S),-2,-1), case = "lower")
      last_2_gram <- paste0(" ",last_2_gram, " ")
      match_2 <- grep(last_2_gram,corpus_en)
      match <- match_2
      last_n_ngram <- last_2_gram
      next_word <- character()
      predict_n <- 1L
      for(i in match) {
        next_word <- rbind(next_word,
                           word(unlist(str_split(corpus_en[i], last_n_ngram, 2))[2],1,predict_n))
      }
      
      r<-textcnt(next_word, method="string",n=predict_n,split = "[[:space:][:punct:]]+", 
                 decreasing = TRUE)
      r.df<-data.frame(counts = unclass(r), size = nchar(names(r)))
      
      best_2 <- data.frame(word = row.names(r.df), prob = r.df$counts / sum(r.df$counts))
      guess <- rbind(guess,best_2)
    }
    # if the probability of the first word is  higher than other mathes then propose it.
    # if (nrow(best_2) > 1) {
    #  if(best_2$prob[1] > 2*best_2$prob[2]) guess <- rbind(guess,best_2[1,])
    # }
    
    # if (nrow(best_2) == 1) {
    #  guess <- rbind(guess,best_2[1,])
    # }
    
    # Sum probabilities from different n_grams
    if(nrow(guess) > 0){
      guess <- aggregate(prob ~ word, guess, sum)
      guess <- guess[order(guess$prob, decreasing = TRUE),]
    }
    
    out <- as.character(head(guess$word,1))
    
    
    # In the case there is no match, guess based just on words probability.
    # Do not consider stopwords.
    # Read Full Corpus with lower case, no punctuations and without stopwords
    # corpus_en_2 <- readRDS("corpus_en_lower_no_punct_no_stopw")
    
    
    if(length(out) == 0) {
      out <- sample(row.names(ngram1.df), 1, prob = ngram1.df$counts)
    }
    
    return(out)
    
    ######### END OF ALGORITHM ################
    })
  
})
