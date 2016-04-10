## Ranking hospitals by outcome in a state
rankhospital <- function(state, outcome, num) {
    
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
    
    ## Return hospital name in that state with the given rank 30-day death rate
    # all day for specified state
    dataState <- data[data$State == state, ] 
    
    # Sort the data by outcome
    dataStateSorted <- dataState[order(as.numeric(dataState[[colName]]), dataState[["Hospital.Name"]], 
                                       decreasing = FALSE, na.last = NA), ]
    
    # Handle num input
    if (num == "best") {
        num = 1
    }
    if (num == "worst") {
        num = nrow(dataStateSorted)
    }
    dataStateSorted[num, "Hospital.Name"]
}