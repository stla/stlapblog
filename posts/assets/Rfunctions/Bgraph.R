library(diagram) 
Bgraph_v1 <- function(fun_Mn, N, title=NA, path=NULL, col_path="blue", labels_path=FALSE, labels_vertex=TRUE, USE.COLNAMES=FALSE, first_vertex=0, label_root="ø", only_end=FALSE, cex_vertex=1.5, labels_edges=TRUE, cex_edge=1.1, ellipse_vertex=FALSE, ellipse_edge=FALSE, LaTeX=FALSE, ...){
  Mn <- sapply(0:(N-1), function(n) fun_Mn(n))
  nvertices <- sapply(1:N, function(n) nrow(Mn[[n]])) # number of vertices per level
  elpos <- coordinates (c(nvertices, ncol(Mn[[N]])), ...) # positions of vertices
  left <- cumsum(nvertices)
  vertex <- function(n,k){ # n: level ; k: vertex at this level 
    left[n] + k 
  }
  # 
  l <- length(path)
  path <- c(path, rep(0,N+1-l))
  path <- path +1  # NA useless but..
  vpath <- path[1]
  for(k in 2:N){
    v <- vpath[k-1] 
    vpath[k] <- which(Mn[[k]][v,]>0)[path[k]]
  }
  path <- vpath 
  # construct connections matrix
  fromto <- NULL
  multiplicity <- NULL
  lcol <- lty <- lwd <- NULL
  # connections from level n=0
  current <- 1 
  for(i in which(Mn[[1]][1,]>0)){
    goto <- vertex(1, i)
    fromto <- rbind(fromto, c(current,goto))
    multiplicity <- c(multiplicity, Mn[[1]][1,i])
    lcol <- rbind(lcol, 
                  ifelse(i==path[1], col_path, "gray")
    )
    lty <- rbind(lty, 
                 ifelse(i==path[1], "solid", "solid")
    )
    lwd <- rbind(lwd, 
                 ifelse(i==path[1], 4, 2)
    )
  }
  # connections from level n
  for(n in 1:(N-1)){
    for(i in 1:nrow(Mn[[n+1]])){
      current <- vertex(n,i)
      path_done <- FALSE
      for(k in which(Mn[[n+1]][i,]>0)){
        goto <- vertex(n+1, k)
        fromto <- rbind(fromto, c(current,goto))
        multiplicity <- c(multiplicity, Mn[[n+1]][i,k])
        s <- which.max(Mn[[n+1]][i,]>0)-1
        lcol <- rbind(lcol, ifelse(all(c(i,k)==path[n:(n+1)]), col_path, "gray")
        )
        lty <- rbind(lty, ifelse(all(c(i,k)==path[n:(n+1)]), "solid", "solid")
        )
        lwd <- rbind(lwd, ifelse(all(c(i,k)==path[n:(n+1)]), 4, 2)
        )
      }
    }
  }
  nr <- nrow(fromto)
  if(labels_edges) labs_edges <- unlist( by(fromto[,1], fromto[,1], FUN=function(x) 1:length(x)) ) - 1
  arrpos <- matrix(ncol = 2, nrow = nr)
  # START PLOT 
  openplotmat(main=title)
  for (i in 1:nr){ # draw and store the arrows
    if(multiplicity[i]==1){
      arrpos[i, ] <- straightarrow (to = elpos[fromto[i, 2], ],
                                    from = elpos[fromto[i, 1], ],
                                    arr.pos = 0.5, arr.length = 0, 
                                    lcol=lcol[i], lty=lty[i], lwd=lwd[i])
    }
    if(multiplicity[i]==2){
      curvedarrow (to = elpos[fromto[i, 2], ],
                   from = elpos[fromto[i, 1], ],
                   arr.pos = 0.5, arr.length = 0, 
                   lcol=lcol[i], lty=lty[i], lwd=lwd[i],
                   curve=-0.05)
      arrpos[i, ] <- curvedarrow (to = elpos[fromto[i, 2], ],
                                  from = elpos[fromto[i, 1], ],
                                  arr.pos = 0.5, arr.length =0, 
                                  lcol=lcol[i], lty=lty[i], lwd=lwd[i],
                                  curve=0.05)
    }
    # labels on edges 
    if(labels_edges && !labels_path){ 
      if(LaTeX) labels_edges <- paste0("$", labels_edges, "$")
      mid <- arrpos[i, ]
      if(ellipse_edge){
        textellipse(mid, 0.02, lab=labs_edges[i], cex=cex_edge, lcol="black", shadow.size=0) 
      }else{
        textempty(mid+c(0,0), lab=labs_edges[i], cex=cex_edge)
      }
    }
    # labels on the blue path
    if(labels_path){
      if(lcol[i]==col_path){
        mid <- arrpos[i, ]
        if(ellipse_edge){
          textellipse(mid, 0.02, lab=labs_edges[i], cex=cex_edge, lcol="black", shadow.size=0) 
        }else{
          textempty(mid+c(0,0), lab=labs_edges[i], cex=cex_edge)
        }
      }
    }
  }
  # labels on vertices
  if(labels_vertex){
    # root label 
    textellipse(elpos[1,], 0.01, 0.01, lab = label_root, box.col="white", shadow.size=0, lcol="white", cex=cex_vertex) 
    # vertices labels
    start <- ifelse(only_end, N, 1)
    for(n in start:N){ 
      for(i in 1:ncol(Mn[[n]])){
        lab <- as.character(ifelse(USE.COLNAMES, colnames(Mn[[n]])[i] , i-1+first_vertex))
        if(LaTeX && !USE.COLNAMES) lab <- paste0("$", lab, "$")
        if(ellipse_vertex){
          textellipse(elpos[vertex(n,i),], 0.02, 0.02, lab=lab, box.col="white", shadow.size=0, cex=cex_vertex)          
        }else{
          textempty(elpos[vertex(n,i),], lab = lab, cex=cex_vertex)  
        }
      }
    }
  }
}