join <- function(x){ 
  tab <- stringr::str_detect(x, "  ") | stringr::str_detect(x, "\t")
  begins <- which(sapply(seq_len(length(x)-1), function(i) !tab[i] && tab[i+1])) 
  ends <- which(sapply(seq_len(length(x)-1), function(i) tab[i] && !tab[i+1]))+1
  for(i in 1:length(begins)){
    begin <- begins[i]
    end <- ends[i]
    x[begin] <- paste(x[begin:end], collapse="\n")
    x[(begin+1):end] <- NA
  }
  x <- x[-which(is.na(x))]
  return(x)
}
# example: 
# > join(c("x=2", "y=3;", "def f(a)", "  w=a*a",  "  return w", "end", "puts f(x+y)", "def g(a)", "  return a*a*a", "end"))
# [1] "x=2"                                "y=3;"                              
# [3] "def f(a)\n  w=a*a\n  return w\nend" "puts f(x+y)"                       
# [5] "def g(a)\n  return a*a*a\nend"   
knit_engines$set(RUBY = function(options) {
  if(!exists("MEMO")) MEMO <<- list()
  if(length(MEMO) && !is.null(options$use.memo) && options$use.memo){
    precode <- do.call(c, MEMO)
    memo <- TRUE
  }else{
    memo <- FALSE
  }
  code0 <- options$code
  if(!is.null(options$memo) && options$memo) MEMO <<- c(MEMO, list(code0))
  if(length(code0)>1){
    code <-   if(any(stringr::str_detect(code0, "  "))) join(code0) else code0
  }else{
    code <- code0
  }
  prog <- paste(sapply(code, function(x) sprintf("puts '>> %s'\n%s", x, x)), collapse="\n")
  if(memo){
    prog <- paste(paste(precode, collapse="\n"), "\n", prog, collapse="\n")
  }
  out <-  system2("ruby", args=c("-e", shQuote(prog)), stdout=TRUE, stderr=TRUE)
  start <- which.max(out==paste0(">> ", code0[1]))
  if(memo) out <- out[start:length(out)] # tail(out, length(out)-start+2)
  out <- paste(out, collapse="\n") #  capture.output(str(out))
  options$comment=NA
  return( knitr:::wrap.character(out, options))
})