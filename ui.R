library(shiny)
require(caret)
require(dplyr)

# Define UI for final project
shinyUI(
    navbarPage('Final Project for Developing Data Products',
        tabPanel('Description',
        titlePanel('Classification of iris flowers'),
        h4('Introduction'),
        p('A simple algorithm is implemented to classify an iris flower based on size features. 
            The algorithm is implemented visually to facilitate its understanding to the user. 
            The classification is performed using the k-nearest neighbors algorithm, and 
            the training set comes from the Iris set included in the datasets package.'
        ), 
        h4('Data'),
        p('Data from the Iris flowers dataset is used to train the algorithm. 
            The data consists of 4 numerical features: Sepal Length, Sepal Width, Petal Length, and Petal Width; 
            and a categorical variable: Species. The Species variable has three possible values: Setosa, Versicolor and Virginica.
            Species is the predicted variable.'
        ), 
        h4('Algorithm'),
        p('The data is transformed using', a('principal component analysis', 
            href = 'http://en.wikipedia.org/wiki/Principal_component_analysis'), 
            '(PCA), keeping only the first two principal components.
            Then, we take new measurements of Sepal.Width, Sepal.Length, Petal.Width and Petal.Length and project them
            to the principal component (PC) space. We obtain two measurements with this projection: 
            the first and second principal components for the measurements, PC1 and PC2. These are the values
            we are interested in.'
            ),
        p('Once we have the PC1 and PC2 values for a new set of measurements, we plot them in a graph and 
            calculate how close they are to the centers of the clusters that correspond to each iris flower.
            We calculate the distance to each cluster with the', a('Mahalanobis distance.', 
                href = 'http://en.wikipedia.org/wiki/Mahalanobis_distance'), 
            'A point is classified as the flower with the nearest center with the point.'
        ),
        h4('Instructions'),
        p('The classification application is in the Application tab on the top. 
            The values for the variables are selected with the slider. 
            Every time the slider is moved, the new point is projected onto the PC space of the flower data.
            The distance to the cluster centers is calculated and the color and name of the point changes 
            to that one of the nearest flower cluster center.'
        ),
        p('You move the point around and see how it is classified according to its proximity to the center of a cluster.'
        ),
        h4('Source Code'),
        p('The repository for the app code is in', a('Github.', href = 'https://github.com/alcala21/dataProductApp'))
        ),
        tabPanel('Application',
        titlePanel('Classification of iris flowers'),
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
      )
))