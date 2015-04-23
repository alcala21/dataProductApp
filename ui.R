library(shiny)
require(caret)
require(dplyr)

# Define UI for PCA plots
shinyUI(pageWithSidebar(
  headerPanel('Classification of iris flowers'),
  sidebarPanel(    
    sliderInput('Sepal.Length', 'Sepal Length', 
    	min = min(myData$Sepal.Length), 
    	max = max(myData$Sepal.Length), 
    	value = round(mean(myData$Sepal.Length), digits = 2), 
    	step = 0.1
    	), 
    sliderInput('Sepal.Width', 'Sepal Width', 
    	min = min(myData$Sepal.Width), 
    	max = max(myData$Sepal.Width), 
    	value = round(mean(myData$Sepal.Width), digits = 2), 
    	step = 0.1
    	), 
	sliderInput('Petal.Length', 'Petal Length', 
    	min = min(myData$Petal.Length), 
    	max = max(myData$Petal.Length), 
    	value = round(mean(myData$Petal.Length), digits = 2), 
    	step = 0.1
    	), 
	sliderInput('Petal.Width', 'Petal Width', 
    	min = min(myData$Petal.Width), 
    	max = max(myData$Petal.Width), 
    	value = round(mean(myData$Petal.Width), digits = 2), 
    	step = 0.1
    	)
  ),
  mainPanel(
    plotOutput('pcPlot', height = '480px')
  )
))