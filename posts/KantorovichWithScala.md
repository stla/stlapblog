---
title: Using Scala to compute the Kantorovich distance
date : 2014-06-09
--- &lead




Recall that we previously provided an example of calculation of a Kantorovich distance [using R](http://stla.github.io/stlapblog/posts/KantorovichWithR.html) and 
[using Julia](http://stla.github.io/stlapblog/posts/KantorovichWithJulia.html). 
Now it's time to do it with [Scala](http://www.scala-lang.org/) and 
its [breeze library](https://github.com/scalanlp/breeze), 
a [ScalaNLP projet](http://www.scalanlp.org/). 


Our example is a linear programing problem given as follows. 
The unknown variables  $p_{ij}$ have a tabular structure 
$$P=\begin{pmatrix}
p_{11} & p_{12} & p_{13} \\
p_{21} & p_{22} & p_{23} \\
p_{31} & p_{32} & p_{33} 
\end{pmatrix},$$
 are constrained by the following 
linear equality/inequality constraints:
$$\begin{cases}
{\rm (1a) } \quad \sum_j p_{ij} = \mu(a_i) & \forall i \\ 
{\rm (1b) } \quad \sum_i p_{ij} = \nu(a_j) & \forall j \\
{\rm (2) } \quad  p_{ij} \geq 0 & \forall i,j \\
\end{cases}$$
where $\mu$ and $\nu$ are two probability vectors, taken to be 
$$ \mu=\left(\frac{1}{7},\frac{1}{7},\frac{1}{7}\right) 
\qquad 
\text{and } \qquad 
\mu=\left(\frac{1}{4},\frac{1}{4},\frac{1}{2}\right) 
$$
in our example, and the desideratum is to minimize the linear combination 
$$ \sum_{i,j} D_{ij}p_{ij}$$ 
where $D$ is a distance matrix, taken to be 
$$ D = \begin{pmatrix}
0 & 1 & 1 \\
1 & 0 & 1 \\
1 & 1 & 0 
\end{pmatrix}$$ 
in our example.


## Breeze expressions

The linear programming solver provided by `Breeze` is based on 
[Apache's Simplex Solver](http://google-opensource.blogspot.be/2009/06/introducing-apache-commons-math.html). 
Most linear programming solvers are conceived to take as input the 
matrix of linear constraints, and this is quite annoying to construct 
this matrix in our situation: for the linear equality constraints this matrix is 
$$
A=\begin{pmatrix} M_1 \\ M_2 \end{pmatrix} 
$$
where 
$$ M_1 = \begin{pmatrix}
1 & 1 & 1 & 0 & 0 & 0 & 0 & 0 & 0 \\
 0 & 0 & 0 & 1 & 1 & 1  & 0 & 0 & 0 \\
 0 & 0 & 0 & 0 & 0 & 0 & 1 & 1 & 1  
\end{pmatrix} $$
defines the linear equality constraints corresponding to $\mu$ 
and 
$$ M_2 = \begin{pmatrix}
1 & 0 & 0 & 1 & 0 & 0 & 1 & 0 & 0 \\
 0 & 1 & 0 & 0 & 1 & 0  & 0 & 1 & 0 \\
 0 & 0 & 1 & 0 & 0 & 1 & 0 & 0 & 1  
\end{pmatrix}. $$
defines the linear equality constraints corresponding to $\nu$. 
See how I defined these matrices 
[using R](http://stla.github.io/stlapblog/posts/KantorovichWithR.html) and 
[using Julia](http://stla.github.io/stlapblog/posts/KantorovichWithJulia.html) (with the 
`GLPK` library), it was a bit tricky or a bit painful.


[As we have seen](http://stla.github.io/stlapblog/posts/KantorovichWithJulia.html), the Julia 
`JuMP` package provides a very convenient way to *write*, and maybe more importantly, to *read*, 
the linear programing problem, using 
*expressions* to define the unknown variables $p_{ij}$, the objective function and the 
constraints, which avoids in particular to construct the $A$ matrix :


```r
using JuMP 

 mu = [1/7, 2/7, 4/7]
 nu = [1/4, 1/4, 1/2]
 n = length(mu)
 
 m = Model()
 @defVar(m, p[1:n,1:n] >= 0)
 @setObjective(m, Min, sum{p[i,j], i in 1:n, j in 1:n; i != j})
 
 for k in 1:n
 @addConstraint(m, sum(p[k,:]) == mu[k])
 @addConstraint(m, sum(p[:,k]) == nu[k])
 end
 solve(m)
```

Using the Scala `breeze` library we also set the problem by using expressions. 
This is not as concise as the Julia JuMP library and this requires 
a bit of gymnastics with the Scala language, but essentially the spirit is the same: 
we write the problem, using expressions. 
Another Java library, [WVLPsolver](http://www.win-vector.com/blog/2012/11/yet-another-java-linear-programming-library/), allows to encode the problem with a syntax closer to the one 
of `JuMP`, but I have never tried it yet. 
Anyway there is no difficuly with `breeze` once you get a basic knowledge in the 
Scala language: mainly you only have to use a new type, `Expression`, a member of the 
`lp` object.


## Scala breeze in action 

First, we define the probability measures $\mu$ and $\nu$ between which we want the Kantorovich distance to be computed, and the distance matrix $D$:


```r
var Mu = Array(1.0/7, 2.0/7, 4.0/7)
var Nu = Array(1.0/4, 1.0/4, 1.0/2)
val n = Mu.length
val D =  Array.fill(n,n)(0)
for( i <- 0 to n-1 ) 
  for( j <- 0 to n-1 )
		if( !(i==j) ) D(i)(j) = 1
```

To show an array in Scala, do:

```r
scala> println(D.deep.mkString("\n"))
Array(0, 1, 1)
Array(1, 0, 1)
Array(1, 1, 0)
```

Before introducing the $P$ matrix of variables, we need to create a new linear 
programing object:


```r
val lp = new breeze.optimize.linear.LinearProgram()
```

and then we can define $P$ as an array of `Real` variables:


```r
val P =  Array.fill(n,n)(lp.Real())
```

Here is our matrix of unknown variables:


```r
scala> println(P.deep.mkString("\n"))
Array(x_0, x_1, x_2)
Array(x_3, x_4, x_5)
Array(x_6, x_7, x_8)
```

The following code defines the objective function as an expression:

```r
val Objective = ( 
for( i <- 0 to 2 ) 
  	yield ( 
			for( (x, a) <- P(i) zip D(i) ) 
				yield (x * a) 
			).reduce(_ + _)
).reduce(_ + _) 
```


```r
scala> println(Objective)
(x_0) * 0.0 + (x_1) * 1.0 + (x_2) * 1.0 + (x_3) * 1.0 + (x_4) * 0.0 + (x_5) * 1.0 + (x_6) * 1.0 + (x_7) * 1.0 + (x_8) * 0.0
```

Let us explain the above code. The following command returns the scalar product of two vectors 
`V1` and `V2`:

```r
for( (x, a) <- V1 zip V2 ) yield (x * a) ).reduce(_ + _)
```

Then our code firstly generates the scalar product (as an expression) of the $i$-th line `P(i)` of $P$ and the 
$i$-th line `D(i)` of $D$, for every $i=0,1,2$ (indexation starts at $0$ in Scala, not at $1$), 
and then it generates the sum of these three scalar products, which is the 
expression for our objective function.

Now we define the constraints in a `Constraint` array. 
There are $2n$ equality constraints and $n^2$ positivity (inequality) constraints, 
we will store them in this array:


```r
var Constraints = new Array[lp.Constraint](2*n+n*n)
```

The equality constraints are about the sum of the variables in each row and each column of 
the $P$ matrix. We set them as follows:


```r
val tP=P.transpose
for (i <- 0 to n-1) {
  Constraints(i) = P(i).reduce[lp.Expression](_ + _)  =:=  Mu(i)  
  Constraints(i+n) = tP(i).reduce[lp.Expression](_ + _)  =:=  Nu(i)
}
```

And finally we set the positivity constraints as follows:


```r
for (i <- 0 to n-1) {
  var k = 2*n + n*i
  for (j <- 0 to n-1) Constraints(k+j) = P(i)(j) >=0 
}
```

There's quite bit of gymnastics in the previous code... I'll possibly simplify it in a future 
version, as I'm at my first steps with Scala `breeze`.

Since the library only allows to maximize the objective function, whereas we aim to 
minimize it, we take its opposite in the following  `lpp` object which fully 
represents our linear programing problem :


```r
val lpp = ( 
  -Objective
  subjectTo( Constraints:_* )
)
val result = lp.maximize(lpp)
```

And then we get the Kantorovich distance:


```r
scala> println(-result.value)
0.1071428571428571
```

which almost achieves the best 64-bit precision approximation of the exact value $3/28$: 


```r
scala> println(3.0/28)
0.10714285714285714
```



