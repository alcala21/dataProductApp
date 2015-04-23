# Load libraries
libraryNames <- c('dplyr', 'ggplot2', 'caret', 'datasets')
a <- sapply(libraryNames, require, character.only = TRUE)

myData <- iris

pcaModel <- preProcess(myData[, -5], method = 'pca')

loadings <- predict(pcaModel, myData[, -5])

loadings$Species <- myData$Species

get_distance <- function(statList, newLoading) {
	invMat <- statList$invCov[[1]]
	meanVec <- statList$meanVal[[1]]
	diffVec <- unlist(newLoading - meanVec)
	# Mahalanobis Distance
	distance <- t(diffVec) %*% invMat %*% diffVec
	output <- data.frame(Species = statList$Species, Distance = distance[1, 1])
	return(output)
}