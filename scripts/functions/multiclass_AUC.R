library(ROCR)

multiclass.AUC <- function(results.df, axes = FALSE){
  
  unique.labels <- sort(unique(results.df$true.labels))
  
  aurocs <- c()
  auprcs <- c()
  
  if (axes == TRUE){
    # Axes for interpolation
    xq <- seq(from = 0, to = 1, length.out = 4000)
    compiled.curve.axes <- data.frame(matrix(ncol = 4, nrow = 0))
  }
  
  for (curr.label in unique.labels){
    
    if (curr.label == 3){
      temp.df <- data.frame(binary.true.labels = as.numeric(results.df$true.labels == curr.label)) %>%
        mutate(pred.prob = results.df[['prob_GOSE_2_3']])
    } else {
      temp.df <- data.frame(binary.true.labels = as.numeric(results.df$true.labels == curr.label)) %>%
        mutate(pred.prob = results.df[[paste0('prob_GOSE_',as.character(curr.label))]])
    }
    
    curr.pred <- ROCR::prediction(temp.df$pred.prob,temp.df$binary.true.labels)
    
    curr.perf.auroc <- ROCR::performance(curr.pred, measure = "auc")
    curr.perf.auprc <- ROCR::performance(curr.pred, measure = "aucpr")    
    
    aurocs <- c(aurocs, curr.perf.auroc@y.values[[1]])
    auprcs <- c(auprcs, curr.perf.auprc@y.values[[1]])
    
    if (axes == TRUE){
      curr.perf.roc <- performance(curr.pred, measure = "tpr", x.measure = "fpr")
      curr.perf.prc <- performance(curr.pred, measure = "prec", x.measure = "rec")
      
      interp.roc <- approx(x = curr.perf.roc@x.values[[1]], y = curr.perf.roc@y.values[[1]],xout = xq)
      interp.prc <- approx(x = curr.perf.prc@x.values[[1]], y = curr.perf.prc@y.values[[1]],xout = xq)
      
      compiled.curve.axes <- rbind(compiled.curve.axes,
                                   data.frame(class = curr.label,
                                              type = 'roc',
                                              x = interp.roc$x,
                                              y = interp.roc$y),
                                   data.frame(class = curr.label,
                                              type = 'prc',
                                              x = interp.prc$x,
                                              y = interp.prc$y))
    }
  }
  
  auc.df <- rbind(data.frame(class = unique.labels, type = 'auroc',value = aurocs),
                  data.frame(class = unique.labels, type = 'auprc',value = auprcs),
                  data.frame(class = 'macro-average',type = 'auroc',value = mean(aurocs)),
                  data.frame(class = 'macro-average',type = 'auprc',value = mean(auprcs)))
  if (axes == TRUE){
    return(list(auc.df,compiled.curve.axes))
  } else {
    return(auc.df)
  }
}