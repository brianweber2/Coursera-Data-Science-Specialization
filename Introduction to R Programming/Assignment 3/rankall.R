## Ranking hospitals in all states
rankall <- function(outcome, num = "best") {
    
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character", na.strings = "Not Available")
    
    ## Check that state and outcome are valid
    validState = sort(unique(data[, 7]))
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
    
    ## For each state, find the hospital of the given rank
    hospital <- character(0)
    
    for (i in seq_along(validState)) {
        dataState <- data[data$State == validState[i], ]
        
        # Sort data by outcome
        sortedStateData <- dataState[order(as.numeric(dataState[[colName]]), dataState[["Hospital.Name"]], decreasing = FALSE,
                                         na.last = NA), ]
        
        # Handle num input
        thisNum <- num
        if (thisNum == "best") {
            thisNum = 1
        }
        if (thisNum == "worst") {
            thisNum = nrow(sortedStateData)
        }
        hospital[i] <- sortedStateData[thisNum, "Hospital.Name"]
    }
    
    ## Return a data frame with the hospital names and the (abbreviated) state name
    data.frame(hospital=hospital, state=validState, row.names = validState)
}