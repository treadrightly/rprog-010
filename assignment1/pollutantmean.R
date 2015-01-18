pollutantmean = function(directory, pollutant, id=1:332)
{
  numMonitors = length(id)
  data = numeric()
  for (i in 1:numMonitors)
  {
    file = sprintf("%s/%03d.csv", directory, id[i])
    fileData = read.csv(file, header=TRUE)
    data = c(data, fileData[,pollutant])
  }
  m = mean(data, na.rm=TRUE)
  return(m)
}