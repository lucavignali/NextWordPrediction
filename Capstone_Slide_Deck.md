Predict Next Word
========================================================
author: Luca Vignali
css: styles.css
date: April 2016
autosize: true

<small>
[View presentation in Rpubs if you prefer](https://rpubs.com/lvignali/170990)
</small>

The Challenge
========================================================
The challange of this project can be summarized with the following questions:

* How can you predict the next word following a given uncomplete sentence?
* Can you do it from a provided set of:
  * 2.3 Million Tweets
  * 900 Thousand Blog
  * 77 Thousand piece of news?
* Can you create an efficient algorithm that makes use of limited amount of memory and provide prediction in a reasonable period of time?



The Proposed Solution
=======================================================
<small>
The Algorithm consists of five steps as described below, and it is based on the last n-grams of the sentence of which we want to predict the next word:

1. Match the 4-gram and list the words following the 4-gram. Each match is whighted by a kind of probability that is the ratio between all N matching of the 4-gram and the N_w matching of the specific word.

2. In the case the previous point is providing less than 10 results, perform the same action with 3-gram. Add the 3-gram results to the 4-gram results.

3. In the case the previous points are providing less than 10 results, perform the same action with 2-gram. Add the 2-gram results to the previous results.

4. If there is no matching in the previous steps, we use the corpora in a pure statistical way. That is proposing three words (excluding standard words provided by stopwords function in package "tm") with the same probability it appears in the text corpus.

5. As asked in the Capstone project we show most likely result (word), even if the algorithm can show three top matching. 

</small>


Algorithm Performance
========================================================
As one of the challenges was to limit the usage of memory and time to provide the next word prediction, we introduced **BOOST** a parameter **to tune the "complexity"** of the algortihm and thus identify the best trade-off between _performance_ and _memory_ consumption, depending on the application and host that would run the algortihm.

**BOOST** is simply a number that represents how much faster we want to obtain the prediction compared to standard basic algorithm. It simply reduces - by sub-sampling - the size of the word corpus - and thus memory footprint - used for prediction exactly by the factor BOOST. 

In the deployed algortihm in shiny, we tried several BOOST values and selected 8 in order to:

* Limit the memory footprint to 23 Mbyte.
* Limit the response time of the Algorithm to few seconds.



The Shiny App
========================================================
To use The App deployed in Shiny implementing the above algorithm
just type your sentence in the Text Input, press **Predict Next Word** button and wait typically few seconds.

![The Shiny App](App_GUI.png)

[Go to the App in Shiny](https://lvignali.shinyapps.io/Capstone_NLP/)


