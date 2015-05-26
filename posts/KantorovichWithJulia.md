---
title: Using Julia to compute the Kantorovich distance
date : 2014-04-09
--- &lead





 In the article ['Using R to compute the Kantorovich distance'](http://stla.github.io/stlapblog/posts/KantorovichWithR.html) I have shown how to use the [cddlibb C library](http://web.mit.edu/sage/export/tmp/cddlib-094b/doc/cddlibman.pdf) through R with the help of the [rccd R package](http://cran.r-project.org/web/packages/rcdd/vignettes/vinny.pdf) to compute the Kantorovich distance between two probability measures (on a finite set). In the present article I show how to do so using three 
 different ways with [Julia](http://julialang.org/):
 
  - **GLPK**:  Similarly to the R way, this Julia way uses a C library, the [GLPK (GNU Linear Programming Kit)](http://www.gnu.org/software/glpk/) library, wrapped in a Julia package, named [GLPK](https://gplkjl.readthedocs.org/en/latest/glpk.html) too. 
 
  - **JuMP**: Using the [JuMP](https://github.com/JuliaOpt/JuMP.jl) Julia library, a [JuliaOpt](http://juliaopt.org/) project.
 
  - **RationalSimplex**: Using Iain Dunning's [RationalSimplex](https://github.com/IainNZ/RationalSimplex.jl) module: 
 *Pure Julia implementation of the simplex algorithm for rational numbers*. This way is the only one allowing to get 
 the exact value when dealing with rational numbers.


In the current version of this article, I will only detail the `GLPK` method. 
I express my gratitude to all 
guys on [julia-users](https://groups.google.com/forum/#!forum/julia-users) 
who kindly provided me their unvaluable help for this article.


# GLPK library

I will try to explain in details the approach using `GLPK`, 
without assuming the reader has some knowledge about Julia.

## Setting the data of the problem

First, we define the probability measures $\mu$ and $\nu$ between which we want the Kantorovich distance to be computed.


```r
mu = [1/7, 2/7, 4/7]
nu = [1/4, 1/4, 1/2]
```


Recall that the Kantorovich distance is defined from an initial distance which we take to be the $0-1$ distance, and is represented in the $D$ matrix defined as follows with Julia:


```r
n = length(mu)
D = 1.-eye(n);
```



```r
julia> D
3x3 Array{Float64,2}:
 0.0  1.0  1.0
 1.0  0.0  1.0
 1.0  1.0  0.0
```


Thus, the Julia `eye` function is similar to the R `diag` function. 

Note that we have defined $D$ by typing "`1.-eye(n)`" and not "`1-eye(n)`" which 
is ambiguous because "`1`" and "`eye(n)`" have not the same size...  
I'm afraid you are puzzled because you don't know whether "`1.-eye(n)`" is 

```r
1. - eye(n)
```

or

```r
1 .- eye(n)
```

? Don't worry, this is very easy to know with Julia, you can get the structure of "`1.-eye(n)`" as an 
expression:


```r
julia> :(1.-eye(n))
:(.-(1,eye(n)))
```


That means the operator "`.-`" acts on the integer "`1`" and the matrix "`eye(n)`", whereas "`1. - eye(n)`" is the expression 
for the operator "`-`"  acting on the float "`1.`" and "`eye(n)`":


```r
julia> :(1. - eye(n))
:(-(1.0,eye(n)))
```



## Constraint matrix

The constraints matrix is 
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

I define these matrices as follows in Julia:


```r
M1=zeros(n,n*n)
for i in 1:n
        M1[i,(1:n)+n*(i-1)]=1
end
M2=repmat(eye(n),1,n)
A=vcat(M1,M2);
```



```r
julia> A
6x9 Array{Float64,2}:
 1.0  1.0  1.0  0.0  0.0  0.0  0.0  0.0  0.0
 0.0  0.0  0.0  1.0  1.0  1.0  0.0  0.0  0.0
 0.0  0.0  0.0  0.0  0.0  0.0  1.0  1.0  1.0
 1.0  0.0  0.0  1.0  0.0  0.0  1.0  0.0  0.0
 0.0  1.0  0.0  0.0  1.0  0.0  0.0  1.0  0.0
 0.0  0.0  1.0  0.0  0.0  1.0  0.0  0.0  1.0
```



Recall that the constraints of our problem are the linear equality constraints 
$$M_1 P = \begin{pmatrix} \mu(a_1) \\ \mu(a_2) \\ \mu(a_3) \end{pmatrix} 
\qquad \text{and} \qquad 
M_2 P = \begin{pmatrix} \nu(a_1) \\ \nu(a_2) \\ \nu(a_3) \end{pmatrix}$$ 
where $P$ is the vector formed by the variables $p_{ij} \geq 0$.

## GLPK in action 

First load the package, initialize the problem, and give it a name:


```r
import GLPK 
lp = GLPK.Prob()
GLPK.set_prob_name(lp, "kanto")
```


Computing the Kantorovich distance is a minimization problem, declared as follows:


```r
GLPK.set_obj_dir(lp, GLPK.MIN)
```


(`obj` refers to *objective function*, the function to be optimized).

Now we use the `GLPK.set_row_bnds` function to  set the hand side vector (the *bounds*) 
of the linear constraints and to specify the type of 
our constraints. Here these are *equality* constraints and this type is specified by `GLPK.FX`:


```r
GLPK.add_rows(lp, size(A,1))
for i in 1:n
    GLPK.set_row_bnds(lp, i, GLPK.FX, mu[i], mu[i])
    GLPK.set_row_bnds(lp, i+n, GLPK.FX, nu[i], nu[i])
end
```


Now we specify the positivity constraints $p_{ij} \geq 0$ about the variables $p_{ij}$ 
corresponding to the columns of the constraint matrix, and we attach to each column the 
corresponding coefficient of the objective function, given here by the matrix $D$:


```r
GLPK.add_cols(lp, size(A,2))
k=0
for i in 1:n, j in 1:n
    k = k+1
    GLPK.set_col_bnds(lp, k, GLPK.LO, 0.0, 0.0)
    GLPK.set_obj_coef(lp, k, D[i,j])
end
```


We are ready ! Load the matrix, run the algorithm :


```r
GLPK.load_matrix(lp, sparse(A))
GLPK.simplex(lp);
```


and get the solution:


```r
julia> GLPK.get_obj_val(lp)
0.10714285714285715
```


As we have seen in the [previous article](http://stla.github.io/stlapblog/posts/KantorovichWithR.html), the exact Kantorovich distance between $\mu$ and $\nu$ is $\dfrac{3}{28}$:


```r
julia> 3/28
0.10714285714285714
```


Have you noticed the results are *not* exactly the same:


```r
julia> GLPK.get_obj_val(lp) - 3/28
1.3877787807814457e-17
```


Thus, the `GLPK.simplex` method does not achieve 
the best approximation of $3/28$ in the 64 bit precision. A better 
precision is achieved by the  `GLPK.exact` function:


```r
GLPK.exact(lp);
```



```r
julia> GLPK.get_obj_val(lp) - 3/28
0.0
```


However, unfortunately, it is not possible to get the rational number $3/28$ 
with `GLPK`. 


# JuMP library

The `JuMP` library allows a very convenient syntax. As compared to `GLPK`, no matrix gymnastics is needed. 
Watch this concision: 


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



```r
julia> println("Optimal objective value is:", getObjectiveValue(m))
Optimal objective value is:0.10714285714285715

julia> 3/28
0.10714285714285714
```


As you can see, the best 64-bit precision approximation is not achieved. 
But it is possible to get it. 
`JuMP` uses a solver, and we have not specified any solver. 
Then `JuMP` (actually `MathProgBase)` will search for an available solver and pick one by default. 
We can use `GLPK.exact` by calling the `GLPKMathProgInterface` library and specifying the solver 
in the `Model` function: 


```r
using GLPKMathProgInterface
m = Model(solver=GLPKSolverLP(method=:Exact))
```


Then re-run the rest of the code, and you'll get:

```r
julia> getObjectiveValue(m)
0.10714285714285714
```



# RationalSimplex 

The `RationalSimplex` module allows to get the exact Kantorovich distance as a rational number 
as long as $\mu$ and $\nu$ have rational weights. 
Rational numbers are specified in Julia with a double slash: 

```r
mu=  [1//7, 2//7, 4//7]
nu = [1//4, 1//4, 1//2]
```


We will not use matrix gymnastics to construct the constraint matrix $A$ with rational entries, we define it 
in Julia with our bare hands below.  


```r
include("myfolder/RationalSimplex.jl") 
using RationalSimplex
using Base.Test

b = [mu, nu]  # 'row bounds'
c = [0//1, 1//1, 1//1, 1//1, 0//1, 1//1, 1//1, 1//1, 0//1]  #  objective coefficients attached to the columns (D matrix in stacked form)
A = [1//1 1//1 1//1 0//1 0//1 0//1 0//1 0//1 0//1;
     0//1 0//1 0//1 1//1 1//1 1//1 0//1 0//1 0//1;
     0//1 0//1 0//1 0//1 0//1 0//1 1//1 1//1 1//1;
     1//1 0//1 0//1 1//1 0//1 0//1 1//1 0//1 0//1;
     0//1 1//1 0//1 0//1 1//1 0//1 0//1 1//1 0//1;
     0//1 0//1 1//1 0//1 0//1 1//1 0//1 0//1 1//1]

x = status, simplex(c, :Min, A, b, ['=','=','=','=','=','=']);
```


The `simplex` function provides the solution of the linear programming problem, that is, the values of 
$p_{ij}$ achieving the Kantorovich distance:


```r
julia> x
9-element Array{Rational{Int64},1}:
 1//7 
 0//1 
 0//1 
 1//28
 1//4 
 0//1 
 1//14
 0//1 
 1//2 
```


The Kantorovich distance is then obtained as the scalar product of `c` with the solution: 


```r
julia> dot(c,x)
3//28
```




