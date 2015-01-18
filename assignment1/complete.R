complete = function(directory, id=1:332)
{
  numMonitors = length(id)
  nobs = numeric()
  for (i in 1:numMonitors)
  {
    file = sprintf("%s/%03d.csv", directory, id[i])
    fileData = read.csv(file, header=TRUE)
    fileData = subset(fileData, is.na(fileData$sulfate) == FALSE & is.na(fileData$nitrate) == FALSE)
    nobs[i] = dim(fileData)[1]
  }
  m = data.frame(id=id, nobs=nobs)
  return(m)
}