---
title: Extraction of numbers from a character string
date : 2013-12-01
--- &lead




Sometimes you get data like:

|concentration |temperature |   pH|
|:-------------|:-----------|----:|
|2.12mL        |11 C        |  7.0|
|7.5mL         |-1 C        | 10.5|
|0.7mL         |3 C         |  8.0|
|7.6mL         |5 C         |  7.5|
|0.11mL        |8 C         | 11.0|
|2.13mL        |4 C         |  4.0|
|0.27mL        |5 C         | 10.0|
|0.45mL        |4 C         |  8.5|
|0.17mL        |9 C         |  7.5|
|0.96mL        |5 C         |  5.5|
and you'd like to separate the numerical values from the units in columns such as `concentration` or `temperature`. 

@BondedDust and @tcash21 
kindly provide me some help on [stackoverflow](http://stackoverflow.com/questions/19252663/extracting-decimal-numbers-from-a-string) 
to achieve such a task.



## Extract numbers from a character string 

I'm using the following function to extract the numerical values:


```r
library(stringr)
numextract <- function(string){ 
  str_extract(string, "\\-*\\d+\\.*\\d*")
} 
```

For example:


```r
numextract("30.5ml")
```

```
## [1] "30.5"
```

```r
numextract(">2g")
```

```
## [1] "2"
```

The function is vectorized:

```r
numextract(c("30.5ml", "37ml"))
```

```
## [1] "30.5" "37"
```

It also extracts negative numbers:

```r
numextract("-3°C")
```

```
## [1] "-3"
```

If you  want to ignore the minus sign, delete it in `str_extract(string, "\\-*\\d+\\.*\\d*")`. 

If there are multiple numbers in the character string, it only extracts the first one:

```r
numextract("between 2ml and 3ml")
```

```
## [1] "2"
```
(yes, I have already received such data in my life).

If you want to extarct multiple numbers use this function instead:

```r
Numextract <- function(string){
  unlist(regmatches(string,gregexpr("[[:digit:]]+\\.*[[:digit:]]*",string)))
}
Numextract("between 2ml and 3ml")
```

```
## [1] "2" "3"
```


## Separate numbers and units

Consider the problem of the introduction:


```r
dat
```



|concentration |temperature |   pH|
|:-------------|:-----------|----:|
|2.12mL        |11 C        |  7.0|
|7.5mL         |-1 C        | 10.5|
|0.7mL         |3 C         |  8.0|
|7.6mL         |5 C         |  7.5|
|0.11mL        |8 C         | 11.0|
|2.13mL        |4 C         |  4.0|
|0.27mL        |5 C         | 10.0|
|0.45mL        |4 C         |  8.5|
|0.17mL        |9 C         |  7.5|
|0.96mL        |5 C         |  5.5|

Extract the numerical values of the `concentration` column

```r
( concentration <- numextract(dat$concentration) )
```

```
##  [1] "2.12" "7.5"  "0.7"  "7.6"  "0.11" "2.13" "0.27" "0.45" "0.17" "0.96"
```

Sometimes, units are different, and we want to get them :

```r
( unit <- str_split_fixed(dat$concentration, concentration, n=2)[,2] )
```

```
##  [1] "mL" "mL" "mL" "mL" "mL" "mL" "mL" "mL" "mL" "mL"
```
And it is a good practice to check we are able to reconstruct the original column:

```r
all(paste0(concentration, unit) == dat$concentration)
```

```
## [1] TRUE
```
Now we'd like to replace the original column by these two columns:

```r
( concentration <- data.frame(concentration, unit) )
```



|concentration |unit |
|:-------------|:----|
|2.12          |mL   |
|7.5           |mL   |
|0.7           |mL   |
|7.6           |mL   |
|0.11          |mL   |
|2.13          |mL   |
|0.27          |mL   |
|0.45          |mL   |
|0.17          |mL   |
|0.96          |mL   |
To do so, I'm using the following function:

```r
df_replace <- function(dat, col, newcol){
  if(!(col %in% names(dat))) stop(paste0("column ", col, " is not in ", deparse(substitute(dat))))
  if(is.vector(newcol)){
    newcol <- data.frame(newcol, stringsAsFactors=FALSE)
    newcol <- reshape::rename(newcol, replace=(c("newcol"=col)))
  }
  E <- which(names(dat) == col)
  if(E==1) return(cbind(newcol, dat[,(E++1):length(dat),drop=FALSE]))
  if(E==length(dat)) return(cbind(dat[,1:(E-1),drop=FALSE], newcol))
  else return(cbind(dat[,1:(E-1),drop=FALSE], newcol, dat[,(E++1):length(dat),drop=FALSE]))
}
```
like this:

```r
df_replace(dat, "concentration", concentration)
```



|concentration |unit |temperature |   pH|
|:-------------|:----|:-----------|----:|
|2.12          |mL   |11 C        |  7.0|
|7.5           |mL   |-1 C        | 10.5|
|0.7           |mL   |3 C         |  8.0|
|7.6           |mL   |5 C         |  7.5|
|0.11          |mL   |8 C         | 11.0|
|2.13          |mL   |4 C         |  4.0|
|0.27          |mL   |5 C         | 10.0|
|0.45          |mL   |4 C         |  8.5|
|0.17          |mL   |9 C         |  7.5|
|0.96          |mL   |5 C         |  5.5|


## Handling character data

Assume you have a long dataset made of columns in character mode only (see next section about the import of 
Excel files in R). 
Even the columns containing numerical values are given in character mode, and you need an automatic way to 
convert these columns in numeric mode. 

First, I'm using the following function to check whether a column can be safely converted in numerical mode:


```r
isNumeric <- function(string){
  ## test whether a character vector contains numbers only
  x <- numextract(string)
  notNA <- which(!is.na(x))
  ifelse(length(notNA)==0, FALSE, all(x[notNA]==str_trim(string[notNA])))
}
```



```r
x <- c("1.5", "3.2")
isNumeric(x)
```

```
## [1] TRUE
```

```r
x <- factor(x)
isNumeric(x)
```

```
## [1] TRUE
```

```r
x <- c("1.5", "3.2 ")
isNumeric(x)
```

```
## [1] TRUE
```

```r
x <- c("1.5", "<3.2")
isNumeric(x)
```

```
## [1] FALSE
```

If `isNumeric(x)` returns `TRUE`, the you can safely use `as.numeric(x)` to convert  
if `x` is a character vector, *but* you have to use `as.numeric(as.character(x))` 
if `x` is a factor. You can simply use `as.numeric(as.character(x))` for both cases.

Based on `isNumeric`, the function `Numerize` below takes as input a dataframe containing only 
character or factor columns, and returns the same dataframe 
with numerical columns when possible.


```r
Numerize <- function(dat, factors=TRUE){ #
  factorcols <- if(factors) FALSE else vapply(dat, function(col) is.factor(col), TRUE) 
  numcols <- names(dat)[which(vapply(dat, function(col) isNumeric(col), TRUE) & !factorcols)]
  sapply(numcols, function(col) invisible(dat[[col]] <<- as.numeric(as.character(dat[[col]])))) 
  return(dat)
}
```

For example:

```r
Numerize(data.frame(x=c("1.5", "3.2"), y=c("1.5", "<3.2")))
```



|   x|y    |
|---:|:----|
| 1.5|1.5  |
| 3.2|<3.2 |

