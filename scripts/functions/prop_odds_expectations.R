prop.odds.expectation <- function(x, y) {
  n <- length(x)
  f <- lrm.fit(x, y)
  fy <- f$freq/n
  ns <- length(fy) - 1
  k <- ns + 1
  intcept <- f$coef[1:ns]
  xb <- f$linear.predictors - intcept[1]
  xb <- sapply(intcept, "+", xb)
  P <- 1/(1 + exp(-xb))
  P <- matrix(P, ncol = ns)
  P <- cbind(1, P) - cbind(P, 0)
  xmean.y <- tapply(x, y, mean)
  xsd.y <- tapply(x, y, sd)
  xp <- x * P/n
  xmean.y.po <- apply(xp, 2, sum)/fy
  rr <- as.data.frame(t(rbind(xmean.y, xmean.y.po, xsd.y)))
  rr$GOSE <- rownames(rr)
  return(rr)
}