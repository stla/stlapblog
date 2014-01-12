---
title: Schematizing the variance as a moment of inertia
date : 2013-10-06
--- &lead








In order to make a presentation, I was wondering how to display the variance of a distribution or the variance of a sample on a graphic. Finally, I've found this solution:


![plot of chunk gaussian](assets/fig/varinertia-gaussian.png) 


What is this "ellipse" with an arrow ? This is a picture commonly used in classical mechanics to represent the moment of inertia of a body spinning around an axis of rotation. The variance of a distribution has an interpretation as a moment of inertia: the body is a very thin sheet of metal whose shape is the area under the graph of the density and whose mass is $1$, and the axis of rotation is the vertical axis through the mean of the distribution. Thus the variance measures how hard it is to spin this metal sheet. Under this interpretation, the standard deviation is termed as *gyroscopic radius*, or *radius of gyration*, of the metal sheet. 


### Drawing the ellipse in R

I have written my own function `inertia()` to draw this picture. Its main arguments are shown in the following figure (made with R and then converted to a TikZ LaTeX picture with the awesome [tikzDevice](https://github.com/yihui/tikzDevice) package):


```r
inertia(x0, y0, a, b, r, l, d, s, w)
```


<object data="assets/fig/inertiaellipse.pdf" type="application/pdf" width="550px" height="400px">
 
  <p>It appears you don't have a PDF plugin for this browser.
  No biggie... you can <a href="assets/fig/inertiaellipse.pdf">click here to
  download the PDF file.</a></p>
  
</object>


### Application: decomposition of variance 

As shown in the first figure, the ellipse is useful to display the variance of a theoretical distribution. 
In my presentation, I have also used it to explain the decomposition of the sample variance: 





![plot of chunk dsv](assets/fig/varinertia-dsv.png) 


And I have also used the moment of inertia representation to explain the one-way random effect ANOVA model, which is commonly used to model the decomposition of variance:

![plot of chunk anovarandommodel](assets/fig/varinertia-anovarandommodel.png) 


