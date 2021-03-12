fix.tf.impact.dataframe <- function(bc.impact.dataframe){
  # Assign proper variable types
  bc.impact.dataframe$unreactive_pupils <- as.integer(bc.impact.dataframe$unreactive_pupils)
  bc.impact.dataframe$GOSE <- factor(bc.impact.dataframe$GOSE, order = TRUE)
  bc.impact.dataframe$hypoxia <- as.factor(bc.impact.dataframe$hypoxia)
  bc.impact.dataframe$hypotension <- as.factor(bc.impact.dataframe$hypotension)
  bc.impact.dataframe$tsah <- as.factor(bc.impact.dataframe$tsah)
  bc.impact.dataframe$EDH <- as.factor(bc.impact.dataframe$EDH)
  
  return(bc.impact.dataframe)
}