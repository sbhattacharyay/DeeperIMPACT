mylatex <- function (...) {
  o <- capture.output(latex(...))
  # this will strip /all/ line-only comments; or if you're only
  #  interested in stripping the first such comment you could
  #  adjust accordingly
  o <- grep('^%', o, inv=T, value=T)
  cat(o, sep='\n')
}