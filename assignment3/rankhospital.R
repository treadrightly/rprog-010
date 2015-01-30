#Copyright treadrightly
getColumnNumber = function(outcome)
{
  if(outcome == "heart attack")
  {
    return (11)
  }
  if(outcome == "heart failure")
  {
    return (17)
  }
  if(outcome == "pneumonia")
  {
    return (23)
  }
  return (NA)
}

rankhospital = function(state, outcome, num="best")
{
  data = read.csv("outcome-of-care-measures.csv", colClasses="character")
  data = subset(data, data$State == state)
  if (dim(data)[1] == 0) 
  {
    stop("invalid state")
  }
  colNumber = getColumnNumber(outcome)
  if(is.na(colNumber) == TRUE)
  {
    stop("invalid outcome")
  }
  data = subset(data, data[,colNumber] != "Not Available")
  data[,colNumber] = as.numeric(data[,colNumber])
  data = data[with(data, order(data[, colNumber], data[, "Hospital.Name"]), na.last=TRUE), ]
  
  if (num == "best")
  {
    num = 1
  } else if (num == "worst")
  {
    num = dim(data)[1]
  }
  if (num > dim(data)[1])
  {
    return (NA)
  }
  else
  {
    return (data[num, "Hospital.Name"])
  }
  
}