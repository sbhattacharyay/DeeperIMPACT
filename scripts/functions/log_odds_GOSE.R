log.odds.GOSE <- function(gose){
  c('>=3->=4' = qlogis(mean(gose >=3))-qlogis(mean(gose >=4)),
    # '>=3->=5' = qlogis(mean(gose >=3))-qlogis(mean(gose >=5)),
    # '>=3->=6' = qlogis(mean(gose >=3))-qlogis(mean(gose >=6)),
    # '>=3->=7' = qlogis(mean(gose >=3))-qlogis(mean(gose >=7)),
    # '>=3->=8' = qlogis(mean(gose >=3))-qlogis(mean(gose >=8)),
    '>=4->=5' = qlogis(mean(gose >=4))-qlogis(mean(gose >=5)),
    # '>=4->=6' = qlogis(mean(gose >=4))-qlogis(mean(gose >=6)),
    # '>=4->=7' = qlogis(mean(gose >=4))-qlogis(mean(gose >=7)),
    # '>=4->=8' = qlogis(mean(gose >=4))-qlogis(mean(gose >=8)),
    '>=5->=6' = qlogis(mean(gose >=5))-qlogis(mean(gose >=6)),
    # '>=5->=7' = qlogis(mean(gose >=5))-qlogis(mean(gose >=7)),
    # '>=5->=8' = qlogis(mean(gose >=5))-qlogis(mean(gose >=8)),
    '>=6->=7' = qlogis(mean(gose >=6))-qlogis(mean(gose >=7)),
    # '>=6->=8' = qlogis(mean(gose >=6))-qlogis(mean(gose >=8)),
    '>=7->=8' = qlogis(mean(gose >=7))-qlogis(mean(gose >=8)))
}