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

getNum = function(num, numberOfHospitals)
{
  if (num == "best")
  {
    num = 1
  } else if (num == "worst")
  {
    num = numberOfHospitals
  }
  if (num > numberOfHospitals)
  {
    num = NA
  }
  num
}

rankall = function(outcome, num="best")
{
  result = data.frame()
  data = read.csv("outcome-of-care-measures.csv", colClasses="character")
  colNumber = getColumnNumber(outcome)
  if(is.na(colNumber) == TRUE)
  {
    stop("invalid outcome")
  }
  states = split(data, data$State)
  for (i in 1:length(states))
  {
    statedata = states[[i]]
    statedata = subset(statedata, statedata[,colNumber] != "Not Available")
    statename = statedata[1, "State"]
    n = getNum(num, dim(statedata)[1])
    if (is.na(n) == TRUE)
    {
      hospital = NA
    }
    if (is.na(n) == FALSE)
    {
      if (dim(statedata)[1] == 0) 
      {
        stop("invalid state")
      }
      statedata[,colNumber] = as.numeric(statedata[,colNumber])
      statedata = statedata[with(statedata, order(statedata[, colNumber], statedata[, "Hospital.Name"]), na.last=TRUE), ]
      hospital = statedata[n, "Hospital.Name"]
    }
    result = rbind(result, data.frame(hospital=hospital, state=statename))
  }
  result = result[with(result, order(result[, "state"])), ]
}