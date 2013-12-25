---
title: Including an interactive 3D `rgl` graphic in a html report with `knitr`
author: Stéphane Laurent
date : 2013-03-08
--- &lead




I posted [a question on StackOverflow](http://stackoverflow.com/questions/14879210/including-a-interactive-3d-figure-with-knitr): *how to embed an interactive 3D figure created with the `rgl` package into an html report created with `knitr` ?* The next day, Yihui Xie has posted a solution. He has updated `knitr` to include this possibility. 


The first example
--------------------------------

Below is the rendering of the example given by Yihui.


```r
library(rgl)
knit_hooks$set(webgl = hook_webgl)
```



```r
x <- sort(rnorm(1000))
y <- rnorm(1000)
z <- rnorm(1000) + atan2(x, y)
open3d()
plot3d(x, y, z, col = rainbow(1000))
```

<script src="CanvasMatrix.js" type="text/javascript"></script>
<canvas id="rgl_firstexampletextureCanvas" style="display: none;" width="256" height="256">
<img src="rgl_firstexamplesnapshot.png" alt="rgl_firstexamplesnapshot" width=505/><br>
	Your browser does not support the HTML5 canvas element.</canvas>
<!-- ****** points object 6 ****** -->
<script id="rgl_firstexamplevshader6" type="x-shader/x-vertex">
	attribute vec3 aPos;
	attribute vec4 aCol;
	uniform mat4 mvMatrix;
	uniform mat4 prMatrix;
	varying vec4 vCol;
	varying vec4 vPosition;
	void main(void) {
	  vPosition = mvMatrix * vec4(aPos, 1.);
	  gl_Position = prMatrix * vPosition;
	  gl_PointSize = 3.;
	  vCol = aCol;
	}
</script>
<script id="rgl_firstexamplefshader6" type="x-shader/x-fragment"> 
	#ifdef GL_ES
	precision highp float;
	#endif
	varying vec4 vCol; // carries alpha
	varying vec4 vPosition;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  gl_FragColor = lighteffect;
	}
</script> 
<!-- ****** text object 8 ****** -->
<script id="rgl_firstexamplevshader8" type="x-shader/x-vertex">
	attribute vec3 aPos;
	attribute vec4 aCol;
	uniform mat4 mvMatrix;
	uniform mat4 prMatrix;
	varying vec4 vCol;
	varying vec4 vPosition;
	attribute vec2 aTexcoord;
	varying vec2 vTexcoord;
	attribute vec2 aOfs;
	void main(void) {
	  vCol = aCol;
	  vTexcoord = aTexcoord;
	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
	  pos = pos/pos.w;
	  gl_Position = pos + vec4(aOfs, 0.,0.);
	}
</script>
<script id="rgl_firstexamplefshader8" type="x-shader/x-fragment"> 
	#ifdef GL_ES
	precision highp float;
	#endif
	varying vec4 vCol; // carries alpha
	varying vec4 vPosition;
	varying vec2 vTexcoord;
	uniform sampler2D uSampler;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
	  if (textureColor.a < 0.1)
	    discard;
	  else
	    gl_FragColor = textureColor;
	}
</script> 
<!-- ****** text object 9 ****** -->
<script id="rgl_firstexamplevshader9" type="x-shader/x-vertex">
	attribute vec3 aPos;
	attribute vec4 aCol;
	uniform mat4 mvMatrix;
	uniform mat4 prMatrix;
	varying vec4 vCol;
	varying vec4 vPosition;
	attribute vec2 aTexcoord;
	varying vec2 vTexcoord;
	attribute vec2 aOfs;
	void main(void) {
	  vCol = aCol;
	  vTexcoord = aTexcoord;
	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
	  pos = pos/pos.w;
	  gl_Position = pos + vec4(aOfs, 0.,0.);
	}
</script>
<script id="rgl_firstexamplefshader9" type="x-shader/x-fragment"> 
	#ifdef GL_ES
	precision highp float;
	#endif
	varying vec4 vCol; // carries alpha
	varying vec4 vPosition;
	varying vec2 vTexcoord;
	uniform sampler2D uSampler;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
	  if (textureColor.a < 0.1)
	    discard;
	  else
	    gl_FragColor = textureColor;
	}
</script> 
<!-- ****** text object 10 ****** -->
<script id="rgl_firstexamplevshader10" type="x-shader/x-vertex">
	attribute vec3 aPos;
	attribute vec4 aCol;
	uniform mat4 mvMatrix;
	uniform mat4 prMatrix;
	varying vec4 vCol;
	varying vec4 vPosition;
	attribute vec2 aTexcoord;
	varying vec2 vTexcoord;
	attribute vec2 aOfs;
	void main(void) {
	  vCol = aCol;
	  vTexcoord = aTexcoord;
	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
	  pos = pos/pos.w;
	  gl_Position = pos + vec4(aOfs, 0.,0.);
	}
</script>
<script id="rgl_firstexamplefshader10" type="x-shader/x-fragment"> 
	#ifdef GL_ES
	precision highp float;
	#endif
	varying vec4 vCol; // carries alpha
	varying vec4 vPosition;
	varying vec2 vTexcoord;
	uniform sampler2D uSampler;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
	  if (textureColor.a < 0.1)
	    discard;
	  else
	    gl_FragColor = textureColor;
	}
</script> 
<!-- ****** lines object 11 ****** -->
<script id="rgl_firstexamplevshader11" type="x-shader/x-vertex">
	attribute vec3 aPos;
	attribute vec4 aCol;
	uniform mat4 mvMatrix;
	uniform mat4 prMatrix;
	varying vec4 vCol;
	varying vec4 vPosition;
	void main(void) {
	  vPosition = mvMatrix * vec4(aPos, 1.);
	  gl_Position = prMatrix * vPosition;
	  vCol = aCol;
	}
</script>
<script id="rgl_firstexamplefshader11" type="x-shader/x-fragment"> 
	#ifdef GL_ES
	precision highp float;
	#endif
	varying vec4 vCol; // carries alpha
	varying vec4 vPosition;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  gl_FragColor = lighteffect;
	}
</script> 
<!-- ****** text object 12 ****** -->
<script id="rgl_firstexamplevshader12" type="x-shader/x-vertex">
	attribute vec3 aPos;
	attribute vec4 aCol;
	uniform mat4 mvMatrix;
	uniform mat4 prMatrix;
	varying vec4 vCol;
	varying vec4 vPosition;
	attribute vec2 aTexcoord;
	varying vec2 vTexcoord;
	attribute vec2 aOfs;
	void main(void) {
	  vCol = aCol;
	  vTexcoord = aTexcoord;
	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
	  pos = pos/pos.w;
	  gl_Position = pos + vec4(aOfs, 0.,0.);
	}
</script>
<script id="rgl_firstexamplefshader12" type="x-shader/x-fragment"> 
	#ifdef GL_ES
	precision highp float;
	#endif
	varying vec4 vCol; // carries alpha
	varying vec4 vPosition;
	varying vec2 vTexcoord;
	uniform sampler2D uSampler;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
	  if (textureColor.a < 0.1)
	    discard;
	  else
	    gl_FragColor = textureColor;
	}
</script> 
<!-- ****** lines object 13 ****** -->
<script id="rgl_firstexamplevshader13" type="x-shader/x-vertex">
	attribute vec3 aPos;
	attribute vec4 aCol;
	uniform mat4 mvMatrix;
	uniform mat4 prMatrix;
	varying vec4 vCol;
	varying vec4 vPosition;
	void main(void) {
	  vPosition = mvMatrix * vec4(aPos, 1.);
	  gl_Position = prMatrix * vPosition;
	  vCol = aCol;
	}
</script>
<script id="rgl_firstexamplefshader13" type="x-shader/x-fragment"> 
	#ifdef GL_ES
	precision highp float;
	#endif
	varying vec4 vCol; // carries alpha
	varying vec4 vPosition;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  gl_FragColor = lighteffect;
	}
</script> 
<!-- ****** text object 14 ****** -->
<script id="rgl_firstexamplevshader14" type="x-shader/x-vertex">
	attribute vec3 aPos;
	attribute vec4 aCol;
	uniform mat4 mvMatrix;
	uniform mat4 prMatrix;
	varying vec4 vCol;
	varying vec4 vPosition;
	attribute vec2 aTexcoord;
	varying vec2 vTexcoord;
	attribute vec2 aOfs;
	void main(void) {
	  vCol = aCol;
	  vTexcoord = aTexcoord;
	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
	  pos = pos/pos.w;
	  gl_Position = pos + vec4(aOfs, 0.,0.);
	}
</script>
<script id="rgl_firstexamplefshader14" type="x-shader/x-fragment"> 
	#ifdef GL_ES
	precision highp float;
	#endif
	varying vec4 vCol; // carries alpha
	varying vec4 vPosition;
	varying vec2 vTexcoord;
	uniform sampler2D uSampler;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
	  if (textureColor.a < 0.1)
	    discard;
	  else
	    gl_FragColor = textureColor;
	}
</script> 
<!-- ****** lines object 15 ****** -->
<script id="rgl_firstexamplevshader15" type="x-shader/x-vertex">
	attribute vec3 aPos;
	attribute vec4 aCol;
	uniform mat4 mvMatrix;
	uniform mat4 prMatrix;
	varying vec4 vCol;
	varying vec4 vPosition;
	void main(void) {
	  vPosition = mvMatrix * vec4(aPos, 1.);
	  gl_Position = prMatrix * vPosition;
	  vCol = aCol;
	}
</script>
<script id="rgl_firstexamplefshader15" type="x-shader/x-fragment"> 
	#ifdef GL_ES
	precision highp float;
	#endif
	varying vec4 vCol; // carries alpha
	varying vec4 vPosition;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  gl_FragColor = lighteffect;
	}
</script> 
<!-- ****** text object 16 ****** -->
<script id="rgl_firstexamplevshader16" type="x-shader/x-vertex">
	attribute vec3 aPos;
	attribute vec4 aCol;
	uniform mat4 mvMatrix;
	uniform mat4 prMatrix;
	varying vec4 vCol;
	varying vec4 vPosition;
	attribute vec2 aTexcoord;
	varying vec2 vTexcoord;
	attribute vec2 aOfs;
	void main(void) {
	  vCol = aCol;
	  vTexcoord = aTexcoord;
	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
	  pos = pos/pos.w;
	  gl_Position = pos + vec4(aOfs, 0.,0.);
	}
</script>
<script id="rgl_firstexamplefshader16" type="x-shader/x-fragment"> 
	#ifdef GL_ES
	precision highp float;
	#endif
	varying vec4 vCol; // carries alpha
	varying vec4 vPosition;
	varying vec2 vTexcoord;
	uniform sampler2D uSampler;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
	  if (textureColor.a < 0.1)
	    discard;
	  else
	    gl_FragColor = textureColor;
	}
</script> 
<!-- ****** lines object 17 ****** -->
<script id="rgl_firstexamplevshader17" type="x-shader/x-vertex">
	attribute vec3 aPos;
	attribute vec4 aCol;
	uniform mat4 mvMatrix;
	uniform mat4 prMatrix;
	varying vec4 vCol;
	varying vec4 vPosition;
	void main(void) {
	  vPosition = mvMatrix * vec4(aPos, 1.);
	  gl_Position = prMatrix * vPosition;
	  vCol = aCol;
	}
</script>
<script id="rgl_firstexamplefshader17" type="x-shader/x-fragment"> 
	#ifdef GL_ES
	precision highp float;
	#endif
	varying vec4 vCol; // carries alpha
	varying vec4 vPosition;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  gl_FragColor = lighteffect;
	}
</script> 
<script type="text/javascript"> 
	function getShader ( gl, id ){
	   var shaderScript = document.getElementById ( id );
	   var str = "";
	   var k = shaderScript.firstChild;
	   while ( k ){
	     if ( k.nodeType == 3 ) str += k.textContent;
	     k = k.nextSibling;
	   }
	   var shader;
	   if ( shaderScript.type == "x-shader/x-fragment" )
             shader = gl.createShader ( gl.FRAGMENT_SHADER );
	   else if ( shaderScript.type == "x-shader/x-vertex" )
             shader = gl.createShader(gl.VERTEX_SHADER);
	   else return null;
	   gl.shaderSource(shader, str);
	   gl.compileShader(shader);
	   if (gl.getShaderParameter(shader, gl.COMPILE_STATUS) == 0)
	     alert(gl.getShaderInfoLog(shader));
	   return shader;
	}
	var min = Math.min;
	var max = Math.max;
	var sqrt = Math.sqrt;
	var sin = Math.sin;
	var acos = Math.acos;
	var tan = Math.tan;
	var SQRT2 = Math.SQRT2;
	var PI = Math.PI;
	var log = Math.log;
	var exp = Math.exp;
	function rgl_firstexamplewebGLStart() {
	   var debug = function(msg) {
	     document.getElementById("rgl_firstexampledebug").innerHTML = msg;
	   }
	   debug("");
	   var canvas = document.getElementById("rgl_firstexamplecanvas");
	   if (!window.WebGLRenderingContext){
	     debug("<img src=\"rgl_firstexamplesnapshot.png\" alt=\"rgl_firstexamplesnapshot\" width=505/><br> Your browser does not support WebGL. See <a href=\"http://get.webgl.org\">http://get.webgl.org</a>");
	     return;
	   }
	   var gl;
	   try {
	     // Try to grab the standard context. If it fails, fallback to experimental.
	     gl = canvas.getContext("webgl") 
	       || canvas.getContext("experimental-webgl");
	   }
	   catch(e) {}
	   if ( !gl ) {
	     debug("<img src=\"rgl_firstexamplesnapshot.png\" alt=\"rgl_firstexamplesnapshot\" width=505/><br> Your browser appears to support WebGL, but did not create a WebGL context.  See <a href=\"http://get.webgl.org\">http://get.webgl.org</a>");
	     return;
	   }
	   var width = 505;  var height = 505;
	   canvas.width = width;   canvas.height = height;
	   gl.viewport(0, 0, width, height);
	   var prMatrix = new CanvasMatrix4();
	   var mvMatrix = new CanvasMatrix4();
	   var normMatrix = new CanvasMatrix4();
	   var saveMat = new CanvasMatrix4();
	   saveMat.makeIdentity();
	   var distance;
	   var posLoc = 0;
	   var colLoc = 1;
	   var zoom = 1;
	   var fov = 30;
	   var userMatrix = new CanvasMatrix4();
	   userMatrix.load([
	    1, 0, 0, 0,
	    0, 0.3420201, -0.9396926, 0,
	    0, 0.9396926, 0.3420201, 0,
	    0, 0, 0, 1
		]);
	   function getPowerOfTwo(value) {
	     var pow = 1;
	     while(pow<value) {
	       pow *= 2;
	     }
	     return pow;
	   }
	   function handleLoadedTexture(texture, textureCanvas) {
	     gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, true);
	     gl.bindTexture(gl.TEXTURE_2D, texture);
	     gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, textureCanvas);
	     gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);
	     gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_NEAREST);
	     gl.generateMipmap(gl.TEXTURE_2D);
	     gl.bindTexture(gl.TEXTURE_2D, null);
	   }
	   function loadImageToTexture(filename, texture) {   
	     var canvas = document.getElementById("rgl_firstexampletextureCanvas");
	     var ctx = canvas.getContext("2d");
	     var image = new Image();
	     image.onload = function() {
	       var w = image.width;
	       var h = image.height;
	       var canvasX = getPowerOfTwo(w);
	       var canvasY = getPowerOfTwo(h);
	       canvas.width = canvasX;
	       canvas.height = canvasY;
	       ctx.imageSmoothingEnabled = true;
	       ctx.drawImage(image, 0, 0, canvasX, canvasY);
	       handleLoadedTexture(texture, canvas);
   	       drawScene();
	     }
	     image.src = filename;
	   }  	   
	   function drawTextToCanvas(text, cex) {
	     var canvasX, canvasY;
	     var textX, textY;
	     var textHeight = 20 * cex;
	     var textColour = "white";
	     var fontFamily = "Arial";
	     var backgroundColour = "rgba(0,0,0,0)";
	     var canvas = document.getElementById("rgl_firstexampletextureCanvas");
	     var ctx = canvas.getContext("2d");
	     ctx.font = textHeight+"px "+fontFamily;
             canvasX = 1;
             var widths = [];
	     for (var i = 0; i < text.length; i++)  {
	       widths[i] = ctx.measureText(text[i]).width;
	       canvasX = (widths[i] > canvasX) ? widths[i] : canvasX;
	     }	  
	     canvasX = getPowerOfTwo(canvasX);
	     var offset = 2*textHeight; // offset to first baseline
	     var skip = 2*textHeight;   // skip between baselines	  
	     canvasY = getPowerOfTwo(offset + text.length*skip);
	     canvas.width = canvasX;
	     canvas.height = canvasY;
	     ctx.fillStyle = backgroundColour;
	     ctx.fillRect(0, 0, ctx.canvas.width, ctx.canvas.height);
	     ctx.fillStyle = textColour;
	     ctx.textAlign = "left";
	     ctx.textBaseline = "alphabetic";
	     ctx.font = textHeight+"px "+fontFamily;
	     for(var i = 0; i < text.length; i++) {
	       textY = i*skip + offset;
	       ctx.fillText(text[i], 0,  textY);
	     }
	     return {canvasX:canvasX, canvasY:canvasY,
	             widths:widths, textHeight:textHeight,
	             offset:offset, skip:skip};
	   }
	   // ****** points object 6 ******
	   var prog6  = gl.createProgram();
	   gl.attachShader(prog6, getShader( gl, "rgl_firstexamplevshader6" ));
	   gl.attachShader(prog6, getShader( gl, "rgl_firstexamplefshader6" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog6, 0, "aPos");
	   gl.bindAttribLocation(prog6, 1, "aCol");
	   gl.linkProgram(prog6);
	   var v=new Float32Array([
	    -3.206011, -0.6968233, -1.317109, 1, 0, 0, 1,
	    -3.125606, -0.9596732, -2.349029, 1, 0.007843138, 0, 1,
	    -3.056304, -0.9859542, -2.65001, 1, 0.01176471, 0, 1,
	    -3.025981, -1.377647, -1.739416, 1, 0.01960784, 0, 1,
	    -2.908216, -0.8224134, -1.092607, 1, 0.02352941, 0, 1,
	    -2.817703, -0.4495989, -1.345363, 1, 0.03137255, 0, 1,
	    -2.753176, -0.3006659, -2.909802, 1, 0.03529412, 0, 1,
	    -2.724789, 0.2506256, -0.8465738, 1, 0.04313726, 0, 1,
	    -2.658983, 0.2339697, 0.3767034, 1, 0.04705882, 0, 1,
	    -2.586367, 0.6688897, -1.183101, 1, 0.05490196, 0, 1,
	    -2.498393, 1.733487, -0.3367065, 1, 0.05882353, 0, 1,
	    -2.435162, -0.7378803, -2.006091, 1, 0.06666667, 0, 1,
	    -2.414936, -0.04096865, -2.463229, 1, 0.07058824, 0, 1,
	    -2.399494, 1.537789, -0.367052, 1, 0.07843138, 0, 1,
	    -2.368184, 1.948305, -1.483622, 1, 0.08235294, 0, 1,
	    -2.282809, 0.5218251, -1.043389, 1, 0.09019608, 0, 1,
	    -2.232491, -0.2773895, -2.061578, 1, 0.09411765, 0, 1,
	    -2.190572, 1.558808, -0.3693432, 1, 0.1019608, 0, 1,
	    -2.177002, 0.8482946, -0.06665003, 1, 0.1098039, 0, 1,
	    -2.17416, -0.7514893, -2.288032, 1, 0.1137255, 0, 1,
	    -2.026129, 0.4052263, -1.922197, 1, 0.1215686, 0, 1,
	    -1.999711, -0.5412346, -1.246703, 1, 0.1254902, 0, 1,
	    -1.98358, -0.4018426, -1.704043, 1, 0.1333333, 0, 1,
	    -1.945591, 2.125422, -0.8687109, 1, 0.1372549, 0, 1,
	    -1.874304, -0.1517382, -0.4327123, 1, 0.145098, 0, 1,
	    -1.872273, -0.4294272, -3.163652, 1, 0.1490196, 0, 1,
	    -1.837264, -0.3684782, -1.533716, 1, 0.1568628, 0, 1,
	    -1.829728, 0.1141884, 0.2575598, 1, 0.1607843, 0, 1,
	    -1.823266, 0.6867809, -2.507376, 1, 0.1686275, 0, 1,
	    -1.809182, 0.3445449, -2.989775, 1, 0.172549, 0, 1,
	    -1.796521, 1.306623, -0.4235655, 1, 0.1803922, 0, 1,
	    -1.786262, 1.144134, 0.3159339, 1, 0.1843137, 0, 1,
	    -1.767877, 1.674553, -0.1152322, 1, 0.1921569, 0, 1,
	    -1.744601, -0.970907, -2.042643, 1, 0.1960784, 0, 1,
	    -1.742381, -0.7020188, -0.5855191, 1, 0.2039216, 0, 1,
	    -1.714689, -0.4141381, -1.402554, 1, 0.2117647, 0, 1,
	    -1.694344, -0.09016845, -1.065972, 1, 0.2156863, 0, 1,
	    -1.688085, 0.007553862, -3.425834, 1, 0.2235294, 0, 1,
	    -1.68189, 1.924608, -1.254881, 1, 0.227451, 0, 1,
	    -1.679261, 0.5305083, -0.7016987, 1, 0.2352941, 0, 1,
	    -1.678006, -2.188883, -1.836043, 1, 0.2392157, 0, 1,
	    -1.663766, -0.1118968, -2.875142, 1, 0.2470588, 0, 1,
	    -1.660169, 1.551674, -1.005772, 1, 0.2509804, 0, 1,
	    -1.657808, 0.8913616, 0.2241514, 1, 0.2588235, 0, 1,
	    -1.651026, -1.149853, -0.6342434, 1, 0.2627451, 0, 1,
	    -1.631533, -0.1570585, -1.900465, 1, 0.2705882, 0, 1,
	    -1.62437, 0.7775806, -1.263972, 1, 0.2745098, 0, 1,
	    -1.609774, -1.391195, -2.191466, 1, 0.282353, 0, 1,
	    -1.605586, 0.1475277, -0.4507205, 1, 0.2862745, 0, 1,
	    -1.590415, -1.130071, -2.725384, 1, 0.2941177, 0, 1,
	    -1.582067, -1.166924, -2.323663, 1, 0.3019608, 0, 1,
	    -1.577767, -0.6531824, -2.073488, 1, 0.3058824, 0, 1,
	    -1.56851, -1.759042, -2.277734, 1, 0.3137255, 0, 1,
	    -1.559646, -1.369823, -2.828964, 1, 0.3176471, 0, 1,
	    -1.558025, 0.5783548, -2.160744, 1, 0.3254902, 0, 1,
	    -1.55389, 0.3849225, -0.3979177, 1, 0.3294118, 0, 1,
	    -1.544249, 1.277902, 0.1076461, 1, 0.3372549, 0, 1,
	    -1.517799, -0.9523636, -1.739052, 1, 0.3411765, 0, 1,
	    -1.516486, 1.195412, 0.1676967, 1, 0.3490196, 0, 1,
	    -1.502224, 0.2715793, -2.462512, 1, 0.3529412, 0, 1,
	    -1.500205, -0.4503142, -2.410597, 1, 0.3607843, 0, 1,
	    -1.495187, -1.449003, -1.413841, 1, 0.3647059, 0, 1,
	    -1.487476, -0.4982873, -0.4711562, 1, 0.372549, 0, 1,
	    -1.481866, 0.4910333, -0.1890969, 1, 0.3764706, 0, 1,
	    -1.479253, -1.527948, -3.261934, 1, 0.3843137, 0, 1,
	    -1.456747, 1.218784, -2.189497, 1, 0.3882353, 0, 1,
	    -1.45107, 1.26433, -1.568847, 1, 0.3960784, 0, 1,
	    -1.448611, 0.06567863, -0.7772028, 1, 0.4039216, 0, 1,
	    -1.446065, -1.435373, -1.551956, 1, 0.4078431, 0, 1,
	    -1.435863, 0.4204661, -2.478436, 1, 0.4156863, 0, 1,
	    -1.433494, 0.2287669, -2.637198, 1, 0.4196078, 0, 1,
	    -1.431148, -0.9677075, -2.693716, 1, 0.427451, 0, 1,
	    -1.397866, -2.105532, -2.960158, 1, 0.4313726, 0, 1,
	    -1.392754, -0.7270948, -1.836956, 1, 0.4392157, 0, 1,
	    -1.390321, 2.238794, -0.7990025, 1, 0.4431373, 0, 1,
	    -1.377805, 1.418086, -2.385722, 1, 0.4509804, 0, 1,
	    -1.374822, -1.868377, -3.422113, 1, 0.454902, 0, 1,
	    -1.368854, -1.110347, -1.704604, 1, 0.4627451, 0, 1,
	    -1.366409, 0.9332472, -1.141542, 1, 0.4666667, 0, 1,
	    -1.36464, 1.223799, -3.104, 1, 0.4745098, 0, 1,
	    -1.362221, 0.8241305, -2.103766, 1, 0.4784314, 0, 1,
	    -1.361713, -0.5719857, -0.7638423, 1, 0.4862745, 0, 1,
	    -1.354551, -0.8788649, -3.514705, 1, 0.4901961, 0, 1,
	    -1.350175, -0.3958691, -2.606578, 1, 0.4980392, 0, 1,
	    -1.347982, -0.2813923, -0.9593391, 1, 0.5058824, 0, 1,
	    -1.334758, -0.6704361, -2.394077, 1, 0.509804, 0, 1,
	    -1.334181, 0.959968, -1.896804, 1, 0.5176471, 0, 1,
	    -1.328303, 1.173122, -0.055553, 1, 0.5215687, 0, 1,
	    -1.322671, -1.139594, -3.229372, 1, 0.5294118, 0, 1,
	    -1.317865, -0.9201587, -1.166532, 1, 0.5333334, 0, 1,
	    -1.30552, 0.1777568, -1.817745, 1, 0.5411765, 0, 1,
	    -1.302201, -0.8698261, -2.748324, 1, 0.5450981, 0, 1,
	    -1.300855, 0.0616991, -1.522096, 1, 0.5529412, 0, 1,
	    -1.29665, -1.77736, -3.136102, 1, 0.5568628, 0, 1,
	    -1.286385, 0.5530087, 0.457762, 1, 0.5647059, 0, 1,
	    -1.281426, -1.346786, -2.685084, 1, 0.5686275, 0, 1,
	    -1.278282, -0.5544788, -0.2121102, 1, 0.5764706, 0, 1,
	    -1.267758, -1.776843, -4.006947, 1, 0.5803922, 0, 1,
	    -1.26562, -0.01203811, -2.79986, 1, 0.5882353, 0, 1,
	    -1.264002, -0.05536168, -2.733157, 1, 0.5921569, 0, 1,
	    -1.261544, -1.155452, -3.175059, 1, 0.6, 0, 1,
	    -1.261383, -0.6150656, -1.992362, 1, 0.6078432, 0, 1,
	    -1.259836, 0.3157047, -2.154622, 1, 0.6117647, 0, 1,
	    -1.259719, -1.097277, -1.493768, 1, 0.6196079, 0, 1,
	    -1.257868, -0.4066449, -3.248971, 1, 0.6235294, 0, 1,
	    -1.237429, -0.8188156, -3.006545, 1, 0.6313726, 0, 1,
	    -1.234979, -0.9405161, -0.8372556, 1, 0.6352941, 0, 1,
	    -1.229187, -2.835307, -0.5852296, 1, 0.6431373, 0, 1,
	    -1.227199, 0.006664114, -2.2474, 1, 0.6470588, 0, 1,
	    -1.221696, 1.202785, -0.8070486, 1, 0.654902, 0, 1,
	    -1.208388, -1.250291, -2.804793, 1, 0.6588235, 0, 1,
	    -1.201918, -1.219492, -2.573922, 1, 0.6666667, 0, 1,
	    -1.198978, -1.58654, -3.885734, 1, 0.6705883, 0, 1,
	    -1.198929, -0.442984, -3.093083, 1, 0.6784314, 0, 1,
	    -1.192703, -0.005826969, -2.001458, 1, 0.682353, 0, 1,
	    -1.189888, -0.5403445, -1.289492, 1, 0.6901961, 0, 1,
	    -1.183654, -0.01653915, -2.177375, 1, 0.6941177, 0, 1,
	    -1.181195, -1.211895, -3.762695, 1, 0.7019608, 0, 1,
	    -1.181042, 1.150149, -2.422067, 1, 0.7098039, 0, 1,
	    -1.177067, -1.035619, -2.910722, 1, 0.7137255, 0, 1,
	    -1.170381, -0.1904724, -3.478837, 1, 0.7215686, 0, 1,
	    -1.161231, 1.241875, -3.089154, 1, 0.7254902, 0, 1,
	    -1.157481, -0.3806906, -2.820256, 1, 0.7333333, 0, 1,
	    -1.154416, -0.9907277, -1.993038, 1, 0.7372549, 0, 1,
	    -1.151996, -0.9923984, -1.074862, 1, 0.7450981, 0, 1,
	    -1.150622, 0.6043392, -0.4697319, 1, 0.7490196, 0, 1,
	    -1.129021, -0.9563475, -1.673628, 1, 0.7568628, 0, 1,
	    -1.127676, -0.6124732, -2.56661, 1, 0.7607843, 0, 1,
	    -1.127675, 0.294029, -0.8149548, 1, 0.7686275, 0, 1,
	    -1.114205, -0.8517656, -2.696726, 1, 0.772549, 0, 1,
	    -1.10523, 0.1639553, -1.413594, 1, 0.7803922, 0, 1,
	    -1.104945, 0.8247522, -0.340867, 1, 0.7843137, 0, 1,
	    -1.099918, -0.4362441, -1.416674, 1, 0.7921569, 0, 1,
	    -1.098798, 0.3558795, 1.14369, 1, 0.7960784, 0, 1,
	    -1.098224, 1.57859, -1.782936, 1, 0.8039216, 0, 1,
	    -1.09734, 0.6306693, -1.512291, 1, 0.8117647, 0, 1,
	    -1.079576, -0.33311, -1.980111, 1, 0.8156863, 0, 1,
	    -1.072323, 0.3920573, -2.28238, 1, 0.8235294, 0, 1,
	    -1.072129, -1.498741, -1.438125, 1, 0.827451, 0, 1,
	    -1.070794, 0.251171, -0.4158264, 1, 0.8352941, 0, 1,
	    -1.066124, -0.6944228, -2.930939, 1, 0.8392157, 0, 1,
	    -1.064985, -0.3311593, -0.3579825, 1, 0.8470588, 0, 1,
	    -1.059288, 0.5862589, 1.998149, 1, 0.8509804, 0, 1,
	    -1.056697, 0.06434868, -2.66971, 1, 0.8588235, 0, 1,
	    -1.049494, 0.0273481, -2.243173, 1, 0.8627451, 0, 1,
	    -1.038018, 2.246392, 0.02026409, 1, 0.8705882, 0, 1,
	    -1.033239, 0.206304, 0.789028, 1, 0.8745098, 0, 1,
	    -1.031608, 1.473878, -0.8579083, 1, 0.8823529, 0, 1,
	    -1.029155, 1.908396, -1.552735, 1, 0.8862745, 0, 1,
	    -1.019819, 0.9427844, -2.13419, 1, 0.8941177, 0, 1,
	    -1.012107, -1.315381, -2.409992, 1, 0.8980392, 0, 1,
	    -1.001182, 0.8629911, -0.8829952, 1, 0.9058824, 0, 1,
	    -0.9956033, -1.015255, -2.857231, 1, 0.9137255, 0, 1,
	    -0.9936909, -0.08091544, -1.770875, 1, 0.9176471, 0, 1,
	    -0.990528, 0.007475648, -0.5352464, 1, 0.9254902, 0, 1,
	    -0.9882468, -1.687886, -2.941717, 1, 0.9294118, 0, 1,
	    -0.984939, 0.2893296, -0.397835, 1, 0.9372549, 0, 1,
	    -0.9789142, -2.097961, -3.054425, 1, 0.9411765, 0, 1,
	    -0.9752902, -0.7523138, -2.310418, 1, 0.9490196, 0, 1,
	    -0.9741756, 2.297085, -1.468715, 1, 0.9529412, 0, 1,
	    -0.9645601, -0.6393567, -1.907484, 1, 0.9607843, 0, 1,
	    -0.9638131, 0.2115955, -1.836865, 1, 0.9647059, 0, 1,
	    -0.9601809, 0.4235116, -1.901924, 1, 0.972549, 0, 1,
	    -0.9549435, 0.454731, -1.860139, 1, 0.9764706, 0, 1,
	    -0.9540233, 1.211738, -0.6242356, 1, 0.9843137, 0, 1,
	    -0.9493707, -0.2844602, -1.0373, 1, 0.9882353, 0, 1,
	    -0.9489499, -0.3136424, -2.496548, 1, 0.9960784, 0, 1,
	    -0.9482809, -0.3702798, -1.463371, 0.9960784, 1, 0, 1,
	    -0.9471197, -0.2796853, -2.573157, 0.9921569, 1, 0, 1,
	    -0.9459103, 1.697808, -0.9857304, 0.9843137, 1, 0, 1,
	    -0.9438277, -0.3293561, -2.149763, 0.9803922, 1, 0, 1,
	    -0.9429844, -0.6034313, -2.696163, 0.972549, 1, 0, 1,
	    -0.9355584, 1.636863, -0.1313502, 0.9686275, 1, 0, 1,
	    -0.9284101, -0.513359, -3.218772, 0.9607843, 1, 0, 1,
	    -0.9262112, -1.434971, -2.712301, 0.9568627, 1, 0, 1,
	    -0.9249209, 0.293517, -1.227745, 0.9490196, 1, 0, 1,
	    -0.9244846, -1.654473, -2.810989, 0.945098, 1, 0, 1,
	    -0.9225535, 1.642233, 0.7982382, 0.9372549, 1, 0, 1,
	    -0.9208933, -0.9122541, -2.546329, 0.9333333, 1, 0, 1,
	    -0.9202375, -1.077555, -3.28295, 0.9254902, 1, 0, 1,
	    -0.9179167, -1.665098, -2.615122, 0.9215686, 1, 0, 1,
	    -0.916701, -0.7289862, -1.643026, 0.9137255, 1, 0, 1,
	    -0.9146268, -0.6926028, -2.226096, 0.9098039, 1, 0, 1,
	    -0.9131194, 1.666104, -1.10458, 0.9019608, 1, 0, 1,
	    -0.9095702, -1.281367, -3.019892, 0.8941177, 1, 0, 1,
	    -0.9082242, 1.1133, 0.2734427, 0.8901961, 1, 0, 1,
	    -0.9054201, 0.9921191, -1.63958, 0.8823529, 1, 0, 1,
	    -0.9000407, 0.3140371, -1.960985, 0.8784314, 1, 0, 1,
	    -0.8908021, 0.301003, -2.327635, 0.8705882, 1, 0, 1,
	    -0.8901947, 1.57461, -0.5000219, 0.8666667, 1, 0, 1,
	    -0.8895169, -0.174906, -2.070348, 0.8588235, 1, 0, 1,
	    -0.8859836, 0.863254, -2.268066, 0.854902, 1, 0, 1,
	    -0.872634, 0.5008854, -1.002009, 0.8470588, 1, 0, 1,
	    -0.868904, 0.1306127, -2.398384, 0.8431373, 1, 0, 1,
	    -0.8680042, 0.4925651, -1.456358, 0.8352941, 1, 0, 1,
	    -0.8669298, 0.1265105, -1.543153, 0.8313726, 1, 0, 1,
	    -0.8660868, 0.223404, -1.668691, 0.8235294, 1, 0, 1,
	    -0.8652733, 0.1330564, -0.4299532, 0.8196079, 1, 0, 1,
	    -0.865187, 0.2368597, -0.8988033, 0.8117647, 1, 0, 1,
	    -0.8603221, 0.2668419, -1.803151, 0.8078431, 1, 0, 1,
	    -0.8600369, -0.219019, -2.118698, 0.8, 1, 0, 1,
	    -0.8550055, 0.06499859, -1.677841, 0.7921569, 1, 0, 1,
	    -0.8423212, 0.6956889, -1.000788, 0.7882353, 1, 0, 1,
	    -0.8382066, -2.787895, -0.2888413, 0.7803922, 1, 0, 1,
	    -0.8299954, -0.2000831, -1.635665, 0.7764706, 1, 0, 1,
	    -0.8230659, -0.3254097, -2.301682, 0.7686275, 1, 0, 1,
	    -0.8199734, 1.47791, -0.459643, 0.7647059, 1, 0, 1,
	    -0.8195343, -0.2666733, -3.550447, 0.7568628, 1, 0, 1,
	    -0.8155081, 0.665974, -0.5024378, 0.7529412, 1, 0, 1,
	    -0.8152287, -1.236932, -4.063577, 0.7450981, 1, 0, 1,
	    -0.8127922, 0.2145685, -0.06082042, 0.7411765, 1, 0, 1,
	    -0.8035653, -0.2126794, -1.743386, 0.7333333, 1, 0, 1,
	    -0.800555, 0.3792527, -1.398578, 0.7294118, 1, 0, 1,
	    -0.7978187, -0.8345565, -1.832141, 0.7215686, 1, 0, 1,
	    -0.7942131, 0.691721, -0.3564442, 0.7176471, 1, 0, 1,
	    -0.7941204, 1.540187, -1.176562, 0.7098039, 1, 0, 1,
	    -0.7887419, 0.3314828, -1.686763, 0.7058824, 1, 0, 1,
	    -0.7872452, 0.169972, -0.002534243, 0.6980392, 1, 0, 1,
	    -0.7759835, -0.5175288, -1.851284, 0.6901961, 1, 0, 1,
	    -0.7598227, 1.168842, -0.3569785, 0.6862745, 1, 0, 1,
	    -0.7581177, -0.2543323, -2.030318, 0.6784314, 1, 0, 1,
	    -0.7556937, -1.324599, -3.221867, 0.6745098, 1, 0, 1,
	    -0.7548431, 0.005451335, -1.256565, 0.6666667, 1, 0, 1,
	    -0.7546332, -1.346193, -3.186618, 0.6627451, 1, 0, 1,
	    -0.7520533, -0.2034462, -1.181123, 0.654902, 1, 0, 1,
	    -0.747045, 1.050238, 0.7319451, 0.6509804, 1, 0, 1,
	    -0.7408056, 1.248747, 0.8324127, 0.6431373, 1, 0, 1,
	    -0.7349732, -1.805408, -3.573345, 0.6392157, 1, 0, 1,
	    -0.7335692, -0.9276333, -3.94667, 0.6313726, 1, 0, 1,
	    -0.7300261, -1.060038, -2.363424, 0.627451, 1, 0, 1,
	    -0.7248474, 0.8266039, 0.08229572, 0.6196079, 1, 0, 1,
	    -0.723946, -0.8137735, -3.980027, 0.6156863, 1, 0, 1,
	    -0.7206243, 1.390016, 0.2808666, 0.6078432, 1, 0, 1,
	    -0.7118368, -1.957428, -3.147039, 0.6039216, 1, 0, 1,
	    -0.7104864, 0.212429, -2.062724, 0.5960785, 1, 0, 1,
	    -0.6961938, 0.7242023, -0.2281204, 0.5882353, 1, 0, 1,
	    -0.6945575, 1.539282, 0.2491439, 0.5843138, 1, 0, 1,
	    -0.6943916, -0.2497983, -1.364804, 0.5764706, 1, 0, 1,
	    -0.6940019, 1.239542, 0.09858612, 0.572549, 1, 0, 1,
	    -0.6922475, 0.6464811, -1.124201, 0.5647059, 1, 0, 1,
	    -0.687749, -0.04149075, -1.672348, 0.5607843, 1, 0, 1,
	    -0.683371, 0.1983301, -1.608073, 0.5529412, 1, 0, 1,
	    -0.6782246, 0.2961782, -0.5158498, 0.5490196, 1, 0, 1,
	    -0.6770238, -1.030941, -3.584261, 0.5411765, 1, 0, 1,
	    -0.6721292, -0.6781119, -0.5121669, 0.5372549, 1, 0, 1,
	    -0.6721083, -0.06909563, -1.40684, 0.5294118, 1, 0, 1,
	    -0.6696073, -0.06898538, -2.003, 0.5254902, 1, 0, 1,
	    -0.6690608, -0.5242832, -1.795069, 0.5176471, 1, 0, 1,
	    -0.6634864, 0.5621698, -1.664863, 0.5137255, 1, 0, 1,
	    -0.6613302, 0.4852941, -1.76923, 0.5058824, 1, 0, 1,
	    -0.6607991, -0.6877348, -2.540647, 0.5019608, 1, 0, 1,
	    -0.6592866, 0.6705053, 0.8193524, 0.4941176, 1, 0, 1,
	    -0.6480843, -0.07745072, -1.649009, 0.4862745, 1, 0, 1,
	    -0.646282, -1.795975, -1.745912, 0.4823529, 1, 0, 1,
	    -0.6460918, -1.514632, -2.723973, 0.4745098, 1, 0, 1,
	    -0.6419085, -1.767779, -1.719807, 0.4705882, 1, 0, 1,
	    -0.6399384, -0.3202138, -0.722797, 0.4627451, 1, 0, 1,
	    -0.6376237, 0.9334382, -0.4388912, 0.4588235, 1, 0, 1,
	    -0.635004, 2.492639, -0.1420762, 0.4509804, 1, 0, 1,
	    -0.6349637, 1.123023, -0.6810742, 0.4470588, 1, 0, 1,
	    -0.6348128, 0.3147657, -1.770977, 0.4392157, 1, 0, 1,
	    -0.6342344, -1.794875, -4.658028, 0.4352941, 1, 0, 1,
	    -0.6328056, -1.182989, -2.198586, 0.427451, 1, 0, 1,
	    -0.6319376, -1.076281, -3.346121, 0.4235294, 1, 0, 1,
	    -0.6308288, -0.5957699, -1.855194, 0.4156863, 1, 0, 1,
	    -0.6259105, 0.2454856, 0.4598466, 0.4117647, 1, 0, 1,
	    -0.6258785, 0.4827327, 0.2031568, 0.4039216, 1, 0, 1,
	    -0.6212519, 0.7184036, -1.181844, 0.3960784, 1, 0, 1,
	    -0.6114495, -0.2410961, -0.4208185, 0.3921569, 1, 0, 1,
	    -0.610459, 0.61625, -1.214839, 0.3843137, 1, 0, 1,
	    -0.6075656, 1.390083, -1.603688, 0.3803922, 1, 0, 1,
	    -0.6058842, 1.199872, -0.5995526, 0.372549, 1, 0, 1,
	    -0.6043729, -0.3753103, -3.473771, 0.3686275, 1, 0, 1,
	    -0.6043366, 0.5045722, -1.8779, 0.3607843, 1, 0, 1,
	    -0.601116, -1.72342, -2.657353, 0.3568628, 1, 0, 1,
	    -0.6001441, 0.5688923, -0.5172259, 0.3490196, 1, 0, 1,
	    -0.5977799, 0.3904271, 1.159434, 0.345098, 1, 0, 1,
	    -0.5955682, -0.04102825, -2.021806, 0.3372549, 1, 0, 1,
	    -0.5951998, 0.3912114, -1.298668, 0.3333333, 1, 0, 1,
	    -0.5941516, -1.340374, -2.450378, 0.3254902, 1, 0, 1,
	    -0.5939142, -0.6201313, -2.736396, 0.3215686, 1, 0, 1,
	    -0.59096, 0.1193924, -2.85931, 0.3137255, 1, 0, 1,
	    -0.5900765, -0.1376763, -1.640245, 0.3098039, 1, 0, 1,
	    -0.587508, 0.6264464, -1.467884, 0.3019608, 1, 0, 1,
	    -0.5872302, -0.2755095, -1.599559, 0.2941177, 1, 0, 1,
	    -0.5869815, 0.1100325, -1.500922, 0.2901961, 1, 0, 1,
	    -0.5789945, 2.77775, -0.5130012, 0.282353, 1, 0, 1,
	    -0.5763732, 1.692423, -0.2203717, 0.2784314, 1, 0, 1,
	    -0.5738362, -1.539269, -0.5628892, 0.2705882, 1, 0, 1,
	    -0.5637181, 0.2041452, -0.1610244, 0.2666667, 1, 0, 1,
	    -0.5572152, -0.106594, -0.2722324, 0.2588235, 1, 0, 1,
	    -0.5486693, -0.6307892, -1.527178, 0.254902, 1, 0, 1,
	    -0.5486605, 1.700757, -0.1224292, 0.2470588, 1, 0, 1,
	    -0.5470011, -0.4791205, -1.672478, 0.2431373, 1, 0, 1,
	    -0.54663, -1.653645, -3.705328, 0.2352941, 1, 0, 1,
	    -0.5447968, 0.423165, -3.42785, 0.2313726, 1, 0, 1,
	    -0.5382541, -0.5128884, -2.160973, 0.2235294, 1, 0, 1,
	    -0.5376349, -2.362521, -2.73806, 0.2196078, 1, 0, 1,
	    -0.5375261, 1.531859, 2.183112, 0.2117647, 1, 0, 1,
	    -0.5341247, -0.5210887, -2.828946, 0.2078431, 1, 0, 1,
	    -0.524501, 1.937658, -1.383668, 0.2, 1, 0, 1,
	    -0.524148, 1.16831, -1.298487, 0.1921569, 1, 0, 1,
	    -0.5170556, -0.937801, -2.205594, 0.1882353, 1, 0, 1,
	    -0.5154893, -0.6437415, -3.619008, 0.1803922, 1, 0, 1,
	    -0.508199, 0.2633702, -0.7283653, 0.1764706, 1, 0, 1,
	    -0.5068876, 0.2877843, -0.7279438, 0.1686275, 1, 0, 1,
	    -0.4992236, -2.035663, -2.727523, 0.1647059, 1, 0, 1,
	    -0.4931711, 0.6764995, -1.106667, 0.1568628, 1, 0, 1,
	    -0.4860485, 0.07388426, -1.683512, 0.1529412, 1, 0, 1,
	    -0.4856404, -0.8815483, -2.147389, 0.145098, 1, 0, 1,
	    -0.4843506, 2.541093, -1.484653, 0.1411765, 1, 0, 1,
	    -0.4788537, 1.092451, 0.6028163, 0.1333333, 1, 0, 1,
	    -0.4782182, 0.1324218, -1.281599, 0.1294118, 1, 0, 1,
	    -0.4763907, -0.02220809, -1.078132, 0.1215686, 1, 0, 1,
	    -0.468006, 0.9236349, -1.51748, 0.1176471, 1, 0, 1,
	    -0.4662457, 0.8501627, 0.5480745, 0.1098039, 1, 0, 1,
	    -0.4649791, -1.145134, -1.320854, 0.1058824, 1, 0, 1,
	    -0.4560649, 0.521324, -0.7800512, 0.09803922, 1, 0, 1,
	    -0.4531114, 0.0587834, -0.874491, 0.09019608, 1, 0, 1,
	    -0.4505089, -0.1281527, -2.904048, 0.08627451, 1, 0, 1,
	    -0.4486772, -0.4626983, -2.63474, 0.07843138, 1, 0, 1,
	    -0.4483565, -1.341499, -3.549524, 0.07450981, 1, 0, 1,
	    -0.4444659, 0.5493199, -0.7968617, 0.06666667, 1, 0, 1,
	    -0.4411925, 0.5832308, -1.324159, 0.0627451, 1, 0, 1,
	    -0.4391346, 0.1890785, -0.3799358, 0.05490196, 1, 0, 1,
	    -0.4366882, 0.3554963, -2.040896, 0.05098039, 1, 0, 1,
	    -0.4330063, 1.5482, -0.2807791, 0.04313726, 1, 0, 1,
	    -0.4323993, -0.7816637, -2.368961, 0.03921569, 1, 0, 1,
	    -0.4224855, -0.4001288, -3.072361, 0.03137255, 1, 0, 1,
	    -0.4193147, -0.1570253, -1.587619, 0.02745098, 1, 0, 1,
	    -0.4141847, 1.133633, 0.05676531, 0.01960784, 1, 0, 1,
	    -0.4115479, 1.848757, -1.485138, 0.01568628, 1, 0, 1,
	    -0.4110208, -1.252771, -1.315974, 0.007843138, 1, 0, 1,
	    -0.4020151, 0.7359548, 0.09157988, 0.003921569, 1, 0, 1,
	    -0.3956803, 0.152073, -2.234746, 0, 1, 0.003921569, 1,
	    -0.3951182, 0.9135479, -1.215478, 0, 1, 0.01176471, 1,
	    -0.3939147, -0.8269333, -2.737246, 0, 1, 0.01568628, 1,
	    -0.3926148, 1.527448, -0.8439846, 0, 1, 0.02352941, 1,
	    -0.3909937, -0.500334, -0.426852, 0, 1, 0.02745098, 1,
	    -0.3872916, -0.2050478, -1.374038, 0, 1, 0.03529412, 1,
	    -0.3861201, -0.9611759, -5.373685, 0, 1, 0.03921569, 1,
	    -0.3787364, -0.7695464, -2.658889, 0, 1, 0.04705882, 1,
	    -0.3779125, 0.3723266, 0.3928991, 0, 1, 0.05098039, 1,
	    -0.3778147, 0.3086281, -0.3397941, 0, 1, 0.05882353, 1,
	    -0.3777766, -0.1099278, -1.676605, 0, 1, 0.0627451, 1,
	    -0.3768988, 0.9341567, 1.911289, 0, 1, 0.07058824, 1,
	    -0.374146, -0.4225954, -2.295893, 0, 1, 0.07450981, 1,
	    -0.3706278, 0.3472794, -1.944185, 0, 1, 0.08235294, 1,
	    -0.3702463, -1.608392, -1.857493, 0, 1, 0.08627451, 1,
	    -0.3697797, -0.6045061, -1.681382, 0, 1, 0.09411765, 1,
	    -0.3694124, -1.273345, -1.645874, 0, 1, 0.1019608, 1,
	    -0.367972, 0.8716695, -0.4832659, 0, 1, 0.1058824, 1,
	    -0.3633358, -0.9089356, -2.752164, 0, 1, 0.1137255, 1,
	    -0.3627649, 1.959071, -1.043203, 0, 1, 0.1176471, 1,
	    -0.3621489, -1.525035, -1.791563, 0, 1, 0.1254902, 1,
	    -0.3589315, -0.4596881, -1.59134, 0, 1, 0.1294118, 1,
	    -0.352898, 1.561368, 0.6144641, 0, 1, 0.1372549, 1,
	    -0.3513223, 1.137762, -1.313355, 0, 1, 0.1411765, 1,
	    -0.3501465, -1.904987, -3.527908, 0, 1, 0.1490196, 1,
	    -0.3415931, 0.09843023, -2.153501, 0, 1, 0.1529412, 1,
	    -0.3374827, -0.5802683, -2.51797, 0, 1, 0.1607843, 1,
	    -0.3371906, -0.8867295, -4.032938, 0, 1, 0.1647059, 1,
	    -0.3294914, 0.9225308, -1.40012, 0, 1, 0.172549, 1,
	    -0.329058, -0.1288987, -2.202766, 0, 1, 0.1764706, 1,
	    -0.3287458, -1.145009, -2.691712, 0, 1, 0.1843137, 1,
	    -0.3279969, 0.3142821, 1.377459, 0, 1, 0.1882353, 1,
	    -0.3244051, -0.1395535, -2.01816, 0, 1, 0.1960784, 1,
	    -0.3191361, 1.052483, -1.643263, 0, 1, 0.2039216, 1,
	    -0.3182081, 0.1096938, 0.3061847, 0, 1, 0.2078431, 1,
	    -0.3103786, -0.568617, -3.435642, 0, 1, 0.2156863, 1,
	    -0.3091632, 0.6407683, -1.851235, 0, 1, 0.2196078, 1,
	    -0.3066521, 0.5695307, -0.3053693, 0, 1, 0.227451, 1,
	    -0.2992696, 0.5199506, -0.5940842, 0, 1, 0.2313726, 1,
	    -0.2979194, -2.55081, -4.073174, 0, 1, 0.2392157, 1,
	    -0.2977206, 0.01681861, -1.125162, 0, 1, 0.2431373, 1,
	    -0.2972208, -0.468614, -1.994026, 0, 1, 0.2509804, 1,
	    -0.2950196, -0.4628725, -3.219893, 0, 1, 0.254902, 1,
	    -0.2861146, -2.659477, -1.94709, 0, 1, 0.2627451, 1,
	    -0.2860161, -1.109659, -3.985043, 0, 1, 0.2666667, 1,
	    -0.2848388, -0.864952, -2.948591, 0, 1, 0.2745098, 1,
	    -0.2839777, -0.6611825, -3.265527, 0, 1, 0.2784314, 1,
	    -0.2764505, 0.5982413, -0.5552652, 0, 1, 0.2862745, 1,
	    -0.2753235, 1.808158, -0.005412784, 0, 1, 0.2901961, 1,
	    -0.2726402, 0.0757311, -0.5352837, 0, 1, 0.2980392, 1,
	    -0.2685125, 0.5116611, -0.9092578, 0, 1, 0.3058824, 1,
	    -0.2599178, -0.5057001, -4.912987, 0, 1, 0.3098039, 1,
	    -0.2546884, 0.3685384, 0.8224435, 0, 1, 0.3176471, 1,
	    -0.251709, 0.09750444, -1.621396, 0, 1, 0.3215686, 1,
	    -0.2509826, 0.5698973, -1.067055, 0, 1, 0.3294118, 1,
	    -0.2479602, -0.3042234, -2.116124, 0, 1, 0.3333333, 1,
	    -0.2462189, -1.366552, -2.618431, 0, 1, 0.3411765, 1,
	    -0.2431258, -0.4755999, -3.003848, 0, 1, 0.345098, 1,
	    -0.2368064, 0.8519423, 1.396122, 0, 1, 0.3529412, 1,
	    -0.2319289, 0.1899395, -1.734401, 0, 1, 0.3568628, 1,
	    -0.2291183, -0.5513277, -1.878664, 0, 1, 0.3647059, 1,
	    -0.2283442, -1.419251, -3.522405, 0, 1, 0.3686275, 1,
	    -0.2282036, -0.9537941, -2.42967, 0, 1, 0.3764706, 1,
	    -0.2258371, 0.6661838, -0.1976869, 0, 1, 0.3803922, 1,
	    -0.221184, -0.973426, -0.7727112, 0, 1, 0.3882353, 1,
	    -0.2187444, -0.708207, -3.23944, 0, 1, 0.3921569, 1,
	    -0.2173367, 1.205872, -0.06425764, 0, 1, 0.4, 1,
	    -0.2102592, 1.800629, -0.2618497, 0, 1, 0.4078431, 1,
	    -0.2064385, 2.586092, -0.4046633, 0, 1, 0.4117647, 1,
	    -0.1990632, -0.9120617, -1.479133, 0, 1, 0.4196078, 1,
	    -0.1982195, 0.257655, -0.6322333, 0, 1, 0.4235294, 1,
	    -0.1850974, -0.4405783, -2.891677, 0, 1, 0.4313726, 1,
	    -0.1834542, 0.5242832, -2.42099, 0, 1, 0.4352941, 1,
	    -0.1808873, -1.258141, -4.272715, 0, 1, 0.4431373, 1,
	    -0.1736753, -0.1840556, -3.524102, 0, 1, 0.4470588, 1,
	    -0.169332, 0.4370676, -1.366068, 0, 1, 0.454902, 1,
	    -0.1644481, 0.5713714, -1.872359, 0, 1, 0.4588235, 1,
	    -0.164194, -0.5087478, -3.440329, 0, 1, 0.4666667, 1,
	    -0.1639291, 0.7371416, 1.321792, 0, 1, 0.4705882, 1,
	    -0.1607348, -1.13628, -4.240522, 0, 1, 0.4784314, 1,
	    -0.1595875, -0.1294388, -1.720764, 0, 1, 0.4823529, 1,
	    -0.1588789, -0.5205315, -2.484666, 0, 1, 0.4901961, 1,
	    -0.1576384, -1.205162, -2.612719, 0, 1, 0.4941176, 1,
	    -0.1519042, -0.3935417, -3.073921, 0, 1, 0.5019608, 1,
	    -0.1483788, -0.6946605, -1.43883, 0, 1, 0.509804, 1,
	    -0.1482931, 0.8870038, 0.428528, 0, 1, 0.5137255, 1,
	    -0.1443002, -2.121304, -4.31051, 0, 1, 0.5215687, 1,
	    -0.1440388, -1.246542, -1.795799, 0, 1, 0.5254902, 1,
	    -0.1410708, -1.053622, -1.941707, 0, 1, 0.5333334, 1,
	    -0.1346425, -0.417093, -5.457557, 0, 1, 0.5372549, 1,
	    -0.1330197, -0.7531713, -1.523192, 0, 1, 0.5450981, 1,
	    -0.1315193, -0.6389526, -5.138313, 0, 1, 0.5490196, 1,
	    -0.1301557, 0.05131019, 0.1624079, 0, 1, 0.5568628, 1,
	    -0.1301179, 0.7579199, -0.4668727, 0, 1, 0.5607843, 1,
	    -0.1291435, -0.4106735, -3.926053, 0, 1, 0.5686275, 1,
	    -0.1289324, -0.1686093, -2.933324, 0, 1, 0.572549, 1,
	    -0.1278344, -0.9528213, -3.200392, 0, 1, 0.5803922, 1,
	    -0.1264723, -1.179995, -3.329069, 0, 1, 0.5843138, 1,
	    -0.1252646, 3.677751, 2.014769, 0, 1, 0.5921569, 1,
	    -0.116666, -0.7471302, -2.388108, 0, 1, 0.5960785, 1,
	    -0.1088517, 0.3523045, -0.5988368, 0, 1, 0.6039216, 1,
	    -0.1079225, -1.055384, -2.400907, 0, 1, 0.6117647, 1,
	    -0.1066423, 0.7333444, -0.2291378, 0, 1, 0.6156863, 1,
	    -0.106496, -1.057043, -3.330061, 0, 1, 0.6235294, 1,
	    -0.1056367, 0.6591798, 0.04064017, 0, 1, 0.627451, 1,
	    -0.1049491, 1.481587, -1.756189, 0, 1, 0.6352941, 1,
	    -0.103024, 0.5147223, 0.6267981, 0, 1, 0.6392157, 1,
	    -0.1018344, -0.1236775, -2.403377, 0, 1, 0.6470588, 1,
	    -0.101303, 0.2207302, -0.5913218, 0, 1, 0.6509804, 1,
	    -0.09933209, 0.6369633, -0.8014122, 0, 1, 0.6588235, 1,
	    -0.09617039, 0.6737514, 0.1425235, 0, 1, 0.6627451, 1,
	    -0.09311427, 0.2647889, -2.302205, 0, 1, 0.6705883, 1,
	    -0.08980646, -0.4164941, -2.308688, 0, 1, 0.6745098, 1,
	    -0.08930455, -0.948478, -3.315494, 0, 1, 0.682353, 1,
	    -0.08626778, 0.8342798, 0.4208291, 0, 1, 0.6862745, 1,
	    -0.08419178, 0.9826614, -0.3964859, 0, 1, 0.6941177, 1,
	    -0.08200265, 0.594932, -0.2820127, 0, 1, 0.7019608, 1,
	    -0.08001664, -0.7334755, -3.088512, 0, 1, 0.7058824, 1,
	    -0.07912222, 1.101091, -1.8034, 0, 1, 0.7137255, 1,
	    -0.0783167, -0.01881858, -1.651123, 0, 1, 0.7176471, 1,
	    -0.07807884, 0.8719932, -0.6433321, 0, 1, 0.7254902, 1,
	    -0.07707269, 0.8327997, -0.8617492, 0, 1, 0.7294118, 1,
	    -0.07680146, 0.3920574, 0.2918563, 0, 1, 0.7372549, 1,
	    -0.07521058, -0.2467794, -3.58793, 0, 1, 0.7411765, 1,
	    -0.06833179, -0.05216809, -3.22701, 0, 1, 0.7490196, 1,
	    -0.06704191, 0.2216686, -0.1544297, 0, 1, 0.7529412, 1,
	    -0.06694938, 0.8515927, -0.05324665, 0, 1, 0.7607843, 1,
	    -0.06679143, -1.278983, -2.894674, 0, 1, 0.7647059, 1,
	    -0.06641769, -1.146662, -4.110606, 0, 1, 0.772549, 1,
	    -0.06360777, 0.3498021, 1.132448, 0, 1, 0.7764706, 1,
	    -0.06172115, -1.165215, -2.460641, 0, 1, 0.7843137, 1,
	    -0.0598046, -0.6930853, -2.174453, 0, 1, 0.7882353, 1,
	    -0.05520045, 1.818273, -0.08674174, 0, 1, 0.7960784, 1,
	    -0.05245889, 0.04783464, -1.558389, 0, 1, 0.8039216, 1,
	    -0.0500897, -1.352268, -3.550662, 0, 1, 0.8078431, 1,
	    -0.04936336, -0.2503906, -3.518534, 0, 1, 0.8156863, 1,
	    -0.04554446, -0.3903664, -2.268512, 0, 1, 0.8196079, 1,
	    -0.04422881, 0.07970817, -0.1536968, 0, 1, 0.827451, 1,
	    -0.04118652, 1.02607, 0.5135916, 0, 1, 0.8313726, 1,
	    -0.04056865, -0.223011, -2.491112, 0, 1, 0.8392157, 1,
	    -0.03934012, 0.8695768, -0.4026429, 0, 1, 0.8431373, 1,
	    -0.03700383, 0.6203333, -0.03877672, 0, 1, 0.8509804, 1,
	    -0.03395523, -1.658362, -3.078459, 0, 1, 0.854902, 1,
	    -0.03242371, 1.577838, 0.9021547, 0, 1, 0.8627451, 1,
	    -0.02570237, -0.9403977, -1.428643, 0, 1, 0.8666667, 1,
	    -0.0223995, -1.374689, -2.319477, 0, 1, 0.8745098, 1,
	    -0.0190229, -1.011615, -1.942582, 0, 1, 0.8784314, 1,
	    -0.01890568, -1.06482, -3.621768, 0, 1, 0.8862745, 1,
	    -0.01757988, 1.730353, -0.2382627, 0, 1, 0.8901961, 1,
	    -0.01612385, -1.050498, -1.947978, 0, 1, 0.8980392, 1,
	    -0.006568069, 0.3360649, 1.521563, 0, 1, 0.9058824, 1,
	    -0.005385681, 1.367745, -0.6527164, 0, 1, 0.9098039, 1,
	    -0.001343553, -0.377785, -4.360919, 0, 1, 0.9176471, 1,
	    -0.0009506675, 1.181957, 2.548394, 0, 1, 0.9215686, 1,
	    0.0003510093, -1.919253, 4.100319, 0, 1, 0.9294118, 1,
	    0.0005615033, 0.1132777, -0.7010933, 0, 1, 0.9333333, 1,
	    0.001520682, 1.343987, 0.2462661, 0, 1, 0.9411765, 1,
	    0.005534441, -0.3747527, 1.608162, 0, 1, 0.945098, 1,
	    0.01121403, -1.632722, 3.064353, 0, 1, 0.9529412, 1,
	    0.01270071, -1.075792, 3.756078, 0, 1, 0.9568627, 1,
	    0.01337623, -0.1243018, 1.902236, 0, 1, 0.9647059, 1,
	    0.01376642, -0.3030035, 2.124966, 0, 1, 0.9686275, 1,
	    0.01416572, -1.38742, 3.134031, 0, 1, 0.9764706, 1,
	    0.01467183, -0.6097111, 2.637124, 0, 1, 0.9803922, 1,
	    0.01499824, -1.864073, 4.27042, 0, 1, 0.9882353, 1,
	    0.01805308, -0.1149537, 2.143516, 0, 1, 0.9921569, 1,
	    0.01890461, -0.8288468, 2.990958, 0, 1, 1, 1,
	    0.01920811, 2.10651, -0.3929347, 0, 0.9921569, 1, 1,
	    0.01985328, -2.306123, 2.739483, 0, 0.9882353, 1, 1,
	    0.02025752, -0.1030764, 4.116004, 0, 0.9803922, 1, 1,
	    0.02210373, -1.412703, 4.350431, 0, 0.9764706, 1, 1,
	    0.02249893, 0.6115615, -1.069095, 0, 0.9686275, 1, 1,
	    0.02442757, 0.6644303, -1.778192, 0, 0.9647059, 1, 1,
	    0.0319371, 0.7053042, -0.8323591, 0, 0.9568627, 1, 1,
	    0.03526927, 0.6322345, 0.5751697, 0, 0.9529412, 1, 1,
	    0.03721331, 1.124694, -0.01773348, 0, 0.945098, 1, 1,
	    0.03783409, -0.2667173, 4.370207, 0, 0.9411765, 1, 1,
	    0.04084435, -1.733542, 3.216073, 0, 0.9333333, 1, 1,
	    0.04100597, 0.8721086, 0.7765086, 0, 0.9294118, 1, 1,
	    0.04240683, -1.186333, 2.639788, 0, 0.9215686, 1, 1,
	    0.04628408, 1.378195, -0.4441879, 0, 0.9176471, 1, 1,
	    0.05087113, 0.5165631, 0.2808791, 0, 0.9098039, 1, 1,
	    0.05111005, 0.3391065, 0.3322423, 0, 0.9058824, 1, 1,
	    0.05219409, -0.1874566, 3.632268, 0, 0.8980392, 1, 1,
	    0.05513461, 0.6449934, 0.9038979, 0, 0.8901961, 1, 1,
	    0.06070213, -0.6214779, 2.005656, 0, 0.8862745, 1, 1,
	    0.06378873, 1.221508, 0.4388304, 0, 0.8784314, 1, 1,
	    0.0644047, -1.325711, 1.938784, 0, 0.8745098, 1, 1,
	    0.06447943, 2.009114, 0.55599, 0, 0.8666667, 1, 1,
	    0.0658889, 2.349133, -0.09880281, 0, 0.8627451, 1, 1,
	    0.06625259, -1.524326, 2.728009, 0, 0.854902, 1, 1,
	    0.06902023, 0.5469748, 1.817271, 0, 0.8509804, 1, 1,
	    0.07161912, 1.319552, 0.7753255, 0, 0.8431373, 1, 1,
	    0.07340702, -1.99821, 3.122362, 0, 0.8392157, 1, 1,
	    0.07377584, -1.699463, 2.448329, 0, 0.8313726, 1, 1,
	    0.07780746, 0.7344799, -0.5229582, 0, 0.827451, 1, 1,
	    0.07991521, 0.009483349, 0.5291953, 0, 0.8196079, 1, 1,
	    0.08038872, -0.6718917, 2.699633, 0, 0.8156863, 1, 1,
	    0.08164879, -0.6409302, 1.902986, 0, 0.8078431, 1, 1,
	    0.08942119, 1.133815, -0.8757743, 0, 0.8039216, 1, 1,
	    0.09174564, -0.2856686, 2.366246, 0, 0.7960784, 1, 1,
	    0.1021865, 0.008921665, 1.480255, 0, 0.7882353, 1, 1,
	    0.1032633, -1.901109, 1.900182, 0, 0.7843137, 1, 1,
	    0.1034693, 0.2165704, -0.2689729, 0, 0.7764706, 1, 1,
	    0.1047883, -0.5989017, 2.575829, 0, 0.772549, 1, 1,
	    0.1122728, 0.7972787, 1.141654, 0, 0.7647059, 1, 1,
	    0.1124059, -0.6203197, 3.283587, 0, 0.7607843, 1, 1,
	    0.1165073, 1.744257, 2.932011, 0, 0.7529412, 1, 1,
	    0.1179833, -0.1426334, 2.294087, 0, 0.7490196, 1, 1,
	    0.1222724, 1.288284, 0.7293819, 0, 0.7411765, 1, 1,
	    0.1240571, 0.01838788, 2.275109, 0, 0.7372549, 1, 1,
	    0.1258921, -0.1781597, 1.21404, 0, 0.7294118, 1, 1,
	    0.1273662, -0.9859982, 3.703382, 0, 0.7254902, 1, 1,
	    0.1293574, -1.076137, 3.863997, 0, 0.7176471, 1, 1,
	    0.1315031, -0.572332, 2.582365, 0, 0.7137255, 1, 1,
	    0.1342161, 0.3442369, 0.970237, 0, 0.7058824, 1, 1,
	    0.1343233, 1.208969, 0.716992, 0, 0.6980392, 1, 1,
	    0.1363892, 0.8870068, -0.2488791, 0, 0.6941177, 1, 1,
	    0.1373866, 1.43347, -1.532247, 0, 0.6862745, 1, 1,
	    0.1474465, -1.329018, 1.60598, 0, 0.682353, 1, 1,
	    0.1475003, 0.3932011, -0.7289382, 0, 0.6745098, 1, 1,
	    0.1504161, -2.030463, 3.509368, 0, 0.6705883, 1, 1,
	    0.151864, 1.184683, 0.7814476, 0, 0.6627451, 1, 1,
	    0.1535171, -2.183028, 2.438119, 0, 0.6588235, 1, 1,
	    0.1557004, 1.927607, -0.5624588, 0, 0.6509804, 1, 1,
	    0.1572776, -1.797886, 4.551328, 0, 0.6470588, 1, 1,
	    0.157827, -1.328347, 1.796568, 0, 0.6392157, 1, 1,
	    0.1714941, 0.03995513, 1.628401, 0, 0.6352941, 1, 1,
	    0.180356, 0.09227912, 1.077896, 0, 0.627451, 1, 1,
	    0.1805426, 0.9036656, 0.672038, 0, 0.6235294, 1, 1,
	    0.185792, 1.895773, 0.3942083, 0, 0.6156863, 1, 1,
	    0.1886352, 0.9389416, 0.2295906, 0, 0.6117647, 1, 1,
	    0.1891088, -0.08675793, 2.018147, 0, 0.6039216, 1, 1,
	    0.1905168, -1.217325, 2.709364, 0, 0.5960785, 1, 1,
	    0.1910081, -0.2609054, 3.88834, 0, 0.5921569, 1, 1,
	    0.1919367, 0.1008646, 0.6531291, 0, 0.5843138, 1, 1,
	    0.198598, -0.8212687, 2.093656, 0, 0.5803922, 1, 1,
	    0.202079, -0.2649457, 1.354333, 0, 0.572549, 1, 1,
	    0.2036263, 0.2105238, 1.06231, 0, 0.5686275, 1, 1,
	    0.2039774, 2.166357, 1.213124, 0, 0.5607843, 1, 1,
	    0.2063715, -0.315898, 3.239099, 0, 0.5568628, 1, 1,
	    0.2086907, -0.7880057, 3.807619, 0, 0.5490196, 1, 1,
	    0.2156777, -0.005303266, 1.183361, 0, 0.5450981, 1, 1,
	    0.2169154, 1.030751, 1.073367, 0, 0.5372549, 1, 1,
	    0.2219778, -1.097623, 3.028444, 0, 0.5333334, 1, 1,
	    0.2251769, -0.8874402, 3.118542, 0, 0.5254902, 1, 1,
	    0.2253501, -0.3251648, 1.655468, 0, 0.5215687, 1, 1,
	    0.2355491, 1.239585, 2.163482, 0, 0.5137255, 1, 1,
	    0.2376431, 0.4643733, 0.5441632, 0, 0.509804, 1, 1,
	    0.2405307, 2.310608, -0.3220847, 0, 0.5019608, 1, 1,
	    0.2416506, -0.9508345, 4.332472, 0, 0.4941176, 1, 1,
	    0.2451012, -1.787108, 3.717537, 0, 0.4901961, 1, 1,
	    0.2454087, 0.2528564, 1.396041, 0, 0.4823529, 1, 1,
	    0.2467105, -0.6948186, 2.082554, 0, 0.4784314, 1, 1,
	    0.2508638, 0.006335431, 0.3112914, 0, 0.4705882, 1, 1,
	    0.2553101, 1.441288, -1.745514, 0, 0.4666667, 1, 1,
	    0.2596197, 0.6375109, -0.04673082, 0, 0.4588235, 1, 1,
	    0.2596917, 1.22919, -0.6188068, 0, 0.454902, 1, 1,
	    0.2625963, -1.403682, 1.704153, 0, 0.4470588, 1, 1,
	    0.2635991, -0.03961403, 2.860891, 0, 0.4431373, 1, 1,
	    0.2643978, 1.023646, -0.3548958, 0, 0.4352941, 1, 1,
	    0.2665905, 0.03840853, 1.073696, 0, 0.4313726, 1, 1,
	    0.2706009, 0.1868929, 0.9426733, 0, 0.4235294, 1, 1,
	    0.2740214, -0.9261407, 3.939563, 0, 0.4196078, 1, 1,
	    0.2762324, 1.150886, 0.6228384, 0, 0.4117647, 1, 1,
	    0.2762389, 0.557932, -0.7742849, 0, 0.4078431, 1, 1,
	    0.2762644, 0.7086437, -0.8118394, 0, 0.4, 1, 1,
	    0.2783879, -0.777018, 2.998226, 0, 0.3921569, 1, 1,
	    0.2828901, -1.106739, 3.964882, 0, 0.3882353, 1, 1,
	    0.2839671, 0.3930198, -1.705479, 0, 0.3803922, 1, 1,
	    0.2842726, 0.2340502, 1.182074, 0, 0.3764706, 1, 1,
	    0.2868416, -0.04707569, 2.283711, 0, 0.3686275, 1, 1,
	    0.2897809, 0.8270677, 1.311089, 0, 0.3647059, 1, 1,
	    0.2934914, 0.5408367, -1.70661, 0, 0.3568628, 1, 1,
	    0.2953034, 1.18455, -0.8932866, 0, 0.3529412, 1, 1,
	    0.2986929, -0.2035842, 2.136723, 0, 0.345098, 1, 1,
	    0.3019415, 0.8645609, 0.9701379, 0, 0.3411765, 1, 1,
	    0.3034593, -0.2600575, 2.439188, 0, 0.3333333, 1, 1,
	    0.3041492, 1.043465, -0.6689432, 0, 0.3294118, 1, 1,
	    0.3124934, -0.09805027, 3.259727, 0, 0.3215686, 1, 1,
	    0.3135964, -0.1858235, 1.292432, 0, 0.3176471, 1, 1,
	    0.3141557, 0.5558143, 0.3002726, 0, 0.3098039, 1, 1,
	    0.314962, -1.067524, 3.264876, 0, 0.3058824, 1, 1,
	    0.3163191, 0.9334719, 0.2407549, 0, 0.2980392, 1, 1,
	    0.3175246, 0.6782315, 0.02504135, 0, 0.2901961, 1, 1,
	    0.3214853, -1.115778, 2.543249, 0, 0.2862745, 1, 1,
	    0.3235506, -1.37805, 4.158879, 0, 0.2784314, 1, 1,
	    0.3272397, -0.2573352, 2.71643, 0, 0.2745098, 1, 1,
	    0.3356532, -1.547712, 3.718068, 0, 0.2666667, 1, 1,
	    0.3401664, -0.9322538, 2.055483, 0, 0.2627451, 1, 1,
	    0.3486618, 1.248093, 0.07581911, 0, 0.254902, 1, 1,
	    0.3501015, -1.187648, 2.000663, 0, 0.2509804, 1, 1,
	    0.3539153, -2.622816, 3.14947, 0, 0.2431373, 1, 1,
	    0.3583539, -0.2798501, 2.785842, 0, 0.2392157, 1, 1,
	    0.3681246, -1.892848, 2.562012, 0, 0.2313726, 1, 1,
	    0.3708194, -0.004896889, 0.4129016, 0, 0.227451, 1, 1,
	    0.3721594, -1.090907, 2.366179, 0, 0.2196078, 1, 1,
	    0.376964, -1.54614, 3.50999, 0, 0.2156863, 1, 1,
	    0.3790234, 0.2782331, 0.5433689, 0, 0.2078431, 1, 1,
	    0.3797341, -0.08660355, 2.323738, 0, 0.2039216, 1, 1,
	    0.3862439, 0.2455466, -0.1494747, 0, 0.1960784, 1, 1,
	    0.3890238, -0.2848578, 1.852845, 0, 0.1882353, 1, 1,
	    0.3907768, 0.4663884, 1.017277, 0, 0.1843137, 1, 1,
	    0.3933237, 1.074382, -0.3990256, 0, 0.1764706, 1, 1,
	    0.4010011, -1.335977, 3.690224, 0, 0.172549, 1, 1,
	    0.4111376, -0.724896, 1.447066, 0, 0.1647059, 1, 1,
	    0.4142662, -1.126743, 3.129046, 0, 0.1607843, 1, 1,
	    0.4146589, -1.88605, 3.717207, 0, 0.1529412, 1, 1,
	    0.4149035, -0.4635799, 2.662432, 0, 0.1490196, 1, 1,
	    0.4242705, -0.3074622, 0.4412618, 0, 0.1411765, 1, 1,
	    0.4263223, -0.2289787, 4.084892, 0, 0.1372549, 1, 1,
	    0.4310339, -1.049033, 2.059391, 0, 0.1294118, 1, 1,
	    0.4324447, -0.7431172, 3.533674, 0, 0.1254902, 1, 1,
	    0.4413833, 0.4352757, 0.2047309, 0, 0.1176471, 1, 1,
	    0.4475402, -0.4803843, 3.155442, 0, 0.1137255, 1, 1,
	    0.4497895, 0.0323005, 0.7267719, 0, 0.1058824, 1, 1,
	    0.4498253, 0.9934205, 1.53142, 0, 0.09803922, 1, 1,
	    0.4535728, -0.2918195, 0.636865, 0, 0.09411765, 1, 1,
	    0.4542938, 0.4106989, 0.8431509, 0, 0.08627451, 1, 1,
	    0.4558272, 0.9859454, 0.646631, 0, 0.08235294, 1, 1,
	    0.4581861, -1.132459, 4.064212, 0, 0.07450981, 1, 1,
	    0.4595278, 0.06372796, 1.001265, 0, 0.07058824, 1, 1,
	    0.4601912, -0.6010924, 2.631843, 0, 0.0627451, 1, 1,
	    0.4610658, -0.4727859, 3.064343, 0, 0.05882353, 1, 1,
	    0.4686163, -0.4831915, 3.595135, 0, 0.05098039, 1, 1,
	    0.4696977, 0.6173493, 2.123885, 0, 0.04705882, 1, 1,
	    0.4705031, 0.9474002, 0.7387603, 0, 0.03921569, 1, 1,
	    0.474881, -1.170421, 1.623319, 0, 0.03529412, 1, 1,
	    0.4756787, -0.6757661, 1.444709, 0, 0.02745098, 1, 1,
	    0.4765785, 0.4280927, 0.5680902, 0, 0.02352941, 1, 1,
	    0.4783824, -0.61164, 1.303169, 0, 0.01568628, 1, 1,
	    0.4784628, -0.1594019, 1.459525, 0, 0.01176471, 1, 1,
	    0.4812658, -1.321254, 4.025158, 0, 0.003921569, 1, 1,
	    0.482481, 0.7875147, -0.9163502, 0.003921569, 0, 1, 1,
	    0.4839079, -0.548592, 1.447325, 0.007843138, 0, 1, 1,
	    0.4862927, -1.471029, 4.286724, 0.01568628, 0, 1, 1,
	    0.4901836, -1.50472, 2.540157, 0.01960784, 0, 1, 1,
	    0.4911828, 0.3524598, -1.37456, 0.02745098, 0, 1, 1,
	    0.4914798, 2.118264, 0.2940025, 0.03137255, 0, 1, 1,
	    0.492804, 0.005050245, 3.761515, 0.03921569, 0, 1, 1,
	    0.4991218, 0.515008, 0.1288739, 0.04313726, 0, 1, 1,
	    0.5005997, 0.4470766, -0.4994295, 0.05098039, 0, 1, 1,
	    0.5032497, 1.251953, -0.01322813, 0.05490196, 0, 1, 1,
	    0.5042443, -0.4983068, 2.006964, 0.0627451, 0, 1, 1,
	    0.506629, -0.03480014, 1.310293, 0.06666667, 0, 1, 1,
	    0.5072179, 1.446769, 0.6320853, 0.07450981, 0, 1, 1,
	    0.5078271, 1.453615, 0.546565, 0.07843138, 0, 1, 1,
	    0.5094016, -1.753102, 2.539523, 0.08627451, 0, 1, 1,
	    0.5130072, 1.064762, -0.1353933, 0.09019608, 0, 1, 1,
	    0.5143386, 0.06863528, 0.197986, 0.09803922, 0, 1, 1,
	    0.5146866, -1.083056, 2.138623, 0.1058824, 0, 1, 1,
	    0.5176977, 0.881985, 0.5401119, 0.1098039, 0, 1, 1,
	    0.5238786, -0.5307274, 1.405097, 0.1176471, 0, 1, 1,
	    0.5239856, 0.7240843, 0.6977189, 0.1215686, 0, 1, 1,
	    0.5248913, -0.9363882, 1.728336, 0.1294118, 0, 1, 1,
	    0.5252081, 0.3526201, 0.900501, 0.1333333, 0, 1, 1,
	    0.5259463, -0.8775272, 1.617767, 0.1411765, 0, 1, 1,
	    0.5276728, 0.5722235, 0.7828026, 0.145098, 0, 1, 1,
	    0.5280967, -0.925657, 2.76639, 0.1529412, 0, 1, 1,
	    0.5307783, 1.430937, 2.518643, 0.1568628, 0, 1, 1,
	    0.5355234, -0.2152301, 1.248991, 0.1647059, 0, 1, 1,
	    0.5365565, -0.02914648, 0.3891062, 0.1686275, 0, 1, 1,
	    0.5400677, -1.025784, 4.664821, 0.1764706, 0, 1, 1,
	    0.5513174, -1.041898, 2.452152, 0.1803922, 0, 1, 1,
	    0.5571514, 0.6932147, 2.236229, 0.1882353, 0, 1, 1,
	    0.5608156, -0.7829638, 2.465394, 0.1921569, 0, 1, 1,
	    0.5622386, -4.296268, 3.590971, 0.2, 0, 1, 1,
	    0.5643378, 1.288776, 1.705263, 0.2078431, 0, 1, 1,
	    0.5644748, 0.8755746, 0.20489, 0.2117647, 0, 1, 1,
	    0.5659701, 0.801158, 0.2534979, 0.2196078, 0, 1, 1,
	    0.5714855, 0.6355573, -1.255904, 0.2235294, 0, 1, 1,
	    0.5715261, -0.8028404, 1.792729, 0.2313726, 0, 1, 1,
	    0.5730908, 0.988745, -1.245899, 0.2352941, 0, 1, 1,
	    0.5775926, 1.422017, -0.6398145, 0.2431373, 0, 1, 1,
	    0.5805009, -0.05244586, 0.1571316, 0.2470588, 0, 1, 1,
	    0.5807865, -0.09008343, 1.330099, 0.254902, 0, 1, 1,
	    0.5814852, 1.116772, 0.7733827, 0.2588235, 0, 1, 1,
	    0.5902786, -0.4003423, 2.134603, 0.2666667, 0, 1, 1,
	    0.5928683, -0.4297787, 1.823781, 0.2705882, 0, 1, 1,
	    0.5955567, 0.3907014, 0.7493965, 0.2784314, 0, 1, 1,
	    0.595627, -0.8522167, 3.526341, 0.282353, 0, 1, 1,
	    0.5978926, 2.928858, 2.06016, 0.2901961, 0, 1, 1,
	    0.6040683, 0.6518192, 2.503389, 0.2941177, 0, 1, 1,
	    0.6047422, -0.7308084, 2.466757, 0.3019608, 0, 1, 1,
	    0.6059136, -0.05891046, 0.9345445, 0.3098039, 0, 1, 1,
	    0.6112077, -0.7858036, 3.080214, 0.3137255, 0, 1, 1,
	    0.6136223, -0.3377426, 1.063159, 0.3215686, 0, 1, 1,
	    0.6192496, -1.225801, 1.141978, 0.3254902, 0, 1, 1,
	    0.6206802, 1.159678, 1.775222, 0.3333333, 0, 1, 1,
	    0.6220245, 0.7139539, 1.83545, 0.3372549, 0, 1, 1,
	    0.6242193, -0.6019546, 2.807129, 0.345098, 0, 1, 1,
	    0.629908, -0.2574494, 2.963354, 0.3490196, 0, 1, 1,
	    0.6313571, -0.6054527, 3.315715, 0.3568628, 0, 1, 1,
	    0.6316685, 1.012518, -0.1393005, 0.3607843, 0, 1, 1,
	    0.6356561, 0.5011413, 1.987243, 0.3686275, 0, 1, 1,
	    0.6358798, -1.078703, 2.858872, 0.372549, 0, 1, 1,
	    0.6465706, 0.5957756, 1.056273, 0.3803922, 0, 1, 1,
	    0.647826, -0.07707201, 2.21571, 0.3843137, 0, 1, 1,
	    0.6529692, -0.178701, 1.245625, 0.3921569, 0, 1, 1,
	    0.6548285, 0.7101313, 0.2215149, 0.3960784, 0, 1, 1,
	    0.6555589, -0.3558791, 1.372584, 0.4039216, 0, 1, 1,
	    0.658592, -0.6397706, 3.952268, 0.4117647, 0, 1, 1,
	    0.6591569, 1.283151, 3.055339, 0.4156863, 0, 1, 1,
	    0.6623873, -1.375569, 1.683498, 0.4235294, 0, 1, 1,
	    0.6641859, -2.060566, 2.540736, 0.427451, 0, 1, 1,
	    0.664415, 0.4253271, 1.682098, 0.4352941, 0, 1, 1,
	    0.6672285, 1.0102, 0.4447651, 0.4392157, 0, 1, 1,
	    0.6672354, 0.9316276, 0.7365816, 0.4470588, 0, 1, 1,
	    0.6767952, -0.456295, 1.637152, 0.4509804, 0, 1, 1,
	    0.6788669, -0.307972, 4.027822, 0.4588235, 0, 1, 1,
	    0.6800495, 1.314217, 0.1557828, 0.4627451, 0, 1, 1,
	    0.6814989, 1.560053, 0.4064704, 0.4705882, 0, 1, 1,
	    0.6918266, 1.578256, 1.610813, 0.4745098, 0, 1, 1,
	    0.6936742, 0.2993539, 1.445359, 0.4823529, 0, 1, 1,
	    0.6943845, -0.6627058, 1.79091, 0.4862745, 0, 1, 1,
	    0.6975933, 1.276657, 1.66141, 0.4941176, 0, 1, 1,
	    0.7000217, -0.2201389, 2.349222, 0.5019608, 0, 1, 1,
	    0.7007245, 0.04676498, 2.931731, 0.5058824, 0, 1, 1,
	    0.7037804, 0.004980148, 1.189963, 0.5137255, 0, 1, 1,
	    0.7056428, -0.1604052, 0.1537377, 0.5176471, 0, 1, 1,
	    0.7118245, 0.8005853, 0.7421039, 0.5254902, 0, 1, 1,
	    0.7176691, -0.212783, 3.325948, 0.5294118, 0, 1, 1,
	    0.7212727, 0.5257995, -0.938924, 0.5372549, 0, 1, 1,
	    0.7219128, -1.179442, 2.874319, 0.5411765, 0, 1, 1,
	    0.7236502, 0.7185758, 0.760374, 0.5490196, 0, 1, 1,
	    0.7279238, -0.9040002, 1.531542, 0.5529412, 0, 1, 1,
	    0.7312848, 2.502488, -0.1044919, 0.5607843, 0, 1, 1,
	    0.7319259, -0.6819185, 2.097914, 0.5647059, 0, 1, 1,
	    0.7350006, 0.5828035, 0.4128619, 0.572549, 0, 1, 1,
	    0.7358547, 0.5974884, 2.787656, 0.5764706, 0, 1, 1,
	    0.7442606, -1.482076, 2.804636, 0.5843138, 0, 1, 1,
	    0.7478879, -2.063557, 2.328966, 0.5882353, 0, 1, 1,
	    0.7646448, 1.061347, 2.361588, 0.5960785, 0, 1, 1,
	    0.7778516, -0.03010297, 0.2814409, 0.6039216, 0, 1, 1,
	    0.7783309, -0.326862, 0.3127281, 0.6078432, 0, 1, 1,
	    0.7787849, -0.3728688, 1.535694, 0.6156863, 0, 1, 1,
	    0.7846171, 0.5536012, 1.476615, 0.6196079, 0, 1, 1,
	    0.7863762, 1.759161, 1.172783, 0.627451, 0, 1, 1,
	    0.7865098, -0.855475, 2.672809, 0.6313726, 0, 1, 1,
	    0.7923484, -1.059744, 3.388786, 0.6392157, 0, 1, 1,
	    0.8050047, -1.019068, 3.028461, 0.6431373, 0, 1, 1,
	    0.806316, 1.080143, -0.03811667, 0.6509804, 0, 1, 1,
	    0.8071524, 0.70721, 1.168593, 0.654902, 0, 1, 1,
	    0.8096946, -1.59154, 4.140362, 0.6627451, 0, 1, 1,
	    0.810536, -0.2121595, 3.339663, 0.6666667, 0, 1, 1,
	    0.8206861, -0.709161, 3.474975, 0.6745098, 0, 1, 1,
	    0.8231897, 0.1589921, 1.424718, 0.6784314, 0, 1, 1,
	    0.8278323, -1.200729, 3.654522, 0.6862745, 0, 1, 1,
	    0.8280304, -0.08466513, 2.182351, 0.6901961, 0, 1, 1,
	    0.8370606, 0.6560463, 0.3524934, 0.6980392, 0, 1, 1,
	    0.8384079, 1.351473, 1.489137, 0.7058824, 0, 1, 1,
	    0.8421952, -0.5896794, 0.9872078, 0.7098039, 0, 1, 1,
	    0.8435412, -0.2500551, 2.79516, 0.7176471, 0, 1, 1,
	    0.8526937, 0.4108652, 1.095202, 0.7215686, 0, 1, 1,
	    0.8558112, -0.1026333, 1.992068, 0.7294118, 0, 1, 1,
	    0.8569679, 0.1972355, 1.638432, 0.7333333, 0, 1, 1,
	    0.8571086, -2.582052, 2.945448, 0.7411765, 0, 1, 1,
	    0.8768384, -1.829099, 2.82753, 0.7450981, 0, 1, 1,
	    0.8813807, -0.7137962, 4.129924, 0.7529412, 0, 1, 1,
	    0.8853509, 0.3191275, -0.2459273, 0.7568628, 0, 1, 1,
	    0.88536, 1.197099, -1.318836, 0.7647059, 0, 1, 1,
	    0.8858375, 1.286092, 1.415286, 0.7686275, 0, 1, 1,
	    0.892888, -1.26984, 2.29959, 0.7764706, 0, 1, 1,
	    0.8988571, 1.769366, -0.7662727, 0.7803922, 0, 1, 1,
	    0.9070851, 0.4113196, 1.797649, 0.7882353, 0, 1, 1,
	    0.9088396, -0.2452679, 1.686016, 0.7921569, 0, 1, 1,
	    0.9132724, -0.6898378, 0.3649459, 0.8, 0, 1, 1,
	    0.9158794, -0.3885197, 3.219117, 0.8078431, 0, 1, 1,
	    0.9210742, 0.9595274, 0.4376474, 0.8117647, 0, 1, 1,
	    0.9248324, 1.114415, 0.3944808, 0.8196079, 0, 1, 1,
	    0.9291422, -1.739283, 2.279004, 0.8235294, 0, 1, 1,
	    0.9296326, 0.08886368, 1.719609, 0.8313726, 0, 1, 1,
	    0.9307985, 0.3339583, 1.334685, 0.8352941, 0, 1, 1,
	    0.9332374, -0.9686745, 1.688021, 0.8431373, 0, 1, 1,
	    0.9415106, -0.2666264, 1.979264, 0.8470588, 0, 1, 1,
	    0.9427969, -1.022733, 2.843911, 0.854902, 0, 1, 1,
	    0.9433659, 1.448024, 1.073969, 0.8588235, 0, 1, 1,
	    0.9471993, 0.3696097, 2.418732, 0.8666667, 0, 1, 1,
	    0.9500124, 0.7469529, 0.571027, 0.8705882, 0, 1, 1,
	    0.9595821, -0.4074136, 0.9990169, 0.8784314, 0, 1, 1,
	    0.9655428, -0.6212184, 1.995013, 0.8823529, 0, 1, 1,
	    0.9685928, -1.674875, 1.678536, 0.8901961, 0, 1, 1,
	    0.9694204, -0.4517841, 2.81371, 0.8941177, 0, 1, 1,
	    0.9760728, -0.8483145, 3.023104, 0.9019608, 0, 1, 1,
	    0.9788702, 1.442679, 0.4718363, 0.9098039, 0, 1, 1,
	    0.9809175, -0.04437804, 2.845607, 0.9137255, 0, 1, 1,
	    0.9824045, 1.117405, 0.1968932, 0.9215686, 0, 1, 1,
	    0.9878908, 1.292297, -0.7232202, 0.9254902, 0, 1, 1,
	    0.9920933, -0.4382485, 1.70321, 0.9333333, 0, 1, 1,
	    0.9942542, 0.3154835, 0.3340122, 0.9372549, 0, 1, 1,
	    0.9953005, -0.7842214, 2.225026, 0.945098, 0, 1, 1,
	    0.9970996, 1.409656, 1.928571, 0.9490196, 0, 1, 1,
	    0.9973795, 0.6243719, 0.8026404, 0.9568627, 0, 1, 1,
	    1.011635, -1.381849, 1.833918, 0.9607843, 0, 1, 1,
	    1.011913, -0.8154428, 3.031042, 0.9686275, 0, 1, 1,
	    1.017958, -0.8182396, 1.408507, 0.972549, 0, 1, 1,
	    1.01852, 0.05232523, 0.4132114, 0.9803922, 0, 1, 1,
	    1.018682, 0.3674983, 1.392925, 0.9843137, 0, 1, 1,
	    1.018824, -0.5596517, 0.2008293, 0.9921569, 0, 1, 1,
	    1.01939, -0.7301657, 0.211375, 0.9960784, 0, 1, 1,
	    1.019583, -0.1095436, 2.011249, 1, 0, 0.9960784, 1,
	    1.020345, -0.1679868, 2.167344, 1, 0, 0.9882353, 1,
	    1.021315, 0.4924182, 0.6872071, 1, 0, 0.9843137, 1,
	    1.026255, -0.02691036, 3.396932, 1, 0, 0.9764706, 1,
	    1.026761, 0.252333, 1.807959, 1, 0, 0.972549, 1,
	    1.031565, 0.1285738, -0.1643753, 1, 0, 0.9647059, 1,
	    1.032631, -1.027682, 3.580612, 1, 0, 0.9607843, 1,
	    1.033686, 0.9084946, 0.151389, 1, 0, 0.9529412, 1,
	    1.034694, 1.380906, 0.09588767, 1, 0, 0.9490196, 1,
	    1.037289, 1.579919, 1.404803, 1, 0, 0.9411765, 1,
	    1.040868, -1.740289, 3.761698, 1, 0, 0.9372549, 1,
	    1.052273, -0.3082629, -0.6000687, 1, 0, 0.9294118, 1,
	    1.053547, 0.01223756, 1.650264, 1, 0, 0.9254902, 1,
	    1.067108, 0.02652191, 2.506478, 1, 0, 0.9176471, 1,
	    1.069829, -0.1184921, 2.507599, 1, 0, 0.9137255, 1,
	    1.081752, -0.115496, 2.081756, 1, 0, 0.9058824, 1,
	    1.083342, 0.1469045, 1.866763, 1, 0, 0.9019608, 1,
	    1.090011, 1.343955, -0.3963381, 1, 0, 0.8941177, 1,
	    1.107433, -1.376631, 1.842792, 1, 0, 0.8862745, 1,
	    1.116786, 2.72575, 0.2290176, 1, 0, 0.8823529, 1,
	    1.123638, 0.453263, 1.317145, 1, 0, 0.8745098, 1,
	    1.128741, 0.2936565, 0.6223138, 1, 0, 0.8705882, 1,
	    1.136541, -0.3318679, 3.092096, 1, 0, 0.8627451, 1,
	    1.137654, 1.169051, 1.64788, 1, 0, 0.8588235, 1,
	    1.139984, 0.2120689, 1.744639, 1, 0, 0.8509804, 1,
	    1.141147, -0.3229361, 0.9124012, 1, 0, 0.8470588, 1,
	    1.143085, 0.703463, 0.08920941, 1, 0, 0.8392157, 1,
	    1.144657, 0.4105223, 1.69312, 1, 0, 0.8352941, 1,
	    1.145206, -0.245239, -0.3604546, 1, 0, 0.827451, 1,
	    1.147211, -1.860351, 2.303887, 1, 0, 0.8235294, 1,
	    1.159474, 1.11456, 0.4531069, 1, 0, 0.8156863, 1,
	    1.16087, 0.05240114, 1.077443, 1, 0, 0.8117647, 1,
	    1.161301, 0.6833299, 3.202349, 1, 0, 0.8039216, 1,
	    1.166817, -1.20118, 0.8816551, 1, 0, 0.7960784, 1,
	    1.167754, 1.131144, 0.6744473, 1, 0, 0.7921569, 1,
	    1.175994, 0.09091315, -0.3363401, 1, 0, 0.7843137, 1,
	    1.178836, -0.1989769, 0.7856389, 1, 0, 0.7803922, 1,
	    1.179907, 1.001414, 2.036324, 1, 0, 0.772549, 1,
	    1.181193, -0.1706205, 2.960216, 1, 0, 0.7686275, 1,
	    1.183107, -1.83126, 1.932786, 1, 0, 0.7607843, 1,
	    1.184235, 1.544702, 0.9565372, 1, 0, 0.7568628, 1,
	    1.184921, 0.2501715, 1.076237, 1, 0, 0.7490196, 1,
	    1.188728, 0.003888438, 1.766508, 1, 0, 0.7450981, 1,
	    1.192358, 0.5150885, 1.437746, 1, 0, 0.7372549, 1,
	    1.192411, 1.232163, 1.144897, 1, 0, 0.7333333, 1,
	    1.201014, -0.8346778, 2.301136, 1, 0, 0.7254902, 1,
	    1.20961, 0.5369321, -0.2770598, 1, 0, 0.7215686, 1,
	    1.216989, 0.729811, 1.396523, 1, 0, 0.7137255, 1,
	    1.221602, -0.4149159, 2.884691, 1, 0, 0.7098039, 1,
	    1.222021, -1.441771, 1.168246, 1, 0, 0.7019608, 1,
	    1.222126, -0.7709313, 2.471037, 1, 0, 0.6941177, 1,
	    1.225438, -0.6228612, 1.861307, 1, 0, 0.6901961, 1,
	    1.234191, 0.4461386, 1.21637, 1, 0, 0.682353, 1,
	    1.243262, 1.128603, 0.2570007, 1, 0, 0.6784314, 1,
	    1.24767, -1.356347, 1.32474, 1, 0, 0.6705883, 1,
	    1.252402, -0.1797536, 2.832527, 1, 0, 0.6666667, 1,
	    1.258534, 0.9126295, 0.9964132, 1, 0, 0.6588235, 1,
	    1.280506, -0.6303906, 1.503504, 1, 0, 0.654902, 1,
	    1.283589, 1.874575, -0.06470009, 1, 0, 0.6470588, 1,
	    1.28832, -1.414033, 2.636441, 1, 0, 0.6431373, 1,
	    1.288335, -1.500588, 1.143418, 1, 0, 0.6352941, 1,
	    1.291734, -0.1867729, 0.5962146, 1, 0, 0.6313726, 1,
	    1.292203, 0.6947836, 2.488379, 1, 0, 0.6235294, 1,
	    1.296976, 0.5066877, 0.6408052, 1, 0, 0.6196079, 1,
	    1.316738, -0.07784468, 2.169863, 1, 0, 0.6117647, 1,
	    1.324379, -2.349494, 3.380144, 1, 0, 0.6078432, 1,
	    1.328884, 0.5502286, 0.05688321, 1, 0, 0.6, 1,
	    1.34537, -0.2482711, 4.275259, 1, 0, 0.5921569, 1,
	    1.349375, 0.5038981, 0.3092043, 1, 0, 0.5882353, 1,
	    1.355161, -0.3501262, 0.6794505, 1, 0, 0.5803922, 1,
	    1.365536, 0.7288261, -0.3744763, 1, 0, 0.5764706, 1,
	    1.368869, 0.4469389, 0.7692514, 1, 0, 0.5686275, 1,
	    1.369231, -0.06778283, 1.335495, 1, 0, 0.5647059, 1,
	    1.378816, 0.06284921, 0.7601541, 1, 0, 0.5568628, 1,
	    1.380064, -1.644626, 3.588316, 1, 0, 0.5529412, 1,
	    1.403231, -0.2840028, 1.255686, 1, 0, 0.5450981, 1,
	    1.40719, -1.474093, 1.585985, 1, 0, 0.5411765, 1,
	    1.416058, -0.473154, 3.035123, 1, 0, 0.5333334, 1,
	    1.420703, -0.8052763, 1.86606, 1, 0, 0.5294118, 1,
	    1.423203, 1.022406, -0.7595028, 1, 0, 0.5215687, 1,
	    1.424941, -0.7049868, 2.347237, 1, 0, 0.5176471, 1,
	    1.429794, -0.2380316, 0.2554393, 1, 0, 0.509804, 1,
	    1.436911, 0.01513231, 0.7222226, 1, 0, 0.5058824, 1,
	    1.443174, -0.5253437, 2.407958, 1, 0, 0.4980392, 1,
	    1.455037, -1.288522, 3.261682, 1, 0, 0.4901961, 1,
	    1.457376, -2.379097, 3.954421, 1, 0, 0.4862745, 1,
	    1.485001, -0.8477631, 3.304703, 1, 0, 0.4784314, 1,
	    1.485095, 0.5873941, -0.599531, 1, 0, 0.4745098, 1,
	    1.486937, -0.2523927, 0.9672428, 1, 0, 0.4666667, 1,
	    1.487952, -0.1291583, -0.4218455, 1, 0, 0.4627451, 1,
	    1.497831, -2.811458, 3.165103, 1, 0, 0.454902, 1,
	    1.500401, 2.620162, -0.3192083, 1, 0, 0.4509804, 1,
	    1.506367, 0.07150951, 3.249201, 1, 0, 0.4431373, 1,
	    1.510335, 0.7396104, 0.8857367, 1, 0, 0.4392157, 1,
	    1.526899, 0.0799333, 1.726707, 1, 0, 0.4313726, 1,
	    1.549206, -0.1284651, 3.258678, 1, 0, 0.427451, 1,
	    1.554544, -1.975288, 1.564981, 1, 0, 0.4196078, 1,
	    1.557667, -1.263224, 2.196877, 1, 0, 0.4156863, 1,
	    1.559167, -0.4645047, 0.491184, 1, 0, 0.4078431, 1,
	    1.577114, -0.9213758, 1.621665, 1, 0, 0.4039216, 1,
	    1.578399, 0.1354189, 0.1201966, 1, 0, 0.3960784, 1,
	    1.583858, 0.240097, 1.65323, 1, 0, 0.3882353, 1,
	    1.586032, -1.574116, 0.615061, 1, 0, 0.3843137, 1,
	    1.591756, -0.1101937, 0.5587537, 1, 0, 0.3764706, 1,
	    1.5995, 0.3260971, 1.15376, 1, 0, 0.372549, 1,
	    1.60658, -1.031204, 2.301787, 1, 0, 0.3647059, 1,
	    1.625425, -0.29866, 1.762002, 1, 0, 0.3607843, 1,
	    1.645759, -0.009775859, 0.7073467, 1, 0, 0.3529412, 1,
	    1.654188, 0.3609428, 1.59997, 1, 0, 0.3490196, 1,
	    1.657337, -0.7003041, -0.1295768, 1, 0, 0.3411765, 1,
	    1.661051, -0.1167691, 1.866673, 1, 0, 0.3372549, 1,
	    1.687201, 1.51527, 1.02684, 1, 0, 0.3294118, 1,
	    1.691195, 0.3263418, 1.485405, 1, 0, 0.3254902, 1,
	    1.695414, 0.2477717, 2.059577, 1, 0, 0.3176471, 1,
	    1.712615, 0.2082273, -0.3725432, 1, 0, 0.3137255, 1,
	    1.712957, -0.879064, 2.947936, 1, 0, 0.3058824, 1,
	    1.743911, -0.4867086, -0.2535188, 1, 0, 0.2980392, 1,
	    1.754165, 1.001932, 2.501388, 1, 0, 0.2941177, 1,
	    1.771713, 0.7638152, 2.34733, 1, 0, 0.2862745, 1,
	    1.772932, -0.1583439, 0.6093742, 1, 0, 0.282353, 1,
	    1.785238, -1.420552, 4.465613, 1, 0, 0.2745098, 1,
	    1.796005, -0.914387, 1.114411, 1, 0, 0.2705882, 1,
	    1.811172, -1.103143, 2.949744, 1, 0, 0.2627451, 1,
	    1.823185, -0.2451586, 3.379139, 1, 0, 0.2588235, 1,
	    1.825059, 0.03253014, 0.0004894352, 1, 0, 0.2509804, 1,
	    1.834649, 1.113902, 0.8879815, 1, 0, 0.2470588, 1,
	    1.837152, -0.3698249, 2.134397, 1, 0, 0.2392157, 1,
	    1.844164, 1.223721, 0.3846345, 1, 0, 0.2352941, 1,
	    1.85042, 1.100985, -1.241697, 1, 0, 0.227451, 1,
	    1.853331, -0.3856154, -0.4160224, 1, 0, 0.2235294, 1,
	    1.864724, 0.001059888, 2.040028, 1, 0, 0.2156863, 1,
	    1.868327, -0.7982771, 1.552154, 1, 0, 0.2117647, 1,
	    1.93271, -0.5486954, 1.486086, 1, 0, 0.2039216, 1,
	    1.941953, -0.8210786, 2.192708, 1, 0, 0.1960784, 1,
	    1.958979, -1.174869, 3.019422, 1, 0, 0.1921569, 1,
	    1.966566, 0.7387355, -0.3819425, 1, 0, 0.1843137, 1,
	    1.970506, 0.6835407, 0.7925611, 1, 0, 0.1803922, 1,
	    1.977679, -0.8532782, 1.548099, 1, 0, 0.172549, 1,
	    1.988723, -0.84404, 2.048497, 1, 0, 0.1686275, 1,
	    2.00023, 0.5686738, 2.339653, 1, 0, 0.1607843, 1,
	    2.010289, -0.7470264, 2.561281, 1, 0, 0.1568628, 1,
	    2.03626, 0.4299253, 2.947827, 1, 0, 0.1490196, 1,
	    2.055654, 0.7577947, 1.294143, 1, 0, 0.145098, 1,
	    2.109136, -1.723321, 2.322745, 1, 0, 0.1372549, 1,
	    2.12652, -0.1150688, 2.021915, 1, 0, 0.1333333, 1,
	    2.139287, -1.181069, -0.1386394, 1, 0, 0.1254902, 1,
	    2.163727, 2.059793, 1.438894, 1, 0, 0.1215686, 1,
	    2.250146, 1.379483, 1.636676, 1, 0, 0.1137255, 1,
	    2.253876, 0.1009094, 0.3555255, 1, 0, 0.1098039, 1,
	    2.279254, -0.4875013, 2.419664, 1, 0, 0.1019608, 1,
	    2.281113, -0.4899705, 0.2594214, 1, 0, 0.09411765, 1,
	    2.308576, -1.375535, 1.349992, 1, 0, 0.09019608, 1,
	    2.313261, -0.605472, 2.274704, 1, 0, 0.08235294, 1,
	    2.326977, -0.3566105, 1.538679, 1, 0, 0.07843138, 1,
	    2.3486, 0.2919769, 0.3656135, 1, 0, 0.07058824, 1,
	    2.493531, 1.050258, 0.2402157, 1, 0, 0.06666667, 1,
	    2.501705, 0.1576622, 0.7466818, 1, 0, 0.05882353, 1,
	    2.560265, -1.064744, 1.164426, 1, 0, 0.05490196, 1,
	    2.5897, 0.7903411, -1.049092, 1, 0, 0.04705882, 1,
	    2.597006, -0.9691425, 2.330202, 1, 0, 0.04313726, 1,
	    2.636711, 0.6453574, 1.289243, 1, 0, 0.03529412, 1,
	    2.673946, 0.5899644, 1.161074, 1, 0, 0.03137255, 1,
	    2.860422, -0.01325194, 2.377002, 1, 0, 0.02352941, 1,
	    2.937731, -0.5055712, 1.4512, 1, 0, 0.01960784, 1,
	    3.234618, -0.09970614, 1.247232, 1, 0, 0.01176471, 1,
	    3.571611, -1.651236, 1.373583, 1, 0, 0.007843138, 1
	   ]);
	   var buf6 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf6);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc6 = gl.getUniformLocation(prog6,"mvMatrix");
	   var prMatLoc6 = gl.getUniformLocation(prog6,"prMatrix");
	   // ****** text object 8 ******
	   var prog8  = gl.createProgram();
	   gl.attachShader(prog8, getShader( gl, "rgl_firstexamplevshader8" ));
	   gl.attachShader(prog8, getShader( gl, "rgl_firstexamplefshader8" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog8, 0, "aPos");
	   gl.bindAttribLocation(prog8, 1, "aCol");
	   gl.linkProgram(prog8);
	   var texts = [
	    "x"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX8 = texinfo.canvasX;
	   var canvasY8 = texinfo.canvasY;
	   var ofsLoc8 = gl.getAttribLocation(prog8, "aOfs");
	   var texture8 = gl.createTexture();
	   var texLoc8 = gl.getAttribLocation(prog8, "aTexcoord");
	   var sampler8 = gl.getUniformLocation(prog8,"uSampler");
    	   handleLoadedTexture(texture8, document.getElementById("rgl_firstexampletextureCanvas"));
	   var v=new Float32Array([
	    0.1828002, -5.647865, -7.1733, 0, -0.5, 0.5, 0.5,
	    0.1828002, -5.647865, -7.1733, 1, -0.5, 0.5, 0.5,
	    0.1828002, -5.647865, -7.1733, 1, 1.5, 0.5, 0.5,
	    0.1828002, -5.647865, -7.1733, 0, 1.5, 0.5, 0.5
	   ]);
	   for (var i=0; i<1; i++) 
	     for (var j=0; j<4; j++) {
	         ind = 7*(4*i + j) + 3;
	         v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i]/width;
	         v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight/height;
	         v[ind] *= texinfo.widths[i]/texinfo.canvasX;
	         v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
	           - v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
	     }
	   var f=new Uint16Array([
	    0, 1, 2, 0, 2, 3
	   ]);
	   var buf8 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf8);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf8 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf8);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc8 = gl.getUniformLocation(prog8,"mvMatrix");
	   var prMatLoc8 = gl.getUniformLocation(prog8,"prMatrix");
	   // ****** text object 9 ******
	   var prog9  = gl.createProgram();
	   gl.attachShader(prog9, getShader( gl, "rgl_firstexamplevshader9" ));
	   gl.attachShader(prog9, getShader( gl, "rgl_firstexamplefshader9" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog9, 0, "aPos");
	   gl.bindAttribLocation(prog9, 1, "aCol");
	   gl.linkProgram(prog9);
	   var texts = [
	    "y"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX9 = texinfo.canvasX;
	   var canvasY9 = texinfo.canvasY;
	   var ofsLoc9 = gl.getAttribLocation(prog9, "aOfs");
	   var texture9 = gl.createTexture();
	   var texLoc9 = gl.getAttribLocation(prog9, "aTexcoord");
	   var sampler9 = gl.getUniformLocation(prog9,"uSampler");
    	   handleLoadedTexture(texture9, document.getElementById("rgl_firstexampletextureCanvas"));
	   var v=new Float32Array([
	    -4.354817, -0.3092586, -7.1733, 0, -0.5, 0.5, 0.5,
	    -4.354817, -0.3092586, -7.1733, 1, -0.5, 0.5, 0.5,
	    -4.354817, -0.3092586, -7.1733, 1, 1.5, 0.5, 0.5,
	    -4.354817, -0.3092586, -7.1733, 0, 1.5, 0.5, 0.5
	   ]);
	   for (var i=0; i<1; i++) 
	     for (var j=0; j<4; j++) {
	         ind = 7*(4*i + j) + 3;
	         v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i]/width;
	         v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight/height;
	         v[ind] *= texinfo.widths[i]/texinfo.canvasX;
	         v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
	           - v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
	     }
	   var f=new Uint16Array([
	    0, 1, 2, 0, 2, 3
	   ]);
	   var buf9 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf9);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf9 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf9);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc9 = gl.getUniformLocation(prog9,"mvMatrix");
	   var prMatLoc9 = gl.getUniformLocation(prog9,"prMatrix");
	   // ****** text object 10 ******
	   var prog10  = gl.createProgram();
	   gl.attachShader(prog10, getShader( gl, "rgl_firstexamplevshader10" ));
	   gl.attachShader(prog10, getShader( gl, "rgl_firstexamplefshader10" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog10, 0, "aPos");
	   gl.bindAttribLocation(prog10, 1, "aCol");
	   gl.linkProgram(prog10);
	   var texts = [
	    "z"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX10 = texinfo.canvasX;
	   var canvasY10 = texinfo.canvasY;
	   var ofsLoc10 = gl.getAttribLocation(prog10, "aOfs");
	   var texture10 = gl.createTexture();
	   var texLoc10 = gl.getAttribLocation(prog10, "aTexcoord");
	   var sampler10 = gl.getUniformLocation(prog10,"uSampler");
    	   handleLoadedTexture(texture10, document.getElementById("rgl_firstexampletextureCanvas"));
	   var v=new Float32Array([
	    -4.354817, -5.647865, -0.3963683, 0, -0.5, 0.5, 0.5,
	    -4.354817, -5.647865, -0.3963683, 1, -0.5, 0.5, 0.5,
	    -4.354817, -5.647865, -0.3963683, 1, 1.5, 0.5, 0.5,
	    -4.354817, -5.647865, -0.3963683, 0, 1.5, 0.5, 0.5
	   ]);
	   for (var i=0; i<1; i++) 
	     for (var j=0; j<4; j++) {
	         ind = 7*(4*i + j) + 3;
	         v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i]/width;
	         v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight/height;
	         v[ind] *= texinfo.widths[i]/texinfo.canvasX;
	         v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
	           - v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
	     }
	   var f=new Uint16Array([
	    0, 1, 2, 0, 2, 3
	   ]);
	   var buf10 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf10);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf10 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf10);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc10 = gl.getUniformLocation(prog10,"mvMatrix");
	   var prMatLoc10 = gl.getUniformLocation(prog10,"prMatrix");
	   // ****** lines object 11 ******
	   var prog11  = gl.createProgram();
	   gl.attachShader(prog11, getShader( gl, "rgl_firstexamplevshader11" ));
	   gl.attachShader(prog11, getShader( gl, "rgl_firstexamplefshader11" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog11, 0, "aPos");
	   gl.bindAttribLocation(prog11, 1, "aCol");
	   gl.linkProgram(prog11);
	   var v=new Float32Array([
	    -3, -4.415879, -5.609393,
	    3, -4.415879, -5.609393,
	    -3, -4.415879, -5.609393,
	    -3, -4.62121, -5.870044,
	    -2, -4.415879, -5.609393,
	    -2, -4.62121, -5.870044,
	    -1, -4.415879, -5.609393,
	    -1, -4.62121, -5.870044,
	    0, -4.415879, -5.609393,
	    0, -4.62121, -5.870044,
	    1, -4.415879, -5.609393,
	    1, -4.62121, -5.870044,
	    2, -4.415879, -5.609393,
	    2, -4.62121, -5.870044,
	    3, -4.415879, -5.609393,
	    3, -4.62121, -5.870044
	   ]);
	   var buf11 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf11);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc11 = gl.getUniformLocation(prog11,"mvMatrix");
	   var prMatLoc11 = gl.getUniformLocation(prog11,"prMatrix");
	   // ****** text object 12 ******
	   var prog12  = gl.createProgram();
	   gl.attachShader(prog12, getShader( gl, "rgl_firstexamplevshader12" ));
	   gl.attachShader(prog12, getShader( gl, "rgl_firstexamplefshader12" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog12, 0, "aPos");
	   gl.bindAttribLocation(prog12, 1, "aCol");
	   gl.linkProgram(prog12);
	   var texts = [
	    "-3",
	    "-2",
	    "-1",
	    "0",
	    "1",
	    "2",
	    "3"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX12 = texinfo.canvasX;
	   var canvasY12 = texinfo.canvasY;
	   var ofsLoc12 = gl.getAttribLocation(prog12, "aOfs");
	   var texture12 = gl.createTexture();
	   var texLoc12 = gl.getAttribLocation(prog12, "aTexcoord");
	   var sampler12 = gl.getUniformLocation(prog12,"uSampler");
    	   handleLoadedTexture(texture12, document.getElementById("rgl_firstexampletextureCanvas"));
	   var v=new Float32Array([
	    -3, -5.031872, -6.391346, 0, -0.5, 0.5, 0.5,
	    -3, -5.031872, -6.391346, 1, -0.5, 0.5, 0.5,
	    -3, -5.031872, -6.391346, 1, 1.5, 0.5, 0.5,
	    -3, -5.031872, -6.391346, 0, 1.5, 0.5, 0.5,
	    -2, -5.031872, -6.391346, 0, -0.5, 0.5, 0.5,
	    -2, -5.031872, -6.391346, 1, -0.5, 0.5, 0.5,
	    -2, -5.031872, -6.391346, 1, 1.5, 0.5, 0.5,
	    -2, -5.031872, -6.391346, 0, 1.5, 0.5, 0.5,
	    -1, -5.031872, -6.391346, 0, -0.5, 0.5, 0.5,
	    -1, -5.031872, -6.391346, 1, -0.5, 0.5, 0.5,
	    -1, -5.031872, -6.391346, 1, 1.5, 0.5, 0.5,
	    -1, -5.031872, -6.391346, 0, 1.5, 0.5, 0.5,
	    0, -5.031872, -6.391346, 0, -0.5, 0.5, 0.5,
	    0, -5.031872, -6.391346, 1, -0.5, 0.5, 0.5,
	    0, -5.031872, -6.391346, 1, 1.5, 0.5, 0.5,
	    0, -5.031872, -6.391346, 0, 1.5, 0.5, 0.5,
	    1, -5.031872, -6.391346, 0, -0.5, 0.5, 0.5,
	    1, -5.031872, -6.391346, 1, -0.5, 0.5, 0.5,
	    1, -5.031872, -6.391346, 1, 1.5, 0.5, 0.5,
	    1, -5.031872, -6.391346, 0, 1.5, 0.5, 0.5,
	    2, -5.031872, -6.391346, 0, -0.5, 0.5, 0.5,
	    2, -5.031872, -6.391346, 1, -0.5, 0.5, 0.5,
	    2, -5.031872, -6.391346, 1, 1.5, 0.5, 0.5,
	    2, -5.031872, -6.391346, 0, 1.5, 0.5, 0.5,
	    3, -5.031872, -6.391346, 0, -0.5, 0.5, 0.5,
	    3, -5.031872, -6.391346, 1, -0.5, 0.5, 0.5,
	    3, -5.031872, -6.391346, 1, 1.5, 0.5, 0.5,
	    3, -5.031872, -6.391346, 0, 1.5, 0.5, 0.5
	   ]);
	   for (var i=0; i<7; i++) 
	     for (var j=0; j<4; j++) {
	         ind = 7*(4*i + j) + 3;
	         v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i]/width;
	         v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight/height;
	         v[ind] *= texinfo.widths[i]/texinfo.canvasX;
	         v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
	           - v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
	     }
	   var f=new Uint16Array([
	    0, 1, 2, 0, 2, 3,
	    4, 5, 6, 4, 6, 7,
	    8, 9, 10, 8, 10, 11,
	    12, 13, 14, 12, 14, 15,
	    16, 17, 18, 16, 18, 19,
	    20, 21, 22, 20, 22, 23,
	    24, 25, 26, 24, 26, 27
	   ]);
	   var buf12 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf12);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf12 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf12);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc12 = gl.getUniformLocation(prog12,"mvMatrix");
	   var prMatLoc12 = gl.getUniformLocation(prog12,"prMatrix");
	   // ****** lines object 13 ******
	   var prog13  = gl.createProgram();
	   gl.attachShader(prog13, getShader( gl, "rgl_firstexamplevshader13" ));
	   gl.attachShader(prog13, getShader( gl, "rgl_firstexamplefshader13" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog13, 0, "aPos");
	   gl.bindAttribLocation(prog13, 1, "aCol");
	   gl.linkProgram(prog13);
	   var v=new Float32Array([
	    -3.307675, -4, -5.609393,
	    -3.307675, 2, -5.609393,
	    -3.307675, -4, -5.609393,
	    -3.482199, -4, -5.870044,
	    -3.307675, -2, -5.609393,
	    -3.482199, -2, -5.870044,
	    -3.307675, 0, -5.609393,
	    -3.482199, 0, -5.870044,
	    -3.307675, 2, -5.609393,
	    -3.482199, 2, -5.870044
	   ]);
	   var buf13 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf13);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc13 = gl.getUniformLocation(prog13,"mvMatrix");
	   var prMatLoc13 = gl.getUniformLocation(prog13,"prMatrix");
	   // ****** text object 14 ******
	   var prog14  = gl.createProgram();
	   gl.attachShader(prog14, getShader( gl, "rgl_firstexamplevshader14" ));
	   gl.attachShader(prog14, getShader( gl, "rgl_firstexamplefshader14" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog14, 0, "aPos");
	   gl.bindAttribLocation(prog14, 1, "aCol");
	   gl.linkProgram(prog14);
	   var texts = [
	    "-4",
	    "-2",
	    "0",
	    "2"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX14 = texinfo.canvasX;
	   var canvasY14 = texinfo.canvasY;
	   var ofsLoc14 = gl.getAttribLocation(prog14, "aOfs");
	   var texture14 = gl.createTexture();
	   var texLoc14 = gl.getAttribLocation(prog14, "aTexcoord");
	   var sampler14 = gl.getUniformLocation(prog14,"uSampler");
    	   handleLoadedTexture(texture14, document.getElementById("rgl_firstexampletextureCanvas"));
	   var v=new Float32Array([
	    -3.831246, -4, -6.391346, 0, -0.5, 0.5, 0.5,
	    -3.831246, -4, -6.391346, 1, -0.5, 0.5, 0.5,
	    -3.831246, -4, -6.391346, 1, 1.5, 0.5, 0.5,
	    -3.831246, -4, -6.391346, 0, 1.5, 0.5, 0.5,
	    -3.831246, -2, -6.391346, 0, -0.5, 0.5, 0.5,
	    -3.831246, -2, -6.391346, 1, -0.5, 0.5, 0.5,
	    -3.831246, -2, -6.391346, 1, 1.5, 0.5, 0.5,
	    -3.831246, -2, -6.391346, 0, 1.5, 0.5, 0.5,
	    -3.831246, 0, -6.391346, 0, -0.5, 0.5, 0.5,
	    -3.831246, 0, -6.391346, 1, -0.5, 0.5, 0.5,
	    -3.831246, 0, -6.391346, 1, 1.5, 0.5, 0.5,
	    -3.831246, 0, -6.391346, 0, 1.5, 0.5, 0.5,
	    -3.831246, 2, -6.391346, 0, -0.5, 0.5, 0.5,
	    -3.831246, 2, -6.391346, 1, -0.5, 0.5, 0.5,
	    -3.831246, 2, -6.391346, 1, 1.5, 0.5, 0.5,
	    -3.831246, 2, -6.391346, 0, 1.5, 0.5, 0.5
	   ]);
	   for (var i=0; i<4; i++) 
	     for (var j=0; j<4; j++) {
	         ind = 7*(4*i + j) + 3;
	         v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i]/width;
	         v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight/height;
	         v[ind] *= texinfo.widths[i]/texinfo.canvasX;
	         v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
	           - v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
	     }
	   var f=new Uint16Array([
	    0, 1, 2, 0, 2, 3,
	    4, 5, 6, 4, 6, 7,
	    8, 9, 10, 8, 10, 11,
	    12, 13, 14, 12, 14, 15
	   ]);
	   var buf14 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf14);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf14 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf14);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc14 = gl.getUniformLocation(prog14,"mvMatrix");
	   var prMatLoc14 = gl.getUniformLocation(prog14,"prMatrix");
	   // ****** lines object 15 ******
	   var prog15  = gl.createProgram();
	   gl.attachShader(prog15, getShader( gl, "rgl_firstexamplevshader15" ));
	   gl.attachShader(prog15, getShader( gl, "rgl_firstexamplefshader15" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog15, 0, "aPos");
	   gl.bindAttribLocation(prog15, 1, "aCol");
	   gl.linkProgram(prog15);
	   var v=new Float32Array([
	    -3.307675, -4.415879, -4,
	    -3.307675, -4.415879, 4,
	    -3.307675, -4.415879, -4,
	    -3.482199, -4.62121, -4,
	    -3.307675, -4.415879, -2,
	    -3.482199, -4.62121, -2,
	    -3.307675, -4.415879, 0,
	    -3.482199, -4.62121, 0,
	    -3.307675, -4.415879, 2,
	    -3.482199, -4.62121, 2,
	    -3.307675, -4.415879, 4,
	    -3.482199, -4.62121, 4
	   ]);
	   var buf15 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf15);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc15 = gl.getUniformLocation(prog15,"mvMatrix");
	   var prMatLoc15 = gl.getUniformLocation(prog15,"prMatrix");
	   // ****** text object 16 ******
	   var prog16  = gl.createProgram();
	   gl.attachShader(prog16, getShader( gl, "rgl_firstexamplevshader16" ));
	   gl.attachShader(prog16, getShader( gl, "rgl_firstexamplefshader16" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog16, 0, "aPos");
	   gl.bindAttribLocation(prog16, 1, "aCol");
	   gl.linkProgram(prog16);
	   var texts = [
	    "-4",
	    "-2",
	    "0",
	    "2",
	    "4"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX16 = texinfo.canvasX;
	   var canvasY16 = texinfo.canvasY;
	   var ofsLoc16 = gl.getAttribLocation(prog16, "aOfs");
	   var texture16 = gl.createTexture();
	   var texLoc16 = gl.getAttribLocation(prog16, "aTexcoord");
	   var sampler16 = gl.getUniformLocation(prog16,"uSampler");
    	   handleLoadedTexture(texture16, document.getElementById("rgl_firstexampletextureCanvas"));
	   var v=new Float32Array([
	    -3.831246, -5.031872, -4, 0, -0.5, 0.5, 0.5,
	    -3.831246, -5.031872, -4, 1, -0.5, 0.5, 0.5,
	    -3.831246, -5.031872, -4, 1, 1.5, 0.5, 0.5,
	    -3.831246, -5.031872, -4, 0, 1.5, 0.5, 0.5,
	    -3.831246, -5.031872, -2, 0, -0.5, 0.5, 0.5,
	    -3.831246, -5.031872, -2, 1, -0.5, 0.5, 0.5,
	    -3.831246, -5.031872, -2, 1, 1.5, 0.5, 0.5,
	    -3.831246, -5.031872, -2, 0, 1.5, 0.5, 0.5,
	    -3.831246, -5.031872, 0, 0, -0.5, 0.5, 0.5,
	    -3.831246, -5.031872, 0, 1, -0.5, 0.5, 0.5,
	    -3.831246, -5.031872, 0, 1, 1.5, 0.5, 0.5,
	    -3.831246, -5.031872, 0, 0, 1.5, 0.5, 0.5,
	    -3.831246, -5.031872, 2, 0, -0.5, 0.5, 0.5,
	    -3.831246, -5.031872, 2, 1, -0.5, 0.5, 0.5,
	    -3.831246, -5.031872, 2, 1, 1.5, 0.5, 0.5,
	    -3.831246, -5.031872, 2, 0, 1.5, 0.5, 0.5,
	    -3.831246, -5.031872, 4, 0, -0.5, 0.5, 0.5,
	    -3.831246, -5.031872, 4, 1, -0.5, 0.5, 0.5,
	    -3.831246, -5.031872, 4, 1, 1.5, 0.5, 0.5,
	    -3.831246, -5.031872, 4, 0, 1.5, 0.5, 0.5
	   ]);
	   for (var i=0; i<5; i++) 
	     for (var j=0; j<4; j++) {
	         ind = 7*(4*i + j) + 3;
	         v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i]/width;
	         v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight/height;
	         v[ind] *= texinfo.widths[i]/texinfo.canvasX;
	         v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
	           - v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
	     }
	   var f=new Uint16Array([
	    0, 1, 2, 0, 2, 3,
	    4, 5, 6, 4, 6, 7,
	    8, 9, 10, 8, 10, 11,
	    12, 13, 14, 12, 14, 15,
	    16, 17, 18, 16, 18, 19
	   ]);
	   var buf16 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf16);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf16 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf16);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc16 = gl.getUniformLocation(prog16,"mvMatrix");
	   var prMatLoc16 = gl.getUniformLocation(prog16,"prMatrix");
	   // ****** lines object 17 ******
	   var prog17  = gl.createProgram();
	   gl.attachShader(prog17, getShader( gl, "rgl_firstexamplevshader17" ));
	   gl.attachShader(prog17, getShader( gl, "rgl_firstexamplefshader17" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog17, 0, "aPos");
	   gl.bindAttribLocation(prog17, 1, "aCol");
	   gl.linkProgram(prog17);
	   var v=new Float32Array([
	    -3.307675, -4.415879, -5.609393,
	    -3.307675, 3.797362, -5.609393,
	    -3.307675, -4.415879, 4.816656,
	    -3.307675, 3.797362, 4.816656,
	    -3.307675, -4.415879, -5.609393,
	    -3.307675, -4.415879, 4.816656,
	    -3.307675, 3.797362, -5.609393,
	    -3.307675, 3.797362, 4.816656,
	    -3.307675, -4.415879, -5.609393,
	    3.673275, -4.415879, -5.609393,
	    -3.307675, -4.415879, 4.816656,
	    3.673275, -4.415879, 4.816656,
	    -3.307675, 3.797362, -5.609393,
	    3.673275, 3.797362, -5.609393,
	    -3.307675, 3.797362, 4.816656,
	    3.673275, 3.797362, 4.816656,
	    3.673275, -4.415879, -5.609393,
	    3.673275, 3.797362, -5.609393,
	    3.673275, -4.415879, 4.816656,
	    3.673275, 3.797362, 4.816656,
	    3.673275, -4.415879, -5.609393,
	    3.673275, -4.415879, 4.816656,
	    3.673275, 3.797362, -5.609393,
	    3.673275, 3.797362, 4.816656
	   ]);
	   var buf17 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf17);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc17 = gl.getUniformLocation(prog17,"mvMatrix");
	   var prMatLoc17 = gl.getUniformLocation(prog17,"prMatrix");
	   gl.enable(gl.DEPTH_TEST);
	   gl.depthFunc(gl.LEQUAL);
	   gl.clearDepth(1.0);
	   gl.clearColor(1, 1, 1, 1);
	   var xOffs = yOffs = 0,  drag  = 0;
	   drawScene();
	   function drawScene(){
	     gl.depthMask(true);
	     gl.disable(gl.BLEND);
	     var radius = 8.007813;
	     var s = sin(fov*PI/360);
	     var t = tan(fov*PI/360);
	     var distance = radius/s;
	     var near = distance - radius;
	     var far = distance + radius;
	     var hlen = t*near;
	     var aspect = width/height;
	     prMatrix.makeIdentity();
	     if (aspect > 1)
	       prMatrix.frustum(-hlen*aspect*zoom, hlen*aspect*zoom, 
	                        -hlen*zoom, hlen*zoom, near, far);
	     else  
	       prMatrix.frustum(-hlen*zoom, hlen*zoom, 
	                        -hlen*zoom/aspect, hlen*zoom/aspect, 
	                        near, far);
	     mvMatrix.makeIdentity();
	     mvMatrix.translate( -0.1828002, 0.3092586, 0.3963683 );
	     mvMatrix.scale( 1.240262, 1.054176, 0.8304396 );   
	     mvMatrix.multRight( userMatrix );  
	     mvMatrix.translate(0, 0, -distance);
	     gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
	     // ****** points object 6 *******
	     gl.useProgram(prog6);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf6);
	     gl.uniformMatrix4fv( prMatLoc6, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc6, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.enableVertexAttribArray( colLoc );
	     gl.vertexAttribPointer(colLoc, 4, gl.FLOAT, false, 28, 12);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawArrays(gl.POINTS, 0, 1000);
	     // ****** text object 8 *******
	     gl.useProgram(prog8);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf8);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf8);
	     gl.uniformMatrix4fv( prMatLoc8, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc8, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc8 );
	     gl.vertexAttribPointer(texLoc8, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture8);
	     gl.uniform1i( sampler8, 0);
	     gl.enableVertexAttribArray( ofsLoc8 );
	     gl.vertexAttribPointer(ofsLoc8, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
	     // ****** text object 9 *******
	     gl.useProgram(prog9);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf9);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf9);
	     gl.uniformMatrix4fv( prMatLoc9, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc9, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc9 );
	     gl.vertexAttribPointer(texLoc9, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture9);
	     gl.uniform1i( sampler9, 0);
	     gl.enableVertexAttribArray( ofsLoc9 );
	     gl.vertexAttribPointer(ofsLoc9, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
	     // ****** text object 10 *******
	     gl.useProgram(prog10);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf10);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf10);
	     gl.uniformMatrix4fv( prMatLoc10, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc10, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc10 );
	     gl.vertexAttribPointer(texLoc10, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture10);
	     gl.uniform1i( sampler10, 0);
	     gl.enableVertexAttribArray( ofsLoc10 );
	     gl.vertexAttribPointer(ofsLoc10, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
	     // ****** lines object 11 *******
	     gl.useProgram(prog11);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf11);
	     gl.uniformMatrix4fv( prMatLoc11, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc11, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.lineWidth( 1 );
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
	     gl.drawArrays(gl.LINES, 0, 16);
	     // ****** text object 12 *******
	     gl.useProgram(prog12);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf12);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf12);
	     gl.uniformMatrix4fv( prMatLoc12, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc12, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc12 );
	     gl.vertexAttribPointer(texLoc12, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture12);
	     gl.uniform1i( sampler12, 0);
	     gl.enableVertexAttribArray( ofsLoc12 );
	     gl.vertexAttribPointer(ofsLoc12, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 42, gl.UNSIGNED_SHORT, 0);
	     // ****** lines object 13 *******
	     gl.useProgram(prog13);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf13);
	     gl.uniformMatrix4fv( prMatLoc13, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc13, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.lineWidth( 1 );
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
	     gl.drawArrays(gl.LINES, 0, 10);
	     // ****** text object 14 *******
	     gl.useProgram(prog14);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf14);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf14);
	     gl.uniformMatrix4fv( prMatLoc14, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc14, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc14 );
	     gl.vertexAttribPointer(texLoc14, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture14);
	     gl.uniform1i( sampler14, 0);
	     gl.enableVertexAttribArray( ofsLoc14 );
	     gl.vertexAttribPointer(ofsLoc14, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 24, gl.UNSIGNED_SHORT, 0);
	     // ****** lines object 15 *******
	     gl.useProgram(prog15);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf15);
	     gl.uniformMatrix4fv( prMatLoc15, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc15, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.lineWidth( 1 );
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
	     gl.drawArrays(gl.LINES, 0, 12);
	     // ****** text object 16 *******
	     gl.useProgram(prog16);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf16);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf16);
	     gl.uniformMatrix4fv( prMatLoc16, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc16, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc16 );
	     gl.vertexAttribPointer(texLoc16, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture16);
	     gl.uniform1i( sampler16, 0);
	     gl.enableVertexAttribArray( ofsLoc16 );
	     gl.vertexAttribPointer(ofsLoc16, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 30, gl.UNSIGNED_SHORT, 0);
	     // ****** lines object 17 *******
	     gl.useProgram(prog17);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf17);
	     gl.uniformMatrix4fv( prMatLoc17, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc17, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.lineWidth( 1 );
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
	     gl.drawArrays(gl.LINES, 0, 24);
	     gl.flush ();
	   }
	   var vlen = function(v) {
	     return sqrt(v[0]*v[0] + v[1]*v[1] + v[2]*v[2])
	   }
	   var xprod = function(a, b) {
	     return [a[1]*b[2] - a[2]*b[1],
	             a[2]*b[0] - a[0]*b[2],
	             a[0]*b[1] - a[1]*b[0]];
	   }
	   var screenToVector = function(x, y) {
	     var radius = max(width, height)/2.0;
	     var cx = width/2.0;
	     var cy = height/2.0;
	     var px = (x-cx)/radius;
	     var py = (y-cy)/radius;
	     var plen = sqrt(px*px+py*py);
	     if (plen > 1.e-6) { 
	       px = px/plen;
	       py = py/plen;
	     }
	     var angle = (SQRT2 - plen)/SQRT2*PI/2;
	     var z = sin(angle);
	     var zlen = sqrt(1.0 - z*z);
	     px = px * zlen;
	     py = py * zlen;
	     return [px, py, z];
	   }
	   var rotBase;
	   var trackballdown = function(x,y) {
	     rotBase = screenToVector(x, y);
	     saveMat.load(userMatrix);
	   }
	   var trackballmove = function(x,y) {
	     var rotCurrent = screenToVector(x,y);
	     var dot = rotBase[0]*rotCurrent[0] + 
	   	       rotBase[1]*rotCurrent[1] + 
	   	       rotBase[2]*rotCurrent[2];
	     var angle = acos( dot/vlen(rotBase)/vlen(rotCurrent) )*180./PI;
	     var axis = xprod(rotBase, rotCurrent);
	     userMatrix.load(saveMat);
	     userMatrix.rotate(angle, axis[0], axis[1], axis[2]);
	     drawScene();
	   }
	   var y0zoom = 0;
	   var zoom0 = 1;
	   var zoomdown = function(x, y) {
	     y0zoom = y;
	     zoom0 = log(zoom);
	   }
	   var zoommove = function(x, y) {
	     zoom = exp(zoom0 + (y-y0zoom)/height);
	     drawScene();
	   }
	   var y0fov = 0;
	   var fov0 = 1;
	   var fovdown = function(x, y) {
	     y0fov = y;
	     fov0 = fov;
	   }
	   var fovmove = function(x, y) {
	     fov = max(1, min(179, fov0 + 180*(y-y0fov)/height));
	     drawScene();
	   }
	   var mousedown = [trackballdown, zoomdown, fovdown];
	   var mousemove = [trackballmove, zoommove, fovmove];
	   function relMouseCoords(event){
	     var totalOffsetX = 0;
	     var totalOffsetY = 0;
	     var currentElement = canvas;
	     do{
	       totalOffsetX += currentElement.offsetLeft;
	       totalOffsetY += currentElement.offsetTop;
	     }
	     while(currentElement = currentElement.offsetParent)
	     var canvasX = event.pageX - totalOffsetX;
	     var canvasY = event.pageY - totalOffsetY;
	     return {x:canvasX, y:canvasY}
	   }
	   canvas.onmousedown = function ( ev ){
	     if (!ev.which) // Use w3c defns in preference to MS
	       switch (ev.button) {
	       case 0: ev.which = 1; break;
	       case 1: 
	       case 4: ev.which = 2; break;
	       case 2: ev.which = 3;
	     }
	     drag = ev.which;
	     var f = mousedown[drag-1];
	     if (f) {
	       var coords = relMouseCoords(ev);
	       f(coords.x, height-coords.y); 
	       ev.preventDefault();
	     }
	   }    
	   canvas.onmouseup = function ( ev ){	
	     drag = 0;
	   }
	   canvas.onmouseout = canvas.onmouseup;
	   canvas.onmousemove = function ( ev ){
	     if ( drag == 0 ) return;
	     var f = mousemove[drag-1];
	     if (f) {
	       var coords = relMouseCoords(ev);
	       f(coords.x, height-coords.y);
	     }
	   }
	   var wheelHandler = function(ev) {
	     var del = 1.1;
	     if (ev.shiftKey) del = 1.01;
	     var ds = ((ev.detail || ev.wheelDelta) > 0) ? del : (1 / del);
	     zoom *= ds;
	     drawScene();
	     ev.preventDefault();
	   };
	   canvas.addEventListener("DOMMouseScroll", wheelHandler, false);
	   canvas.addEventListener("mousewheel", wheelHandler, false);
	}
</script>
<canvas id="rgl_firstexamplecanvas" width="1" height="1"></canvas> 
<p id="rgl_firstexampledebug">
<img src="rgl_firstexamplesnapshot.png" alt="rgl_firstexamplesnapshot" width=505/><br>
	You must enable Javascript to view this page properly.</p>
<script>rgl_firstexamplewebGLStart();</script>





A real-life motivated example
-------------------------------

As a statistician consultant I sometimes have to write statistical reports about a  response surface  analysis.  Wouldn't it be great to include an interactive  response surface in a statistical report ? 
(At least, for fun --- I do not want to encourage an abusive practice of 3D visualization, even when it is interactive)

Russell V. Lenth's `rsm` package provides convenient functions  to draw the response surface fitted with the `lm()` funtion or the  `rsm()` function,  as shown in the vignette [Surface Plots in the rsm Package](http://cran.r-project.org/web/packages/rsm/vignettes/rsm-plots.pdf). 
Below is the interactive `rgl` version of the first example of the vignette.






```r
library(rsm)
swiss2.lm <- lm(Fertility ~ poly(Agriculture, Education, degree = 2), data = swiss)
open3d()
persp3d.lm(swiss2.lm, Education ~ Agriculture, zlab = "Fertility")
```

<script src="CanvasMatrix.js" type="text/javascript"></script>
<canvas id="rgl_persp3dlmtextureCanvas" style="display: none;" width="256" height="256">
<img src="rgl_persp3dlmsnapshot.png" alt="rgl_persp3dlmsnapshot" width=505/><br>
	Your browser does not support the HTML5 canvas element.</canvas>
<!-- ****** surface object 22 ****** -->
<script id="rgl_persp3dlmvshader22" type="x-shader/x-vertex">
	attribute vec3 aPos;
	attribute vec4 aCol;
	uniform mat4 mvMatrix;
	uniform mat4 prMatrix;
	varying vec4 vCol;
	varying vec4 vPosition;
	attribute vec3 aNorm;
	uniform mat4 normMatrix;
	varying vec3 vNormal;
	void main(void) {
	  vPosition = mvMatrix * vec4(aPos, 1.);
	  gl_Position = prMatrix * vPosition;
	  vCol = aCol;
	  vNormal = normalize((normMatrix * vec4(aNorm, 1.)).xyz);
	}
</script>
<script id="rgl_persp3dlmfshader22" type="x-shader/x-fragment"> 
	#ifdef GL_ES
	precision highp float;
	#endif
	varying vec4 vCol; // carries alpha
	varying vec4 vPosition;
	varying vec3 vNormal;
	void main(void) {
	  vec3 eye = normalize(-vPosition.xyz);
	  const vec3 emission = vec3(0., 0., 0.);
	  const vec3 ambient1 = vec3(0., 0., 0.);
	  const vec3 specular1 = vec3(1., 1., 1.);// light*material
	  const float shininess1 = 50.;
	  vec4 colDiff1 = vec4(vCol.rgb * vec3(1., 1., 1.), vCol.a);
	  const vec3 lightDir1 = vec3(0., 0., 1.);
	  vec3 halfVec1 = normalize(lightDir1 + eye);
      vec4 lighteffect = vec4(emission, 0.);
	  vec3 n = normalize(vNormal);
	  n = -faceforward(n, n, eye);
	  vec3 col1 = ambient1;
	  float nDotL1 = dot(n, lightDir1);
	  col1 = col1 + max(nDotL1, 0.) * colDiff1.rgb;
	  col1 = col1 + pow(max(dot(halfVec1, n), 0.), shininess1) * specular1;
	  lighteffect = lighteffect + vec4(col1, colDiff1.a);
	  gl_FragColor = lighteffect;
	}
</script> 
<!-- ****** lines object 23 ****** -->
<script id="rgl_persp3dlmvshader23" type="x-shader/x-vertex">
	attribute vec3 aPos;
	attribute vec4 aCol;
	uniform mat4 mvMatrix;
	uniform mat4 prMatrix;
	varying vec4 vCol;
	varying vec4 vPosition;
	void main(void) {
	  vPosition = mvMatrix * vec4(aPos, 1.);
	  gl_Position = prMatrix * vPosition;
	  vCol = aCol;
	}
</script>
<script id="rgl_persp3dlmfshader23" type="x-shader/x-fragment"> 
	#ifdef GL_ES
	precision highp float;
	#endif
	varying vec4 vCol; // carries alpha
	varying vec4 vPosition;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  gl_FragColor = lighteffect;
	}
</script> 
<!-- ****** text object 25 ****** -->
<script id="rgl_persp3dlmvshader25" type="x-shader/x-vertex">
	attribute vec3 aPos;
	attribute vec4 aCol;
	uniform mat4 mvMatrix;
	uniform mat4 prMatrix;
	varying vec4 vCol;
	varying vec4 vPosition;
	attribute vec2 aTexcoord;
	varying vec2 vTexcoord;
	attribute vec2 aOfs;
	void main(void) {
	  vCol = aCol;
	  vTexcoord = aTexcoord;
	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
	  pos = pos/pos.w;
	  gl_Position = pos + vec4(aOfs, 0.,0.);
	}
</script>
<script id="rgl_persp3dlmfshader25" type="x-shader/x-fragment"> 
	#ifdef GL_ES
	precision highp float;
	#endif
	varying vec4 vCol; // carries alpha
	varying vec4 vPosition;
	varying vec2 vTexcoord;
	uniform sampler2D uSampler;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
	  if (textureColor.a < 0.1)
	    discard;
	  else
	    gl_FragColor = textureColor;
	}
</script> 
<!-- ****** text object 26 ****** -->
<script id="rgl_persp3dlmvshader26" type="x-shader/x-vertex">
	attribute vec3 aPos;
	attribute vec4 aCol;
	uniform mat4 mvMatrix;
	uniform mat4 prMatrix;
	varying vec4 vCol;
	varying vec4 vPosition;
	attribute vec2 aTexcoord;
	varying vec2 vTexcoord;
	attribute vec2 aOfs;
	void main(void) {
	  vCol = aCol;
	  vTexcoord = aTexcoord;
	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
	  pos = pos/pos.w;
	  gl_Position = pos + vec4(aOfs, 0.,0.);
	}
</script>
<script id="rgl_persp3dlmfshader26" type="x-shader/x-fragment"> 
	#ifdef GL_ES
	precision highp float;
	#endif
	varying vec4 vCol; // carries alpha
	varying vec4 vPosition;
	varying vec2 vTexcoord;
	uniform sampler2D uSampler;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
	  if (textureColor.a < 0.1)
	    discard;
	  else
	    gl_FragColor = textureColor;
	}
</script> 
<!-- ****** text object 27 ****** -->
<script id="rgl_persp3dlmvshader27" type="x-shader/x-vertex">
	attribute vec3 aPos;
	attribute vec4 aCol;
	uniform mat4 mvMatrix;
	uniform mat4 prMatrix;
	varying vec4 vCol;
	varying vec4 vPosition;
	attribute vec2 aTexcoord;
	varying vec2 vTexcoord;
	attribute vec2 aOfs;
	void main(void) {
	  vCol = aCol;
	  vTexcoord = aTexcoord;
	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
	  pos = pos/pos.w;
	  gl_Position = pos + vec4(aOfs, 0.,0.);
	}
</script>
<script id="rgl_persp3dlmfshader27" type="x-shader/x-fragment"> 
	#ifdef GL_ES
	precision highp float;
	#endif
	varying vec4 vCol; // carries alpha
	varying vec4 vPosition;
	varying vec2 vTexcoord;
	uniform sampler2D uSampler;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
	  if (textureColor.a < 0.1)
	    discard;
	  else
	    gl_FragColor = textureColor;
	}
</script> 
<!-- ****** lines object 28 ****** -->
<script id="rgl_persp3dlmvshader28" type="x-shader/x-vertex">
	attribute vec3 aPos;
	attribute vec4 aCol;
	uniform mat4 mvMatrix;
	uniform mat4 prMatrix;
	varying vec4 vCol;
	varying vec4 vPosition;
	void main(void) {
	  vPosition = mvMatrix * vec4(aPos, 1.);
	  gl_Position = prMatrix * vPosition;
	  vCol = aCol;
	}
</script>
<script id="rgl_persp3dlmfshader28" type="x-shader/x-fragment"> 
	#ifdef GL_ES
	precision highp float;
	#endif
	varying vec4 vCol; // carries alpha
	varying vec4 vPosition;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  gl_FragColor = lighteffect;
	}
</script> 
<!-- ****** text object 29 ****** -->
<script id="rgl_persp3dlmvshader29" type="x-shader/x-vertex">
	attribute vec3 aPos;
	attribute vec4 aCol;
	uniform mat4 mvMatrix;
	uniform mat4 prMatrix;
	varying vec4 vCol;
	varying vec4 vPosition;
	attribute vec2 aTexcoord;
	varying vec2 vTexcoord;
	attribute vec2 aOfs;
	void main(void) {
	  vCol = aCol;
	  vTexcoord = aTexcoord;
	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
	  pos = pos/pos.w;
	  gl_Position = pos + vec4(aOfs, 0.,0.);
	}
</script>
<script id="rgl_persp3dlmfshader29" type="x-shader/x-fragment"> 
	#ifdef GL_ES
	precision highp float;
	#endif
	varying vec4 vCol; // carries alpha
	varying vec4 vPosition;
	varying vec2 vTexcoord;
	uniform sampler2D uSampler;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
	  if (textureColor.a < 0.1)
	    discard;
	  else
	    gl_FragColor = textureColor;
	}
</script> 
<!-- ****** lines object 30 ****** -->
<script id="rgl_persp3dlmvshader30" type="x-shader/x-vertex">
	attribute vec3 aPos;
	attribute vec4 aCol;
	uniform mat4 mvMatrix;
	uniform mat4 prMatrix;
	varying vec4 vCol;
	varying vec4 vPosition;
	void main(void) {
	  vPosition = mvMatrix * vec4(aPos, 1.);
	  gl_Position = prMatrix * vPosition;
	  vCol = aCol;
	}
</script>
<script id="rgl_persp3dlmfshader30" type="x-shader/x-fragment"> 
	#ifdef GL_ES
	precision highp float;
	#endif
	varying vec4 vCol; // carries alpha
	varying vec4 vPosition;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  gl_FragColor = lighteffect;
	}
</script> 
<!-- ****** text object 31 ****** -->
<script id="rgl_persp3dlmvshader31" type="x-shader/x-vertex">
	attribute vec3 aPos;
	attribute vec4 aCol;
	uniform mat4 mvMatrix;
	uniform mat4 prMatrix;
	varying vec4 vCol;
	varying vec4 vPosition;
	attribute vec2 aTexcoord;
	varying vec2 vTexcoord;
	attribute vec2 aOfs;
	void main(void) {
	  vCol = aCol;
	  vTexcoord = aTexcoord;
	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
	  pos = pos/pos.w;
	  gl_Position = pos + vec4(aOfs, 0.,0.);
	}
</script>
<script id="rgl_persp3dlmfshader31" type="x-shader/x-fragment"> 
	#ifdef GL_ES
	precision highp float;
	#endif
	varying vec4 vCol; // carries alpha
	varying vec4 vPosition;
	varying vec2 vTexcoord;
	uniform sampler2D uSampler;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
	  if (textureColor.a < 0.1)
	    discard;
	  else
	    gl_FragColor = textureColor;
	}
</script> 
<!-- ****** lines object 32 ****** -->
<script id="rgl_persp3dlmvshader32" type="x-shader/x-vertex">
	attribute vec3 aPos;
	attribute vec4 aCol;
	uniform mat4 mvMatrix;
	uniform mat4 prMatrix;
	varying vec4 vCol;
	varying vec4 vPosition;
	void main(void) {
	  vPosition = mvMatrix * vec4(aPos, 1.);
	  gl_Position = prMatrix * vPosition;
	  vCol = aCol;
	}
</script>
<script id="rgl_persp3dlmfshader32" type="x-shader/x-fragment"> 
	#ifdef GL_ES
	precision highp float;
	#endif
	varying vec4 vCol; // carries alpha
	varying vec4 vPosition;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  gl_FragColor = lighteffect;
	}
</script> 
<!-- ****** text object 33 ****** -->
<script id="rgl_persp3dlmvshader33" type="x-shader/x-vertex">
	attribute vec3 aPos;
	attribute vec4 aCol;
	uniform mat4 mvMatrix;
	uniform mat4 prMatrix;
	varying vec4 vCol;
	varying vec4 vPosition;
	attribute vec2 aTexcoord;
	varying vec2 vTexcoord;
	attribute vec2 aOfs;
	void main(void) {
	  vCol = aCol;
	  vTexcoord = aTexcoord;
	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
	  pos = pos/pos.w;
	  gl_Position = pos + vec4(aOfs, 0.,0.);
	}
</script>
<script id="rgl_persp3dlmfshader33" type="x-shader/x-fragment"> 
	#ifdef GL_ES
	precision highp float;
	#endif
	varying vec4 vCol; // carries alpha
	varying vec4 vPosition;
	varying vec2 vTexcoord;
	uniform sampler2D uSampler;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
	  if (textureColor.a < 0.1)
	    discard;
	  else
	    gl_FragColor = textureColor;
	}
</script> 
<!-- ****** lines object 34 ****** -->
<script id="rgl_persp3dlmvshader34" type="x-shader/x-vertex">
	attribute vec3 aPos;
	attribute vec4 aCol;
	uniform mat4 mvMatrix;
	uniform mat4 prMatrix;
	varying vec4 vCol;
	varying vec4 vPosition;
	void main(void) {
	  vPosition = mvMatrix * vec4(aPos, 1.);
	  gl_Position = prMatrix * vPosition;
	  vCol = aCol;
	}
</script>
<script id="rgl_persp3dlmfshader34" type="x-shader/x-fragment"> 
	#ifdef GL_ES
	precision highp float;
	#endif
	varying vec4 vCol; // carries alpha
	varying vec4 vPosition;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  gl_FragColor = lighteffect;
	}
</script> 
<script type="text/javascript"> 
	function getShader ( gl, id ){
	   var shaderScript = document.getElementById ( id );
	   var str = "";
	   var k = shaderScript.firstChild;
	   while ( k ){
	     if ( k.nodeType == 3 ) str += k.textContent;
	     k = k.nextSibling;
	   }
	   var shader;
	   if ( shaderScript.type == "x-shader/x-fragment" )
             shader = gl.createShader ( gl.FRAGMENT_SHADER );
	   else if ( shaderScript.type == "x-shader/x-vertex" )
             shader = gl.createShader(gl.VERTEX_SHADER);
	   else return null;
	   gl.shaderSource(shader, str);
	   gl.compileShader(shader);
	   if (gl.getShaderParameter(shader, gl.COMPILE_STATUS) == 0)
	     alert(gl.getShaderInfoLog(shader));
	   return shader;
	}
	var min = Math.min;
	var max = Math.max;
	var sqrt = Math.sqrt;
	var sin = Math.sin;
	var acos = Math.acos;
	var tan = Math.tan;
	var SQRT2 = Math.SQRT2;
	var PI = Math.PI;
	var log = Math.log;
	var exp = Math.exp;
	function rgl_persp3dlmwebGLStart() {
	   var debug = function(msg) {
	     document.getElementById("rgl_persp3dlmdebug").innerHTML = msg;
	   }
	   debug("");
	   var canvas = document.getElementById("rgl_persp3dlmcanvas");
	   if (!window.WebGLRenderingContext){
	     debug("<img src=\"rgl_persp3dlmsnapshot.png\" alt=\"rgl_persp3dlmsnapshot\" width=505/><br> Your browser does not support WebGL. See <a href=\"http://get.webgl.org\">http://get.webgl.org</a>");
	     return;
	   }
	   var gl;
	   try {
	     // Try to grab the standard context. If it fails, fallback to experimental.
	     gl = canvas.getContext("webgl") 
	       || canvas.getContext("experimental-webgl");
	   }
	   catch(e) {}
	   if ( !gl ) {
	     debug("<img src=\"rgl_persp3dlmsnapshot.png\" alt=\"rgl_persp3dlmsnapshot\" width=505/><br> Your browser appears to support WebGL, but did not create a WebGL context.  See <a href=\"http://get.webgl.org\">http://get.webgl.org</a>");
	     return;
	   }
	   var width = 505;  var height = 505;
	   canvas.width = width;   canvas.height = height;
	   gl.viewport(0, 0, width, height);
	   var prMatrix = new CanvasMatrix4();
	   var mvMatrix = new CanvasMatrix4();
	   var normMatrix = new CanvasMatrix4();
	   var saveMat = new CanvasMatrix4();
	   saveMat.makeIdentity();
	   var distance;
	   var posLoc = 0;
	   var colLoc = 1;
	   var zoom = 1;
	   var fov = 30;
	   var userMatrix = new CanvasMatrix4();
	   userMatrix.load([
	    1, 0, 0, 0,
	    0, 0.3420201, -0.9396926, 0,
	    0, 0.9396926, 0.3420201, 0,
	    0, 0, 0, 1
		]);
	   function getPowerOfTwo(value) {
	     var pow = 1;
	     while(pow<value) {
	       pow *= 2;
	     }
	     return pow;
	   }
	   function handleLoadedTexture(texture, textureCanvas) {
	     gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, true);
	     gl.bindTexture(gl.TEXTURE_2D, texture);
	     gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, textureCanvas);
	     gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);
	     gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_NEAREST);
	     gl.generateMipmap(gl.TEXTURE_2D);
	     gl.bindTexture(gl.TEXTURE_2D, null);
	   }
	   function loadImageToTexture(filename, texture) {   
	     var canvas = document.getElementById("rgl_persp3dlmtextureCanvas");
	     var ctx = canvas.getContext("2d");
	     var image = new Image();
	     image.onload = function() {
	       var w = image.width;
	       var h = image.height;
	       var canvasX = getPowerOfTwo(w);
	       var canvasY = getPowerOfTwo(h);
	       canvas.width = canvasX;
	       canvas.height = canvasY;
	       ctx.imageSmoothingEnabled = true;
	       ctx.drawImage(image, 0, 0, canvasX, canvasY);
	       handleLoadedTexture(texture, canvas);
   	       drawScene();
	     }
	     image.src = filename;
	   }  	   
	   function drawTextToCanvas(text, cex) {
	     var canvasX, canvasY;
	     var textX, textY;
	     var textHeight = 20 * cex;
	     var textColour = "white";
	     var fontFamily = "Arial";
	     var backgroundColour = "rgba(0,0,0,0)";
	     var canvas = document.getElementById("rgl_persp3dlmtextureCanvas");
	     var ctx = canvas.getContext("2d");
	     ctx.font = textHeight+"px "+fontFamily;
             canvasX = 1;
             var widths = [];
	     for (var i = 0; i < text.length; i++)  {
	       widths[i] = ctx.measureText(text[i]).width;
	       canvasX = (widths[i] > canvasX) ? widths[i] : canvasX;
	     }	  
	     canvasX = getPowerOfTwo(canvasX);
	     var offset = 2*textHeight; // offset to first baseline
	     var skip = 2*textHeight;   // skip between baselines	  
	     canvasY = getPowerOfTwo(offset + text.length*skip);
	     canvas.width = canvasX;
	     canvas.height = canvasY;
	     ctx.fillStyle = backgroundColour;
	     ctx.fillRect(0, 0, ctx.canvas.width, ctx.canvas.height);
	     ctx.fillStyle = textColour;
	     ctx.textAlign = "left";
	     ctx.textBaseline = "alphabetic";
	     ctx.font = textHeight+"px "+fontFamily;
	     for(var i = 0; i < text.length; i++) {
	       textY = i*skip + offset;
	       ctx.fillText(text[i], 0,  textY);
	     }
	     return {canvasX:canvasX, canvasY:canvasY,
	             widths:widths, textHeight:textHeight,
	             offset:offset, skip:skip};
	   }
	   // ****** surface object 22 ******
	   var prog22  = gl.createProgram();
	   gl.attachShader(prog22, getShader( gl, "rgl_persp3dlmvshader22" ));
	   gl.attachShader(prog22, getShader( gl, "rgl_persp3dlmfshader22" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog22, 0, "aPos");
	   gl.bindAttribLocation(prog22, 1, "aCol");
	   gl.linkProgram(prog22);
	   var v=new Float32Array([
	    1.2, 1, 72.92789, 0.02351678, -0.08777684, -0.9958625,
	    4.74, 1, 73.01148, 0.02236517, -0.08869245, -0.9958079,
	    8.28, 1, 73.08569, 0.01972478, -0.09006461, -0.9957406,
	    11.82, 1, 73.15052, 0.01708244, -0.09143698, -0.9956643,
	    15.36, 1, 73.20596, 0.0144411, -0.0928071, -0.9955794,
	    18.9, 1, 73.25201, 0.01180082, -0.09417496, -0.9954857,
	    22.44, 1, 73.28867, 0.00916024, -0.09554171, -0.9953833,
	    25.98, 1, 73.31595, 0.006519434, -0.09690732, -0.9952721,
	    29.52, 1, 73.33384, 0.00388061, -0.09827176, -0.9951521,
	    33.06, 1, 73.34235, 0.001241699, -0.09963739, -0.995023,
	    36.6, 1, 73.34147, -0.001395802, -0.1010006, -0.9948854,
	    40.14, 1, 73.3312, -0.004033966, -0.1023613, -0.9947391,
	    43.68, 1, 73.31155, -0.00667058, -0.1037231, -0.9945838,
	    47.22, 1, 73.28251, -0.00930558, -0.1050823, -0.99442,
	    50.76, 1, 73.24408, -0.01194104, -0.106439, -0.9942475,
	    54.3, 1, 73.19627, -0.01457401, -0.1077942, -0.9940664,
	    57.84, 1, 73.13907, -0.01720659, -0.1091504, -0.9938763,
	    61.38, 1, 73.07249, -0.01983729, -0.1105038, -0.9936777,
	    64.92, 1, 72.99651, -0.02246816, -0.1118546, -0.9934705,
	    68.46, 1, 72.91116, -0.02509628, -0.1132038, -0.9932548,
	    72, 1, 72.81641, -0.02772372, -0.1145538, -0.9930301,
	    75.54, 1, 72.71229, -0.03034971, -0.1159034, -0.9927967,
	    79.08, 1, 72.59877, -0.03297419, -0.1172489, -0.992555,
	    82.62, 1, 72.47587, -0.03559708, -0.1185916, -0.9923048,
	    86.16, 1, 72.34357, -0.03821834, -0.1199325, -0.9920461,
	    89.7, 1, 72.2019, -0.04009716, -0.1210518, -0.991836,
	    1.2, 3.08, 72.74455, 0.02296997, -0.09083006, -0.9956015,
	    4.74, 3.08, 72.82526, 0.0213777, -0.09303999, -0.9954328,
	    8.28, 3.08, 72.8966, 0.01873713, -0.09441051, -0.995357,
	    11.82, 3.08, 72.95854, 0.01609611, -0.09578058, -0.9952723,
	    15.36, 3.08, 73.0111, 0.01345649, -0.09714774, -0.995179,
	    18.9, 3.08, 73.05428, 0.01081691, -0.09851498, -0.9950768,
	    22.44, 3.08, 73.08807, 0.008177449, -0.09988046, -0.9949658,
	    25.98, 3.08, 73.11246, 0.005538168, -0.1012441, -0.9948462,
	    29.52, 3.08, 73.12748, 0.002899495, -0.1026084, -0.9947176,
	    33.06, 3.08, 73.1331, 0.0002625735, -0.1039713, -0.9945803,
	    36.6, 3.08, 73.12935, -0.002373956, -0.1053324, -0.9944342,
	    40.14, 3.08, 73.1162, -0.005010737, -0.1066921, -0.9942795,
	    43.68, 3.08, 73.09367, -0.007645204, -0.1080493, -0.9941161,
	    47.22, 3.08, 73.06175, -0.01027943, -0.1094056, -0.993944,
	    50.76, 3.08, 73.02045, -0.01291263, -0.1107605, -0.9937632,
	    54.3, 3.08, 72.96976, -0.01554509, -0.1121151, -0.9935736,
	    57.84, 3.08, 72.90968, -0.01817496, -0.113467, -0.9933755,
	    61.38, 3.08, 72.84022, -0.02080468, -0.1148174, -0.9931687,
	    64.92, 3.08, 72.76137, -0.02343344, -0.1161674, -0.9929532,
	    68.46, 3.08, 72.67313, -0.02606011, -0.1175151, -0.9927291,
	    72, 3.08, 72.57551, -0.02868606, -0.1188618, -0.9924963,
	    75.54, 3.08, 72.4685, -0.0313098, -0.1202062, -0.9922551,
	    79.08, 3.08, 72.3521, -0.03393162, -0.1215478, -0.9920054,
	    82.62, 3.08, 72.22633, -0.03655322, -0.1228887, -0.9917471,
	    86.16, 3.08, 72.09116, -0.03917208, -0.1242279, -0.9914802,
	    89.7, 3.08, 71.9466, -0.0407412, -0.126402, -0.9911421,
	    1.2, 5.16, 72.54482, 0.0221457, -0.09860508, -0.9948802,
	    4.74, 5.16, 72.62266, 0.02055326, -0.1008108, -0.9946933,
	    8.28, 5.16, 72.69111, 0.01791377, -0.102179, -0.9946047,
	    11.82, 5.16, 72.75018, 0.01527569, -0.1035443, -0.9945075,
	    15.36, 5.16, 72.79986, 0.0126373, -0.1049089, -0.9944015,
	    18.9, 5.16, 72.84015, 0.009999743, -0.1062729, -0.9942867,
	    22.44, 5.16, 72.87106, 0.007362729, -0.1076357, -0.9941631,
	    25.98, 5.16, 72.89259, 0.004724899, -0.1089983, -0.9940307,
	    29.52, 5.16, 72.90472, 0.002088823, -0.1103578, -0.9938897,
	    33.06, 5.16, 72.90746, -0.0005457845, -0.1117154, -0.9937401,
	    36.6, 5.16, 72.90083, -0.003180284, -0.1130739, -0.9935815,
	    40.14, 5.16, 72.8848, -0.005813179, -0.1144286, -0.9934145,
	    43.68, 5.16, 72.8594, -0.008445827, -0.1157824, -0.9932387,
	    47.22, 5.16, 72.8246, -0.01107781, -0.1171359, -0.9930541,
	    50.76, 5.16, 72.78042, -0.01370833, -0.1184867, -0.992861,
	    54.3, 5.16, 72.72684, -0.01633768, -0.1198359, -0.9926593,
	    57.84, 5.16, 72.66389, -0.01896473, -0.1211835, -0.9924489,
	    61.38, 5.16, 72.59155, -0.02159263, -0.1225312, -0.9922297,
	    64.92, 5.16, 72.50982, -0.02421772, -0.1238761, -0.9920021,
	    68.46, 5.16, 72.41871, -0.02684135, -0.1252192, -0.9917659,
	    72, 5.16, 72.31821, -0.02946386, -0.12656, -0.9915213,
	    75.54, 5.16, 72.20832, -0.03208408, -0.1278984, -0.9912682,
	    79.08, 5.16, 72.08905, -0.03470371, -0.1292368, -0.9910063,
	    82.62, 5.16, 71.96039, -0.03732164, -0.1305734, -0.9907359,
	    86.16, 5.16, 71.82234, -0.03993678, -0.1319063, -0.9904574,
	    89.7, 5.16, 71.67491, -0.04150361, -0.1340737, -0.9901019,
	    1.2, 7.24, 72.32869, 0.02131988, -0.1063635, -0.9940987,
	    4.74, 7.24, 72.40365, 0.01972812, -0.108564, -0.9938937,
	    8.28, 7.24, 72.46922, 0.01709168, -0.1099272, -0.9937927,
	    11.82, 7.24, 72.52541, 0.01445529, -0.1112904, -0.9936828,
	    15.36, 7.24, 72.57222, 0.01181867, -0.1126528, -0.9935641,
	    18.9, 7.24, 72.60963, 0.009183306, -0.1140133, -0.9934368,
	    22.44, 7.24, 72.63766, 0.006547849, -0.1153731, -0.9933006,
	    25.98, 7.24, 72.6563, 0.003913437, -0.1167302, -0.9931559,
	    29.52, 7.24, 72.66557, 0.001280493, -0.1180853, -0.9930026,
	    33.06, 7.24, 72.66544, -0.001353052, -0.1194402, -0.9928405,
	    36.6, 7.24, 72.65591, -0.003984632, -0.1207935, -0.9926697,
	    40.14, 7.24, 72.63702, -0.006614533, -0.1221447, -0.9924903,
	    43.68, 7.24, 72.60873, -0.009245541, -0.1234961, -0.992302,
	    47.22, 7.24, 72.57105, -0.01187332, -0.1248442, -0.9921053,
	    50.76, 7.24, 72.52399, -0.0145017, -0.1261911, -0.9918999,
	    54.3, 7.24, 72.46754, -0.01712777, -0.1275365, -0.991686,
	    57.84, 7.24, 72.40171, -0.01975254, -0.1288801, -0.9914634,
	    61.38, 7.24, 72.32649, -0.02237667, -0.1302207, -0.9912325,
	    64.92, 7.24, 72.24188, -0.02499898, -0.1315602, -0.9909929,
	    68.46, 7.24, 72.14789, -0.02761942, -0.1328985, -0.9907448,
	    72, 7.24, 72.04451, -0.03023829, -0.1342349, -0.9904881,
	    75.54, 7.24, 71.93175, -0.03285552, -0.1355695, -0.9902229,
	    79.08, 7.24, 71.80959, -0.03547211, -0.1369022, -0.9899493,
	    82.62, 7.24, 71.67805, -0.03808585, -0.1382329, -0.9896672,
	    86.16, 7.24, 71.53713, -0.0406978, -0.1395616, -0.9893767,
	    89.7, 7.24, 71.38682, -0.04226259, -0.1417208, -0.9890041,
	    1.2, 9.32, 72.09617, 0.02049411, -0.1141015, -0.9932577,
	    4.74, 9.32, 72.16825, 0.01890422, -0.1162959, -0.9930347,
	    8.28, 9.32, 72.23095, 0.01626886, -0.1176574, -0.992921,
	    11.82, 9.32, 72.28426, 0.01363434, -0.1190182, -0.9927985,
	    15.36, 9.32, 72.32818, 0.01100074, -0.1203763, -0.9926674,
	    18.9, 9.32, 72.36272, 0.008368109, -0.1217319, -0.9925277,
	    22.44, 9.32, 72.38787, 0.005734746, -0.1230872, -0.9923793,
	    25.98, 9.32, 72.40363, 0.003103212, -0.1244409, -0.9922222,
	    29.52, 9.32, 72.41001, 0.0004725064, -0.1257932, -0.9920564,
	    33.06, 9.32, 72.40701, -0.002158371, -0.1271439, -0.9918819,
	    36.6, 9.32, 72.39461, -0.004786499, -0.1284924, -0.9916989,
	    40.14, 9.32, 72.37283, -0.007415014, -0.1298404, -0.9915072,
	    43.68, 9.32, 72.34166, -0.01004207, -0.1311856, -0.991307,
	    47.22, 9.32, 72.30111, -0.01266761, -0.1325296, -0.9910981,
	    50.76, 9.32, 72.25117, -0.01529261, -0.1338726, -0.9908806,
	    54.3, 9.32, 72.19184, -0.01791523, -0.1352119, -0.9906547,
	    57.84, 9.32, 72.12313, -0.02053684, -0.1365507, -0.9904202,
	    61.38, 9.32, 72.04504, -0.02315737, -0.137887, -0.9901772,
	    64.92, 9.32, 71.95755, -0.02577674, -0.1392209, -0.9899258,
	    68.46, 9.32, 71.86068, -0.02839451, -0.1405547, -0.9896657,
	    72, 9.32, 71.75442, -0.03100959, -0.1418865, -0.9893971,
	    75.54, 9.32, 71.63878, -0.03362331, -0.1432158, -0.9891202,
	    79.08, 9.32, 71.51375, -0.03623632, -0.144543, -0.9888348,
	    82.62, 9.32, 71.37933, -0.03884607, -0.1458671, -0.9885412,
	    86.16, 9.32, 71.23553, -0.04145467, -0.1471897, -0.9882392,
	    89.7, 9.32, 71.08234, -0.04301589, -0.1493408, -0.9878497,
	    1.2, 11.4, 71.84725, 0.01966924, -0.1218203, -0.9923573,
	    4.74, 11.4, 71.91646, 0.01807956, -0.1240104, -0.9921162,
	    8.28, 11.4, 71.97627, 0.0154469, -0.125367, -0.9919902,
	    11.82, 11.4, 72.0267, 0.01281479, -0.1267221, -0.9918555,
	    15.36, 11.4, 72.06775, 0.01018438, -0.1280757, -0.9917121,
	    18.9, 11.4, 72.09941, 0.007553231, -0.129429, -0.9915599,
	    22.44, 11.4, 72.12168, 0.004922849, -0.1307808, -0.9913991,
	    25.98, 11.4, 72.13457, 0.00229437, -0.1321291, -0.9912299,
	    29.52, 11.4, 72.13807, -0.0003339217, -0.1334765, -0.9910519,
	    33.06, 11.4, 72.13218, -0.002961957, -0.1348227, -0.9908653,
	    36.6, 11.4, 72.11691, -0.005587173, -0.1361667, -0.9906702,
	    40.14, 11.4, 72.09225, -0.008212703, -0.1375101, -0.9904663,
	    43.68, 11.4, 72.0582, -0.01083635, -0.1388512, -0.990254,
	    47.22, 11.4, 72.01477, -0.01345947, -0.140191, -0.990033,
	    50.76, 11.4, 71.96195, -0.01608021, -0.1415273, -0.9898037,
	    54.3, 11.4, 71.89975, -0.01870028, -0.1428623, -0.9895659,
	    57.84, 11.4, 71.82816, -0.02131855, -0.144196, -0.9893195,
	    61.38, 11.4, 71.74718, -0.02393533, -0.1455277, -0.9890646,
	    64.92, 11.4, 71.65682, -0.02655193, -0.1468587, -0.9888011,
	    68.46, 11.4, 71.55707, -0.02916581, -0.1481859, -0.9885294,
	    72, 11.4, 71.44793, -0.03177729, -0.1495105, -0.9882494,
	    75.54, 11.4, 71.32941, -0.03438768, -0.1508354, -0.9879606,
	    79.08, 11.4, 71.2015, -0.03699554, -0.1521558, -0.9876639,
	    82.62, 11.4, 71.06421, -0.03960219, -0.1534747, -0.9873587,
	    86.16, 11.4, 70.91753, -0.04220727, -0.1547927, -0.987045,
	    89.7, 11.4, 70.76146, -0.04376481, -0.1569348, -0.9866388,
	    1.2, 13.48, 71.58194, 0.01884329, -0.1295183, -0.991398,
	    4.74, 13.48, 71.64826, 0.0172561, -0.1317002, -0.9911394,
	    8.28, 13.48, 71.70521, 0.01462594, -0.1330528, -0.991001,
	    11.82, 13.48, 71.75275, 0.01199642, -0.1344038, -0.990854,
	    15.36, 13.48, 71.79092, 0.009367948, -0.1357539, -0.9906983,
	    18.9, 13.48, 71.8197, 0.00673953, -0.1371029, -0.9905339,
	    22.44, 13.48, 71.8391, 0.004113018, -0.1384484, -0.9903611,
	    25.98, 13.48, 71.84911, 0.001487054, -0.1397935, -0.9901796,
	    29.52, 13.48, 71.84973, -0.001138649, -0.1411374, -0.9899894,
	    33.06, 13.48, 71.84097, -0.003762959, -0.1424784, -0.9897908,
	    36.6, 13.48, 71.82281, -0.006386157, -0.1438176, -0.9895836,
	    40.14, 13.48, 71.79527, -0.00900853, -0.1451562, -0.9893677,
	    43.68, 13.48, 71.75835, -0.01162895, -0.1464923, -0.9891435,
	    47.22, 13.48, 71.71204, -0.01424772, -0.1478253, -0.9889109,
	    50.76, 13.48, 71.65634, -0.01686545, -0.1491576, -0.9886696,
	    54.3, 13.48, 71.59126, -0.01948243, -0.1504885, -0.9884198,
	    57.84, 13.48, 71.51679, -0.0220972, -0.1518168, -0.9881616,
	    61.38, 13.48, 71.43294, -0.02471112, -0.1531437, -0.9878949,
	    64.92, 13.48, 71.33969, -0.02732302, -0.1544674, -0.98762,
	    68.46, 13.48, 71.23707, -0.02993249, -0.1557884, -0.9873368,
	    72, 13.48, 71.12505, -0.03254161, -0.1571085, -0.9870451,
	    75.54, 13.48, 71.00365, -0.03514782, -0.1584264, -0.986745,
	    79.08, 13.48, 70.87286, -0.03775142, -0.1597416, -0.9864367,
	    82.62, 13.48, 70.73269, -0.04035515, -0.1610563, -0.9861198,
	    86.16, 13.48, 70.58313, -0.04295479, -0.162367, -0.985795,
	    89.7, 13.48, 70.42419, -0.04450995, -0.1645016, -0.9853721,
	    1.2, 15.56, 71.30023, 0.01801855, -0.1371908, -0.9903807,
	    4.74, 15.56, 71.36368, 0.01643326, -0.1393665, -0.9901045,
	    8.28, 15.56, 71.41774, 0.01380579, -0.1407148, -0.9899539,
	    11.82, 15.56, 71.46242, 0.01117902, -0.1420615, -0.9897947,
	    15.36, 15.56, 71.4977, 0.008552668, -0.1434077, -0.9896267,
	    18.9, 15.56, 71.52361, 0.005928222, -0.1447504, -0.9894504,
	    22.44, 15.56, 71.54012, 0.003303615, -0.1460931, -0.9892653,
	    25.98, 15.56, 71.54725, 0.0006803402, -0.1474346, -0.9890716,
	    29.52, 15.56, 71.54499, -0.001941536, -0.1487731, -0.9888695,
	    33.06, 15.56, 71.53335, -0.00456195, -0.1501085, -0.988659,
	    36.6, 15.56, 71.51232, -0.007182602, -0.1514433, -0.9884399,
	    40.14, 15.56, 71.4819, -0.009801295, -0.1527755, -0.9882123,
	    43.68, 15.56, 71.4421, -0.01241797, -0.1541053, -0.9879764,
	    47.22, 15.56, 71.39291, -0.01503433, -0.1554348, -0.9877317,
	    50.76, 15.56, 71.33434, -0.01764888, -0.1567628, -0.9874786,
	    54.3, 15.56, 71.26637, -0.02026156, -0.1580877, -0.9872172,
	    57.84, 15.56, 71.18903, -0.02287231, -0.1594093, -0.9869476,
	    61.38, 15.56, 71.10229, -0.02548285, -0.1607299, -0.9866694,
	    64.92, 15.56, 71.00617, -0.02809059, -0.1620484, -0.9863829,
	    68.46, 15.56, 70.90067, -0.03069654, -0.1633648, -0.9860881,
	    72, 15.56, 70.78577, -0.03330173, -0.1646789, -0.9857849,
	    75.54, 15.56, 70.66149, -0.03590324, -0.1659902, -0.9854736,
	    79.08, 15.56, 70.52783, -0.03850418, -0.1673005, -0.9851538,
	    82.62, 15.56, 70.38477, -0.04110274, -0.1686072, -0.984826,
	    86.16, 15.56, 70.23234, -0.04369888, -0.1699122, -0.9844898,
	    89.7, 15.56, 70.07051, -0.04525121, -0.1720377, -0.9840505,
	    1.2, 17.64, 71.00213, 0.01719518, -0.14484, -0.9893057,
	    4.74, 17.64, 71.0627, 0.01561119, -0.1470079, -0.9890121,
	    8.28, 17.64, 71.11388, 0.01298622, -0.1483529, -0.9888492,
	    11.82, 17.64, 71.15568, 0.01036203, -0.1496962, -0.9886777,
	    15.36, 17.64, 71.18809, 0.00773975, -0.1510359, -0.988498,
	    18.9, 17.64, 71.21111, 0.005117311, -0.1523755, -0.9883094,
	    22.44, 17.64, 71.22475, 0.00249585, -0.1537133, -0.9881123,
	    25.98, 17.64, 71.229, -0.0001234988, -0.1550475, -0.987907,
	    29.52, 17.64, 71.22386, -0.002741736, -0.1563797, -0.9876932,
	    33.06, 17.64, 71.20934, -0.005359859, -0.1577118, -0.9874706,
	    36.6, 17.64, 71.18543, -0.00797673, -0.1590418, -0.9872396,
	    40.14, 17.64, 71.15214, -0.01059122, -0.1603681, -0.9870004,
	    43.68, 17.64, 71.10946, -0.01320539, -0.1616942, -0.9867526,
	    47.22, 17.64, 71.05739, -0.01581778, -0.163017, -0.9864965,
	    50.76, 17.64, 70.99593, -0.01842863, -0.1643376, -0.986232,
	    54.3, 17.64, 70.92509, -0.02103684, -0.1656562, -0.9859592,
	    57.84, 17.64, 70.84487, -0.02364482, -0.1669737, -0.9856778,
	    61.38, 17.64, 70.75526, -0.0262511, -0.168289, -0.9853881,
	    64.92, 17.64, 70.65626, -0.02885453, -0.1696004, -0.9850904,
	    68.46, 17.64, 70.54787, -0.03145681, -0.1709101, -0.9847843,
	    72, 17.64, 70.4301, -0.0340579, -0.1722181, -0.9844699,
	    75.54, 17.64, 70.30294, -0.03665526, -0.1735231, -0.9841474,
	    79.08, 17.64, 70.1664, -0.03925198, -0.174827, -0.9838164,
	    82.62, 17.64, 70.02047, -0.04184589, -0.1761279, -0.9834774,
	    86.16, 17.64, 69.86515, -0.04443839, -0.177427, -0.9831301,
	    89.7, 17.64, 69.70045, -0.04598638, -0.1795418, -0.9826749,
	    1.2, 19.72, 70.68763, 0.01637261, -0.1524634, -0.9881735,
	    4.74, 19.72, 70.74532, 0.01478969, -0.1546244, -0.9878626,
	    8.28, 19.72, 70.79362, 0.0121674, -0.155964, -0.9876878,
	    11.82, 19.72, 70.83254, 0.009547025, -0.1573018, -0.9875044,
	    15.36, 19.72, 70.86208, 0.00692756, -0.1586377, -0.9873126,
	    18.9, 19.72, 70.88222, 0.004308011, -0.1599717, -0.9871122,
	    22.44, 19.72, 70.89297, 0.00169093, -0.1613026, -0.9869035,
	    25.98, 19.72, 70.89435, -0.0009250373, -0.1626315, -0.9866864,
	    29.52, 19.72, 70.88634, -0.003540884, -0.1639602, -0.9864606,
	    33.06, 19.72, 70.86893, -0.006155485, -0.1652868, -0.9862263,
	    36.6, 19.72, 70.84215, -0.008767705, -0.1666096, -0.985984,
	    40.14, 19.72, 70.80598, -0.0113796, -0.1679321, -0.9857329,
	    43.68, 19.72, 70.76041, -0.01398934, -0.1692518, -0.9854735,
	    47.22, 19.72, 70.70547, -0.01659793, -0.1705688, -0.985206,
	    50.76, 19.72, 70.64114, -0.01920492, -0.1718836, -0.98493,
	    54.3, 19.72, 70.56742, -0.02180991, -0.1731968, -0.9846457,
	    57.84, 19.72, 70.48431, -0.0244139, -0.1745083, -0.984353,
	    61.38, 19.72, 70.39182, -0.02701507, -0.1758158, -0.9840523,
	    64.92, 19.72, 70.28995, -0.02961473, -0.1771221, -0.9837432,
	    68.46, 19.72, 70.17869, -0.03221316, -0.1784266, -0.9834258,
	    72, 19.72, 70.05804, -0.0348093, -0.1797276, -0.9831004,
	    75.54, 19.72, 69.928, -0.0374034, -0.1810262, -0.9827668,
	    79.08, 19.72, 69.78857, -0.03999574, -0.1823235, -0.9824248,
	    82.62, 19.72, 69.63976, -0.04258522, -0.1836178, -0.9820748,
	    86.16, 19.72, 69.48157, -0.04517217, -0.1849084, -0.981717,
	    89.7, 19.72, 69.31399, -0.04671747, -0.1870141, -0.9812457,
	    1.2, 21.8, 70.35674, 0.01555099, -0.1600586, -0.986985,
	    4.74, 21.8, 70.41155, 0.01396926, -0.1622117, -0.9866571,
	    8.28, 21.8, 70.45698, 0.01134982, -0.1635475, -0.9864702,
	    11.82, 21.8, 70.49301, 0.008733428, -0.1648796, -0.986275,
	    15.36, 21.8, 70.51967, 0.006116952, -0.1662097, -0.9860715,
	    18.9, 21.8, 70.53693, 0.003501525, -0.1675378, -0.9858594,
	    22.44, 21.8, 70.54482, 0.000887923, -0.1688633, -0.9856391,
	    25.98, 21.8, 70.54331, -0.001725556, -0.1701885, -0.98541,
	    29.52, 21.8, 70.53242, -0.004337784, -0.1715116, -0.9851725,
	    33.06, 21.8, 70.51214, -0.006947638, -0.1728308, -0.984927,
	    36.6, 21.8, 70.48248, -0.009557162, -0.1741497, -0.9846728,
	    40.14, 21.8, 70.44342, -0.01216523, -0.1754663, -0.9844103,
	    43.68, 21.8, 70.39498, -0.01477038, -0.1767795, -0.9841396,
	    47.22, 21.8, 70.33716, -0.01737501, -0.1780905, -0.9838607,
	    50.76, 21.8, 70.26995, -0.01997799, -0.1793992, -0.9835735,
	    54.3, 21.8, 70.19335, -0.02257959, -0.1807068, -0.9832778,
	    57.84, 21.8, 70.10737, -0.02517837, -0.1820103, -0.9829742,
	    61.38, 21.8, 70.012, -0.02777638, -0.1833131, -0.9826621,
	    64.92, 21.8, 69.90724, -0.03037211, -0.1846141, -0.9823417,
	    68.46, 21.8, 69.7931, -0.0329655, -0.1859116, -0.9820133,
	    72, 21.8, 69.66957, -0.03555653, -0.1872054, -0.9816771,
	    75.54, 21.8, 69.53666, -0.03814685, -0.1884979, -0.9813324,
	    79.08, 21.8, 69.39436, -0.04073432, -0.1897872, -0.9809799,
	    82.62, 21.8, 69.24267, -0.04331886, -0.1910735, -0.9806194,
	    86.16, 21.8, 69.0816, -0.04590221, -0.1923589, -0.9802505,
	    89.7, 21.8, 68.91113, -0.04744436, -0.1944556, -0.9797633,
	    1.2, 23.88, 70.00945, 0.01472905, -0.1676268, -0.9857405,
	    4.74, 23.88, 70.06139, 0.01314934, -0.1697728, -0.9853955,
	    8.28, 23.88, 70.10393, 0.01053434, -0.1711015, -0.9851971,
	    11.82, 23.88, 70.13709, 0.007921385, -0.1724283, -0.9849902,
	    15.36, 23.88, 70.16087, 0.005308062, -0.1737541, -0.9847748,
	    18.9, 23.88, 70.17525, 0.002696922, -0.1750761, -0.9845512,
	    22.44, 23.88, 70.18026, 8.590613e-05, -0.1763977, -0.984319,
	    25.98, 23.88, 70.17587, -0.002523857, -0.1777172, -0.9840784,
	    29.52, 23.88, 70.1621, -0.005131241, -0.1790328, -0.9838297,
	    33.06, 23.88, 70.13895, -0.007738303, -0.1803479, -0.9835725,
	    36.6, 23.88, 70.1064, -0.01034391, -0.1816607, -0.9833069,
	    40.14, 23.88, 70.06447, -0.01294694, -0.1829695, -0.9830333,
	    43.68, 23.88, 70.01315, -0.01554839, -0.184276, -0.9827515,
	    47.22, 23.88, 69.95245, -0.01814926, -0.1855819, -0.9824612,
	    50.76, 23.88, 69.88236, -0.0207484, -0.1868855, -0.9821626,
	    54.3, 23.88, 69.80289, -0.02334471, -0.1881849, -0.9818561,
	    57.84, 23.88, 69.71403, -0.02594023, -0.1894836, -0.9815412,
	    61.38, 23.88, 69.61578, -0.02853387, -0.1907799, -0.981218,
	    64.92, 23.88, 69.50814, -0.03112447, -0.1920719, -0.9808872,
	    68.46, 23.88, 69.39112, -0.03371302, -0.1933615, -0.9805482,
	    72, 23.88, 69.26472, -0.03630053, -0.1946502, -0.9802008,
	    75.54, 23.88, 69.12892, -0.03888588, -0.1959363, -0.9798453,
	    79.08, 23.88, 68.98374, -0.04146797, -0.1972182, -0.9794822,
	    82.62, 23.88, 68.82918, -0.04404881, -0.1984991, -0.9791107,
	    86.16, 23.88, 68.66522, -0.04662701, -0.1997762, -0.9787315,
	    89.7, 23.88, 68.49188, -0.04816559, -0.2018607, -0.9782292,
	    1.2, 25.96, 69.64577, 0.01390905, -0.1751666, -0.9844405,
	    4.74, 25.96, 69.69482, 0.01233185, -0.1773022, -0.9840792,
	    8.28, 25.96, 69.73449, 0.009720387, -0.1786255, -0.9838691,
	    11.82, 25.96, 69.76477, 0.007110326, -0.1799472, -0.9836506,
	    15.36, 25.96, 69.78567, 0.004501387, -0.1812668, -0.9834237,
	    18.9, 25.96, 69.79718, 0.001893634, -0.1825842, -0.9831884,
	    22.44, 25.96, 69.7993, -0.0007139245, -0.1838994, -0.9829448,
	    25.98, 25.96, 69.79204, -0.003319103, -0.1852123, -0.9826929,
	    29.52, 25.96, 69.77539, -0.005922895, -0.186523, -0.9824327,
	    33.06, 25.96, 69.74935, -0.0085263, -0.1878314, -0.9821643,
	    36.6, 25.96, 69.71393, -0.01112677, -0.1891363, -0.9818878,
	    40.14, 25.96, 69.66912, -0.01372566, -0.1904388, -0.9816031,
	    43.68, 25.96, 69.61493, -0.01632396, -0.1917407, -0.9813099,
	    47.22, 25.96, 69.55135, -0.01892056, -0.1930401, -0.9810084,
	    50.76, 25.96, 69.47838, -0.02151432, -0.1943354, -0.9806992,
	    54.3, 25.96, 69.39603, -0.02410727, -0.1956299, -0.9803814,
	    57.84, 25.96, 69.30428, -0.02669833, -0.1969219, -0.9800556,
	    61.38, 25.96, 69.20316, -0.0292864, -0.1982097, -0.979722,
	    64.92, 25.96, 69.09264, -0.03187241, -0.1994949, -0.9793804,
	    68.46, 25.96, 68.97275, -0.03445736, -0.2007792, -0.9790303,
	    72, 25.96, 68.84346, -0.03704016, -0.2020608, -0.9786723,
	    75.54, 25.96, 68.70479, -0.0396197, -0.2033382, -0.9783066,
	    79.08, 25.96, 68.55673, -0.042198, -0.2046145, -0.9779326,
	    82.62, 25.96, 68.39928, -0.04477325, -0.2058876, -0.9775508,
	    86.16, 25.96, 68.23246, -0.04734651, -0.2071574, -0.9771613,
	    89.7, 25.96, 68.05624, -0.04888175, -0.2092317, -0.9766436,
	    1.2, 28.04, 69.26569, 0.01309116, -0.1826735, -0.9830865,
	    4.74, 28.04, 69.31187, 0.01151587, -0.1848007, -0.9827085,
	    8.28, 28.04, 69.34866, 0.008908099, -0.1861183, -0.982487,
	    11.82, 28.04, 69.37606, 0.006301102, -0.1874347, -0.9822568,
	    15.36, 28.04, 69.39407, 0.003696704, -0.1887478, -0.9820186,
	    18.9, 28.04, 69.40271, 0.001092503, -0.1900587, -0.9817721,
	    22.44, 28.04, 69.40195, -0.001511435, -0.1913689, -0.981517,
	    25.98, 28.04, 69.39181, -0.004111873, -0.1926751, -0.981254,
	    29.52, 28.04, 69.37228, -0.006711914, -0.193979, -0.9809827,
	    33.06, 28.04, 69.34337, -0.009310447, -0.1952805, -0.9807032,
	    36.6, 28.04, 69.30507, -0.01190704, -0.1965801, -0.9804155,
	    40.14, 28.04, 69.25739, -0.01450198, -0.1978773, -0.9801195,
	    43.68, 28.04, 69.20031, -0.01709627, -0.199172, -0.9798154,
	    47.22, 28.04, 69.13385, -0.01968739, -0.200463, -0.9795034,
	    50.76, 28.04, 69.05801, -0.0222777, -0.2017533, -0.979183,
	    54.3, 28.04, 68.97277, -0.02486611, -0.2030409, -0.9788545,
	    57.84, 28.04, 68.87815, -0.02745151, -0.2043243, -0.9785183,
	    61.38, 28.04, 68.77415, -0.0300349, -0.2056051, -0.978174,
	    64.92, 28.04, 68.66076, -0.03261722, -0.2068849, -0.9778214,
	    68.46, 28.04, 68.53798, -0.03519737, -0.208162, -0.9774609,
	    72, 28.04, 68.40582, -0.03777427, -0.2094348, -0.9770927,
	    75.54, 28.04, 68.26427, -0.04034994, -0.2107065, -0.9767163,
	    79.08, 28.04, 68.11333, -0.04292326, -0.2119754, -0.9763319,
	    82.62, 28.04, 67.953, -0.04549278, -0.2132405, -0.97594,
	    86.16, 28.04, 67.78329, -0.04806095, -0.2145027, -0.9755402,
	    89.7, 28.04, 67.6042, -0.04959137, -0.2165655, -0.9750077,
	    1.2, 30.12, 68.86922, 0.01227338, -0.19015, -0.9816783,
	    4.74, 30.12, 68.91251, 0.01070117, -0.1922684, -0.981284,
	    8.28, 30.12, 68.94643, 0.008097263, -0.19358, -0.9810511,
	    11.82, 30.12, 68.97095, 0.00549455, -0.1948893, -0.9808099,
	    15.36, 30.12, 68.98609, 0.00289415, -0.1961962, -0.9805604,
	    18.9, 30.12, 68.99184, 0.0002929552, -0.1975026, -0.9803023,
	    22.44, 30.12, 68.9882, -0.002305796, -0.1988048, -0.9800364,
	    25.98, 30.12, 68.97519, -0.004902038, -0.2001046, -0.9797623,
	    29.52, 30.12, 68.95278, -0.00749817, -0.2014031, -0.9794797,
	    33.06, 30.12, 68.92099, -0.01009238, -0.202698, -0.9791893,
	    36.6, 30.12, 68.87981, -0.01268458, -0.203991, -0.9788906,
	    40.14, 30.12, 68.82925, -0.01527506, -0.2052815, -0.9785838,
	    43.68, 30.12, 68.76929, -0.01786413, -0.2065688, -0.978269,
	    47.22, 30.12, 68.69996, -0.02045172, -0.2078547, -0.9779459,
	    50.76, 30.12, 68.62123, -0.0230374, -0.209138, -0.9776147,
	    54.3, 30.12, 68.53312, -0.02562005, -0.2104169, -0.977276,
	    57.84, 30.12, 68.43562, -0.02820069, -0.2116931, -0.9769292,
	    61.38, 30.12, 68.32874, -0.0307803, -0.2129684, -0.9765741,
	    64.92, 30.12, 68.21247, -0.03335773, -0.2142409, -0.9762111,
	    68.46, 30.12, 68.08681, -0.0359319, -0.215509, -0.9758405,
	    72, 30.12, 67.95177, -0.03850484, -0.216776, -0.9754617,
	    75.54, 30.12, 67.80734, -0.04107544, -0.2180402, -0.975075,
	    79.08, 30.12, 67.65353, -0.04364261, -0.2192999, -0.9746809,
	    82.62, 30.12, 67.49033, -0.04620732, -0.2205567, -0.974279,
	    86.16, 30.12, 67.31774, -0.04877059, -0.2218124, -0.9738689,
	    89.7, 30.12, 67.13577, -0.05029782, -0.2238655, -0.9733213,
	    1.2, 32.2, 68.45634, 0.01145798, -0.1975934, -0.9802171,
	    4.74, 32.2, 68.49677, 0.009888957, -0.1997005, -0.9798071,
	    8.28, 32.2, 68.5278, 0.007288373, -0.2010065, -0.9795628,
	    11.82, 32.2, 68.54945, 0.0046901, -0.2023101, -0.9793103,
	    15.36, 32.2, 68.56171, 0.002093149, -0.2036113, -0.9790496,
	    18.9, 32.2, 68.56458, -0.0005034701, -0.20491, -0.9787807,
	    22.44, 32.2, 68.55807, -0.003097583, -0.2062063, -0.9785036,
	    25.98, 32.2, 68.54217, -0.005690179, -0.2075001, -0.9782184,
	    29.52, 32.2, 68.51688, -0.008280844, -0.2087902, -0.9779254,
	    33.06, 32.2, 68.48222, -0.01087127, -0.2100789, -0.977624,
	    36.6, 32.2, 68.43816, -0.01345893, -0.2113651, -0.9773145,
	    40.14, 32.2, 68.38471, -0.01604482, -0.2126486, -0.976997,
	    43.68, 32.2, 68.32188, -0.01862956, -0.2139301, -0.9766713,
	    47.22, 32.2, 68.24966, -0.02121243, -0.2152089, -0.9763376,
	    50.76, 32.2, 68.16806, -0.02379227, -0.2164833, -0.9759964,
	    54.3, 32.2, 68.07707, -0.02637007, -0.2177549, -0.9756472,
	    57.84, 32.2, 67.9767, -0.02894684, -0.2190256, -0.9752896,
	    61.38, 32.2, 67.86694, -0.03152148, -0.2202934, -0.9749242,
	    64.92, 32.2, 67.74779, -0.03409285, -0.2215568, -0.9745513,
	    68.46, 32.2, 67.61926, -0.03666296, -0.222819, -0.9741702,
	    72, 32.2, 67.48133, -0.03923076, -0.2240784, -0.9737812,
	    75.54, 32.2, 67.33402, -0.04179513, -0.2253332, -0.9733849,
	    79.08, 32.2, 67.17733, -0.04435704, -0.2265851, -0.9729808,
	    82.62, 32.2, 67.01125, -0.04691746, -0.2278358, -0.9725686,
	    86.16, 32.2, 66.83578, -0.04947536, -0.2290835, -0.9721486,
	    89.7, 32.2, 66.65093, -0.05099762, -0.2311228, -0.9715871,
	    1.2, 34.28, 68.02708, 0.01064509, -0.2050006, -0.978704,
	    4.74, 34.28, 68.06463, 0.009077609, -0.2070999, -0.9782777,
	    8.28, 34.28, 68.09278, 0.006481556, -0.2084, -0.9780222,
	    11.82, 34.28, 68.11155, 0.003887882, -0.209696, -0.9777589,
	    15.36, 34.28, 68.12093, 0.001294539, -0.2109912, -0.9774871,
	    18.9, 34.28, 68.12093, -0.001297352, -0.2122838, -0.9772072,
	    22.44, 34.28, 68.11153, -0.003886675, -0.2135723, -0.9769195,
	    25.98, 34.28, 68.09276, -0.006474419, -0.2148581, -0.9766238,
	    29.52, 34.28, 68.0646, -0.009061566, -0.216143, -0.9763197,
	    33.06, 34.28, 68.02705, -0.01164701, -0.2174253, -0.9760075,
	    36.6, 34.28, 67.98011, -0.01422964, -0.2187033, -0.9756876,
	    40.14, 34.28, 67.92379, -0.01681146, -0.2199803, -0.9753595,
	    43.68, 34.28, 67.85808, -0.01939139, -0.2212545, -0.9750233,
	    47.22, 34.28, 67.78298, -0.02196834, -0.2225243, -0.9746796,
	    50.76, 34.28, 67.6985, -0.02454325, -0.2237914, -0.974328,
	    54.3, 34.28, 67.60464, -0.0271171, -0.2250573, -0.9739681,
	    57.84, 34.28, 67.50138, -0.02968881, -0.2263204, -0.9736004,
	    61.38, 34.28, 67.38874, -0.0322573, -0.227579, -0.9732252,
	    64.92, 34.28, 67.26672, -0.03482454, -0.2288364, -0.9728418,
	    68.46, 34.28, 67.1353, -0.03738942, -0.2300909, -0.9724506,
	    72, 34.28, 66.9945, -0.0399509, -0.2313407, -0.9720522,
	    75.54, 34.28, 66.84431, -0.04250993, -0.2325877, -0.971646,
	    79.08, 34.28, 66.68475, -0.04506748, -0.2338333, -0.9712316,
	    82.62, 34.28, 66.51579, -0.04762245, -0.235076, -0.9708097,
	    86.16, 34.28, 66.33744, -0.05017382, -0.2363139, -0.9703805,
	    89.7, 34.28, 66.14971, -0.05169272, -0.2383429, -0.9698044,
	    1.2, 36.36, 67.58143, 0.009832733, -0.2123771, -0.9771383,
	    4.74, 36.36, 67.61609, 0.00826831, -0.2144657, -0.9766965,
	    8.28, 36.36, 67.64137, 0.005677649, -0.2157575, -0.9764305,
	    11.82, 36.36, 67.65726, 0.003087322, -0.2170485, -0.9761559,
	    15.36, 36.36, 67.66376, 0.0004984444, -0.2183369, -0.9758733,
	    18.9, 36.36, 67.66087, -0.002087865, -0.219621, -0.975583,
	    22.44, 36.36, 67.64861, -0.004672598, -0.2209024, -0.9752847,
	    25.98, 36.36, 67.62695, -0.007256736, -0.222183, -0.974978,
	    29.52, 36.36, 67.59591, -0.009839165, -0.2234608, -0.9746633,
	    33.06, 36.36, 67.55548, -0.01241879, -0.2247342, -0.974341,
	    36.6, 36.36, 67.50567, -0.01499761, -0.2260066, -0.9740103,
	    40.14, 36.36, 67.44646, -0.01757454, -0.2272763, -0.9736717,
	    43.68, 36.36, 67.37788, -0.02014847, -0.2285414, -0.9733257,
	    47.22, 36.36, 67.2999, -0.02272039, -0.2298038, -0.9729717,
	    50.76, 36.36, 67.21255, -0.02529126, -0.2310649, -0.9726096,
	    54.3, 36.36, 67.1158, -0.02785997, -0.2323232, -0.9722395,
	    57.84, 36.36, 67.00967, -0.03042546, -0.233577, -0.9718622,
	    61.38, 36.36, 66.89415, -0.03298973, -0.2348295, -0.9714766,
	    64.92, 36.36, 66.76924, -0.03555165, -0.236079, -0.9710833,
	    68.46, 36.36, 66.63495, -0.03811014, -0.2373239, -0.9706827,
	    72, 36.36, 66.49127, -0.0406662, -0.2385658, -0.9702745,
	    75.54, 36.36, 66.33821, -0.04322078, -0.2398063, -0.9698582,
	    79.08, 36.36, 66.17576, -0.04577279, -0.2410438, -0.9694342,
	    82.62, 36.36, 66.00392, -0.04832116, -0.2422766, -0.9690032,
	    86.16, 36.36, 65.8227, -0.05086791, -0.2435079, -0.9685641,
	    89.7, 36.36, 65.63209, -0.05238234, -0.2455244, -0.9679741,
	    1.2, 38.44, 67.11937, 0.009023154, -0.2197154, -0.9755223,
	    4.74, 38.44, 67.15115, 0.007462254, -0.2217916, -0.9750655,
	    8.28, 38.44, 67.17355, 0.004875028, -0.2230783, -0.9747883,
	    11.82, 38.44, 67.18656, 0.002289251, -0.2243624, -0.9745031,
	    15.36, 38.44, 67.19019, -0.000293959, -0.2256421, -0.9742102,
	    18.9, 38.44, 67.18443, -0.002875593, -0.2269191, -0.9739094,
	    22.44, 38.44, 67.16928, -0.005456634, -0.2281952, -0.9736001,
	    25.98, 38.44, 67.14474, -0.008035969, -0.2294685, -0.9732829,
	    29.52, 38.44, 67.11082, -0.01061249, -0.2307373, -0.9729582,
	    33.06, 38.44, 67.06752, -0.01318823, -0.2320051, -0.9726252,
	    36.6, 38.44, 67.01482, -0.01576207, -0.2332701, -0.9722842,
	    40.14, 38.44, 66.95274, -0.01833291, -0.2345305, -0.9719359,
	    43.68, 38.44, 66.88128, -0.02090174, -0.2357881, -0.9715797,
	    47.22, 38.44, 66.80043, -0.02346954, -0.2370444, -0.9712153,
	    50.76, 38.44, 66.71019, -0.02603519, -0.2382978, -0.9708431,
	    54.3, 38.44, 66.61057, -0.02859759, -0.2395467, -0.9704636,
	    57.84, 38.44, 66.50156, -0.03115877, -0.2407942, -0.9700759,
	    61.38, 38.44, 66.38316, -0.03371765, -0.2420387, -0.9696806,
	    64.92, 38.44, 66.25537, -0.0362731, -0.2432786, -0.969278,
	    68.46, 38.44, 66.1182, -0.03882609, -0.2445154, -0.9688678,
	    72, 38.44, 65.97165, -0.04137762, -0.2457508, -0.9684495,
	    75.54, 38.44, 65.8157, -0.0439266, -0.2469831, -0.9680237,
	    79.08, 38.44, 65.65038, -0.04647193, -0.2482106, -0.9675907,
	    82.62, 38.44, 65.47566, -0.0490156, -0.2494367, -0.9671498,
	    86.16, 38.44, 65.29156, -0.0515559, -0.250659, -0.9667016,
	    89.7, 38.44, 65.09808, -0.05306509, -0.2526625, -0.9660982,
	    1.2, 40.52, 66.64092, 0.008216488, -0.2270141, -0.9738568,
	    4.74, 40.52, 66.66983, 0.006657457, -0.2290818, -0.9733844,
	    8.28, 40.52, 66.68935, 0.004074868, -0.2303615, -0.9730966,
	    11.82, 40.52, 66.69948, 0.001494844, -0.2316368, -0.9728012,
	    15.36, 40.52, 66.70023, -0.001083605, -0.2329093, -0.9724979,
	    18.9, 40.52, 66.69159, -0.003661461, -0.2341808, -0.9721862,
	    22.44, 40.52, 66.67356, -0.006237616, -0.2354495, -0.9718666,
	    25.98, 40.52, 66.64615, -0.008810959, -0.2367137, -0.9715395,
	    29.52, 40.52, 66.60935, -0.01138351, -0.2379768, -0.9712041,
	    33.06, 40.52, 66.56316, -0.01395419, -0.239237, -0.9708609,
	    36.6, 40.52, 66.50759, -0.01652186, -0.2404926, -0.9705103,
	    40.14, 40.52, 66.44263, -0.01908752, -0.2417454, -0.970152,
	    43.68, 40.52, 66.36829, -0.02165214, -0.2429968, -0.9697854,
	    47.22, 40.52, 66.28456, -0.02421465, -0.2442454, -0.9694111,
	    50.76, 40.52, 66.19144, -0.0267739, -0.2454892, -0.9690295,
	    54.3, 40.52, 66.08894, -0.02933192, -0.2467317, -0.9686398,
	    57.84, 40.52, 65.97705, -0.03188763, -0.2479712, -0.9682425,
	    61.38, 40.52, 65.85577, -0.03443996, -0.2492059, -0.967838,
	    64.92, 40.52, 65.72511, -0.03698983, -0.2504376, -0.9674259,
	    68.46, 40.52, 65.58507, -0.03953821, -0.2516678, -0.9670057,
	    72, 40.52, 65.43563, -0.04208406, -0.2528948, -0.9665781,
	    75.54, 40.52, 65.27681, -0.04462627, -0.2541171, -0.9661434,
	    79.08, 40.52, 65.1086, -0.04716683, -0.2553378, -0.9657007,
	    82.62, 40.52, 64.93101, -0.04970466, -0.2565554, -0.9652506,
	    86.16, 40.52, 64.74403, -0.05223839, -0.2577686, -0.9647935,
	    89.7, 40.52, 64.54766, -0.05374466, -0.2597606, -0.9641763,
	    1.2, 42.6, 66.14608, 0.00741075, -0.2342784, -0.9721413,
	    4.74, 42.6, 66.1721, 0.005855099, -0.2363336, -0.9716543,
	    8.28, 42.6, 66.18874, 0.003278346, -0.2376044, -0.9713565,
	    11.82, 42.6, 66.196, 0.0007028189, -0.2388735, -0.9710504,
	    15.36, 42.6, 66.19387, -0.001871419, -0.2401409, -0.9707362,
	    18.9, 42.6, 66.18235, -0.004444304, -0.241405, -0.9704143,
	    22.44, 42.6, 66.16145, -0.007014383, -0.2426645, -0.9700849,
	    25.98, 42.6, 66.13116, -0.009583332, -0.2439217, -0.9697476,
	    29.52, 42.6, 66.09148, -0.01215109, -0.2451765, -0.9694023,
	    33.06, 42.6, 66.04241, -0.01471586, -0.2464284, -0.9690493,
	    36.6, 42.6, 65.98396, -0.01727792, -0.2476768, -0.9686886,
	    40.14, 42.6, 65.91613, -0.01983929, -0.2489233, -0.96832,
	    43.68, 42.6, 65.83891, -0.02239853, -0.2501669, -0.9679436,
	    47.22, 42.6, 65.7523, -0.02495456, -0.2514057, -0.9675601,
	    50.76, 42.6, 65.6563, -0.02750935, -0.2526431, -0.9671684,
	    54.3, 42.6, 65.55092, -0.03006149, -0.2538763, -0.9667694,
	    57.84, 42.6, 65.43615, -0.03261126, -0.2551065, -0.9663629,
	    61.38, 42.6, 65.312, -0.03515758, -0.2563335, -0.9659488,
	    64.92, 42.6, 65.17846, -0.03770276, -0.2575584, -0.9655269,
	    68.46, 42.6, 65.03553, -0.04024538, -0.2587802, -0.9650975,
	    72, 42.6, 64.88322, -0.04278439, -0.2599971, -0.9646611,
	    75.54, 42.6, 64.72152, -0.04532176, -0.2612125, -0.9642168,
	    79.08, 42.6, 64.55043, -0.04785623, -0.262424, -0.9637652,
	    82.62, 42.6, 64.36996, -0.05038725, -0.263631, -0.9633067,
	    86.16, 42.6, 64.1801, -0.05291583, -0.2648357, -0.9628406,
	    89.7, 42.6, 63.98085, -0.05441757, -0.2668142, -0.9622104,
	    1.2, 44.68, 65.63484, 0.006608173, -0.2415022, -0.9703778,
	    4.74, 44.68, 65.65799, 0.005056351, -0.2435461, -0.9698761,
	    8.28, 44.68, 65.67175, 0.002483831, -0.24481, -0.9695679,
	    11.82, 44.68, 65.67612, -8.740073e-05, -0.2460722, -0.9692515,
	    15.36, 44.68, 65.67111, -0.002656238, -0.2473309, -0.9689274,
	    18.9, 44.68, 65.65672, -0.005222968, -0.2485857, -0.9685958,
	    22.44, 44.68, 65.63293, -0.007788224, -0.2498386, -0.9682562,
	    25.98, 44.68, 65.59977, -0.01035229, -0.2510891, -0.9679086,
	    29.52, 44.68, 65.55721, -0.01291475, -0.2523361, -0.9675535,
	    33.06, 44.68, 65.50526, -0.01547384, -0.253579, -0.9671909,
	    36.6, 44.68, 65.44394, -0.01803119, -0.25482, -0.9668204,
	    40.14, 44.68, 65.37322, -0.02058709, -0.2560585, -0.966442,
	    43.68, 44.68, 65.29312, -0.02313979, -0.2572922, -0.9660566,
	    47.22, 44.68, 65.20364, -0.02569128, -0.2585245, -0.965663,
	    50.76, 44.68, 65.10476, -0.02823976, -0.2597531, -0.9652621,
	    54.3, 44.68, 64.99651, -0.03078621, -0.260978, -0.9648537,
	    57.84, 44.68, 64.87885, -0.03333025, -0.2621998, -0.9644378,
	    61.38, 44.68, 64.75182, -0.03587148, -0.2634189, -0.9640144,
	    64.92, 44.68, 64.6154, -0.03841083, -0.2646353, -0.9635833,
	    68.46, 44.68, 64.4696, -0.0409467, -0.2658474, -0.9631451,
	    72, 44.68, 64.31441, -0.04348045, -0.2670571, -0.9626993,
	    75.54, 44.68, 64.14983, -0.04601149, -0.2682626, -0.9622464,
	    79.08, 44.68, 63.97586, -0.04853942, -0.2694646, -0.9617862,
	    82.62, 44.68, 63.79251, -0.05106485, -0.2706643, -0.9613185,
	    86.16, 44.68, 63.59978, -0.05358729, -0.2718602, -0.9608436,
	    89.7, 44.68, 63.39766, -0.05508441, -0.2738257, -0.9602006,
	    1.2, 46.76, 65.1072, 0.005808874, -0.2486873, -0.9685664,
	    4.74, 46.76, 65.12747, 0.004260285, -0.2507183, -0.9680507,
	    8.28, 46.76, 65.13836, 0.001692143, -0.2519752, -0.9677322,
	    11.82, 46.76, 65.13985, -0.0008736079, -0.2532286, -0.9674061,
	    15.36, 46.76, 65.13197, -0.003436907, -0.2544785, -0.9670723,
	    18.9, 46.76, 65.11469, -0.005999426, -0.2557271, -0.9667304,
	    22.44, 46.76, 65.08803, -0.008559718, -0.2569732, -0.9663806,
	    25.98, 46.76, 65.05198, -0.01111772, -0.2582153, -0.9660234,
	    29.52, 46.76, 65.00655, -0.01367373, -0.2594526, -0.965659,
	    33.06, 46.76, 64.95173, -0.01622802, -0.260688, -0.9652867,
	    36.6, 46.76, 64.88752, -0.01878053, -0.2619213, -0.9649065,
	    40.14, 46.76, 64.81393, -0.02132981, -0.26315, -0.9645191,
	    43.68, 46.76, 64.73095, -0.02387789, -0.2643771, -0.9641238,
	    47.22, 46.76, 64.63858, -0.02642368, -0.265601, -0.9637209,
	    50.76, 46.76, 64.53683, -0.02896572, -0.2668207, -0.9633108,
	    54.3, 46.76, 64.42569, -0.03150637, -0.2680371, -0.9628933,
	    57.84, 46.76, 64.30517, -0.03404455, -0.2692503, -0.9624683,
	    61.38, 46.76, 64.17525, -0.03658055, -0.2704613, -0.9620356,
	    64.92, 46.76, 64.03596, -0.03911326, -0.2716677, -0.961596,
	    68.46, 46.76, 63.88727, -0.04164363, -0.2728719, -0.9611486,
	    72, 46.76, 63.7292, -0.04417081, -0.274072, -0.9606943,
	    75.54, 46.76, 63.56175, -0.04669591, -0.2752692, -0.9602324,
	    79.08, 46.76, 63.3849, -0.04921801, -0.2764634, -0.9597633,
	    82.62, 46.76, 63.19867, -0.05173707, -0.2776536, -0.9592871,
	    86.16, 46.76, 63.00306, -0.05425308, -0.2788407, -0.9588037,
	    89.7, 46.76, 62.79806, -0.05574619, -0.2807933, -0.9581479,
	    1.2, 48.84, 64.56317, 0.005012282, -0.255828, -0.9667093,
	    4.74, 48.84, 64.58057, 0.003466326, -0.2578482, -0.9661792,
	    8.28, 48.84, 64.58857, 0.0009033973, -0.2590973, -0.9658508,
	    11.82, 48.84, 64.58719, -0.001656735, -0.2603435, -0.9655147,
	    15.36, 48.84, 64.57642, -0.004215052, -0.2615866, -0.9651708,
	    18.9, 48.84, 64.55627, -0.00677253, -0.2628267, -0.9648193,
	    22.44, 48.84, 64.52673, -0.00932669, -0.2640626, -0.9644605,
	    25.98, 48.84, 64.4878, -0.01187902, -0.2652959, -0.9640938,
	    29.52, 48.84, 64.43949, -0.01442998, -0.2665276, -0.9637193,
	    33.06, 48.84, 64.38179, -0.01697901, -0.2677558, -0.9633372,
	    36.6, 48.84, 64.3147, -0.01952482, -0.2689792, -0.9629481,
	    40.14, 48.84, 64.23824, -0.0220694, -0.2702011, -0.9625509,
	    43.68, 48.84, 64.15237, -0.02461154, -0.2714192, -0.9621465,
	    47.22, 48.84, 64.05713, -0.02715082, -0.2726333, -0.9617349,
	    50.76, 48.84, 63.9525, -0.02968733, -0.2738446, -0.9613157,
	    54.3, 48.84, 63.83849, -0.03222203, -0.2750533, -0.9608889,
	    57.84, 48.84, 63.71508, -0.03475474, -0.2762586, -0.9604547,
	    61.38, 48.84, 63.58229, -0.03728385, -0.2774598, -0.9600135,
	    64.92, 48.84, 63.44012, -0.03981099, -0.2786582, -0.9595648,
	    68.46, 48.84, 63.28855, -0.0423349, -0.2798524, -0.9591092,
	    72, 48.84, 63.12761, -0.0448564, -0.2810443, -0.9586459,
	    75.54, 48.84, 62.95727, -0.04737509, -0.2822329, -0.9581755,
	    79.08, 48.84, 62.77755, -0.04989059, -0.2834169, -0.9576982,
	    82.62, 48.84, 62.58844, -0.05240366, -0.2845983, -0.9572135,
	    86.16, 48.84, 62.38995, -0.05491364, -0.2857765, -0.9567216,
	    89.7, 48.84, 62.18206, -0.05640184, -0.2877152, -0.9560538,
	    1.2, 50.92, 64.00275, 0.004218505, -0.2629289, -0.964806,
	    4.74, 50.92, 64.01727, 0.002675284, -0.264937, -0.964262,
	    8.28, 50.92, 64.02239, 0.0001175336, -0.2661787, -0.9639237,
	    11.82, 50.92, 64.01813, -0.002436847, -0.2674165, -0.9635779,
	    15.36, 50.92, 64.00449, -0.004989872, -0.2686513, -0.9632246,
	    18.9, 50.92, 63.98145, -0.007541138, -0.2698827, -0.9628637,
	    22.44, 50.92, 63.94904, -0.01009024, -0.2711112, -0.9624951,
	    25.98, 50.92, 63.90723, -0.01263745, -0.2723372, -0.9621189,
	    29.52, 50.92, 63.85604, -0.01518273, -0.2735596, -0.9617352,
	    33.06, 50.92, 63.79546, -0.01772515, -0.2747784, -0.9613442,
	    36.6, 50.92, 63.7255, -0.02026585, -0.2759947, -0.9609455,
	    40.14, 50.92, 63.64614, -0.02280442, -0.2772075, -0.9605394,
	    43.68, 50.92, 63.55741, -0.02534014, -0.2784162, -0.9601262,
	    47.22, 50.92, 63.45929, -0.02787398, -0.2796224, -0.9597053,
	    50.76, 50.92, 63.35178, -0.03040449, -0.2808251, -0.9592772,
	    54.3, 50.92, 63.23488, -0.03293331, -0.2820247, -0.9588417,
	    57.84, 50.92, 63.1086, -0.03545957, -0.2832209, -0.958399,
	    61.38, 50.92, 62.97293, -0.0379827, -0.2844137, -0.9579489,
	    64.92, 50.92, 62.82788, -0.04050329, -0.2856029, -0.9574918,
	    68.46, 50.92, 62.67344, -0.04302111, -0.2867887, -0.9570274,
	    72, 50.92, 62.50961, -0.04553684, -0.2879715, -0.9565557,
	    75.54, 50.92, 62.3364, -0.0480485, -0.2891504, -0.9560771,
	    79.08, 50.92, 62.1538, -0.05055794, -0.2903263, -0.9555912,
	    82.62, 50.92, 61.96181, -0.05306441, -0.2914979, -0.9550985,
	    86.16, 50.92, 61.76044, -0.05556793, -0.292666, -0.9545988,
	    89.7, 50.92, 61.54968, -0.05705131, -0.2945906, -0.953919,
	    1.2, 53, 63.42593, 0.003559077, -0.2678486, -0.9634545,
	    4.74, 53, 63.43756, 0.001724102, -0.2688822, -0.9631715,
	    8.28, 53, 63.43981, -0.0008298985, -0.270118, -0.9628269,
	    11.82, 53, 63.43267, -0.003380661, -0.2713501, -0.9624748,
	    15.36, 53, 63.41615, -0.00593089, -0.2725813, -0.9621145,
	    18.9, 53, 63.39024, -0.008478453, -0.2738078, -0.9617471,
	    22.44, 53, 63.35494, -0.01102433, -0.2750316, -0.961372,
	    25.98, 53, 63.31026, -0.01356811, -0.2762511, -0.9609897,
	    29.52, 53, 63.25619, -0.01610973, -0.2774679, -0.9605998,
	    33.06, 53, 63.19273, -0.01864881, -0.2786826, -0.9602022,
	    36.6, 53, 63.11989, -0.02118629, -0.2798935, -0.9597973,
	    40.14, 53, 63.03766, -0.02372041, -0.2811006, -0.9593851,
	    43.68, 53, 62.94605, -0.02625317, -0.2823049, -0.9589654,
	    47.22, 53, 62.84505, -0.02878284, -0.2835048, -0.9585388,
	    50.76, 53, 62.73466, -0.03130996, -0.2847018, -0.9581047,
	    54.3, 53, 62.61489, -0.0338352, -0.2858966, -0.9576629,
	    57.84, 53, 62.48573, -0.0363575, -0.2870875, -0.9572141,
	    61.38, 53, 62.34718, -0.03887682, -0.2882744, -0.9567583,
	    64.92, 53, 62.19925, -0.04139335, -0.2894589, -0.956295,
	    68.46, 53, 62.04193, -0.04390779, -0.2906394, -0.9558247,
	    72, 53, 61.87522, -0.04641907, -0.291816, -0.9553474,
	    75.54, 53, 61.69913, -0.0489271, -0.2929901, -0.9548628,
	    79.08, 53, 61.51365, -0.05143219, -0.2941602, -0.9543713,
	    82.62, 53, 61.31879, -0.05393464, -0.2953257, -0.9538731,
	    86.16, 53, 61.11454, -0.0564341, -0.2964881, -0.9533677,
	    89.7, 53, 60.9009, -0.05751702, -0.297272, -0.9530588
	   ]);
	   var normLoc22 = gl.getAttribLocation(prog22, "aNorm");
	   var f=new Uint16Array([
	    0, 26, 27, 0, 27, 1,
	    26, 52, 53, 26, 53, 27,
	    52, 78, 79, 52, 79, 53,
	    78, 104, 105, 78, 105, 79,
	    104, 130, 131, 104, 131, 105,
	    130, 156, 157, 130, 157, 131,
	    156, 182, 183, 156, 183, 157,
	    182, 208, 209, 182, 209, 183,
	    208, 234, 235, 208, 235, 209,
	    234, 260, 261, 234, 261, 235,
	    260, 286, 287, 260, 287, 261,
	    286, 312, 313, 286, 313, 287,
	    312, 338, 339, 312, 339, 313,
	    338, 364, 365, 338, 365, 339,
	    364, 390, 391, 364, 391, 365,
	    390, 416, 417, 390, 417, 391,
	    416, 442, 443, 416, 443, 417,
	    442, 468, 469, 442, 469, 443,
	    468, 494, 495, 468, 495, 469,
	    494, 520, 521, 494, 521, 495,
	    520, 546, 547, 520, 547, 521,
	    546, 572, 573, 546, 573, 547,
	    572, 598, 599, 572, 599, 573,
	    598, 624, 625, 598, 625, 599,
	    624, 650, 651, 624, 651, 625,
	    1, 27, 28, 1, 28, 2,
	    27, 53, 54, 27, 54, 28,
	    53, 79, 80, 53, 80, 54,
	    79, 105, 106, 79, 106, 80,
	    105, 131, 132, 105, 132, 106,
	    131, 157, 158, 131, 158, 132,
	    157, 183, 184, 157, 184, 158,
	    183, 209, 210, 183, 210, 184,
	    209, 235, 236, 209, 236, 210,
	    235, 261, 262, 235, 262, 236,
	    261, 287, 288, 261, 288, 262,
	    287, 313, 314, 287, 314, 288,
	    313, 339, 340, 313, 340, 314,
	    339, 365, 366, 339, 366, 340,
	    365, 391, 392, 365, 392, 366,
	    391, 417, 418, 391, 418, 392,
	    417, 443, 444, 417, 444, 418,
	    443, 469, 470, 443, 470, 444,
	    469, 495, 496, 469, 496, 470,
	    495, 521, 522, 495, 522, 496,
	    521, 547, 548, 521, 548, 522,
	    547, 573, 574, 547, 574, 548,
	    573, 599, 600, 573, 600, 574,
	    599, 625, 626, 599, 626, 600,
	    625, 651, 652, 625, 652, 626,
	    2, 28, 29, 2, 29, 3,
	    28, 54, 55, 28, 55, 29,
	    54, 80, 81, 54, 81, 55,
	    80, 106, 107, 80, 107, 81,
	    106, 132, 133, 106, 133, 107,
	    132, 158, 159, 132, 159, 133,
	    158, 184, 185, 158, 185, 159,
	    184, 210, 211, 184, 211, 185,
	    210, 236, 237, 210, 237, 211,
	    236, 262, 263, 236, 263, 237,
	    262, 288, 289, 262, 289, 263,
	    288, 314, 315, 288, 315, 289,
	    314, 340, 341, 314, 341, 315,
	    340, 366, 367, 340, 367, 341,
	    366, 392, 393, 366, 393, 367,
	    392, 418, 419, 392, 419, 393,
	    418, 444, 445, 418, 445, 419,
	    444, 470, 471, 444, 471, 445,
	    470, 496, 497, 470, 497, 471,
	    496, 522, 523, 496, 523, 497,
	    522, 548, 549, 522, 549, 523,
	    548, 574, 575, 548, 575, 549,
	    574, 600, 601, 574, 601, 575,
	    600, 626, 627, 600, 627, 601,
	    626, 652, 653, 626, 653, 627,
	    3, 29, 30, 3, 30, 4,
	    29, 55, 56, 29, 56, 30,
	    55, 81, 82, 55, 82, 56,
	    81, 107, 108, 81, 108, 82,
	    107, 133, 134, 107, 134, 108,
	    133, 159, 160, 133, 160, 134,
	    159, 185, 186, 159, 186, 160,
	    185, 211, 212, 185, 212, 186,
	    211, 237, 238, 211, 238, 212,
	    237, 263, 264, 237, 264, 238,
	    263, 289, 290, 263, 290, 264,
	    289, 315, 316, 289, 316, 290,
	    315, 341, 342, 315, 342, 316,
	    341, 367, 368, 341, 368, 342,
	    367, 393, 394, 367, 394, 368,
	    393, 419, 420, 393, 420, 394,
	    419, 445, 446, 419, 446, 420,
	    445, 471, 472, 445, 472, 446,
	    471, 497, 498, 471, 498, 472,
	    497, 523, 524, 497, 524, 498,
	    523, 549, 550, 523, 550, 524,
	    549, 575, 576, 549, 576, 550,
	    575, 601, 602, 575, 602, 576,
	    601, 627, 628, 601, 628, 602,
	    627, 653, 654, 627, 654, 628,
	    4, 30, 31, 4, 31, 5,
	    30, 56, 57, 30, 57, 31,
	    56, 82, 83, 56, 83, 57,
	    82, 108, 109, 82, 109, 83,
	    108, 134, 135, 108, 135, 109,
	    134, 160, 161, 134, 161, 135,
	    160, 186, 187, 160, 187, 161,
	    186, 212, 213, 186, 213, 187,
	    212, 238, 239, 212, 239, 213,
	    238, 264, 265, 238, 265, 239,
	    264, 290, 291, 264, 291, 265,
	    290, 316, 317, 290, 317, 291,
	    316, 342, 343, 316, 343, 317,
	    342, 368, 369, 342, 369, 343,
	    368, 394, 395, 368, 395, 369,
	    394, 420, 421, 394, 421, 395,
	    420, 446, 447, 420, 447, 421,
	    446, 472, 473, 446, 473, 447,
	    472, 498, 499, 472, 499, 473,
	    498, 524, 525, 498, 525, 499,
	    524, 550, 551, 524, 551, 525,
	    550, 576, 577, 550, 577, 551,
	    576, 602, 603, 576, 603, 577,
	    602, 628, 629, 602, 629, 603,
	    628, 654, 655, 628, 655, 629,
	    5, 31, 32, 5, 32, 6,
	    31, 57, 58, 31, 58, 32,
	    57, 83, 84, 57, 84, 58,
	    83, 109, 110, 83, 110, 84,
	    109, 135, 136, 109, 136, 110,
	    135, 161, 162, 135, 162, 136,
	    161, 187, 188, 161, 188, 162,
	    187, 213, 214, 187, 214, 188,
	    213, 239, 240, 213, 240, 214,
	    239, 265, 266, 239, 266, 240,
	    265, 291, 292, 265, 292, 266,
	    291, 317, 318, 291, 318, 292,
	    317, 343, 344, 317, 344, 318,
	    343, 369, 370, 343, 370, 344,
	    369, 395, 396, 369, 396, 370,
	    395, 421, 422, 395, 422, 396,
	    421, 447, 448, 421, 448, 422,
	    447, 473, 474, 447, 474, 448,
	    473, 499, 500, 473, 500, 474,
	    499, 525, 526, 499, 526, 500,
	    525, 551, 552, 525, 552, 526,
	    551, 577, 578, 551, 578, 552,
	    577, 603, 604, 577, 604, 578,
	    603, 629, 630, 603, 630, 604,
	    629, 655, 656, 629, 656, 630,
	    6, 32, 33, 6, 33, 7,
	    32, 58, 59, 32, 59, 33,
	    58, 84, 85, 58, 85, 59,
	    84, 110, 111, 84, 111, 85,
	    110, 136, 137, 110, 137, 111,
	    136, 162, 163, 136, 163, 137,
	    162, 188, 189, 162, 189, 163,
	    188, 214, 215, 188, 215, 189,
	    214, 240, 241, 214, 241, 215,
	    240, 266, 267, 240, 267, 241,
	    266, 292, 293, 266, 293, 267,
	    292, 318, 319, 292, 319, 293,
	    318, 344, 345, 318, 345, 319,
	    344, 370, 371, 344, 371, 345,
	    370, 396, 397, 370, 397, 371,
	    396, 422, 423, 396, 423, 397,
	    422, 448, 449, 422, 449, 423,
	    448, 474, 475, 448, 475, 449,
	    474, 500, 501, 474, 501, 475,
	    500, 526, 527, 500, 527, 501,
	    526, 552, 553, 526, 553, 527,
	    552, 578, 579, 552, 579, 553,
	    578, 604, 605, 578, 605, 579,
	    604, 630, 631, 604, 631, 605,
	    630, 656, 657, 630, 657, 631,
	    7, 33, 34, 7, 34, 8,
	    33, 59, 60, 33, 60, 34,
	    59, 85, 86, 59, 86, 60,
	    85, 111, 112, 85, 112, 86,
	    111, 137, 138, 111, 138, 112,
	    137, 163, 164, 137, 164, 138,
	    163, 189, 190, 163, 190, 164,
	    189, 215, 216, 189, 216, 190,
	    215, 241, 242, 215, 242, 216,
	    241, 267, 268, 241, 268, 242,
	    267, 293, 294, 267, 294, 268,
	    293, 319, 320, 293, 320, 294,
	    319, 345, 346, 319, 346, 320,
	    345, 371, 372, 345, 372, 346,
	    371, 397, 398, 371, 398, 372,
	    397, 423, 424, 397, 424, 398,
	    423, 449, 450, 423, 450, 424,
	    449, 475, 476, 449, 476, 450,
	    475, 501, 502, 475, 502, 476,
	    501, 527, 528, 501, 528, 502,
	    527, 553, 554, 527, 554, 528,
	    553, 579, 580, 553, 580, 554,
	    579, 605, 606, 579, 606, 580,
	    605, 631, 632, 605, 632, 606,
	    631, 657, 658, 631, 658, 632,
	    8, 34, 35, 8, 35, 9,
	    34, 60, 61, 34, 61, 35,
	    60, 86, 87, 60, 87, 61,
	    86, 112, 113, 86, 113, 87,
	    112, 138, 139, 112, 139, 113,
	    138, 164, 165, 138, 165, 139,
	    164, 190, 191, 164, 191, 165,
	    190, 216, 217, 190, 217, 191,
	    216, 242, 243, 216, 243, 217,
	    242, 268, 269, 242, 269, 243,
	    268, 294, 295, 268, 295, 269,
	    294, 320, 321, 294, 321, 295,
	    320, 346, 347, 320, 347, 321,
	    346, 372, 373, 346, 373, 347,
	    372, 398, 399, 372, 399, 373,
	    398, 424, 425, 398, 425, 399,
	    424, 450, 451, 424, 451, 425,
	    450, 476, 477, 450, 477, 451,
	    476, 502, 503, 476, 503, 477,
	    502, 528, 529, 502, 529, 503,
	    528, 554, 555, 528, 555, 529,
	    554, 580, 581, 554, 581, 555,
	    580, 606, 607, 580, 607, 581,
	    606, 632, 633, 606, 633, 607,
	    632, 658, 659, 632, 659, 633,
	    9, 35, 36, 9, 36, 10,
	    35, 61, 62, 35, 62, 36,
	    61, 87, 88, 61, 88, 62,
	    87, 113, 114, 87, 114, 88,
	    113, 139, 140, 113, 140, 114,
	    139, 165, 166, 139, 166, 140,
	    165, 191, 192, 165, 192, 166,
	    191, 217, 218, 191, 218, 192,
	    217, 243, 244, 217, 244, 218,
	    243, 269, 270, 243, 270, 244,
	    269, 295, 296, 269, 296, 270,
	    295, 321, 322, 295, 322, 296,
	    321, 347, 348, 321, 348, 322,
	    347, 373, 374, 347, 374, 348,
	    373, 399, 400, 373, 400, 374,
	    399, 425, 426, 399, 426, 400,
	    425, 451, 452, 425, 452, 426,
	    451, 477, 478, 451, 478, 452,
	    477, 503, 504, 477, 504, 478,
	    503, 529, 530, 503, 530, 504,
	    529, 555, 556, 529, 556, 530,
	    555, 581, 582, 555, 582, 556,
	    581, 607, 608, 581, 608, 582,
	    607, 633, 634, 607, 634, 608,
	    633, 659, 660, 633, 660, 634,
	    10, 36, 37, 10, 37, 11,
	    36, 62, 63, 36, 63, 37,
	    62, 88, 89, 62, 89, 63,
	    88, 114, 115, 88, 115, 89,
	    114, 140, 141, 114, 141, 115,
	    140, 166, 167, 140, 167, 141,
	    166, 192, 193, 166, 193, 167,
	    192, 218, 219, 192, 219, 193,
	    218, 244, 245, 218, 245, 219,
	    244, 270, 271, 244, 271, 245,
	    270, 296, 297, 270, 297, 271,
	    296, 322, 323, 296, 323, 297,
	    322, 348, 349, 322, 349, 323,
	    348, 374, 375, 348, 375, 349,
	    374, 400, 401, 374, 401, 375,
	    400, 426, 427, 400, 427, 401,
	    426, 452, 453, 426, 453, 427,
	    452, 478, 479, 452, 479, 453,
	    478, 504, 505, 478, 505, 479,
	    504, 530, 531, 504, 531, 505,
	    530, 556, 557, 530, 557, 531,
	    556, 582, 583, 556, 583, 557,
	    582, 608, 609, 582, 609, 583,
	    608, 634, 635, 608, 635, 609,
	    634, 660, 661, 634, 661, 635,
	    11, 37, 38, 11, 38, 12,
	    37, 63, 64, 37, 64, 38,
	    63, 89, 90, 63, 90, 64,
	    89, 115, 116, 89, 116, 90,
	    115, 141, 142, 115, 142, 116,
	    141, 167, 168, 141, 168, 142,
	    167, 193, 194, 167, 194, 168,
	    193, 219, 220, 193, 220, 194,
	    219, 245, 246, 219, 246, 220,
	    245, 271, 272, 245, 272, 246,
	    271, 297, 298, 271, 298, 272,
	    297, 323, 324, 297, 324, 298,
	    323, 349, 350, 323, 350, 324,
	    349, 375, 376, 349, 376, 350,
	    375, 401, 402, 375, 402, 376,
	    401, 427, 428, 401, 428, 402,
	    427, 453, 454, 427, 454, 428,
	    453, 479, 480, 453, 480, 454,
	    479, 505, 506, 479, 506, 480,
	    505, 531, 532, 505, 532, 506,
	    531, 557, 558, 531, 558, 532,
	    557, 583, 584, 557, 584, 558,
	    583, 609, 610, 583, 610, 584,
	    609, 635, 636, 609, 636, 610,
	    635, 661, 662, 635, 662, 636,
	    12, 38, 39, 12, 39, 13,
	    38, 64, 65, 38, 65, 39,
	    64, 90, 91, 64, 91, 65,
	    90, 116, 117, 90, 117, 91,
	    116, 142, 143, 116, 143, 117,
	    142, 168, 169, 142, 169, 143,
	    168, 194, 195, 168, 195, 169,
	    194, 220, 221, 194, 221, 195,
	    220, 246, 247, 220, 247, 221,
	    246, 272, 273, 246, 273, 247,
	    272, 298, 299, 272, 299, 273,
	    298, 324, 325, 298, 325, 299,
	    324, 350, 351, 324, 351, 325,
	    350, 376, 377, 350, 377, 351,
	    376, 402, 403, 376, 403, 377,
	    402, 428, 429, 402, 429, 403,
	    428, 454, 455, 428, 455, 429,
	    454, 480, 481, 454, 481, 455,
	    480, 506, 507, 480, 507, 481,
	    506, 532, 533, 506, 533, 507,
	    532, 558, 559, 532, 559, 533,
	    558, 584, 585, 558, 585, 559,
	    584, 610, 611, 584, 611, 585,
	    610, 636, 637, 610, 637, 611,
	    636, 662, 663, 636, 663, 637,
	    13, 39, 40, 13, 40, 14,
	    39, 65, 66, 39, 66, 40,
	    65, 91, 92, 65, 92, 66,
	    91, 117, 118, 91, 118, 92,
	    117, 143, 144, 117, 144, 118,
	    143, 169, 170, 143, 170, 144,
	    169, 195, 196, 169, 196, 170,
	    195, 221, 222, 195, 222, 196,
	    221, 247, 248, 221, 248, 222,
	    247, 273, 274, 247, 274, 248,
	    273, 299, 300, 273, 300, 274,
	    299, 325, 326, 299, 326, 300,
	    325, 351, 352, 325, 352, 326,
	    351, 377, 378, 351, 378, 352,
	    377, 403, 404, 377, 404, 378,
	    403, 429, 430, 403, 430, 404,
	    429, 455, 456, 429, 456, 430,
	    455, 481, 482, 455, 482, 456,
	    481, 507, 508, 481, 508, 482,
	    507, 533, 534, 507, 534, 508,
	    533, 559, 560, 533, 560, 534,
	    559, 585, 586, 559, 586, 560,
	    585, 611, 612, 585, 612, 586,
	    611, 637, 638, 611, 638, 612,
	    637, 663, 664, 637, 664, 638,
	    14, 40, 41, 14, 41, 15,
	    40, 66, 67, 40, 67, 41,
	    66, 92, 93, 66, 93, 67,
	    92, 118, 119, 92, 119, 93,
	    118, 144, 145, 118, 145, 119,
	    144, 170, 171, 144, 171, 145,
	    170, 196, 197, 170, 197, 171,
	    196, 222, 223, 196, 223, 197,
	    222, 248, 249, 222, 249, 223,
	    248, 274, 275, 248, 275, 249,
	    274, 300, 301, 274, 301, 275,
	    300, 326, 327, 300, 327, 301,
	    326, 352, 353, 326, 353, 327,
	    352, 378, 379, 352, 379, 353,
	    378, 404, 405, 378, 405, 379,
	    404, 430, 431, 404, 431, 405,
	    430, 456, 457, 430, 457, 431,
	    456, 482, 483, 456, 483, 457,
	    482, 508, 509, 482, 509, 483,
	    508, 534, 535, 508, 535, 509,
	    534, 560, 561, 534, 561, 535,
	    560, 586, 587, 560, 587, 561,
	    586, 612, 613, 586, 613, 587,
	    612, 638, 639, 612, 639, 613,
	    638, 664, 665, 638, 665, 639,
	    15, 41, 42, 15, 42, 16,
	    41, 67, 68, 41, 68, 42,
	    67, 93, 94, 67, 94, 68,
	    93, 119, 120, 93, 120, 94,
	    119, 145, 146, 119, 146, 120,
	    145, 171, 172, 145, 172, 146,
	    171, 197, 198, 171, 198, 172,
	    197, 223, 224, 197, 224, 198,
	    223, 249, 250, 223, 250, 224,
	    249, 275, 276, 249, 276, 250,
	    275, 301, 302, 275, 302, 276,
	    301, 327, 328, 301, 328, 302,
	    327, 353, 354, 327, 354, 328,
	    353, 379, 380, 353, 380, 354,
	    379, 405, 406, 379, 406, 380,
	    405, 431, 432, 405, 432, 406,
	    431, 457, 458, 431, 458, 432,
	    457, 483, 484, 457, 484, 458,
	    483, 509, 510, 483, 510, 484,
	    509, 535, 536, 509, 536, 510,
	    535, 561, 562, 535, 562, 536,
	    561, 587, 588, 561, 588, 562,
	    587, 613, 614, 587, 614, 588,
	    613, 639, 640, 613, 640, 614,
	    639, 665, 666, 639, 666, 640,
	    16, 42, 43, 16, 43, 17,
	    42, 68, 69, 42, 69, 43,
	    68, 94, 95, 68, 95, 69,
	    94, 120, 121, 94, 121, 95,
	    120, 146, 147, 120, 147, 121,
	    146, 172, 173, 146, 173, 147,
	    172, 198, 199, 172, 199, 173,
	    198, 224, 225, 198, 225, 199,
	    224, 250, 251, 224, 251, 225,
	    250, 276, 277, 250, 277, 251,
	    276, 302, 303, 276, 303, 277,
	    302, 328, 329, 302, 329, 303,
	    328, 354, 355, 328, 355, 329,
	    354, 380, 381, 354, 381, 355,
	    380, 406, 407, 380, 407, 381,
	    406, 432, 433, 406, 433, 407,
	    432, 458, 459, 432, 459, 433,
	    458, 484, 485, 458, 485, 459,
	    484, 510, 511, 484, 511, 485,
	    510, 536, 537, 510, 537, 511,
	    536, 562, 563, 536, 563, 537,
	    562, 588, 589, 562, 589, 563,
	    588, 614, 615, 588, 615, 589,
	    614, 640, 641, 614, 641, 615,
	    640, 666, 667, 640, 667, 641,
	    17, 43, 44, 17, 44, 18,
	    43, 69, 70, 43, 70, 44,
	    69, 95, 96, 69, 96, 70,
	    95, 121, 122, 95, 122, 96,
	    121, 147, 148, 121, 148, 122,
	    147, 173, 174, 147, 174, 148,
	    173, 199, 200, 173, 200, 174,
	    199, 225, 226, 199, 226, 200,
	    225, 251, 252, 225, 252, 226,
	    251, 277, 278, 251, 278, 252,
	    277, 303, 304, 277, 304, 278,
	    303, 329, 330, 303, 330, 304,
	    329, 355, 356, 329, 356, 330,
	    355, 381, 382, 355, 382, 356,
	    381, 407, 408, 381, 408, 382,
	    407, 433, 434, 407, 434, 408,
	    433, 459, 460, 433, 460, 434,
	    459, 485, 486, 459, 486, 460,
	    485, 511, 512, 485, 512, 486,
	    511, 537, 538, 511, 538, 512,
	    537, 563, 564, 537, 564, 538,
	    563, 589, 590, 563, 590, 564,
	    589, 615, 616, 589, 616, 590,
	    615, 641, 642, 615, 642, 616,
	    641, 667, 668, 641, 668, 642,
	    18, 44, 45, 18, 45, 19,
	    44, 70, 71, 44, 71, 45,
	    70, 96, 97, 70, 97, 71,
	    96, 122, 123, 96, 123, 97,
	    122, 148, 149, 122, 149, 123,
	    148, 174, 175, 148, 175, 149,
	    174, 200, 201, 174, 201, 175,
	    200, 226, 227, 200, 227, 201,
	    226, 252, 253, 226, 253, 227,
	    252, 278, 279, 252, 279, 253,
	    278, 304, 305, 278, 305, 279,
	    304, 330, 331, 304, 331, 305,
	    330, 356, 357, 330, 357, 331,
	    356, 382, 383, 356, 383, 357,
	    382, 408, 409, 382, 409, 383,
	    408, 434, 435, 408, 435, 409,
	    434, 460, 461, 434, 461, 435,
	    460, 486, 487, 460, 487, 461,
	    486, 512, 513, 486, 513, 487,
	    512, 538, 539, 512, 539, 513,
	    538, 564, 565, 538, 565, 539,
	    564, 590, 591, 564, 591, 565,
	    590, 616, 617, 590, 617, 591,
	    616, 642, 643, 616, 643, 617,
	    642, 668, 669, 642, 669, 643,
	    19, 45, 46, 19, 46, 20,
	    45, 71, 72, 45, 72, 46,
	    71, 97, 98, 71, 98, 72,
	    97, 123, 124, 97, 124, 98,
	    123, 149, 150, 123, 150, 124,
	    149, 175, 176, 149, 176, 150,
	    175, 201, 202, 175, 202, 176,
	    201, 227, 228, 201, 228, 202,
	    227, 253, 254, 227, 254, 228,
	    253, 279, 280, 253, 280, 254,
	    279, 305, 306, 279, 306, 280,
	    305, 331, 332, 305, 332, 306,
	    331, 357, 358, 331, 358, 332,
	    357, 383, 384, 357, 384, 358,
	    383, 409, 410, 383, 410, 384,
	    409, 435, 436, 409, 436, 410,
	    435, 461, 462, 435, 462, 436,
	    461, 487, 488, 461, 488, 462,
	    487, 513, 514, 487, 514, 488,
	    513, 539, 540, 513, 540, 514,
	    539, 565, 566, 539, 566, 540,
	    565, 591, 592, 565, 592, 566,
	    591, 617, 618, 591, 618, 592,
	    617, 643, 644, 617, 644, 618,
	    643, 669, 670, 643, 670, 644,
	    20, 46, 47, 20, 47, 21,
	    46, 72, 73, 46, 73, 47,
	    72, 98, 99, 72, 99, 73,
	    98, 124, 125, 98, 125, 99,
	    124, 150, 151, 124, 151, 125,
	    150, 176, 177, 150, 177, 151,
	    176, 202, 203, 176, 203, 177,
	    202, 228, 229, 202, 229, 203,
	    228, 254, 255, 228, 255, 229,
	    254, 280, 281, 254, 281, 255,
	    280, 306, 307, 280, 307, 281,
	    306, 332, 333, 306, 333, 307,
	    332, 358, 359, 332, 359, 333,
	    358, 384, 385, 358, 385, 359,
	    384, 410, 411, 384, 411, 385,
	    410, 436, 437, 410, 437, 411,
	    436, 462, 463, 436, 463, 437,
	    462, 488, 489, 462, 489, 463,
	    488, 514, 515, 488, 515, 489,
	    514, 540, 541, 514, 541, 515,
	    540, 566, 567, 540, 567, 541,
	    566, 592, 593, 566, 593, 567,
	    592, 618, 619, 592, 619, 593,
	    618, 644, 645, 618, 645, 619,
	    644, 670, 671, 644, 671, 645,
	    21, 47, 48, 21, 48, 22,
	    47, 73, 74, 47, 74, 48,
	    73, 99, 100, 73, 100, 74,
	    99, 125, 126, 99, 126, 100,
	    125, 151, 152, 125, 152, 126,
	    151, 177, 178, 151, 178, 152,
	    177, 203, 204, 177, 204, 178,
	    203, 229, 230, 203, 230, 204,
	    229, 255, 256, 229, 256, 230,
	    255, 281, 282, 255, 282, 256,
	    281, 307, 308, 281, 308, 282,
	    307, 333, 334, 307, 334, 308,
	    333, 359, 360, 333, 360, 334,
	    359, 385, 386, 359, 386, 360,
	    385, 411, 412, 385, 412, 386,
	    411, 437, 438, 411, 438, 412,
	    437, 463, 464, 437, 464, 438,
	    463, 489, 490, 463, 490, 464,
	    489, 515, 516, 489, 516, 490,
	    515, 541, 542, 515, 542, 516,
	    541, 567, 568, 541, 568, 542,
	    567, 593, 594, 567, 594, 568,
	    593, 619, 620, 593, 620, 594,
	    619, 645, 646, 619, 646, 620,
	    645, 671, 672, 645, 672, 646,
	    22, 48, 49, 22, 49, 23,
	    48, 74, 75, 48, 75, 49,
	    74, 100, 101, 74, 101, 75,
	    100, 126, 127, 100, 127, 101,
	    126, 152, 153, 126, 153, 127,
	    152, 178, 179, 152, 179, 153,
	    178, 204, 205, 178, 205, 179,
	    204, 230, 231, 204, 231, 205,
	    230, 256, 257, 230, 257, 231,
	    256, 282, 283, 256, 283, 257,
	    282, 308, 309, 282, 309, 283,
	    308, 334, 335, 308, 335, 309,
	    334, 360, 361, 334, 361, 335,
	    360, 386, 387, 360, 387, 361,
	    386, 412, 413, 386, 413, 387,
	    412, 438, 439, 412, 439, 413,
	    438, 464, 465, 438, 465, 439,
	    464, 490, 491, 464, 491, 465,
	    490, 516, 517, 490, 517, 491,
	    516, 542, 543, 516, 543, 517,
	    542, 568, 569, 542, 569, 543,
	    568, 594, 595, 568, 595, 569,
	    594, 620, 621, 594, 621, 595,
	    620, 646, 647, 620, 647, 621,
	    646, 672, 673, 646, 673, 647,
	    23, 49, 50, 23, 50, 24,
	    49, 75, 76, 49, 76, 50,
	    75, 101, 102, 75, 102, 76,
	    101, 127, 128, 101, 128, 102,
	    127, 153, 154, 127, 154, 128,
	    153, 179, 180, 153, 180, 154,
	    179, 205, 206, 179, 206, 180,
	    205, 231, 232, 205, 232, 206,
	    231, 257, 258, 231, 258, 232,
	    257, 283, 284, 257, 284, 258,
	    283, 309, 310, 283, 310, 284,
	    309, 335, 336, 309, 336, 310,
	    335, 361, 362, 335, 362, 336,
	    361, 387, 388, 361, 388, 362,
	    387, 413, 414, 387, 414, 388,
	    413, 439, 440, 413, 440, 414,
	    439, 465, 466, 439, 466, 440,
	    465, 491, 492, 465, 492, 466,
	    491, 517, 518, 491, 518, 492,
	    517, 543, 544, 517, 544, 518,
	    543, 569, 570, 543, 570, 544,
	    569, 595, 596, 569, 596, 570,
	    595, 621, 622, 595, 622, 596,
	    621, 647, 648, 621, 648, 622,
	    647, 673, 674, 647, 674, 648,
	    24, 50, 51, 24, 51, 25,
	    50, 76, 77, 50, 77, 51,
	    76, 102, 103, 76, 103, 77,
	    102, 128, 129, 102, 129, 103,
	    128, 154, 155, 128, 155, 129,
	    154, 180, 181, 154, 181, 155,
	    180, 206, 207, 180, 207, 181,
	    206, 232, 233, 206, 233, 207,
	    232, 258, 259, 232, 259, 233,
	    258, 284, 285, 258, 285, 259,
	    284, 310, 311, 284, 311, 285,
	    310, 336, 337, 310, 337, 311,
	    336, 362, 363, 336, 363, 337,
	    362, 388, 389, 362, 389, 363,
	    388, 414, 415, 388, 415, 389,
	    414, 440, 441, 414, 441, 415,
	    440, 466, 467, 440, 467, 441,
	    466, 492, 493, 466, 493, 467,
	    492, 518, 519, 492, 519, 493,
	    518, 544, 545, 518, 545, 519,
	    544, 570, 571, 544, 571, 545,
	    570, 596, 597, 570, 597, 571,
	    596, 622, 623, 596, 623, 597,
	    622, 648, 649, 622, 649, 623,
	    648, 674, 675, 648, 675, 649
	   ]);
	   var buf22 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf22);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf22 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf22);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc22 = gl.getUniformLocation(prog22,"mvMatrix");
	   var prMatLoc22 = gl.getUniformLocation(prog22,"prMatrix");
	   var normMatLoc22 = gl.getUniformLocation(prog22,"normMatrix");
	   // ****** lines object 23 ******
	   var prog23  = gl.createProgram();
	   gl.attachShader(prog23, getShader( gl, "rgl_persp3dlmvshader23" ));
	   gl.attachShader(prog23, getShader( gl, "rgl_persp3dlmfshader23" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog23, 0, "aPos");
	   gl.bindAttribLocation(prog23, 1, "aCol");
	   gl.linkProgram(prog23);
	   var v=new Float32Array([
	    1.2, 1, 60.9009,
	    1.2, 1, 60.9009,
	    89.7, 53, 73.34235,
	    89.7, 53, 73.34235
	   ]);
	   var buf23 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf23);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc23 = gl.getUniformLocation(prog23,"mvMatrix");
	   var prMatLoc23 = gl.getUniformLocation(prog23,"prMatrix");
	   // ****** text object 25 ******
	   var prog25  = gl.createProgram();
	   gl.attachShader(prog25, getShader( gl, "rgl_persp3dlmvshader25" ));
	   gl.attachShader(prog25, getShader( gl, "rgl_persp3dlmfshader25" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog25, 0, "aPos");
	   gl.bindAttribLocation(prog25, 1, "aCol");
	   gl.linkProgram(prog25);
	   var texts = [
	    "Agriculture"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX25 = texinfo.canvasX;
	   var canvasY25 = texinfo.canvasY;
	   var ofsLoc25 = gl.getAttribLocation(prog25, "aOfs");
	   var texture25 = gl.createTexture();
	   var texLoc25 = gl.getAttribLocation(prog25, "aTexcoord");
	   var sampler25 = gl.getUniformLocation(prog25,"uSampler");
    	   handleLoadedTexture(texture25, document.getElementById("rgl_persp3dlmtextureCanvas"));
	   var v=new Float32Array([
	    45.45, -7.814, 58.79207, 0, -0.5, 0.5, 0.5,
	    45.45, -7.814, 58.79207, 1, -0.5, 0.5, 0.5,
	    45.45, -7.814, 58.79207, 1, 1.5, 0.5, 0.5,
	    45.45, -7.814, 58.79207, 0, 1.5, 0.5, 0.5
	   ]);
	   for (var i=0; i<1; i++) 
	     for (var j=0; j<4; j++) {
	         ind = 7*(4*i + j) + 3;
	         v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i]/width;
	         v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight/height;
	         v[ind] *= texinfo.widths[i]/texinfo.canvasX;
	         v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
	           - v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
	     }
	   var f=new Uint16Array([
	    0, 1, 2, 0, 2, 3
	   ]);
	   var buf25 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf25);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf25 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf25);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc25 = gl.getUniformLocation(prog25,"mvMatrix");
	   var prMatLoc25 = gl.getUniformLocation(prog25,"prMatrix");
	   // ****** text object 26 ******
	   var prog26  = gl.createProgram();
	   gl.attachShader(prog26, getShader( gl, "rgl_persp3dlmvshader26" ));
	   gl.attachShader(prog26, getShader( gl, "rgl_persp3dlmfshader26" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog26, 0, "aPos");
	   gl.bindAttribLocation(prog26, 1, "aCol");
	   gl.linkProgram(prog26);
	   var texts = [
	    "Education"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX26 = texinfo.canvasX;
	   var canvasY26 = texinfo.canvasY;
	   var ofsLoc26 = gl.getAttribLocation(prog26, "aOfs");
	   var texture26 = gl.createTexture();
	   var texLoc26 = gl.getAttribLocation(prog26, "aTexcoord");
	   var sampler26 = gl.getUniformLocation(prog26,"uSampler");
    	   handleLoadedTexture(texture26, document.getElementById("rgl_persp3dlmtextureCanvas"));
	   var v=new Float32Array([
	    -13.80075, 27, 58.79207, 0, -0.5, 0.5, 0.5,
	    -13.80075, 27, 58.79207, 1, -0.5, 0.5, 0.5,
	    -13.80075, 27, 58.79207, 1, 1.5, 0.5, 0.5,
	    -13.80075, 27, 58.79207, 0, 1.5, 0.5, 0.5
	   ]);
	   for (var i=0; i<1; i++) 
	     for (var j=0; j<4; j++) {
	         ind = 7*(4*i + j) + 3;
	         v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i]/width;
	         v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight/height;
	         v[ind] *= texinfo.widths[i]/texinfo.canvasX;
	         v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
	           - v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
	     }
	   var f=new Uint16Array([
	    0, 1, 2, 0, 2, 3
	   ]);
	   var buf26 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf26);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf26 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf26);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc26 = gl.getUniformLocation(prog26,"mvMatrix");
	   var prMatLoc26 = gl.getUniformLocation(prog26,"prMatrix");
	   // ****** text object 27 ******
	   var prog27  = gl.createProgram();
	   gl.attachShader(prog27, getShader( gl, "rgl_persp3dlmvshader27" ));
	   gl.attachShader(prog27, getShader( gl, "rgl_persp3dlmfshader27" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog27, 0, "aPos");
	   gl.bindAttribLocation(prog27, 1, "aCol");
	   gl.linkProgram(prog27);
	   var texts = [
	    "Fertility"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX27 = texinfo.canvasX;
	   var canvasY27 = texinfo.canvasY;
	   var ofsLoc27 = gl.getAttribLocation(prog27, "aOfs");
	   var texture27 = gl.createTexture();
	   var texLoc27 = gl.getAttribLocation(prog27, "aTexcoord");
	   var sampler27 = gl.getUniformLocation(prog27,"uSampler");
    	   handleLoadedTexture(texture27, document.getElementById("rgl_persp3dlmtextureCanvas"));
	   var v=new Float32Array([
	    -13.80075, -7.814, 67.12162, 0, -0.5, 0.5, 0.5,
	    -13.80075, -7.814, 67.12162, 1, -0.5, 0.5, 0.5,
	    -13.80075, -7.814, 67.12162, 1, 1.5, 0.5, 0.5,
	    -13.80075, -7.814, 67.12162, 0, 1.5, 0.5, 0.5
	   ]);
	   for (var i=0; i<1; i++) 
	     for (var j=0; j<4; j++) {
	         ind = 7*(4*i + j) + 3;
	         v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i]/width;
	         v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight/height;
	         v[ind] *= texinfo.widths[i]/texinfo.canvasX;
	         v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
	           - v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
	     }
	   var f=new Uint16Array([
	    0, 1, 2, 0, 2, 3
	   ]);
	   var buf27 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf27);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf27 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf27);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc27 = gl.getUniformLocation(prog27,"mvMatrix");
	   var prMatLoc27 = gl.getUniformLocation(prog27,"prMatrix");
	   // ****** lines object 28 ******
	   var prog28  = gl.createProgram();
	   gl.attachShader(prog28, getShader( gl, "rgl_persp3dlmvshader28" ));
	   gl.attachShader(prog28, getShader( gl, "rgl_persp3dlmfshader28" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog28, 0, "aPos");
	   gl.bindAttribLocation(prog28, 1, "aCol");
	   gl.linkProgram(prog28);
	   var v=new Float32Array([
	    20, 0.22, 60.71428,
	    80, 0.22, 60.71428,
	    20, 0.22, 60.71428,
	    20, -1.119, 60.39391,
	    40, 0.22, 60.71428,
	    40, -1.119, 60.39391,
	    60, 0.22, 60.71428,
	    60, -1.119, 60.39391,
	    80, 0.22, 60.71428,
	    80, -1.119, 60.39391
	   ]);
	   var buf28 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf28);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc28 = gl.getUniformLocation(prog28,"mvMatrix");
	   var prMatLoc28 = gl.getUniformLocation(prog28,"prMatrix");
	   // ****** text object 29 ******
	   var prog29  = gl.createProgram();
	   gl.attachShader(prog29, getShader( gl, "rgl_persp3dlmvshader29" ));
	   gl.attachShader(prog29, getShader( gl, "rgl_persp3dlmfshader29" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog29, 0, "aPos");
	   gl.bindAttribLocation(prog29, 1, "aCol");
	   gl.linkProgram(prog29);
	   var texts = [
	    "20",
	    "40",
	    "60",
	    "80"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX29 = texinfo.canvasX;
	   var canvasY29 = texinfo.canvasY;
	   var ofsLoc29 = gl.getAttribLocation(prog29, "aOfs");
	   var texture29 = gl.createTexture();
	   var texLoc29 = gl.getAttribLocation(prog29, "aTexcoord");
	   var sampler29 = gl.getUniformLocation(prog29,"uSampler");
    	   handleLoadedTexture(texture29, document.getElementById("rgl_persp3dlmtextureCanvas"));
	   var v=new Float32Array([
	    20, -3.797, 59.75317, 0, -0.5, 0.5, 0.5,
	    20, -3.797, 59.75317, 1, -0.5, 0.5, 0.5,
	    20, -3.797, 59.75317, 1, 1.5, 0.5, 0.5,
	    20, -3.797, 59.75317, 0, 1.5, 0.5, 0.5,
	    40, -3.797, 59.75317, 0, -0.5, 0.5, 0.5,
	    40, -3.797, 59.75317, 1, -0.5, 0.5, 0.5,
	    40, -3.797, 59.75317, 1, 1.5, 0.5, 0.5,
	    40, -3.797, 59.75317, 0, 1.5, 0.5, 0.5,
	    60, -3.797, 59.75317, 0, -0.5, 0.5, 0.5,
	    60, -3.797, 59.75317, 1, -0.5, 0.5, 0.5,
	    60, -3.797, 59.75317, 1, 1.5, 0.5, 0.5,
	    60, -3.797, 59.75317, 0, 1.5, 0.5, 0.5,
	    80, -3.797, 59.75317, 0, -0.5, 0.5, 0.5,
	    80, -3.797, 59.75317, 1, -0.5, 0.5, 0.5,
	    80, -3.797, 59.75317, 1, 1.5, 0.5, 0.5,
	    80, -3.797, 59.75317, 0, 1.5, 0.5, 0.5
	   ]);
	   for (var i=0; i<4; i++) 
	     for (var j=0; j<4; j++) {
	         ind = 7*(4*i + j) + 3;
	         v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i]/width;
	         v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight/height;
	         v[ind] *= texinfo.widths[i]/texinfo.canvasX;
	         v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
	           - v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
	     }
	   var f=new Uint16Array([
	    0, 1, 2, 0, 2, 3,
	    4, 5, 6, 4, 6, 7,
	    8, 9, 10, 8, 10, 11,
	    12, 13, 14, 12, 14, 15
	   ]);
	   var buf29 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf29);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf29 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf29);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc29 = gl.getUniformLocation(prog29,"mvMatrix");
	   var prMatLoc29 = gl.getUniformLocation(prog29,"prMatrix");
	   // ****** lines object 30 ******
	   var prog30  = gl.createProgram();
	   gl.attachShader(prog30, getShader( gl, "rgl_persp3dlmvshader30" ));
	   gl.attachShader(prog30, getShader( gl, "rgl_persp3dlmfshader30" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog30, 0, "aPos");
	   gl.bindAttribLocation(prog30, 1, "aCol");
	   gl.linkProgram(prog30);
	   var v=new Float32Array([
	    -0.1274999, 10, 60.71428,
	    -0.1274999, 50, 60.71428,
	    -0.1274999, 10, 60.71428,
	    -2.406375, 10, 60.39391,
	    -0.1274999, 20, 60.71428,
	    -2.406375, 20, 60.39391,
	    -0.1274999, 30, 60.71428,
	    -2.406375, 30, 60.39391,
	    -0.1274999, 40, 60.71428,
	    -2.406375, 40, 60.39391,
	    -0.1274999, 50, 60.71428,
	    -2.406375, 50, 60.39391
	   ]);
	   var buf30 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf30);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc30 = gl.getUniformLocation(prog30,"mvMatrix");
	   var prMatLoc30 = gl.getUniformLocation(prog30,"prMatrix");
	   // ****** text object 31 ******
	   var prog31  = gl.createProgram();
	   gl.attachShader(prog31, getShader( gl, "rgl_persp3dlmvshader31" ));
	   gl.attachShader(prog31, getShader( gl, "rgl_persp3dlmfshader31" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog31, 0, "aPos");
	   gl.bindAttribLocation(prog31, 1, "aCol");
	   gl.linkProgram(prog31);
	   var texts = [
	    "10",
	    "20",
	    "30",
	    "40",
	    "50"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX31 = texinfo.canvasX;
	   var canvasY31 = texinfo.canvasY;
	   var ofsLoc31 = gl.getAttribLocation(prog31, "aOfs");
	   var texture31 = gl.createTexture();
	   var texLoc31 = gl.getAttribLocation(prog31, "aTexcoord");
	   var sampler31 = gl.getUniformLocation(prog31,"uSampler");
    	   handleLoadedTexture(texture31, document.getElementById("rgl_persp3dlmtextureCanvas"));
	   var v=new Float32Array([
	    -6.964125, 10, 59.75317, 0, -0.5, 0.5, 0.5,
	    -6.964125, 10, 59.75317, 1, -0.5, 0.5, 0.5,
	    -6.964125, 10, 59.75317, 1, 1.5, 0.5, 0.5,
	    -6.964125, 10, 59.75317, 0, 1.5, 0.5, 0.5,
	    -6.964125, 20, 59.75317, 0, -0.5, 0.5, 0.5,
	    -6.964125, 20, 59.75317, 1, -0.5, 0.5, 0.5,
	    -6.964125, 20, 59.75317, 1, 1.5, 0.5, 0.5,
	    -6.964125, 20, 59.75317, 0, 1.5, 0.5, 0.5,
	    -6.964125, 30, 59.75317, 0, -0.5, 0.5, 0.5,
	    -6.964125, 30, 59.75317, 1, -0.5, 0.5, 0.5,
	    -6.964125, 30, 59.75317, 1, 1.5, 0.5, 0.5,
	    -6.964125, 30, 59.75317, 0, 1.5, 0.5, 0.5,
	    -6.964125, 40, 59.75317, 0, -0.5, 0.5, 0.5,
	    -6.964125, 40, 59.75317, 1, -0.5, 0.5, 0.5,
	    -6.964125, 40, 59.75317, 1, 1.5, 0.5, 0.5,
	    -6.964125, 40, 59.75317, 0, 1.5, 0.5, 0.5,
	    -6.964125, 50, 59.75317, 0, -0.5, 0.5, 0.5,
	    -6.964125, 50, 59.75317, 1, -0.5, 0.5, 0.5,
	    -6.964125, 50, 59.75317, 1, 1.5, 0.5, 0.5,
	    -6.964125, 50, 59.75317, 0, 1.5, 0.5, 0.5
	   ]);
	   for (var i=0; i<5; i++) 
	     for (var j=0; j<4; j++) {
	         ind = 7*(4*i + j) + 3;
	         v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i]/width;
	         v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight/height;
	         v[ind] *= texinfo.widths[i]/texinfo.canvasX;
	         v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
	           - v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
	     }
	   var f=new Uint16Array([
	    0, 1, 2, 0, 2, 3,
	    4, 5, 6, 4, 6, 7,
	    8, 9, 10, 8, 10, 11,
	    12, 13, 14, 12, 14, 15,
	    16, 17, 18, 16, 18, 19
	   ]);
	   var buf31 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf31);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf31 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf31);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc31 = gl.getUniformLocation(prog31,"mvMatrix");
	   var prMatLoc31 = gl.getUniformLocation(prog31,"prMatrix");
	   // ****** lines object 32 ******
	   var prog32  = gl.createProgram();
	   gl.attachShader(prog32, getShader( gl, "rgl_persp3dlmvshader32" ));
	   gl.attachShader(prog32, getShader( gl, "rgl_persp3dlmfshader32" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog32, 0, "aPos");
	   gl.bindAttribLocation(prog32, 1, "aCol");
	   gl.linkProgram(prog32);
	   var v=new Float32Array([
	    -0.1274999, 0.22, 62,
	    -0.1274999, 0.22, 72,
	    -0.1274999, 0.22, 62,
	    -2.406375, -1.119, 62,
	    -0.1274999, 0.22, 64,
	    -2.406375, -1.119, 64,
	    -0.1274999, 0.22, 66,
	    -2.406375, -1.119, 66,
	    -0.1274999, 0.22, 68,
	    -2.406375, -1.119, 68,
	    -0.1274999, 0.22, 70,
	    -2.406375, -1.119, 70,
	    -0.1274999, 0.22, 72,
	    -2.406375, -1.119, 72
	   ]);
	   var buf32 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf32);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc32 = gl.getUniformLocation(prog32,"mvMatrix");
	   var prMatLoc32 = gl.getUniformLocation(prog32,"prMatrix");
	   // ****** text object 33 ******
	   var prog33  = gl.createProgram();
	   gl.attachShader(prog33, getShader( gl, "rgl_persp3dlmvshader33" ));
	   gl.attachShader(prog33, getShader( gl, "rgl_persp3dlmfshader33" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog33, 0, "aPos");
	   gl.bindAttribLocation(prog33, 1, "aCol");
	   gl.linkProgram(prog33);
	   var texts = [
	    "62",
	    "64",
	    "66",
	    "68",
	    "70",
	    "72"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX33 = texinfo.canvasX;
	   var canvasY33 = texinfo.canvasY;
	   var ofsLoc33 = gl.getAttribLocation(prog33, "aOfs");
	   var texture33 = gl.createTexture();
	   var texLoc33 = gl.getAttribLocation(prog33, "aTexcoord");
	   var sampler33 = gl.getUniformLocation(prog33,"uSampler");
    	   handleLoadedTexture(texture33, document.getElementById("rgl_persp3dlmtextureCanvas"));
	   var v=new Float32Array([
	    -6.964125, -3.797, 62, 0, -0.5, 0.5, 0.5,
	    -6.964125, -3.797, 62, 1, -0.5, 0.5, 0.5,
	    -6.964125, -3.797, 62, 1, 1.5, 0.5, 0.5,
	    -6.964125, -3.797, 62, 0, 1.5, 0.5, 0.5,
	    -6.964125, -3.797, 64, 0, -0.5, 0.5, 0.5,
	    -6.964125, -3.797, 64, 1, -0.5, 0.5, 0.5,
	    -6.964125, -3.797, 64, 1, 1.5, 0.5, 0.5,
	    -6.964125, -3.797, 64, 0, 1.5, 0.5, 0.5,
	    -6.964125, -3.797, 66, 0, -0.5, 0.5, 0.5,
	    -6.964125, -3.797, 66, 1, -0.5, 0.5, 0.5,
	    -6.964125, -3.797, 66, 1, 1.5, 0.5, 0.5,
	    -6.964125, -3.797, 66, 0, 1.5, 0.5, 0.5,
	    -6.964125, -3.797, 68, 0, -0.5, 0.5, 0.5,
	    -6.964125, -3.797, 68, 1, -0.5, 0.5, 0.5,
	    -6.964125, -3.797, 68, 1, 1.5, 0.5, 0.5,
	    -6.964125, -3.797, 68, 0, 1.5, 0.5, 0.5,
	    -6.964125, -3.797, 70, 0, -0.5, 0.5, 0.5,
	    -6.964125, -3.797, 70, 1, -0.5, 0.5, 0.5,
	    -6.964125, -3.797, 70, 1, 1.5, 0.5, 0.5,
	    -6.964125, -3.797, 70, 0, 1.5, 0.5, 0.5,
	    -6.964125, -3.797, 72, 0, -0.5, 0.5, 0.5,
	    -6.964125, -3.797, 72, 1, -0.5, 0.5, 0.5,
	    -6.964125, -3.797, 72, 1, 1.5, 0.5, 0.5,
	    -6.964125, -3.797, 72, 0, 1.5, 0.5, 0.5
	   ]);
	   for (var i=0; i<6; i++) 
	     for (var j=0; j<4; j++) {
	         ind = 7*(4*i + j) + 3;
	         v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i]/width;
	         v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight/height;
	         v[ind] *= texinfo.widths[i]/texinfo.canvasX;
	         v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
	           - v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
	     }
	   var f=new Uint16Array([
	    0, 1, 2, 0, 2, 3,
	    4, 5, 6, 4, 6, 7,
	    8, 9, 10, 8, 10, 11,
	    12, 13, 14, 12, 14, 15,
	    16, 17, 18, 16, 18, 19,
	    20, 21, 22, 20, 22, 23
	   ]);
	   var buf33 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf33);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf33 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf33);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc33 = gl.getUniformLocation(prog33,"mvMatrix");
	   var prMatLoc33 = gl.getUniformLocation(prog33,"prMatrix");
	   // ****** lines object 34 ******
	   var prog34  = gl.createProgram();
	   gl.attachShader(prog34, getShader( gl, "rgl_persp3dlmvshader34" ));
	   gl.attachShader(prog34, getShader( gl, "rgl_persp3dlmfshader34" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog34, 0, "aPos");
	   gl.bindAttribLocation(prog34, 1, "aCol");
	   gl.linkProgram(prog34);
	   var v=new Float32Array([
	    -0.1274999, 0.22, 60.71428,
	    -0.1274999, 53.78, 60.71428,
	    -0.1274999, 0.22, 73.52897,
	    -0.1274999, 53.78, 73.52897,
	    -0.1274999, 0.22, 60.71428,
	    -0.1274999, 0.22, 73.52897,
	    -0.1274999, 53.78, 60.71428,
	    -0.1274999, 53.78, 73.52897,
	    -0.1274999, 0.22, 60.71428,
	    91.0275, 0.22, 60.71428,
	    -0.1274999, 0.22, 73.52897,
	    91.0275, 0.22, 73.52897,
	    -0.1274999, 53.78, 60.71428,
	    91.0275, 53.78, 60.71428,
	    -0.1274999, 53.78, 73.52897,
	    91.0275, 53.78, 73.52897,
	    91.0275, 0.22, 60.71428,
	    91.0275, 53.78, 60.71428,
	    91.0275, 0.22, 73.52897,
	    91.0275, 53.78, 73.52897,
	    91.0275, 0.22, 60.71428,
	    91.0275, 0.22, 73.52897,
	    91.0275, 53.78, 60.71428,
	    91.0275, 53.78, 73.52897
	   ]);
	   var buf34 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf34);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc34 = gl.getUniformLocation(prog34,"mvMatrix");
	   var prMatLoc34 = gl.getUniformLocation(prog34,"prMatrix");
	   gl.enable(gl.DEPTH_TEST);
	   gl.depthFunc(gl.LEQUAL);
	   gl.clearDepth(1.0);
	   gl.clearColor(1, 1, 1, 1);
	   var xOffs = yOffs = 0,  drag  = 0;
	   drawScene();
	   function drawScene(){
	     gl.depthMask(true);
	     gl.disable(gl.BLEND);
	     var radius = 56.86862;
	     var s = sin(fov*PI/360);
	     var t = tan(fov*PI/360);
	     var distance = radius/s;
	     var near = distance - radius;
	     var far = distance + radius;
	     var hlen = t*near;
	     var aspect = width/height;
	     prMatrix.makeIdentity();
	     if (aspect > 1)
	       prMatrix.frustum(-hlen*aspect*zoom, hlen*aspect*zoom, 
	                        -hlen*zoom, hlen*zoom, near, far);
	     else  
	       prMatrix.frustum(-hlen*zoom, hlen*zoom, 
	                        -hlen*zoom/aspect, hlen*zoom/aspect, 
	                        near, far);
	     mvMatrix.makeIdentity();
	     mvMatrix.translate( -45.45, -27, -67.12162 );
	     mvMatrix.scale( 0.6745375, 1.148011, 4.798201 );   
	     mvMatrix.multRight( userMatrix );  
	     mvMatrix.translate(0, 0, -distance);
	     normMatrix.makeIdentity();
	     normMatrix.scale( 1.482497, 0.8710719, 0.2084115 );   
	     normMatrix.multRight( userMatrix );
	     gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
	     // ****** surface object 22 *******
	     gl.useProgram(prog22);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf22);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf22);
	     gl.uniformMatrix4fv( prMatLoc22, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc22, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( normMatLoc22, false, new Float32Array(normMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 1, 1, 1, 1 );
	     gl.enableVertexAttribArray( normLoc22 );
	     gl.vertexAttribPointer(normLoc22, 3, gl.FLOAT, false, 24, 12);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 24,  0);
	     gl.drawElements(gl.TRIANGLES, 3750, gl.UNSIGNED_SHORT, 0);
	     // ****** lines object 23 *******
	     gl.useProgram(prog23);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf23);
	     gl.uniformMatrix4fv( prMatLoc23, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc23, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.lineWidth( 1 );
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
	     gl.drawArrays(gl.LINES, 0, 4);
	     // ****** text object 25 *******
	     gl.useProgram(prog25);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf25);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf25);
	     gl.uniformMatrix4fv( prMatLoc25, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc25, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc25 );
	     gl.vertexAttribPointer(texLoc25, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture25);
	     gl.uniform1i( sampler25, 0);
	     gl.enableVertexAttribArray( ofsLoc25 );
	     gl.vertexAttribPointer(ofsLoc25, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
	     // ****** text object 26 *******
	     gl.useProgram(prog26);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf26);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf26);
	     gl.uniformMatrix4fv( prMatLoc26, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc26, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc26 );
	     gl.vertexAttribPointer(texLoc26, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture26);
	     gl.uniform1i( sampler26, 0);
	     gl.enableVertexAttribArray( ofsLoc26 );
	     gl.vertexAttribPointer(ofsLoc26, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
	     // ****** text object 27 *******
	     gl.useProgram(prog27);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf27);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf27);
	     gl.uniformMatrix4fv( prMatLoc27, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc27, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc27 );
	     gl.vertexAttribPointer(texLoc27, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture27);
	     gl.uniform1i( sampler27, 0);
	     gl.enableVertexAttribArray( ofsLoc27 );
	     gl.vertexAttribPointer(ofsLoc27, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
	     // ****** lines object 28 *******
	     gl.useProgram(prog28);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf28);
	     gl.uniformMatrix4fv( prMatLoc28, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc28, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.lineWidth( 1 );
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
	     gl.drawArrays(gl.LINES, 0, 10);
	     // ****** text object 29 *******
	     gl.useProgram(prog29);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf29);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf29);
	     gl.uniformMatrix4fv( prMatLoc29, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc29, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc29 );
	     gl.vertexAttribPointer(texLoc29, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture29);
	     gl.uniform1i( sampler29, 0);
	     gl.enableVertexAttribArray( ofsLoc29 );
	     gl.vertexAttribPointer(ofsLoc29, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 24, gl.UNSIGNED_SHORT, 0);
	     // ****** lines object 30 *******
	     gl.useProgram(prog30);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf30);
	     gl.uniformMatrix4fv( prMatLoc30, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc30, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.lineWidth( 1 );
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
	     gl.drawArrays(gl.LINES, 0, 12);
	     // ****** text object 31 *******
	     gl.useProgram(prog31);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf31);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf31);
	     gl.uniformMatrix4fv( prMatLoc31, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc31, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc31 );
	     gl.vertexAttribPointer(texLoc31, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture31);
	     gl.uniform1i( sampler31, 0);
	     gl.enableVertexAttribArray( ofsLoc31 );
	     gl.vertexAttribPointer(ofsLoc31, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 30, gl.UNSIGNED_SHORT, 0);
	     // ****** lines object 32 *******
	     gl.useProgram(prog32);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf32);
	     gl.uniformMatrix4fv( prMatLoc32, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc32, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.lineWidth( 1 );
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
	     gl.drawArrays(gl.LINES, 0, 14);
	     // ****** text object 33 *******
	     gl.useProgram(prog33);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf33);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf33);
	     gl.uniformMatrix4fv( prMatLoc33, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc33, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc33 );
	     gl.vertexAttribPointer(texLoc33, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture33);
	     gl.uniform1i( sampler33, 0);
	     gl.enableVertexAttribArray( ofsLoc33 );
	     gl.vertexAttribPointer(ofsLoc33, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 36, gl.UNSIGNED_SHORT, 0);
	     // ****** lines object 34 *******
	     gl.useProgram(prog34);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf34);
	     gl.uniformMatrix4fv( prMatLoc34, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc34, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.lineWidth( 1 );
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
	     gl.drawArrays(gl.LINES, 0, 24);
	     gl.flush ();
	   }
	   var vlen = function(v) {
	     return sqrt(v[0]*v[0] + v[1]*v[1] + v[2]*v[2])
	   }
	   var xprod = function(a, b) {
	     return [a[1]*b[2] - a[2]*b[1],
	             a[2]*b[0] - a[0]*b[2],
	             a[0]*b[1] - a[1]*b[0]];
	   }
	   var screenToVector = function(x, y) {
	     var radius = max(width, height)/2.0;
	     var cx = width/2.0;
	     var cy = height/2.0;
	     var px = (x-cx)/radius;
	     var py = (y-cy)/radius;
	     var plen = sqrt(px*px+py*py);
	     if (plen > 1.e-6) { 
	       px = px/plen;
	       py = py/plen;
	     }
	     var angle = (SQRT2 - plen)/SQRT2*PI/2;
	     var z = sin(angle);
	     var zlen = sqrt(1.0 - z*z);
	     px = px * zlen;
	     py = py * zlen;
	     return [px, py, z];
	   }
	   var rotBase;
	   var trackballdown = function(x,y) {
	     rotBase = screenToVector(x, y);
	     saveMat.load(userMatrix);
	   }
	   var trackballmove = function(x,y) {
	     var rotCurrent = screenToVector(x,y);
	     var dot = rotBase[0]*rotCurrent[0] + 
	   	       rotBase[1]*rotCurrent[1] + 
	   	       rotBase[2]*rotCurrent[2];
	     var angle = acos( dot/vlen(rotBase)/vlen(rotCurrent) )*180./PI;
	     var axis = xprod(rotBase, rotCurrent);
	     userMatrix.load(saveMat);
	     userMatrix.rotate(angle, axis[0], axis[1], axis[2]);
	     drawScene();
	   }
	   var y0zoom = 0;
	   var zoom0 = 1;
	   var zoomdown = function(x, y) {
	     y0zoom = y;
	     zoom0 = log(zoom);
	   }
	   var zoommove = function(x, y) {
	     zoom = exp(zoom0 + (y-y0zoom)/height);
	     drawScene();
	   }
	   var y0fov = 0;
	   var fov0 = 1;
	   var fovdown = function(x, y) {
	     y0fov = y;
	     fov0 = fov;
	   }
	   var fovmove = function(x, y) {
	     fov = max(1, min(179, fov0 + 180*(y-y0fov)/height));
	     drawScene();
	   }
	   var mousedown = [trackballdown, zoomdown, fovdown];
	   var mousemove = [trackballmove, zoommove, fovmove];
	   function relMouseCoords(event){
	     var totalOffsetX = 0;
	     var totalOffsetY = 0;
	     var currentElement = canvas;
	     do{
	       totalOffsetX += currentElement.offsetLeft;
	       totalOffsetY += currentElement.offsetTop;
	     }
	     while(currentElement = currentElement.offsetParent)
	     var canvasX = event.pageX - totalOffsetX;
	     var canvasY = event.pageY - totalOffsetY;
	     return {x:canvasX, y:canvasY}
	   }
	   canvas.onmousedown = function ( ev ){
	     if (!ev.which) // Use w3c defns in preference to MS
	       switch (ev.button) {
	       case 0: ev.which = 1; break;
	       case 1: 
	       case 4: ev.which = 2; break;
	       case 2: ev.which = 3;
	     }
	     drag = ev.which;
	     var f = mousedown[drag-1];
	     if (f) {
	       var coords = relMouseCoords(ev);
	       f(coords.x, height-coords.y); 
	       ev.preventDefault();
	     }
	   }    
	   canvas.onmouseup = function ( ev ){	
	     drag = 0;
	   }
	   canvas.onmouseout = canvas.onmouseup;
	   canvas.onmousemove = function ( ev ){
	     if ( drag == 0 ) return;
	     var f = mousemove[drag-1];
	     if (f) {
	       var coords = relMouseCoords(ev);
	       f(coords.x, height-coords.y);
	     }
	   }
	   var wheelHandler = function(ev) {
	     var del = 1.1;
	     if (ev.shiftKey) del = 1.01;
	     var ds = ((ev.detail || ev.wheelDelta) > 0) ? del : (1 / del);
	     zoom *= ds;
	     drawScene();
	     ev.preventDefault();
	   };
	   canvas.addEventListener("DOMMouseScroll", wheelHandler, false);
	   canvas.addEventListener("mousewheel", wheelHandler, false);
	}
</script>
<canvas id="rgl_persp3dlmcanvas" width="1" height="1"></canvas> 
<p id="rgl_persp3dlmdebug">
<img src="rgl_persp3dlmsnapshot.png" alt="rgl_persp3dlmsnapshot" width=505/><br>
	You must enable Javascript to view this page properly.</p>
<script>rgl_persp3dlmwebGLStart();</script>



I have obtained the function `persp3d.lm()` I used above from the `persp.lm()` function of the 
`rsm` package by replacing every occurence of a call to the `persp()` function (`graphics` package)  with a call 
to the `persp3d()` function (`rgl` package). 
Thus this example is nothing but a default output whose aesthetics could be greatly improved 
with the possibilites of Adler & Murdoch's `rgl` package. 

