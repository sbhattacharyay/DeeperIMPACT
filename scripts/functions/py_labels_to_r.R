py.labels.to.r <- function(py.labels){
  r.labels <- py.labels %>% plyr::mapvalues(from = c("0","1","2","3","4","5","6"), to = c("1","3","4","5","6","7","8"))
  return(r.labels)
}