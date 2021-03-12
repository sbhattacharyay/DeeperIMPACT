create.segmented.barplot <- function(seg.impact.dataframe,fillLabel = names(seg.impact.dataframe)[2]){
  # Create segmented barplot based on selected variable type
  seg.plot <- ggplot(seg.impact.dataframe, aes_string(x = "GOSE", y = "pct", fill = names(seg.impact.dataframe)[2])) + 
    geom_bar(stat = "identity",position = "fill") +
    scale_y_continuous(breaks = seq(0, 1, .2)) + 
    geom_text(aes(label = lbl), size = 3, position = position_stack(vjust = 0.5)) +
    scale_fill_brewer(palette = "Set2") + 
    labs(y = "Percent", 
         fill = fillLabel,
         x = "GOSE") +
    theme_minimal() + 
    theme(aspect.ratio = 1)
  return(seg.plot)
}