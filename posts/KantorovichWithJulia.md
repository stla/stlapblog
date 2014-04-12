---
title: Using Julia to compute the Kantorovich distance
date : 2014-04-09
--- &lead





 In the article ['Using R to compute the Kantorovich distance'](http://stla.github.io/stlapblog/posts/KantorovichWithR.html) I have shown how to use the [cddlibb C library](http://web.mit.edu/sage/export/tmp/cddlib-094b/doc/cddlibman.pdf) through R with the help of the [rccd R package](http://cran.r-project.org/web/packages/rcdd/vignettes/vinny.pdf) to compute the Kantorovich distance between two probability measures (on a finite set). In the present article I show how to do so using [Julia](http://julialang.org/). 
 Similarly to the R way, the Julia way uses a C library, the [GLPK (GNU Linear Programming Kit)](http://www.gnu.org/software/glpk/) library, wrapped in a Julia package, named [GLPK](http://docs.julialang.org/en/release-0.1/stdlib/glpk/) too. 
 

## Data of the problem

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
Note that we have defined $D$ by `1.-eye(n)` and not `1-eye(n)` which 
is ambiguous in Julia, because of type compatibility:


```r
julia> eye(n)
3x3 Array{Float64,2}:
 1.0  0.0  0.0
 0.0  1.0  0.0
 0.0  0.0  1.0

julia> typeof(1)
Int64

julia> typeof(1.)
Float64
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


Now we specify the positivity constraints $p_{ij} \geq 0$ about the variables $p_{ij}$ corresponding to the columns of the constraint matrix:


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


