library(ROCR)

singleclass.AUC <- function(results.df,types = c('auprc','auroc'), specific.class, axes = FALSE){
  
  results.df$true.labels <- as.character(results.df$true.labels)
  results.df$pred.labels <- as.character(results.df$pred.labels)
  
  if (axes == TRUE){
    # Axes for interpolation
    xq <- seq(from = 0, to = 1, length.out = 4000)
    compiled.curve.axes <- data.frame(matrix(ncol = 4, nrow = 0))
  }
  
  if (specific.class == 'macro-averaged'){
    unique.labels <- sort(unique(results.df$true.labels))
    if ('auroc' %in% types){
      aurocs <- c()
    }
    if ('auprc' %in% types){
      auprcs <- c()
    }
    
    auc.df <- as.data.frame(matrix(ncol = 3, nrow = 0))
    for (curr.label in unique.labels){
      if (curr.label == '3'){
        temp.df <- data.frame(binary.true.labels = as.numeric(results.df$true.labels == curr.label)) %>%
          mutate(pred.prob = results.df[['prob_GOSE_2_3']])
      } else {
        temp.df <- data.frame(binary.true.labels = as.numeric(results.df$true.labels == curr.label)) %>%
          mutate(pred.prob = results.df[[paste0('prob_GOSE_',curr.label)]])
      }
      curr.pred <- ROCR::prediction(temp.df$pred.prob,temp.df$binary.true.labels)
      if ('auroc' %in% types){
        curr.perf.auroc <- ROCR::performance(curr.pred, measure = "auc")
        aurocs <- c(aurocs, curr.perf.auroc@y.values[[1]])
      }
      if ('auprc' %in% types){
        curr.perf.auprc <- ROCR::performance(curr.pred, measure = "aucpr")
        auprcs <- c(auprcs, curr.perf.auprc@y.values[[1]])
      }
      if (axes == TRUE){
        if ('auroc' %in% types){
          curr.perf.roc <- performance(curr.pred, measure = "tpr", x.measure = "fpr")
          interp.roc <- approx(x = curr.perf.roc@x.values[[1]], y = curr.perf.roc@y.values[[1]],xout = xq)
          compiled.curve.axes <- rbind(compiled.curve.axes,
                                       data.frame(class = curr.label,
                                                  type = 'roc',
                                                  x = interp.roc$x,
                                                  y = interp.roc$y))
        }
        if ('auprc' %in% types){
          curr.perf.prc <- performance(curr.pred, measure = "prec", x.measure = "rec")
          interp.prc <- approx(x = curr.perf.prc@x.values[[1]], y = curr.perf.prc@y.values[[1]],xout = xq)
          compiled.curve.axes <- rbind(compiled.curve.axes,
                                       data.frame(class = curr.label,
                                                  type = 'prc',
                                                  x = interp.prc$x,
                                                  y = interp.prc$y))
        }
      }
    }
    if ('auroc' %in% types){
      auc.df <- rbind(auc.df,
                      data.frame(class = 'macro-averaged',type = 'auroc',value = mean(aurocs)))
    }
    if ('auprc' %in% types){
      auc.df <- rbind(auc.df,
                      data.frame(class = 'macro-averaged',type = 'auprc',value = mean(auprcs)))
    }
    if (axes == TRUE){
      return(list(auc.df,compiled.curve.axes))
    } else {
      return(auc.df)
    }
    
  } else {
    if (specific.class == '3'){
      temp.df <- data.frame(binary.true.labels = as.numeric(results.df$true.labels == specific.class)) %>%
        mutate(pred.prob = results.df[['prob_GOSE_2_3']])
    } else {
      temp.df <- data.frame(binary.true.labels = as.numeric(results.df$true.labels == specific.class)) %>%
        mutate(pred.prob = results.df[[paste0('prob_GOSE_',specific.class)]])
    }
    
    curr.pred <- ROCR::prediction(temp.df$pred.prob,temp.df$binary.true.labels)
    
    if ('auroc' %in% types){
      curr.perf.auroc <- ROCR::performance(curr.pred, measure = "auc")
    }
    if ('auprc' %in% types){
      curr.perf.auprc <- ROCR::performance(curr.pred, measure = "aucpr")    
    }
    auc.df <- as.data.frame(matrix(ncol = 3, nrow = 0))
    
    if (axes == TRUE){
      
      if ('auroc' %in% types){
        curr.perf.roc <- performance(curr.pred, measure = "tpr", x.measure = "fpr")
        interp.roc <- approx(x = curr.perf.roc@x.values[[1]], y = curr.perf.roc@y.values[[1]],xout = xq)
        compiled.curve.axes <- rbind(compiled.curve.axes,
                                     data.frame(class = specific.class,
                                                type = 'roc',
                                                x = interp.roc$x,
                                                y = interp.roc$y))
      }
      if ('auprc' %in% types){
        curr.perf.prc <- performance(curr.pred, measure = "prec", x.measure = "rec")  
        interp.prc <- approx(x = curr.perf.prc@x.values[[1]], y = curr.perf.prc@y.values[[1]],xout = xq)
        compiled.curve.axes <- rbind(compiled.curve.axes,
                                     data.frame(class = specific.class,
                                                type = 'prc',
                                                x = interp.prc$x,
                                                y = interp.prc$y))
      }
    }
    if ('auroc' %in% types){
      auc.df <- rbind(auc.df,
                      data.frame(class = specific.class, type = 'auroc',value = curr.perf.auroc@y.values[[1]]))
    }
    if ('auprc' %in% types){
      auc.df <- rbind(auc.df,
                      data.frame(class = specific.class, type = 'auprc',value = curr.perf.auprc@y.values[[1]]))
    }
    if (axes == TRUE){
      return(list(auc.df,compiled.curve.axes))
    } else {
      return(auc.df)
    }
  }
}