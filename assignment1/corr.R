corr = function(directory, threshold=0)
{
  correlations = numeric()
  
  files = list.files(path=directory)
  for (i in 1:length(files))
  {
    file = paste(directory, "/", files[i], sep="")
    fileData = read.csv(file, header=TRUE)
    fileData = subset(fileData, is.na(fileData$sulfate) == FALSE & is.na(fileData$nitrate) == FALSE)
    if(dim(fileData)[1] > threshold)
    {
      c = cor(fileData$sulfate, fileData$nitrate)
      correlations = append(correlations, c)  
    }
  }
  return(correlations)
}