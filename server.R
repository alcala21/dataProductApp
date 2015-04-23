library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {	
	
	speciesColor <- c(setosa = "#00BA38", versicolor = "#F8766D", virginica = "#619CFF")

	centers <- loadings %>% group_by(Species) %>% summarise_each(funs(mean))
	basePlot <- loadings %>% ggplot(aes(x = PC1, y = PC2, colour = Species)) + geom_point() +
		scale_colour_manual(values = speciesColor)		
	basePlot <- basePlot + geom_point(data = centers, aes(fill = Species), size = 5)
	
	speciesList <- loadings %>% group_by(Species) %>% do(invCov = solve(cov(.[-3])), meanVal = apply(.[-3], 2, mean))

	updatedData <- reactive({
		newpoint <- data.frame(Sepal.Length = input$Sepal.Length, 
			Sepal.Width = input$Sepal.Width,
			Petal.Length = input$Petal.Length,
			Petal.Width = input$Petal.Width)	    

		newLoading <- predict(pcaModel, newpoint)

		distanceFrame <- data.frame();
		for (i in 1:nrow(speciesList)) {
			x <- speciesList[i, ]
			distanceFrame <- rbind(distanceFrame, get_distance(x, newLoading))
		}
		Species <- distanceFrame$Species[which.min(distanceFrame$Distance)]

		cbind(newLoading, Species)		
	  })
	
	output$pcPlot <- renderPlot({		
		basePlot + geom_point(data = updatedData(), colour = speciesColor[updatedData()$Species], size = 4) + 
			annotate('text', x = updatedData()$PC1, y = updatedData()$PC2+0.2, label = updatedData()$Species)
		})
})