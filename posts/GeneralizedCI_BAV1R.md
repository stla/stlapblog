# Generalized confidence intervals in the 'BAV1R'
Stéphane Laurent  
2017-03-26  



\newcommand{\SS}{\mathrm{SS}}
\newcommand{\ss}{\mathrm{ss}}

Let us consider the balanced one-way random effect ANOVA model, that we already discussed in a [previous article](http://stla.github.io/stlapblog/posts/Anova1random.html). 

In this previous article, I provided a confidence interval about the total coefficient of variation, and I claimed I didn't remember how I derived it. Now I remember. It is a so-called *generalized confidence interval*. 

We denote by $y_{ij}$ the $j$-th observation in group $i$, for $1 \leqslant i \leqslant I$ and $1 \leqslant j \leqslant J$, and we denote by $Y_{ij}$ the random variable modelling $y_{ij}$.

Recall that the three summary statistics $\bar Y_{\bullet\bullet}$ (overall mean), $\SS_b$ (between sum-of-squares) and $\SS_w$ (within sum-of-squares) are independent and their distributions are given by 
$$
Z \sim {\cal N}(0,1), \quad 
U^2_b \sim \chi^2_{I-1}, \quad 
U^2_w \sim \chi^2_{I(J-1)}
$$
where 
$$
\begin{align}
Z & =  \sqrt{IJ} \frac{\bar Y_{\bullet\bullet}-\mu}{\sqrt{J\sigma^2_b+\sigma^2_w}},\\
U^2_b & = \frac{\SS_b}{J\sigma^2_b+\sigma^2_w},\\
U^2_w & = \frac{\SS_w}{\sigma^2_w}. 
\end{align}
$$

We use notations $\bar y_{\bullet\bullet}$, $\ss_b$, $\ss_w$ to denote the actual observations of these three summary statistics. They are considered as non-random.

Define the three following strange random variables:
$$
\begin{align}
G_\mu & = \bar y_{\bullet\bullet} - 
\sqrt{IJ} \frac{\bar Y_{\bullet\bullet}-\mu}{\sqrt{\SS_b}}
 \sqrt{\frac{\ss_b}{IJ}}, \\
G_{\sigma^2_b} & = \frac{J\sigma^2_b+\sigma^2_w}{J \SS_b} \ss_b
 - \frac{\sigma^2_w}{J \SS_w}\ss_w, \\
G_{\sigma^2_w} & = \frac{\sigma^2_w}{\SS_w}\ss_w.
\end{align}
$$

They are strange because they involve the actual observations.

They enjoy the two following properties. 
Firstly, it is very easy to check that, if
$(\bar Y_{\bullet\bullet}, \SS_b, \SS_w) = (\bar y_{\bullet\bullet}, \ss_b, \ss_w)$, then 
$$
(G_\mu, G_{\sigma^2_b}, G_{\sigma^2_w}) 
= (\mu, \sigma^2_b, \sigma^2_w).
$$

Secondly, it is not difficult to check that, while the expressions of these three strange random variables involve the unknown parameters, the distributions of these random variables does not involve any unknown parameter. Indeed, with the previous notations, 
$$
\begin{align}
G_\mu & = \bar y_{\bullet\bullet} -\frac{Z}{\sqrt{U^2_b}}\sqrt{\frac{\ss_b}{IJ}}, \\
G_{\sigma^2_b} & = \frac{1}{J}\left(\frac{\ss_b}{U^2_b} - \frac{\ss_w}{U^2_w}\right), \\ 
G_{\sigma^2_w} & = \frac{\ss_w}{U^2_w}.
\end{align}
$$

Therefore, these variables can be easily simulated, and it is known that (see [Krishnamoorthy & Mathew][KM]'s book), if $f$ is a suitable function, then *the quantiles of $f(\bar Y_{\bullet\bullet}, \SS_b, \SS_w)$ are confidence bounds of $f(\mu, \sigma^2_b, \sigma^2_w)$*. 
More precisely, if we denote by $q_f(p)$ the $100p\%$-quantile of 
$f(\bar Y_{\bullet\bullet}, \SS_b, \SS_w)$, then, for instance, 
$\left[q_f\left(\frac{\alpha}{2}\right), q_f\left(1-\frac{\alpha}{2}\right)\right]$ is a $100(1-\alpha)\%$-confidence interval about $f(\mu, \sigma^2_b, \sigma^2_w)$. 

This is a so-called *generalized confidence interval*. Such confidence intervals are not exact, but it is known that they are asymptotically exact, and their coverage is often close to the nominal level.

## Example 

Let's write a function simulating a dataset.


```r
library(data.table)
Sim <- function(I, J, mu, sigmab, sigmaw){
  group <- gl(I, J, labels=LETTERS[1:I])
  DT <- data.table(group = group, 
                   y = mu + rep(rnorm(I, sd=sigmab), each=J) + rnorm(I*J, sd=sigmaw),
                   key = "group")
  return(DT)
}
I <- 2L; J <- 3L
mu <- 0; sigmab <- 1; sigmaw <- 2
set.seed(666L)
( DT <- Sim(I, J, mu, sigmab, sigmaw) )
##    group           y
## 1:     A  0.04304213
## 2:     A  4.80964673
## 3:     A -3.68043786
## 4:     B  3.53114702
## 5:     B -0.59801585
## 6:     B  0.40931553
```

And let's write a function calculating the summary statistics from such a dataset.


```r
summaryStats <- function(DT){
  DT[, `:=`(means = rep(mean(y), each=.N)), by=group]
  ssw <- DT[, { squares = (y-means)^2
                .(ssw = sum(squares))}]$ssw
  ybar <- mean(DT$y)
  DT[, `:=`(Mean = ybar)]
  ssb <- DT[, { squares = (means-Mean)^2
                .(ssb = sum(squares))}]$ssb
  return(c(ybar=ybar, ssb=ssb, ssw=ssw))
}
( stats <- summaryStats(DT) )
##       ybar        ssb        ssw 
##  0.7524496  0.7849582 45.4922978
ybar <- stats["ybar"]
ssb <- stats["ssb"]
ssw <- stats["ssw"]
```

Consider a crazy parameter of interest 
$$
\theta = \mu + \sigma^2_b + \log(\sigma^2_w).
$$


```r
f <- function(mu, sigma2b, sigma2w) mu + sigma2b + log(sigma2w)
```

In our example, the true value of $\theta$ is:


```r
( theta0 <- f(mu, sigmab^2, sigmaw^2) )
## [1] 2.386294
```

We get a confidence interval about $\theta$ as follows:


```r
n <- 50000L
Z <- rnorm(n)
U2b <- rchisq(n, I-1)
U2w <- rchisq(n, I*(J-1))
Gmu <- ybar - Z/sqrt(U2b)*sqrt(ssb/I/J)
Gsigma2b <- 1/J*(ssb/U2b - ssw/U2w)
Gsigma2w <- ssw/U2w
quantile(f(Gmu, Gsigma2b, Gsigma2w), c(0.025, 0.975))
##      2.5%     97.5% 
## -23.55456 252.50211
```


## Checking the coverage

Let's check the coverage probability of this interval for our scenario.


```r
nsims <- 20000
SIMS <- t(vapply(1:nsims, function(i){
   summaryStats(Sim(I, J, mu, sigmab, sigmaw))
  }, 
  FUN.VALUE=numeric(3)))
lower <- upper <- numeric(nsims)
for(i in 1:nsims){
  ybar <- SIMS[i,"ybar"]
  ssb <- SIMS[i,"ssb"]
  ssw <- SIMS[i,"ssw"]
  Gmu <- ybar - Z/sqrt(U2b)*sqrt(ssb/I/J)
  Gsigma2b <- 1/J*(ssb/U2b - ssw/U2w)
  Gsigma2w <- ssw/U2w
  theta <- f(Gmu, Gsigma2b, Gsigma2w)
  lower[i] <- quantile(theta, 0.025)
  upper[i] <- quantile(theta, 0.975)
}
mean(theta0 > lower)
## [1] 0.98875
mean(theta0 < upper)
## [1] 0.9728
mean(theta0 > lower & theta0 < upper)
## [1] 0.96155
```

Thus, the generalized confidence interval is a bit conservative in this example (really far from the asymptoticness).


[KM]: http://eu.wiley.com/WileyCDA/WileyTitle/productCd-0470380268.html "Kalimuthu Krishnamoorthy, Thomas Mathew. *Statistical Tolerance Regions: Theory, Applications, and Computation*. Wiley 2009."
