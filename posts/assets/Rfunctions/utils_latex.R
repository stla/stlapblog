library(xtable)

latex_matrix <- function(M){
  print(xtable(M, align=rep("",ncol(M)+1), digits=0), floating=FALSE, tabular.environment="pmatrix", include.rownames=FALSE, include.colnames=FALSE, hline.after=NULL, timestamp=NULL, comment=FALSE, print.results=FALSE)
}