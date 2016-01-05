setwd("~/Github/stlapblog/posts/assets/gif")
library(magrittr)
library(animation)

cexlabs <- 2

# anim 
theta0 <-  0.301744247884566
a0 <- floor(1/theta0)-1
theta <- (a0*theta0)* 2*pi  # en fait ceci est a*theta
theta0 <- theta0*2*pi
nframes <- 100
ell <- (2*pi - theta)
rotate <- 0 #-theta
arc <- seq(theta,  2*pi, len=floor(theta*100/0.6)) 
rmin <-  ell/pi/2
arcmin <-  seq(theta,  2*pi, len=floor(theta*100/0.6)) 
R <- seq(log(1), log(rmin), len=nframes+1)[-1] %>% exp
mainplot <- function(){
  curve(sqrt(1-x^2), from=-1, to=1, ylim=c(-1.01,1.01), asp=1,
        axes=FALSE, xlab=NA, ylab=NA)
  curve(-sqrt(1-x^2), from=-1, to=1, add=TRUE)
  points(cos(arc+rotate), sin(arc+rotate), col="red", pch=19, cex=.5)
  points(rmin*cos(arc/rmin+rotate), rmin*sin(arc/rmin+rotate), col="red", pch=19, cex=.5)
  #
  text(1, 0, expression(0), pos=4, cex=cexlabs)
  #points(cos(theta), sin(theta))
  text(cos(theta), sin(theta), expression(b*theta), pos=2, cex=cexlabs)
  points(cos(2*pi-theta0), sin(2*pi-theta0), pch=19)
  text(cos(2*pi-theta0), sin(2*pi-theta0), expression(1-theta), pos=1, cex=cexlabs)
  return(invisible())
}
saveGIF({
  mainplot()
  for(r in R){
    mainplot()
    arcr <- seq(2*pi-ell/r,  2*pi, len=length(arc)) 
    points(r*cos(arcr), r*sin(arcr), col="red", pch=19, cex=.5)
    points(r*cos(2*pi-theta0/r), r*sin(2*pi-theta0/r), pch=19)
  }
  for(i in 1:20){
    mainplot()
    points(r*cos(arcr), r*sin(arcr), col="red", pch=19, cex=.5)
    points(r*cos(2*pi-theta0/r), r*sin(2*pi-theta0/r), pch=19)
    text(r*cos(2*pi-theta0/r), r*sin(2*pi-theta0/r), expression(1-theta*"'"), pos=3, cex=cexlabs)
  }
  }, movie.name = "renormalisation.gif", interval = 0.1, nmax=2, ani.width = 600, 
  ani.height = 600, auto.browse=FALSE)


gif_compress <- function(ingif, outgif, show=TRUE, extra.opts=""){
  command <-  sprintf("gifsicle -O3 %s < %s > %s", extra.opts, ingif, outgif)
  system.fun <- if (.Platform$OS.type == "windows") shell else system
  if(show) message("Executing: ", strwrap(command, exdent = 2, prefix = "\n"))
  system.fun(ifelse(.Platform$OS.type == "windows", sprintf("\"%s\"", shQuote(command)), command))
}

gif_compress("renormalisation.gif", "renormalisation_optim.gif")

system(sprintf("convert %s -trim %s", "renormalisation_optim.gif", "renormalisation_optim.gif"))
