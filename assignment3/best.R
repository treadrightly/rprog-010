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

best = function(state, outcome)
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
  hospital = data[which(data[,colNumber] == min(data[,colNumber])), "Hospital.Name"]
  if(length(hospital) > 1)
  {
    # more than 1 hospital fits the requirement
    hospital = hospital[sort.list(hospital)]
  }
  return(hospital[1])
}