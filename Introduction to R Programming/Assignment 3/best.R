## Finding the best hospital in a state
best <- function(state, outcome) {
    
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character", na.strings = "Not Available")
    
    ## Check that state and outcome are valid
    validState = unique(data[, 7])
    if (!state %in% validState) {
        stop("invalid state")
    }
    
    validOutcome = c("heart attack", "heart failure", "pneumonia")
    if (!outcome %in% validOutcome) {
        stop("invalid outcome")
    }
    
    # Convert outcome name into column name
    fullColName <- c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack", "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure", "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
    colName <- fullColName[match(outcome, validOutcome)]
    
    ## Return hospital name in that state with lowest 30-day death rate
    dataState <- data[data$State == state, ]
    minIndex <- which.min(dataState[, colName])
    dataState[minIndex, "Hospital.Name"]
}