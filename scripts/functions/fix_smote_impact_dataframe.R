fix.smote.impact.dataframe <- function(train.impact.dataframe){
  # Assign proper variable types
  train.impact.dataframe$PatientType <- as.factor(train.impact.dataframe$PatientType)
  train.impact.dataframe$unreactive_pupils <- factor(train.impact.dataframe$unreactive_pupils)
  train.impact.dataframe$GOSE <- factor(train.impact.dataframe$GOSE)
  train.impact.dataframe$hypoxia <- as.factor(train.impact.dataframe$hypoxia)
  train.impact.dataframe$hypotension <- as.factor(train.impact.dataframe$hypotension)
  train.impact.dataframe$tsah <- as.factor(train.impact.dataframe$tsah)
  train.impact.dataframe$EDH <- as.factor(train.impact.dataframe$EDH)
  return(train.impact.dataframe)
}