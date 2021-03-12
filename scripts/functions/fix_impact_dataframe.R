fix.impact.dataframe <- function(impact.dataframe){
  
  # Assign proper variable types
  impact.dataframe$entity_id <- as.factor(impact.dataframe$entity_id)
  impact.dataframe$PatientType <- as.factor(impact.dataframe$PatientType)
  impact.dataframe$age <- as.integer(impact.dataframe$age)
  impact.dataframe$unreactive_pupils <- factor(impact.dataframe$unreactive_pupils, ordered = TRUE)
  impact.dataframe$GCS <- as.integer(impact.dataframe$GCS)
  impact.dataframe$GCSm <- as.integer(impact.dataframe$GCSm)
  impact.dataframe$GOSE <- factor(impact.dataframe$GOSE, order = TRUE)
  impact.dataframe$hypoxia <- as.factor(impact.dataframe$hypoxia)
  impact.dataframe$hypotension <- as.factor(impact.dataframe$hypotension)
  impact.dataframe$marshall <- as.integer(impact.dataframe$marshall)
  impact.dataframe$tsah <- as.factor(impact.dataframe$tsah)
  impact.dataframe$EDH <- as.factor(impact.dataframe$EDH)
  
  return(impact.dataframe)
}