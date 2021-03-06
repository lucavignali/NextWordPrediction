# Next Word Prediction
The final project of the Data Science 9 courses program from Johns Hopkins University, I completed in 2014, included the development of  implementation of Natural Language Processing to predict the Next Word in a Sentence.

__The Challenge__

The challange of this project can be summarized with the following questions:

How can you predict the next word following a given uncomplete sentence?
Can you do it from a provided set of:

1. 2.3 Million Tweets
1. 900 Thousand Blog
1. 77 Thousand piece of news?

Can you create an efficient algorithm that makes use of limited amount of memory and provide prediction in a reasonable period of time?

The description of the developed Shiny App, is available [here](https://rpubs.com/lvignali/170990), while the Shiny App it self is [here](https://lvignali.shinyapps.io/Capstone_NLP/).

The algorithm is very simple and it is based on 4-ngram recognition. 

__Do you want to have (moderate) fun with this App?__

When I tested this App, I started writing simple common sentences start like “I want”, “I am”, “I think”, “My Mother”, pushed Predict Next Word to obtain the prediction.
Then I added the predicted word to the Text Input and pushed again the Predict Next Word and so on. 

For example start with:

1. “I think”, push predict and obtain “I”

2. Add “I” in the Text input, so that the new sentence is “I think I” and predict again, obtain “am”.

3. Add “am” in the Text input. Now you have “I think I am”. Predict the next word and repeat the same process again and again.

If you repeat the process a number of times, you can obtain a sentence that you can imagine being generated by the guy called Algorithm and start to be familiar with him/her, start to know what he/she likes, thinks….

Of course this is just a joke to have “moderate” fun with this App.
Enjoy it!


