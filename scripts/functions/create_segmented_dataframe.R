create.segmented.dataframe <- function(impact.dataframe,varName){
  # Ensure variable type is of factor form
  impact.dataframe[[varName]] <- as.factor(impact.dataframe[[varName]])
  
  # Create dataframe segmented by selected variable type
  seg.impact.dataframe <- impact.dataframe %>%
    drop_na(all_of(varName)) %>%
    group_by_("GOSE",varName) %>%
    dplyr::summarize(n = n()) %>% 
    mutate(pct = n/sum(n),
           lbl = scales::percent(pct))
  return(seg.impact.dataframe)
}