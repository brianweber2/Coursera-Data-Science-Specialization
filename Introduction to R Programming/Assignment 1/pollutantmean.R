pollutantmean <-function(directory, pollutant, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'pollutant' is a character vector of length 1 indicating
    ## the name of the pollutant for which we will calculate the
    ## mean; either "sulfate" or "nitrate".
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return the mean of the pollutant across all monitors list
    ## in the 'id' vector (ignoring NA vlaues)
    ## NOTE: Do not round the result!
    
    ## Read all files in directory and initialize empty data frame to store data
    allFiles <- list.files(path = directory, pattern = "*.csv", full.names = TRUE)
    selectedData <- data.frame()
    
    ## For the specified id, extract the rows of data into the empty data frame
    for(i in id) {
        selectedData <- rbind(selectedData, read.csv(allFiles[i]))
    }
    
    ## Calculate the mean of the pollutant
    if(pollutant == "sulfate") {
        mean(selectedData$sulfate, na.rm = TRUE)
    } else if(pollutant == "nitrate") {
        mean(selectedData$nitrate, na.rm = TRUE)
    }
}