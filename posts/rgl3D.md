---
title: Including an interactive 3D `rgl` graphic in a html report with `knitr`
author: Stéphane Laurent
date : 2012-11-30
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
<!-- ****** points object 144 ****** -->
<script id="rgl_firstexamplevshader144" type="x-shader/x-vertex">
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
<script id="rgl_firstexamplefshader144" type="x-shader/x-fragment"> 
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
<!-- ****** text object 146 ****** -->
<script id="rgl_firstexamplevshader146" type="x-shader/x-vertex">
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
<script id="rgl_firstexamplefshader146" type="x-shader/x-fragment"> 
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
<!-- ****** text object 147 ****** -->
<script id="rgl_firstexamplevshader147" type="x-shader/x-vertex">
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
<script id="rgl_firstexamplefshader147" type="x-shader/x-fragment"> 
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
<!-- ****** text object 148 ****** -->
<script id="rgl_firstexamplevshader148" type="x-shader/x-vertex">
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
<script id="rgl_firstexamplefshader148" type="x-shader/x-fragment"> 
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
<!-- ****** lines object 149 ****** -->
<script id="rgl_firstexamplevshader149" type="x-shader/x-vertex">
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
<script id="rgl_firstexamplefshader149" type="x-shader/x-fragment"> 
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
<!-- ****** text object 150 ****** -->
<script id="rgl_firstexamplevshader150" type="x-shader/x-vertex">
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
<script id="rgl_firstexamplefshader150" type="x-shader/x-fragment"> 
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
<!-- ****** lines object 151 ****** -->
<script id="rgl_firstexamplevshader151" type="x-shader/x-vertex">
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
<script id="rgl_firstexamplefshader151" type="x-shader/x-fragment"> 
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
<!-- ****** text object 152 ****** -->
<script id="rgl_firstexamplevshader152" type="x-shader/x-vertex">
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
<script id="rgl_firstexamplefshader152" type="x-shader/x-fragment"> 
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
<!-- ****** lines object 153 ****** -->
<script id="rgl_firstexamplevshader153" type="x-shader/x-vertex">
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
<script id="rgl_firstexamplefshader153" type="x-shader/x-fragment"> 
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
<!-- ****** text object 154 ****** -->
<script id="rgl_firstexamplevshader154" type="x-shader/x-vertex">
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
<script id="rgl_firstexamplefshader154" type="x-shader/x-fragment"> 
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
<!-- ****** lines object 155 ****** -->
<script id="rgl_firstexamplevshader155" type="x-shader/x-vertex">
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
<script id="rgl_firstexamplefshader155" type="x-shader/x-fragment"> 
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
	   // ****** points object 144 ******
	   var prog144  = gl.createProgram();
	   gl.attachShader(prog144, getShader( gl, "rgl_firstexamplevshader144" ));
	   gl.attachShader(prog144, getShader( gl, "rgl_firstexamplefshader144" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog144, 0, "aPos");
	   gl.bindAttribLocation(prog144, 1, "aCol");
	   gl.linkProgram(prog144);
	   var v=new Float32Array([
	    -3.439237, 0.2711274, -1.520079, 1, 0, 0, 1,
	    -3.206236, -0.4153563, -2.121334, 1, 0.007843138, 0, 1,
	    -2.665827, 1.51304, -1.948757, 1, 0.01176471, 0, 1,
	    -2.637539, -0.9922866, -3.038537, 1, 0.01960784, 0, 1,
	    -2.590663, 0.01203789, -0.3673855, 1, 0.02352941, 0, 1,
	    -2.571744, -0.7185732, -1.10563, 1, 0.03137255, 0, 1,
	    -2.540441, 0.7932593, -1.189789, 1, 0.03529412, 0, 1,
	    -2.525366, 0.363167, -1.91719, 1, 0.04313726, 0, 1,
	    -2.325826, -0.5813717, -1.887729, 1, 0.04705882, 0, 1,
	    -2.282658, -0.1067649, -1.904014, 1, 0.05490196, 0, 1,
	    -2.280401, 0.7969797, -0.2739635, 1, 0.05882353, 0, 1,
	    -2.27544, -0.2381677, -2.421767, 1, 0.06666667, 0, 1,
	    -2.266646, -0.4918917, -1.859322, 1, 0.07058824, 0, 1,
	    -2.256439, -1.247877, -2.772313, 1, 0.07843138, 0, 1,
	    -2.241649, -0.3662403, -1.736092, 1, 0.08235294, 0, 1,
	    -2.206056, 0.7102408, -1.216128, 1, 0.09019608, 0, 1,
	    -2.198634, 1.317259, -1.556973, 1, 0.09411765, 0, 1,
	    -2.194367, -1.126228, -1.763017, 1, 0.1019608, 0, 1,
	    -2.170447, -1.108397, -1.948229, 1, 0.1098039, 0, 1,
	    -2.136108, -0.07264058, -0.4838336, 1, 0.1137255, 0, 1,
	    -2.132225, 1.701464, -0.8690463, 1, 0.1215686, 0, 1,
	    -2.131785, 0.3653997, -2.599101, 1, 0.1254902, 0, 1,
	    -2.115333, 0.6487463, -1.430624, 1, 0.1333333, 0, 1,
	    -2.109523, -0.09302734, -1.080764, 1, 0.1372549, 0, 1,
	    -2.100931, 0.385294, -1.08612, 1, 0.145098, 0, 1,
	    -2.096702, 0.155915, -2.26698, 1, 0.1490196, 0, 1,
	    -2.096662, 1.900992, -2.3216, 1, 0.1568628, 0, 1,
	    -2.088961, 0.8702316, -1.341998, 1, 0.1607843, 0, 1,
	    -2.083112, -0.2195089, -0.6078086, 1, 0.1686275, 0, 1,
	    -2.079481, 0.1301509, -0.2619327, 1, 0.172549, 0, 1,
	    -2.066119, 0.4294426, -1.66767, 1, 0.1803922, 0, 1,
	    -2.047964, 1.08784, -2.993693, 1, 0.1843137, 0, 1,
	    -2.040264, 0.1462236, -2.107834, 1, 0.1921569, 0, 1,
	    -2.012418, -0.9022974, -2.301091, 1, 0.1960784, 0, 1,
	    -2.000639, -0.5552827, -0.1677668, 1, 0.2039216, 0, 1,
	    -1.970432, -1.261165, -1.991611, 1, 0.2117647, 0, 1,
	    -1.959548, 1.807159, -3.203084, 1, 0.2156863, 0, 1,
	    -1.93195, -0.8007633, -1.309824, 1, 0.2235294, 0, 1,
	    -1.930856, -0.3288345, -1.704328, 1, 0.227451, 0, 1,
	    -1.915497, 0.2824212, -1.500563, 1, 0.2352941, 0, 1,
	    -1.904909, -0.3899053, -3.156084, 1, 0.2392157, 0, 1,
	    -1.898946, 2.137561, -0.6997044, 1, 0.2470588, 0, 1,
	    -1.886342, -0.7422522, -3.391623, 1, 0.2509804, 0, 1,
	    -1.876884, 0.06270412, -0.9142321, 1, 0.2588235, 0, 1,
	    -1.837623, -2.14202, -2.757882, 1, 0.2627451, 0, 1,
	    -1.828456, -1.603897, -2.497127, 1, 0.2705882, 0, 1,
	    -1.824562, -0.07753506, -2.563919, 1, 0.2745098, 0, 1,
	    -1.800816, -0.8134686, -2.037793, 1, 0.282353, 0, 1,
	    -1.784422, 1.012977, -1.915673, 1, 0.2862745, 0, 1,
	    -1.778822, 0.3249997, -1.466785, 1, 0.2941177, 0, 1,
	    -1.76158, -0.3543184, -1.47896, 1, 0.3019608, 0, 1,
	    -1.749847, 0.9028661, -1.122726, 1, 0.3058824, 0, 1,
	    -1.719938, 0.4468607, -1.465054, 1, 0.3137255, 0, 1,
	    -1.716529, 1.413669, -0.032482, 1, 0.3176471, 0, 1,
	    -1.716511, 1.262264, -1.733953, 1, 0.3254902, 0, 1,
	    -1.699107, -0.7723961, -1.662738, 1, 0.3294118, 0, 1,
	    -1.690909, -0.03658526, -1.635777, 1, 0.3372549, 0, 1,
	    -1.690508, -1.977231, -1.023767, 1, 0.3411765, 0, 1,
	    -1.650053, 1.085775, -1.432988, 1, 0.3490196, 0, 1,
	    -1.64942, -1.366714, -2.042351, 1, 0.3529412, 0, 1,
	    -1.647941, -0.1262772, -1.386596, 1, 0.3607843, 0, 1,
	    -1.645143, -0.6596389, -1.353981, 1, 0.3647059, 0, 1,
	    -1.633417, -0.9061347, -0.7362403, 1, 0.372549, 0, 1,
	    -1.619117, -0.8356301, -2.191782, 1, 0.3764706, 0, 1,
	    -1.612076, -0.5648081, -2.306336, 1, 0.3843137, 0, 1,
	    -1.573243, -0.8136272, -3.081441, 1, 0.3882353, 0, 1,
	    -1.570663, -0.5678924, -1.698629, 1, 0.3960784, 0, 1,
	    -1.513009, -0.5786512, -2.281797, 1, 0.4039216, 0, 1,
	    -1.512947, 1.433946, -3.052996, 1, 0.4078431, 0, 1,
	    -1.508656, 0.7615912, -1.921479, 1, 0.4156863, 0, 1,
	    -1.50784, 1.024752, -0.2547107, 1, 0.4196078, 0, 1,
	    -1.500906, -0.8438694, -2.109619, 1, 0.427451, 0, 1,
	    -1.496806, 0.2966894, -1.261773, 1, 0.4313726, 0, 1,
	    -1.481464, 0.9418278, -0.7664687, 1, 0.4392157, 0, 1,
	    -1.458396, 1.32041, 0.5388287, 1, 0.4431373, 0, 1,
	    -1.449165, 1.357282, -1.274963, 1, 0.4509804, 0, 1,
	    -1.448793, -1.854323, -1.545263, 1, 0.454902, 0, 1,
	    -1.446734, 1.220649, -1.379556, 1, 0.4627451, 0, 1,
	    -1.444469, 1.944218, -0.1574431, 1, 0.4666667, 0, 1,
	    -1.443194, -0.8252395, -0.05951151, 1, 0.4745098, 0, 1,
	    -1.436146, 1.589696, -2.241077, 1, 0.4784314, 0, 1,
	    -1.419483, -0.5300597, -2.95248, 1, 0.4862745, 0, 1,
	    -1.407027, 1.024799, 0.4040186, 1, 0.4901961, 0, 1,
	    -1.399996, 0.3737429, -0.2753939, 1, 0.4980392, 0, 1,
	    -1.395483, 1.136855, -1.909699, 1, 0.5058824, 0, 1,
	    -1.394968, -0.7851136, -2.190989, 1, 0.509804, 0, 1,
	    -1.390123, 0.2167782, -1.388152, 1, 0.5176471, 0, 1,
	    -1.376476, -0.9603149, -3.75576, 1, 0.5215687, 0, 1,
	    -1.370793, 0.5573066, -1.170098, 1, 0.5294118, 0, 1,
	    -1.360909, 0.7463928, -0.5561173, 1, 0.5333334, 0, 1,
	    -1.360385, 0.1741605, -1.507268, 1, 0.5411765, 0, 1,
	    -1.357048, -0.8471925, -1.14361, 1, 0.5450981, 0, 1,
	    -1.349247, -1.528181, -3.981459, 1, 0.5529412, 0, 1,
	    -1.347705, -1.225368, -3.451518, 1, 0.5568628, 0, 1,
	    -1.34584, -0.6827309, -2.676917, 1, 0.5647059, 0, 1,
	    -1.344016, -1.708135, -2.044548, 1, 0.5686275, 0, 1,
	    -1.307929, 0.2851876, -0.3386376, 1, 0.5764706, 0, 1,
	    -1.297998, -0.9142873, -1.631, 1, 0.5803922, 0, 1,
	    -1.289693, -0.05074325, -1.138119, 1, 0.5882353, 0, 1,
	    -1.289626, 0.9556508, -1.81147, 1, 0.5921569, 0, 1,
	    -1.286072, 1.574915, -0.1606383, 1, 0.6, 0, 1,
	    -1.282999, -0.6091925, -1.561527, 1, 0.6078432, 0, 1,
	    -1.278835, -0.184839, -3.242047, 1, 0.6117647, 0, 1,
	    -1.236659, 0.6556801, -1.433532, 1, 0.6196079, 0, 1,
	    -1.23636, 2.291247, -0.4424681, 1, 0.6235294, 0, 1,
	    -1.231899, 1.194688, -0.868095, 1, 0.6313726, 0, 1,
	    -1.230726, 1.011537, 0.3579266, 1, 0.6352941, 0, 1,
	    -1.179824, 2.179341, -1.691983, 1, 0.6431373, 0, 1,
	    -1.179156, 0.02255073, -1.869334, 1, 0.6470588, 0, 1,
	    -1.175484, 0.6620392, -1.274993, 1, 0.654902, 0, 1,
	    -1.163283, 0.029985, -0.7956027, 1, 0.6588235, 0, 1,
	    -1.16, -0.3319949, -2.550757, 1, 0.6666667, 0, 1,
	    -1.157578, 0.2940909, -1.022493, 1, 0.6705883, 0, 1,
	    -1.153903, -0.2665165, -2.162239, 1, 0.6784314, 0, 1,
	    -1.153591, 0.9194221, -0.5592217, 1, 0.682353, 0, 1,
	    -1.146551, 0.7304307, -1.427167, 1, 0.6901961, 0, 1,
	    -1.137044, -0.2513979, -1.854605, 1, 0.6941177, 0, 1,
	    -1.127545, 1.019325, -0.892283, 1, 0.7019608, 0, 1,
	    -1.127064, 1.324882, -1.455475, 1, 0.7098039, 0, 1,
	    -1.125923, -0.5937948, -1.462052, 1, 0.7137255, 0, 1,
	    -1.115781, 0.1250434, -1.501369, 1, 0.7215686, 0, 1,
	    -1.109962, 0.06175215, -2.375489, 1, 0.7254902, 0, 1,
	    -1.107568, 1.294619, -1.232412, 1, 0.7333333, 0, 1,
	    -1.099706, 0.81833, -0.6511158, 1, 0.7372549, 0, 1,
	    -1.099053, 0.3667868, 0.01647651, 1, 0.7450981, 0, 1,
	    -1.095105, 0.7265093, -0.1410721, 1, 0.7490196, 0, 1,
	    -1.089885, 0.2480252, 0.1995743, 1, 0.7568628, 0, 1,
	    -1.088997, 1.383291, 0.1399816, 1, 0.7607843, 0, 1,
	    -1.088584, -1.326814, -1.740029, 1, 0.7686275, 0, 1,
	    -1.081729, -0.2222989, -0.8195469, 1, 0.772549, 0, 1,
	    -1.078871, 1.266293, 0.2969978, 1, 0.7803922, 0, 1,
	    -1.078042, 0.8261623, 0.03339239, 1, 0.7843137, 0, 1,
	    -1.06196, 2.091232, -0.09475096, 1, 0.7921569, 0, 1,
	    -1.057877, 1.354066, 0.2375269, 1, 0.7960784, 0, 1,
	    -1.055016, 0.5296134, 1.540293, 1, 0.8039216, 0, 1,
	    -1.048934, -0.9102977, -2.066821, 1, 0.8117647, 0, 1,
	    -1.026786, -0.3498438, -1.690741, 1, 0.8156863, 0, 1,
	    -1.026445, -1.961492, -2.656854, 1, 0.8235294, 0, 1,
	    -1.026232, 0.6549458, -0.5213971, 1, 0.827451, 0, 1,
	    -1.025834, -0.5435192, -3.061569, 1, 0.8352941, 0, 1,
	    -1.020212, -1.268744, -2.990394, 1, 0.8392157, 0, 1,
	    -1.018934, 1.689389, -0.9871027, 1, 0.8470588, 0, 1,
	    -1.017919, -0.7501122, -2.79053, 1, 0.8509804, 0, 1,
	    -1.015377, 0.9191466, -2.652308, 1, 0.8588235, 0, 1,
	    -1.014462, 0.7203363, -2.133869, 1, 0.8627451, 0, 1,
	    -1.001132, 0.1796523, -3.69162, 1, 0.8705882, 0, 1,
	    -1.000257, -0.06778105, -2.086008, 1, 0.8745098, 0, 1,
	    -0.988459, -0.8052317, -2.779189, 1, 0.8823529, 0, 1,
	    -0.987129, -0.5979364, -1.437402, 1, 0.8862745, 0, 1,
	    -0.9822586, -0.8535075, -0.8806738, 1, 0.8941177, 0, 1,
	    -0.9692091, -0.912339, -3.547506, 1, 0.8980392, 0, 1,
	    -0.9679166, 0.2249264, 0.991001, 1, 0.9058824, 0, 1,
	    -0.9598315, -0.3676224, -4.05356, 1, 0.9137255, 0, 1,
	    -0.951481, -0.1136225, -1.703789, 1, 0.9176471, 0, 1,
	    -0.9501778, -0.4194707, -2.148825, 1, 0.9254902, 0, 1,
	    -0.9471753, -0.429537, -1.075024, 1, 0.9294118, 0, 1,
	    -0.9465261, -1.27952, -1.394034, 1, 0.9372549, 0, 1,
	    -0.9458594, 0.5628059, 0.7467222, 1, 0.9411765, 0, 1,
	    -0.9457579, 1.099866, -1.092585, 1, 0.9490196, 0, 1,
	    -0.9349063, 0.1253369, -1.073915, 1, 0.9529412, 0, 1,
	    -0.9336551, -0.5330892, -2.322097, 1, 0.9607843, 0, 1,
	    -0.9327331, -0.5352721, 0.5830767, 1, 0.9647059, 0, 1,
	    -0.9264568, 2.258314, -0.193232, 1, 0.972549, 0, 1,
	    -0.9241394, 1.405681, 1.653424, 1, 0.9764706, 0, 1,
	    -0.9223562, -0.02718963, -2.522606, 1, 0.9843137, 0, 1,
	    -0.9209464, -0.2393257, -2.813426, 1, 0.9882353, 0, 1,
	    -0.9205436, -0.205098, -1.719034, 1, 0.9960784, 0, 1,
	    -0.9172843, 0.06747916, -1.501601, 0.9960784, 1, 0, 1,
	    -0.9163968, 1.427995, -0.3636987, 0.9921569, 1, 0, 1,
	    -0.9155833, -0.9586136, 0.1207937, 0.9843137, 1, 0, 1,
	    -0.9071853, -0.03813681, -1.731114, 0.9803922, 1, 0, 1,
	    -0.9061579, 0.4317231, 0.5589753, 0.972549, 1, 0, 1,
	    -0.900173, -0.6660997, -0.827444, 0.9686275, 1, 0, 1,
	    -0.8994494, -1.369353, -2.222406, 0.9607843, 1, 0, 1,
	    -0.8977739, -0.891423, -0.956976, 0.9568627, 1, 0, 1,
	    -0.8929619, 0.99152, 0.3401158, 0.9490196, 1, 0, 1,
	    -0.8882685, -0.4528769, -0.91251, 0.945098, 1, 0, 1,
	    -0.885932, -0.7587649, -2.653943, 0.9372549, 1, 0, 1,
	    -0.8858074, -0.1982889, -0.2844272, 0.9333333, 1, 0, 1,
	    -0.8855013, -1.58218, -2.191286, 0.9254902, 1, 0, 1,
	    -0.8848827, -1.018, -0.9222086, 0.9215686, 1, 0, 1,
	    -0.8759185, 0.8438377, -0.6588779, 0.9137255, 1, 0, 1,
	    -0.8744763, -0.07271603, -1.976372, 0.9098039, 1, 0, 1,
	    -0.8696659, 1.310278, -0.3972895, 0.9019608, 1, 0, 1,
	    -0.8682067, -0.664161, -0.6454861, 0.8941177, 1, 0, 1,
	    -0.8579338, 0.9551221, -1.48714, 0.8901961, 1, 0, 1,
	    -0.8528002, -2.243589, -3.528438, 0.8823529, 1, 0, 1,
	    -0.8519475, -0.1826425, -1.340007, 0.8784314, 1, 0, 1,
	    -0.8519426, -0.9075401, -2.0664, 0.8705882, 1, 0, 1,
	    -0.8461776, 0.9904638, 0.02922376, 0.8666667, 1, 0, 1,
	    -0.8343233, 0.3338066, -2.21364, 0.8588235, 1, 0, 1,
	    -0.8335678, 1.999524, -0.1833737, 0.854902, 1, 0, 1,
	    -0.8234026, -1.643681, -3.130037, 0.8470588, 1, 0, 1,
	    -0.8192814, -0.7712178, -1.928674, 0.8431373, 1, 0, 1,
	    -0.8153076, 1.13896, -1.450048, 0.8352941, 1, 0, 1,
	    -0.8130023, -0.9399616, -4.602041, 0.8313726, 1, 0, 1,
	    -0.8114289, -0.9343152, -2.189769, 0.8235294, 1, 0, 1,
	    -0.8057805, 1.046375, 0.5747897, 0.8196079, 1, 0, 1,
	    -0.8036343, 0.3620064, 0.8152114, 0.8117647, 1, 0, 1,
	    -0.8025682, -0.6635403, -2.11239, 0.8078431, 1, 0, 1,
	    -0.7984093, 1.28323, -2.092625, 0.8, 1, 0, 1,
	    -0.7980803, 0.2143542, -0.2971397, 0.7921569, 1, 0, 1,
	    -0.79755, 1.047929, -1.587095, 0.7882353, 1, 0, 1,
	    -0.7960356, -0.04369169, -1.853242, 0.7803922, 1, 0, 1,
	    -0.7940542, -0.1694349, -2.057994, 0.7764706, 1, 0, 1,
	    -0.7849665, -0.1351715, -1.948398, 0.7686275, 1, 0, 1,
	    -0.7829697, 0.7919741, -0.430826, 0.7647059, 1, 0, 1,
	    -0.7806009, 1.200275, 0.03370525, 0.7568628, 1, 0, 1,
	    -0.7796172, -0.711185, -4.104809, 0.7529412, 1, 0, 1,
	    -0.7789577, 0.5291482, -1.748454, 0.7450981, 1, 0, 1,
	    -0.7745131, 1.7445, -0.7872822, 0.7411765, 1, 0, 1,
	    -0.773228, -0.01411633, -0.1581025, 0.7333333, 1, 0, 1,
	    -0.7726606, 0.1724211, -0.1212131, 0.7294118, 1, 0, 1,
	    -0.7686643, -0.4565521, -3.372906, 0.7215686, 1, 0, 1,
	    -0.767233, 0.8279564, -1.673618, 0.7176471, 1, 0, 1,
	    -0.7660335, 1.682498, 0.2886866, 0.7098039, 1, 0, 1,
	    -0.7636938, -0.5118821, -1.385952, 0.7058824, 1, 0, 1,
	    -0.7625873, 0.7736607, 1.074901, 0.6980392, 1, 0, 1,
	    -0.7590449, -1.078348, -2.083961, 0.6901961, 1, 0, 1,
	    -0.754976, 0.2423167, -0.8798149, 0.6862745, 1, 0, 1,
	    -0.7527388, -2.274912, -3.840396, 0.6784314, 1, 0, 1,
	    -0.7502079, -1.540151, -1.682603, 0.6745098, 1, 0, 1,
	    -0.7496534, 0.4385726, -0.9369025, 0.6666667, 1, 0, 1,
	    -0.7430122, 0.03304889, 0.1331057, 0.6627451, 1, 0, 1,
	    -0.7331477, 0.4565634, -2.781866, 0.654902, 1, 0, 1,
	    -0.7236254, 0.5217569, -1.338114, 0.6509804, 1, 0, 1,
	    -0.7197934, -1.338688, -3.781952, 0.6431373, 1, 0, 1,
	    -0.7178702, -0.4639464, -1.846507, 0.6392157, 1, 0, 1,
	    -0.7173188, -0.7280274, -2.939692, 0.6313726, 1, 0, 1,
	    -0.7133062, 0.1115655, -1.58157, 0.627451, 1, 0, 1,
	    -0.7044574, 0.5094212, -2.189405, 0.6196079, 1, 0, 1,
	    -0.7029689, 2.460467, 1.204609, 0.6156863, 1, 0, 1,
	    -0.6992834, 0.5722095, -0.2576665, 0.6078432, 1, 0, 1,
	    -0.6968094, 0.5610648, -0.8675276, 0.6039216, 1, 0, 1,
	    -0.6942088, 1.609679, -1.119908, 0.5960785, 1, 0, 1,
	    -0.6940626, -0.3889995, -2.170416, 0.5882353, 1, 0, 1,
	    -0.6938066, 0.4790145, -1.836031, 0.5843138, 1, 0, 1,
	    -0.6933279, -1.016798, -2.473747, 0.5764706, 1, 0, 1,
	    -0.6929457, -0.8258305, -2.100599, 0.572549, 1, 0, 1,
	    -0.6911801, -1.372644, -3.623977, 0.5647059, 1, 0, 1,
	    -0.6831329, 0.4161404, -0.8227046, 0.5607843, 1, 0, 1,
	    -0.680346, -0.2750589, -2.875644, 0.5529412, 1, 0, 1,
	    -0.6724993, -0.7844545, -4.346917, 0.5490196, 1, 0, 1,
	    -0.6644946, -0.8311568, -2.323399, 0.5411765, 1, 0, 1,
	    -0.6641175, -0.1439283, -0.8023513, 0.5372549, 1, 0, 1,
	    -0.6601106, -1.139287, -2.449559, 0.5294118, 1, 0, 1,
	    -0.6593812, 0.1452333, -2.122353, 0.5254902, 1, 0, 1,
	    -0.6593211, -0.3057126, -2.875592, 0.5176471, 1, 0, 1,
	    -0.6572232, -0.2477099, -0.6997132, 0.5137255, 1, 0, 1,
	    -0.6541862, 0.1453053, -0.6287177, 0.5058824, 1, 0, 1,
	    -0.6517059, 0.5808637, -3.298657, 0.5019608, 1, 0, 1,
	    -0.6509017, 0.5103448, 0.6200154, 0.4941176, 1, 0, 1,
	    -0.6508065, 1.234494, -0.6014184, 0.4862745, 1, 0, 1,
	    -0.6496745, -0.2601503, -1.645473, 0.4823529, 1, 0, 1,
	    -0.6472458, -0.8125403, -1.751475, 0.4745098, 1, 0, 1,
	    -0.6467922, 1.309702, -0.2696588, 0.4705882, 1, 0, 1,
	    -0.6465285, 0.1338888, -1.269877, 0.4627451, 1, 0, 1,
	    -0.6408786, -0.4313501, -2.957704, 0.4588235, 1, 0, 1,
	    -0.6397656, -1.036504, -1.947599, 0.4509804, 1, 0, 1,
	    -0.6316546, -1.373607, -3.015239, 0.4470588, 1, 0, 1,
	    -0.6312481, 1.070553, -1.720258, 0.4392157, 1, 0, 1,
	    -0.6278054, -0.06904303, -2.400601, 0.4352941, 1, 0, 1,
	    -0.6202415, -0.301192, -1.940879, 0.427451, 1, 0, 1,
	    -0.6200731, 0.9053699, -0.4806333, 0.4235294, 1, 0, 1,
	    -0.6152798, -0.6705809, -1.853225, 0.4156863, 1, 0, 1,
	    -0.6127745, -1.953152, -3.03406, 0.4117647, 1, 0, 1,
	    -0.6114824, 0.4258384, -1.233862, 0.4039216, 1, 0, 1,
	    -0.6045041, -0.526201, -3.29199, 0.3960784, 1, 0, 1,
	    -0.5953182, -0.6994936, -2.923985, 0.3921569, 1, 0, 1,
	    -0.5818321, -0.4132627, -2.45145, 0.3843137, 1, 0, 1,
	    -0.5731924, 1.547155, -0.3563139, 0.3803922, 1, 0, 1,
	    -0.5726836, 1.883506, 0.001355096, 0.372549, 1, 0, 1,
	    -0.5635326, -0.6408663, -2.559429, 0.3686275, 1, 0, 1,
	    -0.5595711, 0.7696527, -0.2216123, 0.3607843, 1, 0, 1,
	    -0.5567251, -0.326719, -0.9656881, 0.3568628, 1, 0, 1,
	    -0.5521079, 0.162508, -2.268301, 0.3490196, 1, 0, 1,
	    -0.5464898, -0.6174038, -1.723651, 0.345098, 1, 0, 1,
	    -0.5450719, 0.5945706, -0.1582464, 0.3372549, 1, 0, 1,
	    -0.5403068, 0.8845094, -0.594206, 0.3333333, 1, 0, 1,
	    -0.539945, 0.5165208, -0.4596631, 0.3254902, 1, 0, 1,
	    -0.5389065, -0.558069, -2.251323, 0.3215686, 1, 0, 1,
	    -0.5335008, 1.247507, -0.5154596, 0.3137255, 1, 0, 1,
	    -0.5316238, -1.47986, -3.241721, 0.3098039, 1, 0, 1,
	    -0.5279234, 0.8266756, 0.1427819, 0.3019608, 1, 0, 1,
	    -0.5271143, 0.5202026, -0.2998294, 0.2941177, 1, 0, 1,
	    -0.5249211, 0.1193193, -0.5977154, 0.2901961, 1, 0, 1,
	    -0.5247878, 0.8452856, -1.769192, 0.282353, 1, 0, 1,
	    -0.5209799, -0.6834795, -2.00833, 0.2784314, 1, 0, 1,
	    -0.5203377, 0.04568103, -1.240975, 0.2705882, 1, 0, 1,
	    -0.5124621, 1.152049, -0.6745718, 0.2666667, 1, 0, 1,
	    -0.510583, -2.378835, -3.006568, 0.2588235, 1, 0, 1,
	    -0.5098193, 0.1945202, -2.074395, 0.254902, 1, 0, 1,
	    -0.5069974, 0.2744667, -2.164027, 0.2470588, 1, 0, 1,
	    -0.5068315, -0.7504784, -3.039313, 0.2431373, 1, 0, 1,
	    -0.5038211, -1.023826, -2.93848, 0.2352941, 1, 0, 1,
	    -0.5021117, -0.6564799, -3.356098, 0.2313726, 1, 0, 1,
	    -0.4996293, 0.3590451, -1.497637, 0.2235294, 1, 0, 1,
	    -0.4951496, 1.230513, -1.814445, 0.2196078, 1, 0, 1,
	    -0.4945417, -0.7714672, -3.409981, 0.2117647, 1, 0, 1,
	    -0.4933667, 0.140074, -1.955503, 0.2078431, 1, 0, 1,
	    -0.4929328, -1.290935, -2.455766, 0.2, 1, 0, 1,
	    -0.4925615, -0.009747704, 0.7292585, 0.1921569, 1, 0, 1,
	    -0.4900823, -0.8085619, -0.2393525, 0.1882353, 1, 0, 1,
	    -0.4888159, 1.20734, -0.1302511, 0.1803922, 1, 0, 1,
	    -0.4858248, -1.551138, -2.707076, 0.1764706, 1, 0, 1,
	    -0.4849096, 1.312748, 0.5653054, 0.1686275, 1, 0, 1,
	    -0.4806012, 0.4676223, 1.293159, 0.1647059, 1, 0, 1,
	    -0.4737742, -0.3337814, -3.384098, 0.1568628, 1, 0, 1,
	    -0.4701366, 2.876631, -1.598775, 0.1529412, 1, 0, 1,
	    -0.468765, -0.6227511, -4.74199, 0.145098, 1, 0, 1,
	    -0.4606187, 0.2437679, -1.354769, 0.1411765, 1, 0, 1,
	    -0.4592679, 1.238485, -1.021138, 0.1333333, 1, 0, 1,
	    -0.4517701, 1.425002, 0.2929957, 0.1294118, 1, 0, 1,
	    -0.4454585, -1.429946, -1.941134, 0.1215686, 1, 0, 1,
	    -0.4417425, 0.9143559, -0.9459293, 0.1176471, 1, 0, 1,
	    -0.4415019, -0.3543628, -4.133867, 0.1098039, 1, 0, 1,
	    -0.4380769, 2.033551, 0.05487085, 0.1058824, 1, 0, 1,
	    -0.436037, -0.4039051, -2.025292, 0.09803922, 1, 0, 1,
	    -0.4310472, -0.4782071, -1.47271, 0.09019608, 1, 0, 1,
	    -0.4294055, 0.3912542, -1.095147, 0.08627451, 1, 0, 1,
	    -0.4279606, 0.6736681, -1.423745, 0.07843138, 1, 0, 1,
	    -0.4265862, -0.11455, -2.068792, 0.07450981, 1, 0, 1,
	    -0.4260053, 0.3980548, -0.975577, 0.06666667, 1, 0, 1,
	    -0.4251196, 1.089877, -0.4873852, 0.0627451, 1, 0, 1,
	    -0.4249142, 1.83696, -0.4151307, 0.05490196, 1, 0, 1,
	    -0.4234226, -1.223096, -1.825746, 0.05098039, 1, 0, 1,
	    -0.4187773, 0.3655789, -0.6778821, 0.04313726, 1, 0, 1,
	    -0.4180728, -0.07153977, -1.691313, 0.03921569, 1, 0, 1,
	    -0.4178435, 0.5525677, 0.1117463, 0.03137255, 1, 0, 1,
	    -0.4109067, 0.6497577, -1.55672, 0.02745098, 1, 0, 1,
	    -0.4044809, -1.000104, -1.357355, 0.01960784, 1, 0, 1,
	    -0.4022726, 0.1093886, -0.4514959, 0.01568628, 1, 0, 1,
	    -0.3978269, 0.3939687, 0.06273126, 0.007843138, 1, 0, 1,
	    -0.3953344, 0.9864478, -1.180422, 0.003921569, 1, 0, 1,
	    -0.3953149, -1.384052, -5.869993, 0, 1, 0.003921569, 1,
	    -0.3940274, 0.6475883, -0.9781455, 0, 1, 0.01176471, 1,
	    -0.3863567, -0.1316534, -2.038685, 0, 1, 0.01568628, 1,
	    -0.3856796, -1.009813, -2.340917, 0, 1, 0.02352941, 1,
	    -0.3850733, 0.06388987, -1.965019, 0, 1, 0.02745098, 1,
	    -0.3811869, 1.131143, 1.190297, 0, 1, 0.03529412, 1,
	    -0.3802513, 0.3509784, -1.94081, 0, 1, 0.03921569, 1,
	    -0.3739479, -0.08129838, -1.123562, 0, 1, 0.04705882, 1,
	    -0.3729458, 1.302842, 0.3470764, 0, 1, 0.05098039, 1,
	    -0.3723226, -0.7305502, -3.783909, 0, 1, 0.05882353, 1,
	    -0.3689606, 0.6723679, -1.379107, 0, 1, 0.0627451, 1,
	    -0.3665332, 1.137379, -1.236908, 0, 1, 0.07058824, 1,
	    -0.3605891, -0.1359861, -1.83211, 0, 1, 0.07450981, 1,
	    -0.3597504, 0.2131711, 1.344229, 0, 1, 0.08235294, 1,
	    -0.3579492, -1.689009, -3.262735, 0, 1, 0.08627451, 1,
	    -0.3554109, -2.161235, -1.631079, 0, 1, 0.09411765, 1,
	    -0.3512037, -0.6900164, -2.920442, 0, 1, 0.1019608, 1,
	    -0.347374, 0.8819303, 0.5072608, 0, 1, 0.1058824, 1,
	    -0.3461074, 1.053293, -1.027768, 0, 1, 0.1137255, 1,
	    -0.3442415, 0.4944685, 0.4062047, 0, 1, 0.1176471, 1,
	    -0.3411555, 0.3098267, -1.130428, 0, 1, 0.1254902, 1,
	    -0.3355187, -0.8074915, -2.008558, 0, 1, 0.1294118, 1,
	    -0.3353137, -1.398803, -3.34772, 0, 1, 0.1372549, 1,
	    -0.3351922, -0.9522019, -3.114193, 0, 1, 0.1411765, 1,
	    -0.3343201, 2.040551, -1.097261, 0, 1, 0.1490196, 1,
	    -0.3318117, -2.261468, -3.317412, 0, 1, 0.1529412, 1,
	    -0.329858, 1.295546, -1.658285, 0, 1, 0.1607843, 1,
	    -0.328572, 0.7257955, -0.7584711, 0, 1, 0.1647059, 1,
	    -0.3193077, -0.5908337, -2.110657, 0, 1, 0.172549, 1,
	    -0.3171057, 0.6592371, -1.809744, 0, 1, 0.1764706, 1,
	    -0.3134131, 1.023664, -0.2897712, 0, 1, 0.1843137, 1,
	    -0.3080949, 0.1090493, -0.9151868, 0, 1, 0.1882353, 1,
	    -0.3078938, -0.5775928, -3.12338, 0, 1, 0.1960784, 1,
	    -0.3076831, -1.566793, -4.070867, 0, 1, 0.2039216, 1,
	    -0.3035757, 0.4737056, -0.4471581, 0, 1, 0.2078431, 1,
	    -0.3027795, 0.6217018, 0.3776689, 0, 1, 0.2156863, 1,
	    -0.3009532, -1.571682, -1.950726, 0, 1, 0.2196078, 1,
	    -0.2991239, 0.4849664, -1.908157, 0, 1, 0.227451, 1,
	    -0.2956458, -0.9893402, -3.491418, 0, 1, 0.2313726, 1,
	    -0.2951863, 0.7178452, -1.455412, 0, 1, 0.2392157, 1,
	    -0.2936295, 0.1123204, -1.764553, 0, 1, 0.2431373, 1,
	    -0.2884283, -0.4869022, -0.9861674, 0, 1, 0.2509804, 1,
	    -0.2845966, 2.496505, -0.4961019, 0, 1, 0.254902, 1,
	    -0.2845406, 1.114408, 1.743497, 0, 1, 0.2627451, 1,
	    -0.2844649, -0.7477829, -0.7319383, 0, 1, 0.2666667, 1,
	    -0.2769212, -0.4064994, -1.569785, 0, 1, 0.2745098, 1,
	    -0.2755241, -0.6652068, -3.230377, 0, 1, 0.2784314, 1,
	    -0.273978, -1.563354, -6.725246, 0, 1, 0.2862745, 1,
	    -0.271771, 1.020742, -0.6605464, 0, 1, 0.2901961, 1,
	    -0.265234, 1.218592, 1.801917, 0, 1, 0.2980392, 1,
	    -0.2650079, -0.5980701, -2.309311, 0, 1, 0.3058824, 1,
	    -0.2582076, 1.378692, 0.1190734, 0, 1, 0.3098039, 1,
	    -0.2519873, 0.4049613, 1.116918, 0, 1, 0.3176471, 1,
	    -0.2516729, -0.6738554, -1.805638, 0, 1, 0.3215686, 1,
	    -0.2509703, -1.001957, -3.445804, 0, 1, 0.3294118, 1,
	    -0.2450711, -0.5574074, -3.082174, 0, 1, 0.3333333, 1,
	    -0.2435439, 0.2372752, 1.468896, 0, 1, 0.3411765, 1,
	    -0.243374, -0.5124989, -1.982209, 0, 1, 0.345098, 1,
	    -0.2422544, -1.95664, -3.874309, 0, 1, 0.3529412, 1,
	    -0.2294434, 0.9589133, -0.7798747, 0, 1, 0.3568628, 1,
	    -0.2288243, -0.0895763, -2.725025, 0, 1, 0.3647059, 1,
	    -0.2286344, 1.632846, 0.7709978, 0, 1, 0.3686275, 1,
	    -0.2258977, 0.303994, 0.2603834, 0, 1, 0.3764706, 1,
	    -0.2248413, -0.5217233, -1.693983, 0, 1, 0.3803922, 1,
	    -0.2246349, -1.343685, -1.724988, 0, 1, 0.3882353, 1,
	    -0.2198953, -0.131533, -0.8634257, 0, 1, 0.3921569, 1,
	    -0.218233, 1.81718, 0.3126566, 0, 1, 0.4, 1,
	    -0.211338, 2.86763, 1.816013, 0, 1, 0.4078431, 1,
	    -0.2106038, 1.538775, 0.08409576, 0, 1, 0.4117647, 1,
	    -0.210054, -0.6282064, -2.897029, 0, 1, 0.4196078, 1,
	    -0.208999, 1.056373, -0.7248628, 0, 1, 0.4235294, 1,
	    -0.2084574, 0.4251945, -0.2452099, 0, 1, 0.4313726, 1,
	    -0.2078242, 1.084562, -0.681498, 0, 1, 0.4352941, 1,
	    -0.207544, -0.7441506, -2.540735, 0, 1, 0.4431373, 1,
	    -0.2072929, -3.098661, -3.815221, 0, 1, 0.4470588, 1,
	    -0.2072106, -0.6527928, -4.231521, 0, 1, 0.454902, 1,
	    -0.2055214, 0.3647298, -0.7411028, 0, 1, 0.4588235, 1,
	    -0.1996802, -2.598816, -2.821101, 0, 1, 0.4666667, 1,
	    -0.1971156, 0.2450786, -1.29154, 0, 1, 0.4705882, 1,
	    -0.1941384, -1.129454, -2.084065, 0, 1, 0.4784314, 1,
	    -0.1914537, 1.25557, -0.6531758, 0, 1, 0.4823529, 1,
	    -0.1846502, -2.137918, -2.318744, 0, 1, 0.4901961, 1,
	    -0.1752364, -1.461606, -1.338787, 0, 1, 0.4941176, 1,
	    -0.173777, 0.2869407, 0.1943072, 0, 1, 0.5019608, 1,
	    -0.1729431, 1.32088, -0.1371325, 0, 1, 0.509804, 1,
	    -0.1726206, -0.2860269, -2.191756, 0, 1, 0.5137255, 1,
	    -0.1724399, 0.00357365, -0.8283143, 0, 1, 0.5215687, 1,
	    -0.1716035, -1.010369, -4.259968, 0, 1, 0.5254902, 1,
	    -0.1575836, -2.481441, -3.073121, 0, 1, 0.5333334, 1,
	    -0.1513265, -0.1503067, -3.29125, 0, 1, 0.5372549, 1,
	    -0.1446703, 1.626132, 1.163351, 0, 1, 0.5450981, 1,
	    -0.1389125, -1.341284, -2.368075, 0, 1, 0.5490196, 1,
	    -0.1346629, -0.6736208, -4.484055, 0, 1, 0.5568628, 1,
	    -0.1331266, 0.409342, -0.7627699, 0, 1, 0.5607843, 1,
	    -0.1326571, -0.2907887, -2.439256, 0, 1, 0.5686275, 1,
	    -0.1314489, -1.355671, -4.103764, 0, 1, 0.572549, 1,
	    -0.1288418, 0.09957455, -0.5573116, 0, 1, 0.5803922, 1,
	    -0.1255898, -0.3737685, -2.962241, 0, 1, 0.5843138, 1,
	    -0.1253919, 0.2706341, -1.538427, 0, 1, 0.5921569, 1,
	    -0.1246889, -0.09022056, -0.2619569, 0, 1, 0.5960785, 1,
	    -0.1237121, 0.8053398, 0.8121115, 0, 1, 0.6039216, 1,
	    -0.1227771, 0.02362036, -2.316197, 0, 1, 0.6117647, 1,
	    -0.1206855, -0.892796, -4.070753, 0, 1, 0.6156863, 1,
	    -0.1187236, -0.8867482, -3.181901, 0, 1, 0.6235294, 1,
	    -0.1187175, -0.5280197, -3.109, 0, 1, 0.627451, 1,
	    -0.117474, 1.802408, 0.5459402, 0, 1, 0.6352941, 1,
	    -0.1146642, -1.601079, -2.994155, 0, 1, 0.6392157, 1,
	    -0.1119598, 1.115294, -0.2548418, 0, 1, 0.6470588, 1,
	    -0.1117938, -0.3965479, -3.603005, 0, 1, 0.6509804, 1,
	    -0.1097461, 1.049929, 0.1554748, 0, 1, 0.6588235, 1,
	    -0.1066971, -0.8233841, -1.723751, 0, 1, 0.6627451, 1,
	    -0.1047966, -0.6717824, -3.372177, 0, 1, 0.6705883, 1,
	    -0.1036945, 0.7183809, -0.04304224, 0, 1, 0.6745098, 1,
	    -0.1016747, 0.8397092, -0.3891153, 0, 1, 0.682353, 1,
	    -0.1014373, -0.009246591, -3.777029, 0, 1, 0.6862745, 1,
	    -0.09872858, 0.8243502, 0.5838851, 0, 1, 0.6941177, 1,
	    -0.0983318, -1.172141, -3.362189, 0, 1, 0.7019608, 1,
	    -0.09611159, -0.1178966, -2.636575, 0, 1, 0.7058824, 1,
	    -0.09015654, 2.059623, -1.811634, 0, 1, 0.7137255, 1,
	    -0.08923089, -1.518635, -2.979003, 0, 1, 0.7176471, 1,
	    -0.08583695, -0.655725, -2.021879, 0, 1, 0.7254902, 1,
	    -0.08406299, -1.190266, -3.700669, 0, 1, 0.7294118, 1,
	    -0.08144437, 1.31845, -1.805127, 0, 1, 0.7372549, 1,
	    -0.08077253, 1.391362, 0.08620559, 0, 1, 0.7411765, 1,
	    -0.07905957, -1.096817, -3.095005, 0, 1, 0.7490196, 1,
	    -0.07151319, -0.7280836, -3.662534, 0, 1, 0.7529412, 1,
	    -0.06707044, -1.126682, -2.896655, 0, 1, 0.7607843, 1,
	    -0.06618659, -1.334759, -4.284611, 0, 1, 0.7647059, 1,
	    -0.06617811, 0.3772593, 0.7386479, 0, 1, 0.772549, 1,
	    -0.05740352, -0.6213874, -3.491878, 0, 1, 0.7764706, 1,
	    -0.05662267, -1.549276, -4.364123, 0, 1, 0.7843137, 1,
	    -0.05592857, 1.562684, 0.1648143, 0, 1, 0.7882353, 1,
	    -0.05587737, -0.9641447, -3.920557, 0, 1, 0.7960784, 1,
	    -0.05576835, 0.3681847, -1.305839, 0, 1, 0.8039216, 1,
	    -0.05484602, 0.4823916, 2.40042, 0, 1, 0.8078431, 1,
	    -0.0540935, -1.73947, -3.900349, 0, 1, 0.8156863, 1,
	    -0.05195355, -0.7465498, -3.554649, 0, 1, 0.8196079, 1,
	    -0.05138608, 0.02961975, -1.376508, 0, 1, 0.827451, 1,
	    -0.04765123, 0.1026734, 0.03383587, 0, 1, 0.8313726, 1,
	    -0.04408952, -0.706095, -4.322484, 0, 1, 0.8392157, 1,
	    -0.0425788, 0.1734453, 0.4352256, 0, 1, 0.8431373, 1,
	    -0.04151057, 0.6589704, -1.568113, 0, 1, 0.8509804, 1,
	    -0.03713486, 0.1247544, -2.427921, 0, 1, 0.854902, 1,
	    -0.03515171, 0.1612953, -0.2483189, 0, 1, 0.8627451, 1,
	    -0.03398276, 1.44577, 0.7492964, 0, 1, 0.8666667, 1,
	    -0.03382453, -0.1728318, -3.28859, 0, 1, 0.8745098, 1,
	    -0.03304211, -1.221436, -3.130533, 0, 1, 0.8784314, 1,
	    -0.03254259, -0.1435126, -3.201415, 0, 1, 0.8862745, 1,
	    -0.03161282, -1.663793, -3.272642, 0, 1, 0.8901961, 1,
	    -0.02921136, 0.1506652, 1.758185, 0, 1, 0.8980392, 1,
	    -0.02557315, -0.21583, -3.938908, 0, 1, 0.9058824, 1,
	    -0.02301784, 0.4970179, -1.000375, 0, 1, 0.9098039, 1,
	    -0.02155492, 0.4732131, 0.3445622, 0, 1, 0.9176471, 1,
	    -0.01979703, -0.3972846, -1.353672, 0, 1, 0.9215686, 1,
	    -0.01477988, -1.698617, -1.373783, 0, 1, 0.9294118, 1,
	    -0.005208342, 0.1342884, -0.03286766, 0, 1, 0.9333333, 1,
	    -0.003549339, -1.532775, -1.980636, 0, 1, 0.9411765, 1,
	    -0.002520324, -0.1155573, -2.727988, 0, 1, 0.945098, 1,
	    -0.001809148, -1.358508, -2.176188, 0, 1, 0.9529412, 1,
	    0.001440705, 2.454185, 0.7483207, 0, 1, 0.9568627, 1,
	    0.00322365, -0.5613322, 3.068927, 0, 1, 0.9647059, 1,
	    0.005702289, -0.324491, 3.922538, 0, 1, 0.9686275, 1,
	    0.009896233, -1.447939, 4.394744, 0, 1, 0.9764706, 1,
	    0.01142604, -1.235774, 2.593652, 0, 1, 0.9803922, 1,
	    0.01162645, 0.8368531, 0.8743499, 0, 1, 0.9882353, 1,
	    0.01347461, -0.1410933, 3.542675, 0, 1, 0.9921569, 1,
	    0.01615282, -1.57239, 3.416768, 0, 1, 1, 1,
	    0.02741972, -0.6420859, 3.965959, 0, 0.9921569, 1, 1,
	    0.03451474, -0.4273447, 3.902523, 0, 0.9882353, 1, 1,
	    0.04066531, 0.8966165, -0.3536833, 0, 0.9803922, 1, 1,
	    0.04669762, -0.3545426, 2.796695, 0, 0.9764706, 1, 1,
	    0.047909, 0.8212307, -2.002738, 0, 0.9686275, 1, 1,
	    0.04960947, 0.02287202, 1.221338, 0, 0.9647059, 1, 1,
	    0.05271163, 1.008919, 0.7811347, 0, 0.9568627, 1, 1,
	    0.05774723, -0.1060523, 2.694649, 0, 0.9529412, 1, 1,
	    0.05783962, 0.8263773, -2.267848, 0, 0.945098, 1, 1,
	    0.05829456, 1.564484, -2.114812, 0, 0.9411765, 1, 1,
	    0.06169068, -0.4019553, 3.864509, 0, 0.9333333, 1, 1,
	    0.06955333, 0.01193838, 1.547284, 0, 0.9294118, 1, 1,
	    0.07151135, 0.6837569, -0.896435, 0, 0.9215686, 1, 1,
	    0.07449907, 0.65725, 0.6172968, 0, 0.9176471, 1, 1,
	    0.07638052, -0.5832748, 3.471486, 0, 0.9098039, 1, 1,
	    0.07804172, 1.955672, -0.02666317, 0, 0.9058824, 1, 1,
	    0.07946929, 0.2599719, 0.7950355, 0, 0.8980392, 1, 1,
	    0.08395205, -0.2709278, 3.201564, 0, 0.8901961, 1, 1,
	    0.08873124, -0.04239434, 3.608451, 0, 0.8862745, 1, 1,
	    0.09301257, -0.259966, 4.045235, 0, 0.8784314, 1, 1,
	    0.09454633, -0.4580648, 3.475598, 0, 0.8745098, 1, 1,
	    0.09465108, 0.9676872, -0.5270891, 0, 0.8666667, 1, 1,
	    0.09611721, 2.066796, 0.442317, 0, 0.8627451, 1, 1,
	    0.1026566, 0.4450114, 0.2720678, 0, 0.854902, 1, 1,
	    0.1041973, -1.552599, 5.26111, 0, 0.8509804, 1, 1,
	    0.1044849, -0.6019743, 3.029822, 0, 0.8431373, 1, 1,
	    0.1061169, 1.513344, -0.4592052, 0, 0.8392157, 1, 1,
	    0.1062921, -1.016259, 2.445465, 0, 0.8313726, 1, 1,
	    0.107006, -0.3671675, 3.665946, 0, 0.827451, 1, 1,
	    0.1072812, -0.4915379, 1.596094, 0, 0.8196079, 1, 1,
	    0.1078529, 0.3217232, -0.8928439, 0, 0.8156863, 1, 1,
	    0.1100618, 0.6108946, -0.6099887, 0, 0.8078431, 1, 1,
	    0.1103826, -0.4450323, 2.933548, 0, 0.8039216, 1, 1,
	    0.1122502, -0.2229861, -0.1693914, 0, 0.7960784, 1, 1,
	    0.1163002, 0.1643866, 0.4909968, 0, 0.7882353, 1, 1,
	    0.1166655, -0.5865929, 3.148772, 0, 0.7843137, 1, 1,
	    0.1215839, 0.7189328, -0.4760047, 0, 0.7764706, 1, 1,
	    0.1219273, 0.3549853, 1.069234, 0, 0.772549, 1, 1,
	    0.1224325, 0.07305832, 0.984258, 0, 0.7647059, 1, 1,
	    0.1244157, -0.2608297, 3.207429, 0, 0.7607843, 1, 1,
	    0.128006, 0.6515453, 1.038436, 0, 0.7529412, 1, 1,
	    0.1289567, 0.8126485, -0.03728668, 0, 0.7490196, 1, 1,
	    0.131863, -0.1667384, 3.66906, 0, 0.7411765, 1, 1,
	    0.1342645, 0.08703648, 0.6285431, 0, 0.7372549, 1, 1,
	    0.1352197, -0.5717762, 1.392805, 0, 0.7294118, 1, 1,
	    0.1369665, 0.9381886, 0.5698499, 0, 0.7254902, 1, 1,
	    0.1382026, 0.52598, 0.6111594, 0, 0.7176471, 1, 1,
	    0.1383193, -0.2449978, 1.830511, 0, 0.7137255, 1, 1,
	    0.141035, -1.391991, 3.118016, 0, 0.7058824, 1, 1,
	    0.1435739, -0.5446311, 3.274226, 0, 0.6980392, 1, 1,
	    0.1465292, 0.4882877, 0.4689429, 0, 0.6941177, 1, 1,
	    0.1482565, -0.1360025, 1.747028, 0, 0.6862745, 1, 1,
	    0.1521798, 0.3535145, 1.633988, 0, 0.682353, 1, 1,
	    0.1570492, -0.6035639, 3.100048, 0, 0.6745098, 1, 1,
	    0.1594687, 0.5981838, 0.01735535, 0, 0.6705883, 1, 1,
	    0.1603296, -0.2222466, 2.914895, 0, 0.6627451, 1, 1,
	    0.1635241, 0.665046, 0.2537347, 0, 0.6588235, 1, 1,
	    0.1700978, -0.6115986, 4.145239, 0, 0.6509804, 1, 1,
	    0.178025, -2.532845, 1.975884, 0, 0.6470588, 1, 1,
	    0.1792095, 1.144453, 0.726045, 0, 0.6392157, 1, 1,
	    0.1829917, -0.4280172, 0.9340133, 0, 0.6352941, 1, 1,
	    0.1838085, -0.4473387, 0.8215897, 0, 0.627451, 1, 1,
	    0.1839206, -1.019977, 2.666452, 0, 0.6235294, 1, 1,
	    0.1845374, 0.7142898, 0.03128422, 0, 0.6156863, 1, 1,
	    0.1863684, 0.09290506, 0.8440206, 0, 0.6117647, 1, 1,
	    0.1874039, -0.1069539, 2.780745, 0, 0.6039216, 1, 1,
	    0.1883722, 0.258284, 0.545072, 0, 0.5960785, 1, 1,
	    0.190219, -0.3597817, 0.5446491, 0, 0.5921569, 1, 1,
	    0.1905119, -1.337162, 2.084832, 0, 0.5843138, 1, 1,
	    0.1914095, -0.0936728, 2.72074, 0, 0.5803922, 1, 1,
	    0.1919692, 0.5790755, 0.1502081, 0, 0.572549, 1, 1,
	    0.1929063, 1.307526, -0.8896973, 0, 0.5686275, 1, 1,
	    0.1931118, -1.42427, 3.042279, 0, 0.5607843, 1, 1,
	    0.1931683, -0.04915911, 1.511319, 0, 0.5568628, 1, 1,
	    0.1946133, 1.011707, 1.984745, 0, 0.5490196, 1, 1,
	    0.1970275, -1.663379, 2.609975, 0, 0.5450981, 1, 1,
	    0.1983312, 1.065794, 0.07580744, 0, 0.5372549, 1, 1,
	    0.1995554, 0.2647915, 1.019678, 0, 0.5333334, 1, 1,
	    0.1996723, -0.219472, 3.886744, 0, 0.5254902, 1, 1,
	    0.2020285, -0.3415243, 1.436836, 0, 0.5215687, 1, 1,
	    0.2047215, -0.8772489, 2.160733, 0, 0.5137255, 1, 1,
	    0.2078829, 0.1876734, 3.159303, 0, 0.509804, 1, 1,
	    0.2090539, -1.358869, 1.932339, 0, 0.5019608, 1, 1,
	    0.2092445, -0.8809974, 4.38117, 0, 0.4941176, 1, 1,
	    0.2117243, 0.7326301, 0.5692696, 0, 0.4901961, 1, 1,
	    0.2125605, -0.887632, 1.154402, 0, 0.4823529, 1, 1,
	    0.2152017, 0.131702, 0.06559843, 0, 0.4784314, 1, 1,
	    0.2164824, 0.3881406, 0.8190459, 0, 0.4705882, 1, 1,
	    0.2184935, 0.5875551, -0.09697541, 0, 0.4666667, 1, 1,
	    0.2203305, -0.3857507, 2.966745, 0, 0.4588235, 1, 1,
	    0.2251523, -0.3716606, 1.616506, 0, 0.454902, 1, 1,
	    0.2266014, 0.4220589, -0.4766728, 0, 0.4470588, 1, 1,
	    0.2269479, -1.017841, 2.806958, 0, 0.4431373, 1, 1,
	    0.2285464, -0.554351, 2.682117, 0, 0.4352941, 1, 1,
	    0.228572, -1.056745, 4.246807, 0, 0.4313726, 1, 1,
	    0.2317315, -1.169672, 2.880264, 0, 0.4235294, 1, 1,
	    0.2358686, 0.1878211, 0.6595835, 0, 0.4196078, 1, 1,
	    0.2360663, 0.09019014, 2.900752, 0, 0.4117647, 1, 1,
	    0.2380708, 0.9367609, -0.07973503, 0, 0.4078431, 1, 1,
	    0.2445518, 0.1908676, -0.3162779, 0, 0.4, 1, 1,
	    0.2466189, 0.9909604, 1.180173, 0, 0.3921569, 1, 1,
	    0.2473821, 0.6118659, 0.6752173, 0, 0.3882353, 1, 1,
	    0.2474189, -0.6928043, 2.403903, 0, 0.3803922, 1, 1,
	    0.2479757, 0.3410625, -1.024047, 0, 0.3764706, 1, 1,
	    0.2511693, 0.5569203, 0.2246133, 0, 0.3686275, 1, 1,
	    0.2526799, 0.9359461, 0.5471303, 0, 0.3647059, 1, 1,
	    0.2528881, -0.8233687, 3.522155, 0, 0.3568628, 1, 1,
	    0.2572431, -1.005432, 2.149736, 0, 0.3529412, 1, 1,
	    0.2575332, 0.7653229, 0.6192426, 0, 0.345098, 1, 1,
	    0.2583483, 0.748874, -1.185861, 0, 0.3411765, 1, 1,
	    0.2643364, -0.02097367, 2.651446, 0, 0.3333333, 1, 1,
	    0.2678691, -1.277307, 3.241391, 0, 0.3294118, 1, 1,
	    0.2685061, 2.020908, 1.812057, 0, 0.3215686, 1, 1,
	    0.2741299, -0.1199245, 1.405239, 0, 0.3176471, 1, 1,
	    0.2748236, -0.4637829, 1.798468, 0, 0.3098039, 1, 1,
	    0.28603, 0.702406, -0.7782157, 0, 0.3058824, 1, 1,
	    0.2871256, -0.3669437, 0.4109738, 0, 0.2980392, 1, 1,
	    0.2923748, -0.7202891, 2.48531, 0, 0.2901961, 1, 1,
	    0.2939291, -0.3130354, 1.901124, 0, 0.2862745, 1, 1,
	    0.298371, -0.6293191, 4.185496, 0, 0.2784314, 1, 1,
	    0.3056961, -0.1000749, 0.9109806, 0, 0.2745098, 1, 1,
	    0.3065286, -1.900397, 3.570855, 0, 0.2666667, 1, 1,
	    0.3107812, -0.9099705, 4.940164, 0, 0.2627451, 1, 1,
	    0.3122128, 0.785337, 0.7728329, 0, 0.254902, 1, 1,
	    0.3145591, -1.171545, 1.276328, 0, 0.2509804, 1, 1,
	    0.3172991, 1.112064, -0.1799191, 0, 0.2431373, 1, 1,
	    0.3254927, 0.901834, 2.028207, 0, 0.2392157, 1, 1,
	    0.3263812, -0.9142314, 2.310468, 0, 0.2313726, 1, 1,
	    0.3265411, 0.7284775, 0.09317417, 0, 0.227451, 1, 1,
	    0.3268003, -0.7122616, 1.895956, 0, 0.2196078, 1, 1,
	    0.3295407, 0.9836206, 2.059939, 0, 0.2156863, 1, 1,
	    0.3343589, -0.2811627, 2.892952, 0, 0.2078431, 1, 1,
	    0.3356041, -1.835668, 2.312696, 0, 0.2039216, 1, 1,
	    0.3363679, 0.7970281, -0.6648602, 0, 0.1960784, 1, 1,
	    0.3513916, 0.3148961, 1.237654, 0, 0.1882353, 1, 1,
	    0.3527415, 0.8143937, 1.297698, 0, 0.1843137, 1, 1,
	    0.3553777, 1.663997, -0.07211654, 0, 0.1764706, 1, 1,
	    0.3594267, -1.136789, 2.609511, 0, 0.172549, 1, 1,
	    0.3600878, -0.5238538, 2.816959, 0, 0.1647059, 1, 1,
	    0.365236, 0.6437891, 1.018958, 0, 0.1607843, 1, 1,
	    0.3655939, -0.7376626, 1.247418, 0, 0.1529412, 1, 1,
	    0.3665751, 0.8883263, 0.5920367, 0, 0.1490196, 1, 1,
	    0.3684005, 1.164289, -1.041911, 0, 0.1411765, 1, 1,
	    0.3688575, -1.768698, 1.549723, 0, 0.1372549, 1, 1,
	    0.374994, -1.797152, 3.735287, 0, 0.1294118, 1, 1,
	    0.3764427, 0.1465605, 2.475554, 0, 0.1254902, 1, 1,
	    0.3832192, -0.8198991, 2.087719, 0, 0.1176471, 1, 1,
	    0.3894364, -1.327048, 2.986542, 0, 0.1137255, 1, 1,
	    0.3898886, -0.7195575, 2.358831, 0, 0.1058824, 1, 1,
	    0.3937056, 0.2717656, 0.3690591, 0, 0.09803922, 1, 1,
	    0.3965043, 0.6636701, 1.598294, 0, 0.09411765, 1, 1,
	    0.4019325, -1.09271, 2.348265, 0, 0.08627451, 1, 1,
	    0.4021221, -0.107501, 0.8568294, 0, 0.08235294, 1, 1,
	    0.4051938, -0.2065656, 1.518768, 0, 0.07450981, 1, 1,
	    0.4092625, -0.3689673, 3.172438, 0, 0.07058824, 1, 1,
	    0.4135267, 1.234519, 0.0496379, 0, 0.0627451, 1, 1,
	    0.4136343, -0.5442001, 3.302315, 0, 0.05882353, 1, 1,
	    0.4253294, -0.07140379, 3.335873, 0, 0.05098039, 1, 1,
	    0.4254856, -0.5110876, 2.446418, 0, 0.04705882, 1, 1,
	    0.425651, 1.201572, 1.145523, 0, 0.03921569, 1, 1,
	    0.4294204, -0.4200776, 1.988743, 0, 0.03529412, 1, 1,
	    0.4296768, 0.7890232, 2.693126, 0, 0.02745098, 1, 1,
	    0.4297048, -1.23584, 1.516688, 0, 0.02352941, 1, 1,
	    0.4313572, 0.5896196, 0.3839439, 0, 0.01568628, 1, 1,
	    0.431378, 0.2528784, 1.819692, 0, 0.01176471, 1, 1,
	    0.4340013, 0.1696718, 0.5472794, 0, 0.003921569, 1, 1,
	    0.4341751, 0.7655392, 0.8611946, 0.003921569, 0, 1, 1,
	    0.4347065, 2.081046, 0.8277847, 0.007843138, 0, 1, 1,
	    0.4390946, -0.4283992, 1.038629, 0.01568628, 0, 1, 1,
	    0.4414654, -0.7137386, 0.821129, 0.01960784, 0, 1, 1,
	    0.4476425, 0.8850939, 0.3397686, 0.02745098, 0, 1, 1,
	    0.4482242, -1.680972, 2.050063, 0.03137255, 0, 1, 1,
	    0.4501642, -0.00742417, 2.189682, 0.03921569, 0, 1, 1,
	    0.4528178, -1.196445, 2.729747, 0.04313726, 0, 1, 1,
	    0.4547617, 1.407504, -0.5837027, 0.05098039, 0, 1, 1,
	    0.4590748, -1.335068, 3.746183, 0.05490196, 0, 1, 1,
	    0.4637842, 1.980033, 1.162863, 0.0627451, 0, 1, 1,
	    0.4654953, 0.8227708, -0.235175, 0.06666667, 0, 1, 1,
	    0.4683817, 0.5726936, 1.128431, 0.07450981, 0, 1, 1,
	    0.4726784, 0.4847385, 0.7849889, 0.07843138, 0, 1, 1,
	    0.476008, 0.9113375, 0.04666661, 0.08627451, 0, 1, 1,
	    0.4796965, -1.567834, 3.174863, 0.09019608, 0, 1, 1,
	    0.4873758, 0.001658139, 1.193167, 0.09803922, 0, 1, 1,
	    0.4929742, 0.7411689, 0.3371684, 0.1058824, 0, 1, 1,
	    0.4932961, -0.4423964, 1.797442, 0.1098039, 0, 1, 1,
	    0.4968013, 1.689804, 0.7065411, 0.1176471, 0, 1, 1,
	    0.4993505, 0.9091672, -0.1763972, 0.1215686, 0, 1, 1,
	    0.5015466, -0.6261237, 0.9471341, 0.1294118, 0, 1, 1,
	    0.5039274, -0.7392588, 2.435354, 0.1333333, 0, 1, 1,
	    0.5050992, -1.021569, 2.498367, 0.1411765, 0, 1, 1,
	    0.5070629, 0.110033, 1.435212, 0.145098, 0, 1, 1,
	    0.5099042, 0.1335498, 0.5994357, 0.1529412, 0, 1, 1,
	    0.5102943, 0.8642924, -1.086606, 0.1568628, 0, 1, 1,
	    0.5169222, -1.669879, 2.550515, 0.1647059, 0, 1, 1,
	    0.5188851, -1.221196, 1.574998, 0.1686275, 0, 1, 1,
	    0.5195099, 0.7637153, 1.995525, 0.1764706, 0, 1, 1,
	    0.5198834, 0.1871841, 2.103063, 0.1803922, 0, 1, 1,
	    0.5229973, -1.338781, 1.758251, 0.1882353, 0, 1, 1,
	    0.5259225, -2.570678, 4.629694, 0.1921569, 0, 1, 1,
	    0.529009, 1.722551, -0.3940401, 0.2, 0, 1, 1,
	    0.5352999, 2.303874, -0.4184575, 0.2078431, 0, 1, 1,
	    0.5400949, 0.9479592, -0.5662929, 0.2117647, 0, 1, 1,
	    0.5466154, 1.591949, 0.8917838, 0.2196078, 0, 1, 1,
	    0.5550741, 1.2225, 0.9150594, 0.2235294, 0, 1, 1,
	    0.5558312, 0.4769517, -0.681124, 0.2313726, 0, 1, 1,
	    0.5596095, 0.7263267, -1.699225, 0.2352941, 0, 1, 1,
	    0.5615281, -2.424305, 2.59298, 0.2431373, 0, 1, 1,
	    0.563706, -2.172353, 4.090433, 0.2470588, 0, 1, 1,
	    0.5663989, 0.322054, 1.890126, 0.254902, 0, 1, 1,
	    0.5700537, 1.025355, 1.079731, 0.2588235, 0, 1, 1,
	    0.570632, 0.2546245, 2.286671, 0.2666667, 0, 1, 1,
	    0.5743126, -0.8207384, 1.950945, 0.2705882, 0, 1, 1,
	    0.5776034, -1.23545, 1.414374, 0.2784314, 0, 1, 1,
	    0.5797418, -0.5572614, 2.880505, 0.282353, 0, 1, 1,
	    0.5845132, 2.013408, 1.951908, 0.2901961, 0, 1, 1,
	    0.5853955, 0.7274232, 2.9729, 0.2941177, 0, 1, 1,
	    0.5873414, 0.2253125, 0.6050488, 0.3019608, 0, 1, 1,
	    0.5886693, -0.9295229, 1.728288, 0.3098039, 0, 1, 1,
	    0.5920678, -0.7313536, 2.358872, 0.3137255, 0, 1, 1,
	    0.5965451, 0.4646835, 0.5125992, 0.3215686, 0, 1, 1,
	    0.5983518, 0.08187061, 1.960333, 0.3254902, 0, 1, 1,
	    0.5986785, 1.74221, -0.09493145, 0.3333333, 0, 1, 1,
	    0.5992705, 0.2177423, 1.80182, 0.3372549, 0, 1, 1,
	    0.5994596, -0.05148949, 1.731607, 0.345098, 0, 1, 1,
	    0.6031302, -1.267114, 3.591027, 0.3490196, 0, 1, 1,
	    0.6042261, -0.8730811, 1.129582, 0.3568628, 0, 1, 1,
	    0.6043223, -1.915332, 2.561955, 0.3607843, 0, 1, 1,
	    0.6047238, -0.9365023, 2.997514, 0.3686275, 0, 1, 1,
	    0.6146607, -0.4931153, 0.8303838, 0.372549, 0, 1, 1,
	    0.6160794, 0.6149536, 2.980136, 0.3803922, 0, 1, 1,
	    0.6218703, -0.5713632, 3.690783, 0.3843137, 0, 1, 1,
	    0.6243022, 1.488309, 0.8969647, 0.3921569, 0, 1, 1,
	    0.6251644, -0.5810105, 3.458486, 0.3960784, 0, 1, 1,
	    0.6292234, -0.8061491, 3.105771, 0.4039216, 0, 1, 1,
	    0.6334459, 0.2880307, 1.181214, 0.4117647, 0, 1, 1,
	    0.6359507, -0.4316407, 3.140942, 0.4156863, 0, 1, 1,
	    0.6392193, -0.9471861, 1.713566, 0.4235294, 0, 1, 1,
	    0.6423431, 0.7290992, 1.618243, 0.427451, 0, 1, 1,
	    0.6442789, 0.001290415, 1.916065, 0.4352941, 0, 1, 1,
	    0.6458284, -0.0917182, 3.298355, 0.4392157, 0, 1, 1,
	    0.6463413, 0.5807928, 0.02305548, 0.4470588, 0, 1, 1,
	    0.6483135, 0.2033769, 1.119554, 0.4509804, 0, 1, 1,
	    0.6537536, 0.02148359, 1.427253, 0.4588235, 0, 1, 1,
	    0.6554067, 1.054275, 1.216243, 0.4627451, 0, 1, 1,
	    0.6555033, 0.05377162, 1.008654, 0.4705882, 0, 1, 1,
	    0.6593784, -0.8015111, 2.430028, 0.4745098, 0, 1, 1,
	    0.6617915, 1.240925, 1.452918, 0.4823529, 0, 1, 1,
	    0.662336, 0.5326049, 1.053262, 0.4862745, 0, 1, 1,
	    0.6631529, 0.4295362, 3.031649, 0.4941176, 0, 1, 1,
	    0.6647167, -0.08069759, 1.965049, 0.5019608, 0, 1, 1,
	    0.6682475, 0.5112842, 0.5066233, 0.5058824, 0, 1, 1,
	    0.6691505, 0.04652744, 1.745752, 0.5137255, 0, 1, 1,
	    0.670814, -0.09315952, 2.099135, 0.5176471, 0, 1, 1,
	    0.6749287, -0.2347737, 1.577633, 0.5254902, 0, 1, 1,
	    0.6775565, -0.893379, 3.228296, 0.5294118, 0, 1, 1,
	    0.6806843, 0.5698493, 0.6989463, 0.5372549, 0, 1, 1,
	    0.6807137, -0.15848, -0.1790734, 0.5411765, 0, 1, 1,
	    0.6811195, -0.3296212, 0.8177317, 0.5490196, 0, 1, 1,
	    0.6836012, 0.8438966, 0.1913418, 0.5529412, 0, 1, 1,
	    0.6880077, 1.195043, 1.910891, 0.5607843, 0, 1, 1,
	    0.6900715, -1.441558, 3.026865, 0.5647059, 0, 1, 1,
	    0.6916788, 1.500066, 1.976335, 0.572549, 0, 1, 1,
	    0.6991165, 0.7709148, 1.573561, 0.5764706, 0, 1, 1,
	    0.7028804, 1.010851, 2.364694, 0.5843138, 0, 1, 1,
	    0.7175383, -0.7867269, 1.477161, 0.5882353, 0, 1, 1,
	    0.719703, 0.3599024, 0.9055019, 0.5960785, 0, 1, 1,
	    0.7213984, -0.2559587, 0.8043493, 0.6039216, 0, 1, 1,
	    0.723748, 0.4300957, 0.7351699, 0.6078432, 0, 1, 1,
	    0.7262, 0.2491605, 2.992022, 0.6156863, 0, 1, 1,
	    0.7407923, -0.9766032, 2.237557, 0.6196079, 0, 1, 1,
	    0.7411088, 0.7287903, 0.738338, 0.627451, 0, 1, 1,
	    0.741836, -0.5282144, 3.185348, 0.6313726, 0, 1, 1,
	    0.7419101, -0.5319484, 1.685711, 0.6392157, 0, 1, 1,
	    0.7420353, -1.115688, 2.49123, 0.6431373, 0, 1, 1,
	    0.7437646, -0.5926205, 2.557114, 0.6509804, 0, 1, 1,
	    0.750936, -0.3487455, -0.4414684, 0.654902, 0, 1, 1,
	    0.7562128, -0.1684527, 2.234041, 0.6627451, 0, 1, 1,
	    0.756591, 0.4328215, 0.6566299, 0.6666667, 0, 1, 1,
	    0.7627181, 0.4030067, 2.084188, 0.6745098, 0, 1, 1,
	    0.7634903, -1.434577, 3.273043, 0.6784314, 0, 1, 1,
	    0.7661939, 0.8909416, 0.8491132, 0.6862745, 0, 1, 1,
	    0.7684891, -0.1856391, 2.023182, 0.6901961, 0, 1, 1,
	    0.7801667, -0.6752204, 3.904533, 0.6980392, 0, 1, 1,
	    0.7879386, 1.145325, 0.06679469, 0.7058824, 0, 1, 1,
	    0.7922547, 0.277355, 1.014796, 0.7098039, 0, 1, 1,
	    0.7965863, 0.8946573, -1.028544, 0.7176471, 0, 1, 1,
	    0.7988103, 1.322261, -0.8656024, 0.7215686, 0, 1, 1,
	    0.8035467, 0.2237218, 0.4946235, 0.7294118, 0, 1, 1,
	    0.806196, -2.017117, -0.6351306, 0.7333333, 0, 1, 1,
	    0.8064351, -0.05893974, 1.304831, 0.7411765, 0, 1, 1,
	    0.8110426, -1.165267, 2.276885, 0.7450981, 0, 1, 1,
	    0.8185936, -0.196494, 1.864398, 0.7529412, 0, 1, 1,
	    0.8212466, -0.1601952, 2.807967, 0.7568628, 0, 1, 1,
	    0.8339199, -0.7367927, 4.755157, 0.7647059, 0, 1, 1,
	    0.8393537, 0.9523275, -0.9740515, 0.7686275, 0, 1, 1,
	    0.8403126, -1.026926, 1.884026, 0.7764706, 0, 1, 1,
	    0.8404459, -1.787666, 3.232632, 0.7803922, 0, 1, 1,
	    0.8423523, -1.382273, 2.480772, 0.7882353, 0, 1, 1,
	    0.8514102, 0.930451, 0.08503878, 0.7921569, 0, 1, 1,
	    0.8519761, 0.8414823, 0.7370061, 0.8, 0, 1, 1,
	    0.8539235, 0.7645729, 1.343386, 0.8078431, 0, 1, 1,
	    0.8543158, 0.1508888, 1.335459, 0.8117647, 0, 1, 1,
	    0.8565333, 1.608199, -2.485984, 0.8196079, 0, 1, 1,
	    0.8577313, -1.052842, 1.807386, 0.8235294, 0, 1, 1,
	    0.8583113, -0.3175471, 2.490247, 0.8313726, 0, 1, 1,
	    0.8655223, -0.4959556, 0.5236659, 0.8352941, 0, 1, 1,
	    0.8718966, -1.168868, 2.652057, 0.8431373, 0, 1, 1,
	    0.8787474, 0.4164687, 1.01721, 0.8470588, 0, 1, 1,
	    0.8801731, -0.3463355, 0.8141345, 0.854902, 0, 1, 1,
	    0.885679, -0.4456334, 0.5573649, 0.8588235, 0, 1, 1,
	    0.8896487, -1.047949, 1.919018, 0.8666667, 0, 1, 1,
	    0.8900696, -0.7043455, 2.351058, 0.8705882, 0, 1, 1,
	    0.8903096, 1.641982, 0.2406366, 0.8784314, 0, 1, 1,
	    0.8983973, 0.5779285, 2.972297, 0.8823529, 0, 1, 1,
	    0.9041696, 0.9651089, -0.2013962, 0.8901961, 0, 1, 1,
	    0.9096302, -1.949089, 4.850592, 0.8941177, 0, 1, 1,
	    0.9106991, 0.948122, 0.722131, 0.9019608, 0, 1, 1,
	    0.9145529, -1.235598, 1.336981, 0.9098039, 0, 1, 1,
	    0.9218136, -0.7853305, 2.958206, 0.9137255, 0, 1, 1,
	    0.9218828, -0.6331585, 3.05127, 0.9215686, 0, 1, 1,
	    0.9234186, -1.43349, 2.545877, 0.9254902, 0, 1, 1,
	    0.9381148, -0.8925616, 2.149606, 0.9333333, 0, 1, 1,
	    0.9476001, -0.3886733, 0.9248268, 0.9372549, 0, 1, 1,
	    0.9478907, 1.489023, 0.5925103, 0.945098, 0, 1, 1,
	    0.954333, -0.2384526, 0.1379638, 0.9490196, 0, 1, 1,
	    0.9552419, 0.4885001, 2.512027, 0.9568627, 0, 1, 1,
	    0.9578535, 0.3466969, 0.989498, 0.9607843, 0, 1, 1,
	    0.9595397, 0.7775558, 0.06404581, 0.9686275, 0, 1, 1,
	    0.979372, -0.4214701, 2.626821, 0.972549, 0, 1, 1,
	    0.9802197, 0.04655711, 3.345149, 0.9803922, 0, 1, 1,
	    0.9831444, -0.0862759, 0.8689582, 0.9843137, 0, 1, 1,
	    0.9901598, -1.580551, 2.373589, 0.9921569, 0, 1, 1,
	    0.9912349, 0.0217969, 1.306917, 0.9960784, 0, 1, 1,
	    0.9915971, 0.04520204, 2.063054, 1, 0, 0.9960784, 1,
	    0.9935458, 1.44206, 0.752893, 1, 0, 0.9882353, 1,
	    0.9987224, -0.2468695, 3.190087, 1, 0, 0.9843137, 1,
	    1.003093, -1.210032, 3.616322, 1, 0, 0.9764706, 1,
	    1.012855, 1.152163, 0.8058317, 1, 0, 0.972549, 1,
	    1.017065, -0.4009151, 2.271645, 1, 0, 0.9647059, 1,
	    1.017089, -1.302075, 4.63025, 1, 0, 0.9607843, 1,
	    1.022402, -2.087095, 3.440585, 1, 0, 0.9529412, 1,
	    1.026821, 0.2458314, -0.8367593, 1, 0, 0.9490196, 1,
	    1.027892, 0.1338234, 2.961189, 1, 0, 0.9411765, 1,
	    1.030941, -0.33429, 1.792093, 1, 0, 0.9372549, 1,
	    1.035808, -0.6398091, 0.882112, 1, 0, 0.9294118, 1,
	    1.0379, -0.3320836, 2.841559, 1, 0, 0.9254902, 1,
	    1.03893, -0.4205993, 0.8762783, 1, 0, 0.9176471, 1,
	    1.042311, -1.094066, 3.350467, 1, 0, 0.9137255, 1,
	    1.044133, -0.5316652, 2.111084, 1, 0, 0.9058824, 1,
	    1.048627, 0.9510994, 0.9330221, 1, 0, 0.9019608, 1,
	    1.048707, 2.10455, 0.9454204, 1, 0, 0.8941177, 1,
	    1.051578, 0.4079071, 2.034878, 1, 0, 0.8862745, 1,
	    1.053659, -0.4997532, 1.332038, 1, 0, 0.8823529, 1,
	    1.059833, -1.08941, 2.526359, 1, 0, 0.8745098, 1,
	    1.072036, 0.5750423, 2.128619, 1, 0, 0.8705882, 1,
	    1.076846, -0.8357787, 3.112111, 1, 0, 0.8627451, 1,
	    1.082049, -0.8589421, -0.6205416, 1, 0, 0.8588235, 1,
	    1.084321, 0.1659174, 1.894724, 1, 0, 0.8509804, 1,
	    1.106342, 0.8991289, 0.8520855, 1, 0, 0.8470588, 1,
	    1.112944, -0.3385193, 1.876312, 1, 0, 0.8392157, 1,
	    1.116178, 0.2108917, -0.481451, 1, 0, 0.8352941, 1,
	    1.131031, -0.9315465, 1.347641, 1, 0, 0.827451, 1,
	    1.132899, 0.190707, 1.586913, 1, 0, 0.8235294, 1,
	    1.135227, 2.163841, -0.4653414, 1, 0, 0.8156863, 1,
	    1.137197, 1.35075, 1.317697, 1, 0, 0.8117647, 1,
	    1.137208, 1.802798, 2.594671, 1, 0, 0.8039216, 1,
	    1.139062, -0.4896462, 2.024554, 1, 0, 0.7960784, 1,
	    1.139305, 0.3257364, 2.203821, 1, 0, 0.7921569, 1,
	    1.142877, -0.5039365, 0.8598027, 1, 0, 0.7843137, 1,
	    1.148784, 1.873287, 1.422644, 1, 0, 0.7803922, 1,
	    1.162593, -0.6380991, 1.424583, 1, 0, 0.772549, 1,
	    1.170444, -1.415428, 1.776792, 1, 0, 0.7686275, 1,
	    1.172689, 1.423217, -0.2243901, 1, 0, 0.7607843, 1,
	    1.17501, 0.5502619, 1.101423, 1, 0, 0.7568628, 1,
	    1.18141, 1.381114, 1.299161, 1, 0, 0.7490196, 1,
	    1.193445, 0.3829843, 1.022341, 1, 0, 0.7450981, 1,
	    1.195166, -0.07927945, 0.1505162, 1, 0, 0.7372549, 1,
	    1.207424, -2.056541, 3.571899, 1, 0, 0.7333333, 1,
	    1.208319, -0.3321181, 1.264181, 1, 0, 0.7254902, 1,
	    1.216965, 0.4393688, 1.638274, 1, 0, 0.7215686, 1,
	    1.222744, -0.7874217, 1.923233, 1, 0, 0.7137255, 1,
	    1.224775, -0.4901105, 2.503965, 1, 0, 0.7098039, 1,
	    1.234828, -1.660404, 2.681898, 1, 0, 0.7019608, 1,
	    1.239705, 1.559191, 1.881883, 1, 0, 0.6941177, 1,
	    1.24156, -0.5093824, 1.903566, 1, 0, 0.6901961, 1,
	    1.243757, -0.1797429, 0.2534747, 1, 0, 0.682353, 1,
	    1.244416, 0.5824475, 0.6678951, 1, 0, 0.6784314, 1,
	    1.247064, -0.1537837, 0.7533871, 1, 0, 0.6705883, 1,
	    1.247665, -0.4547499, 2.697904, 1, 0, 0.6666667, 1,
	    1.249362, -0.1493696, 2.185444, 1, 0, 0.6588235, 1,
	    1.254358, -0.7841275, 1.880917, 1, 0, 0.654902, 1,
	    1.256475, -0.6159473, 2.830075, 1, 0, 0.6470588, 1,
	    1.264864, -1.301724, 2.779207, 1, 0, 0.6431373, 1,
	    1.265649, -0.016853, 1.723238, 1, 0, 0.6352941, 1,
	    1.2671, 2.029307, 0.8557336, 1, 0, 0.6313726, 1,
	    1.276473, -2.438567, 1.735142, 1, 0, 0.6235294, 1,
	    1.281132, 0.6079572, 0.8016425, 1, 0, 0.6196079, 1,
	    1.281572, -2.80742, 2.434005, 1, 0, 0.6117647, 1,
	    1.281894, -0.8564659, 1.158784, 1, 0, 0.6078432, 1,
	    1.301442, 2.024653, 0.9834145, 1, 0, 0.6, 1,
	    1.302122, -1.102676, 0.9135134, 1, 0, 0.5921569, 1,
	    1.303775, 0.7212898, -0.6105742, 1, 0, 0.5882353, 1,
	    1.30771, -0.2988253, 3.222286, 1, 0, 0.5803922, 1,
	    1.314348, -0.8914454, 3.525439, 1, 0, 0.5764706, 1,
	    1.316196, -0.8970599, 0.1140048, 1, 0, 0.5686275, 1,
	    1.317205, 1.907043, 1.913368, 1, 0, 0.5647059, 1,
	    1.33572, -0.8042935, 2.495217, 1, 0, 0.5568628, 1,
	    1.346993, -0.3029135, 1.500248, 1, 0, 0.5529412, 1,
	    1.349057, 0.3281502, 2.498402, 1, 0, 0.5450981, 1,
	    1.360882, 1.504238, 0.2481277, 1, 0, 0.5411765, 1,
	    1.361, -1.049211, 4.07884, 1, 0, 0.5333334, 1,
	    1.364406, 0.7376127, -0.4058758, 1, 0, 0.5294118, 1,
	    1.366949, 0.9937359, 1.21529, 1, 0, 0.5215687, 1,
	    1.386408, -0.4528491, 1.753989, 1, 0, 0.5176471, 1,
	    1.397722, 0.7964393, 1.701366, 1, 0, 0.509804, 1,
	    1.399222, -0.6291203, 2.537542, 1, 0, 0.5058824, 1,
	    1.405987, -0.2270334, 0.7872786, 1, 0, 0.4980392, 1,
	    1.420704, 0.5032713, -1.574494, 1, 0, 0.4901961, 1,
	    1.427457, 0.4291628, 1.765508, 1, 0, 0.4862745, 1,
	    1.439281, -0.294948, 2.02267, 1, 0, 0.4784314, 1,
	    1.455318, -3.796558, 2.234791, 1, 0, 0.4745098, 1,
	    1.456781, 1.38284, -0.9876788, 1, 0, 0.4666667, 1,
	    1.457386, 0.2736903, 2.021282, 1, 0, 0.4627451, 1,
	    1.460703, 0.176571, 2.062269, 1, 0, 0.454902, 1,
	    1.485004, 0.744482, 1.202498, 1, 0, 0.4509804, 1,
	    1.485314, -0.004370876, -0.2410145, 1, 0, 0.4431373, 1,
	    1.488248, -0.8167691, 3.370741, 1, 0, 0.4392157, 1,
	    1.509459, -1.04239, 4.215803, 1, 0, 0.4313726, 1,
	    1.516866, 0.4961429, 0.534223, 1, 0, 0.427451, 1,
	    1.517245, 0.7435272, 1.185065, 1, 0, 0.4196078, 1,
	    1.520651, -1.369939, 3.751727, 1, 0, 0.4156863, 1,
	    1.532591, -0.1194276, 1.517473, 1, 0, 0.4078431, 1,
	    1.546332, 0.0807752, 1.126593, 1, 0, 0.4039216, 1,
	    1.558363, 0.9801, 0.6547363, 1, 0, 0.3960784, 1,
	    1.565943, 0.9060969, 1.139848, 1, 0, 0.3882353, 1,
	    1.572446, 0.3758109, 0.931002, 1, 0, 0.3843137, 1,
	    1.576365, 0.7952425, -0.05187507, 1, 0, 0.3764706, 1,
	    1.595973, 0.3028728, 1.406537, 1, 0, 0.372549, 1,
	    1.601879, 1.344227, 1.071591, 1, 0, 0.3647059, 1,
	    1.630181, 1.090279, 1.52354, 1, 0, 0.3607843, 1,
	    1.630571, -1.432613, 1.288741, 1, 0, 0.3529412, 1,
	    1.636884, -0.4306608, 0.7853554, 1, 0, 0.3490196, 1,
	    1.647768, 0.8384377, -0.2307568, 1, 0, 0.3411765, 1,
	    1.647967, -0.6844932, 0.9080634, 1, 0, 0.3372549, 1,
	    1.650218, 0.2023214, 1.875852, 1, 0, 0.3294118, 1,
	    1.666939, -1.315106, 0.8486137, 1, 0, 0.3254902, 1,
	    1.667671, -1.130635, 0.6762096, 1, 0, 0.3176471, 1,
	    1.685157, -0.3589162, 0.6997684, 1, 0, 0.3137255, 1,
	    1.718892, -0.8844588, 0.9007099, 1, 0, 0.3058824, 1,
	    1.719741, 0.2708183, 0.2282749, 1, 0, 0.2980392, 1,
	    1.733397, -0.4294756, 0.5542376, 1, 0, 0.2941177, 1,
	    1.735141, 0.6873988, 0.9697185, 1, 0, 0.2862745, 1,
	    1.744206, 0.780598, -0.1162209, 1, 0, 0.282353, 1,
	    1.765705, 0.3532824, 1.625832, 1, 0, 0.2745098, 1,
	    1.774764, -0.2849429, 2.296064, 1, 0, 0.2705882, 1,
	    1.785102, 0.2383637, 0.7919699, 1, 0, 0.2627451, 1,
	    1.797137, -0.2440633, 0.8852751, 1, 0, 0.2588235, 1,
	    1.812815, -0.3838506, 2.770444, 1, 0, 0.2509804, 1,
	    1.863016, -0.7722225, 2.226112, 1, 0, 0.2470588, 1,
	    1.869635, 0.8348635, 0.9892907, 1, 0, 0.2392157, 1,
	    1.874986, -0.1357871, 2.010076, 1, 0, 0.2352941, 1,
	    1.893269, -2.45233, 0.9565188, 1, 0, 0.227451, 1,
	    1.911542, -1.388245, 2.882665, 1, 0, 0.2235294, 1,
	    1.920838, -1.311405, 1.927677, 1, 0, 0.2156863, 1,
	    1.937591, 1.787236, 0.08790232, 1, 0, 0.2117647, 1,
	    1.952029, 0.08263589, 2.663446, 1, 0, 0.2039216, 1,
	    1.957916, 1.148235, 1.036407, 1, 0, 0.1960784, 1,
	    1.960295, -0.04118054, 0.1977792, 1, 0, 0.1921569, 1,
	    1.966074, 0.6735585, -0.07169156, 1, 0, 0.1843137, 1,
	    2.019099, 0.555634, 1.483732, 1, 0, 0.1803922, 1,
	    2.047788, -0.50349, 1.142279, 1, 0, 0.172549, 1,
	    2.066462, -2.3991, 3.961728, 1, 0, 0.1686275, 1,
	    2.077927, -1.181777, 0.7891656, 1, 0, 0.1607843, 1,
	    2.079405, 0.1569915, 2.956904, 1, 0, 0.1568628, 1,
	    2.088162, -0.190165, 1.639578, 1, 0, 0.1490196, 1,
	    2.091744, -0.5719213, 2.742525, 1, 0, 0.145098, 1,
	    2.095661, -1.361598, 3.195292, 1, 0, 0.1372549, 1,
	    2.111926, -1.32135, 4.590166, 1, 0, 0.1333333, 1,
	    2.137564, 1.34132, -0.3556611, 1, 0, 0.1254902, 1,
	    2.139959, 0.2284096, 2.245927, 1, 0, 0.1215686, 1,
	    2.185298, -0.3902181, 3.23363, 1, 0, 0.1137255, 1,
	    2.212136, -1.686325, 1.401524, 1, 0, 0.1098039, 1,
	    2.230249, -0.6751032, 1.007093, 1, 0, 0.1019608, 1,
	    2.230978, -1.027376, 1.609309, 1, 0, 0.09411765, 1,
	    2.277307, 0.3912606, 1.635372, 1, 0, 0.09019608, 1,
	    2.317562, 0.2541426, 1.183669, 1, 0, 0.08235294, 1,
	    2.33838, -1.08137, 2.74118, 1, 0, 0.07843138, 1,
	    2.446646, -0.2751094, 1.402715, 1, 0, 0.07058824, 1,
	    2.488368, -1.289368, 2.382883, 1, 0, 0.06666667, 1,
	    2.491349, -1.767257, 0.9590375, 1, 0, 0.05882353, 1,
	    2.508466, -0.4073273, 2.192771, 1, 0, 0.05490196, 1,
	    2.519879, -2.189801, 0.9218072, 1, 0, 0.04705882, 1,
	    2.613479, -0.1718109, 2.185292, 1, 0, 0.04313726, 1,
	    2.629151, -0.3373981, 1.750592, 1, 0, 0.03529412, 1,
	    2.673481, -2.273634, 2.835373, 1, 0, 0.03137255, 1,
	    2.846193, 0.5850626, 1.532647, 1, 0, 0.02352941, 1,
	    2.880988, 0.2076227, 0.363856, 1, 0, 0.01960784, 1,
	    2.960788, 0.7953812, 1.347275, 1, 0, 0.01176471, 1,
	    3.220311, -0.2006301, 1.199862, 1, 0, 0.007843138, 1
	   ]);
	   var buf144 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf144);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc144 = gl.getUniformLocation(prog144,"mvMatrix");
	   var prMatLoc144 = gl.getUniformLocation(prog144,"prMatrix");
	   // ****** text object 146 ******
	   var prog146  = gl.createProgram();
	   gl.attachShader(prog146, getShader( gl, "rgl_firstexamplevshader146" ));
	   gl.attachShader(prog146, getShader( gl, "rgl_firstexamplefshader146" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog146, 0, "aPos");
	   gl.bindAttribLocation(prog146, 1, "aCol");
	   gl.linkProgram(prog146);
	   var texts = [
	    "x"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX146 = texinfo.canvasX;
	   var canvasY146 = texinfo.canvasY;
	   var ofsLoc146 = gl.getAttribLocation(prog146, "aOfs");
	   var texture146 = gl.createTexture();
	   var texLoc146 = gl.getAttribLocation(prog146, "aTexcoord");
	   var sampler146 = gl.getUniformLocation(prog146,"uSampler");
    	   handleLoadedTexture(texture146, document.getElementById("rgl_firstexampletextureCanvas"));
	   var v=new Float32Array([
	    -0.1094626, -4.927663, -8.756933, 0, -0.5, 0.5, 0.5,
	    -0.1094626, -4.927663, -8.756933, 1, -0.5, 0.5, 0.5,
	    -0.1094626, -4.927663, -8.756933, 1, 1.5, 0.5, 0.5,
	    -0.1094626, -4.927663, -8.756933, 0, 1.5, 0.5, 0.5
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
	   var buf146 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf146);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf146 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf146);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc146 = gl.getUniformLocation(prog146,"mvMatrix");
	   var prMatLoc146 = gl.getUniformLocation(prog146,"prMatrix");
	   // ****** text object 147 ******
	   var prog147  = gl.createProgram();
	   gl.attachShader(prog147, getShader( gl, "rgl_firstexamplevshader147" ));
	   gl.attachShader(prog147, getShader( gl, "rgl_firstexamplefshader147" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog147, 0, "aPos");
	   gl.bindAttribLocation(prog147, 1, "aCol");
	   gl.linkProgram(prog147);
	   var texts = [
	    "y"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX147 = texinfo.canvasX;
	   var canvasY147 = texinfo.canvasY;
	   var ofsLoc147 = gl.getAttribLocation(prog147, "aOfs");
	   var texture147 = gl.createTexture();
	   var texLoc147 = gl.getAttribLocation(prog147, "aTexcoord");
	   var sampler147 = gl.getUniformLocation(prog147,"uSampler");
    	   handleLoadedTexture(texture147, document.getElementById("rgl_firstexampletextureCanvas"));
	   var v=new Float32Array([
	    -4.56803, -0.4599636, -8.756933, 0, -0.5, 0.5, 0.5,
	    -4.56803, -0.4599636, -8.756933, 1, -0.5, 0.5, 0.5,
	    -4.56803, -0.4599636, -8.756933, 1, 1.5, 0.5, 0.5,
	    -4.56803, -0.4599636, -8.756933, 0, 1.5, 0.5, 0.5
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
	   var buf147 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf147);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf147 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf147);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc147 = gl.getUniformLocation(prog147,"mvMatrix");
	   var prMatLoc147 = gl.getUniformLocation(prog147,"prMatrix");
	   // ****** text object 148 ******
	   var prog148  = gl.createProgram();
	   gl.attachShader(prog148, getShader( gl, "rgl_firstexamplevshader148" ));
	   gl.attachShader(prog148, getShader( gl, "rgl_firstexamplefshader148" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog148, 0, "aPos");
	   gl.bindAttribLocation(prog148, 1, "aCol");
	   gl.linkProgram(prog148);
	   var texts = [
	    "z"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX148 = texinfo.canvasX;
	   var canvasY148 = texinfo.canvasY;
	   var ofsLoc148 = gl.getAttribLocation(prog148, "aOfs");
	   var texture148 = gl.createTexture();
	   var texLoc148 = gl.getAttribLocation(prog148, "aTexcoord");
	   var sampler148 = gl.getUniformLocation(prog148,"uSampler");
    	   handleLoadedTexture(texture148, document.getElementById("rgl_firstexampletextureCanvas"));
	   var v=new Float32Array([
	    -4.56803, -4.927663, -0.7320681, 0, -0.5, 0.5, 0.5,
	    -4.56803, -4.927663, -0.7320681, 1, -0.5, 0.5, 0.5,
	    -4.56803, -4.927663, -0.7320681, 1, 1.5, 0.5, 0.5,
	    -4.56803, -4.927663, -0.7320681, 0, 1.5, 0.5, 0.5
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
	   var buf148 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf148);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf148 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf148);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc148 = gl.getUniformLocation(prog148,"mvMatrix");
	   var prMatLoc148 = gl.getUniformLocation(prog148,"prMatrix");
	   // ****** lines object 149 ******
	   var prog149  = gl.createProgram();
	   gl.attachShader(prog149, getShader( gl, "rgl_firstexamplevshader149" ));
	   gl.attachShader(prog149, getShader( gl, "rgl_firstexamplefshader149" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog149, 0, "aPos");
	   gl.bindAttribLocation(prog149, 1, "aCol");
	   gl.linkProgram(prog149);
	   var v=new Float32Array([
	    -3, -3.896656, -6.905041,
	    3, -3.896656, -6.905041,
	    -3, -3.896656, -6.905041,
	    -3, -4.068491, -7.21369,
	    -2, -3.896656, -6.905041,
	    -2, -4.068491, -7.21369,
	    -1, -3.896656, -6.905041,
	    -1, -4.068491, -7.21369,
	    0, -3.896656, -6.905041,
	    0, -4.068491, -7.21369,
	    1, -3.896656, -6.905041,
	    1, -4.068491, -7.21369,
	    2, -3.896656, -6.905041,
	    2, -4.068491, -7.21369,
	    3, -3.896656, -6.905041,
	    3, -4.068491, -7.21369
	   ]);
	   var buf149 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf149);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc149 = gl.getUniformLocation(prog149,"mvMatrix");
	   var prMatLoc149 = gl.getUniformLocation(prog149,"prMatrix");
	   // ****** text object 150 ******
	   var prog150  = gl.createProgram();
	   gl.attachShader(prog150, getShader( gl, "rgl_firstexamplevshader150" ));
	   gl.attachShader(prog150, getShader( gl, "rgl_firstexamplefshader150" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog150, 0, "aPos");
	   gl.bindAttribLocation(prog150, 1, "aCol");
	   gl.linkProgram(prog150);
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
	   var canvasX150 = texinfo.canvasX;
	   var canvasY150 = texinfo.canvasY;
	   var ofsLoc150 = gl.getAttribLocation(prog150, "aOfs");
	   var texture150 = gl.createTexture();
	   var texLoc150 = gl.getAttribLocation(prog150, "aTexcoord");
	   var sampler150 = gl.getUniformLocation(prog150,"uSampler");
    	   handleLoadedTexture(texture150, document.getElementById("rgl_firstexampletextureCanvas"));
	   var v=new Float32Array([
	    -3, -4.412159, -7.830987, 0, -0.5, 0.5, 0.5,
	    -3, -4.412159, -7.830987, 1, -0.5, 0.5, 0.5,
	    -3, -4.412159, -7.830987, 1, 1.5, 0.5, 0.5,
	    -3, -4.412159, -7.830987, 0, 1.5, 0.5, 0.5,
	    -2, -4.412159, -7.830987, 0, -0.5, 0.5, 0.5,
	    -2, -4.412159, -7.830987, 1, -0.5, 0.5, 0.5,
	    -2, -4.412159, -7.830987, 1, 1.5, 0.5, 0.5,
	    -2, -4.412159, -7.830987, 0, 1.5, 0.5, 0.5,
	    -1, -4.412159, -7.830987, 0, -0.5, 0.5, 0.5,
	    -1, -4.412159, -7.830987, 1, -0.5, 0.5, 0.5,
	    -1, -4.412159, -7.830987, 1, 1.5, 0.5, 0.5,
	    -1, -4.412159, -7.830987, 0, 1.5, 0.5, 0.5,
	    0, -4.412159, -7.830987, 0, -0.5, 0.5, 0.5,
	    0, -4.412159, -7.830987, 1, -0.5, 0.5, 0.5,
	    0, -4.412159, -7.830987, 1, 1.5, 0.5, 0.5,
	    0, -4.412159, -7.830987, 0, 1.5, 0.5, 0.5,
	    1, -4.412159, -7.830987, 0, -0.5, 0.5, 0.5,
	    1, -4.412159, -7.830987, 1, -0.5, 0.5, 0.5,
	    1, -4.412159, -7.830987, 1, 1.5, 0.5, 0.5,
	    1, -4.412159, -7.830987, 0, 1.5, 0.5, 0.5,
	    2, -4.412159, -7.830987, 0, -0.5, 0.5, 0.5,
	    2, -4.412159, -7.830987, 1, -0.5, 0.5, 0.5,
	    2, -4.412159, -7.830987, 1, 1.5, 0.5, 0.5,
	    2, -4.412159, -7.830987, 0, 1.5, 0.5, 0.5,
	    3, -4.412159, -7.830987, 0, -0.5, 0.5, 0.5,
	    3, -4.412159, -7.830987, 1, -0.5, 0.5, 0.5,
	    3, -4.412159, -7.830987, 1, 1.5, 0.5, 0.5,
	    3, -4.412159, -7.830987, 0, 1.5, 0.5, 0.5
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
	   var buf150 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf150);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf150 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf150);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc150 = gl.getUniformLocation(prog150,"mvMatrix");
	   var prMatLoc150 = gl.getUniformLocation(prog150,"prMatrix");
	   // ****** lines object 151 ******
	   var prog151  = gl.createProgram();
	   gl.attachShader(prog151, getShader( gl, "rgl_firstexamplevshader151" ));
	   gl.attachShader(prog151, getShader( gl, "rgl_firstexamplefshader151" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog151, 0, "aPos");
	   gl.bindAttribLocation(prog151, 1, "aCol");
	   gl.linkProgram(prog151);
	   var v=new Float32Array([
	    -3.53913, -3, -6.905041,
	    -3.53913, 2, -6.905041,
	    -3.53913, -3, -6.905041,
	    -3.710613, -3, -7.21369,
	    -3.53913, -2, -6.905041,
	    -3.710613, -2, -7.21369,
	    -3.53913, -1, -6.905041,
	    -3.710613, -1, -7.21369,
	    -3.53913, 0, -6.905041,
	    -3.710613, 0, -7.21369,
	    -3.53913, 1, -6.905041,
	    -3.710613, 1, -7.21369,
	    -3.53913, 2, -6.905041,
	    -3.710613, 2, -7.21369
	   ]);
	   var buf151 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf151);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc151 = gl.getUniformLocation(prog151,"mvMatrix");
	   var prMatLoc151 = gl.getUniformLocation(prog151,"prMatrix");
	   // ****** text object 152 ******
	   var prog152  = gl.createProgram();
	   gl.attachShader(prog152, getShader( gl, "rgl_firstexamplevshader152" ));
	   gl.attachShader(prog152, getShader( gl, "rgl_firstexamplefshader152" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog152, 0, "aPos");
	   gl.bindAttribLocation(prog152, 1, "aCol");
	   gl.linkProgram(prog152);
	   var texts = [
	    "-3",
	    "-2",
	    "-1",
	    "0",
	    "1",
	    "2"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX152 = texinfo.canvasX;
	   var canvasY152 = texinfo.canvasY;
	   var ofsLoc152 = gl.getAttribLocation(prog152, "aOfs");
	   var texture152 = gl.createTexture();
	   var texLoc152 = gl.getAttribLocation(prog152, "aTexcoord");
	   var sampler152 = gl.getUniformLocation(prog152,"uSampler");
    	   handleLoadedTexture(texture152, document.getElementById("rgl_firstexampletextureCanvas"));
	   var v=new Float32Array([
	    -4.05358, -3, -7.830987, 0, -0.5, 0.5, 0.5,
	    -4.05358, -3, -7.830987, 1, -0.5, 0.5, 0.5,
	    -4.05358, -3, -7.830987, 1, 1.5, 0.5, 0.5,
	    -4.05358, -3, -7.830987, 0, 1.5, 0.5, 0.5,
	    -4.05358, -2, -7.830987, 0, -0.5, 0.5, 0.5,
	    -4.05358, -2, -7.830987, 1, -0.5, 0.5, 0.5,
	    -4.05358, -2, -7.830987, 1, 1.5, 0.5, 0.5,
	    -4.05358, -2, -7.830987, 0, 1.5, 0.5, 0.5,
	    -4.05358, -1, -7.830987, 0, -0.5, 0.5, 0.5,
	    -4.05358, -1, -7.830987, 1, -0.5, 0.5, 0.5,
	    -4.05358, -1, -7.830987, 1, 1.5, 0.5, 0.5,
	    -4.05358, -1, -7.830987, 0, 1.5, 0.5, 0.5,
	    -4.05358, 0, -7.830987, 0, -0.5, 0.5, 0.5,
	    -4.05358, 0, -7.830987, 1, -0.5, 0.5, 0.5,
	    -4.05358, 0, -7.830987, 1, 1.5, 0.5, 0.5,
	    -4.05358, 0, -7.830987, 0, 1.5, 0.5, 0.5,
	    -4.05358, 1, -7.830987, 0, -0.5, 0.5, 0.5,
	    -4.05358, 1, -7.830987, 1, -0.5, 0.5, 0.5,
	    -4.05358, 1, -7.830987, 1, 1.5, 0.5, 0.5,
	    -4.05358, 1, -7.830987, 0, 1.5, 0.5, 0.5,
	    -4.05358, 2, -7.830987, 0, -0.5, 0.5, 0.5,
	    -4.05358, 2, -7.830987, 1, -0.5, 0.5, 0.5,
	    -4.05358, 2, -7.830987, 1, 1.5, 0.5, 0.5,
	    -4.05358, 2, -7.830987, 0, 1.5, 0.5, 0.5
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
	   var buf152 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf152);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf152 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf152);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc152 = gl.getUniformLocation(prog152,"mvMatrix");
	   var prMatLoc152 = gl.getUniformLocation(prog152,"prMatrix");
	   // ****** lines object 153 ******
	   var prog153  = gl.createProgram();
	   gl.attachShader(prog153, getShader( gl, "rgl_firstexamplevshader153" ));
	   gl.attachShader(prog153, getShader( gl, "rgl_firstexamplefshader153" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog153, 0, "aPos");
	   gl.bindAttribLocation(prog153, 1, "aCol");
	   gl.linkProgram(prog153);
	   var v=new Float32Array([
	    -3.53913, -3.896656, -6,
	    -3.53913, -3.896656, 4,
	    -3.53913, -3.896656, -6,
	    -3.710613, -4.068491, -6,
	    -3.53913, -3.896656, -4,
	    -3.710613, -4.068491, -4,
	    -3.53913, -3.896656, -2,
	    -3.710613, -4.068491, -2,
	    -3.53913, -3.896656, 0,
	    -3.710613, -4.068491, 0,
	    -3.53913, -3.896656, 2,
	    -3.710613, -4.068491, 2,
	    -3.53913, -3.896656, 4,
	    -3.710613, -4.068491, 4
	   ]);
	   var buf153 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf153);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc153 = gl.getUniformLocation(prog153,"mvMatrix");
	   var prMatLoc153 = gl.getUniformLocation(prog153,"prMatrix");
	   // ****** text object 154 ******
	   var prog154  = gl.createProgram();
	   gl.attachShader(prog154, getShader( gl, "rgl_firstexamplevshader154" ));
	   gl.attachShader(prog154, getShader( gl, "rgl_firstexamplefshader154" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog154, 0, "aPos");
	   gl.bindAttribLocation(prog154, 1, "aCol");
	   gl.linkProgram(prog154);
	   var texts = [
	    "-6",
	    "-4",
	    "-2",
	    "0",
	    "2",
	    "4"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX154 = texinfo.canvasX;
	   var canvasY154 = texinfo.canvasY;
	   var ofsLoc154 = gl.getAttribLocation(prog154, "aOfs");
	   var texture154 = gl.createTexture();
	   var texLoc154 = gl.getAttribLocation(prog154, "aTexcoord");
	   var sampler154 = gl.getUniformLocation(prog154,"uSampler");
    	   handleLoadedTexture(texture154, document.getElementById("rgl_firstexampletextureCanvas"));
	   var v=new Float32Array([
	    -4.05358, -4.412159, -6, 0, -0.5, 0.5, 0.5,
	    -4.05358, -4.412159, -6, 1, -0.5, 0.5, 0.5,
	    -4.05358, -4.412159, -6, 1, 1.5, 0.5, 0.5,
	    -4.05358, -4.412159, -6, 0, 1.5, 0.5, 0.5,
	    -4.05358, -4.412159, -4, 0, -0.5, 0.5, 0.5,
	    -4.05358, -4.412159, -4, 1, -0.5, 0.5, 0.5,
	    -4.05358, -4.412159, -4, 1, 1.5, 0.5, 0.5,
	    -4.05358, -4.412159, -4, 0, 1.5, 0.5, 0.5,
	    -4.05358, -4.412159, -2, 0, -0.5, 0.5, 0.5,
	    -4.05358, -4.412159, -2, 1, -0.5, 0.5, 0.5,
	    -4.05358, -4.412159, -2, 1, 1.5, 0.5, 0.5,
	    -4.05358, -4.412159, -2, 0, 1.5, 0.5, 0.5,
	    -4.05358, -4.412159, 0, 0, -0.5, 0.5, 0.5,
	    -4.05358, -4.412159, 0, 1, -0.5, 0.5, 0.5,
	    -4.05358, -4.412159, 0, 1, 1.5, 0.5, 0.5,
	    -4.05358, -4.412159, 0, 0, 1.5, 0.5, 0.5,
	    -4.05358, -4.412159, 2, 0, -0.5, 0.5, 0.5,
	    -4.05358, -4.412159, 2, 1, -0.5, 0.5, 0.5,
	    -4.05358, -4.412159, 2, 1, 1.5, 0.5, 0.5,
	    -4.05358, -4.412159, 2, 0, 1.5, 0.5, 0.5,
	    -4.05358, -4.412159, 4, 0, -0.5, 0.5, 0.5,
	    -4.05358, -4.412159, 4, 1, -0.5, 0.5, 0.5,
	    -4.05358, -4.412159, 4, 1, 1.5, 0.5, 0.5,
	    -4.05358, -4.412159, 4, 0, 1.5, 0.5, 0.5
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
	   var buf154 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf154);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf154 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf154);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc154 = gl.getUniformLocation(prog154,"mvMatrix");
	   var prMatLoc154 = gl.getUniformLocation(prog154,"prMatrix");
	   // ****** lines object 155 ******
	   var prog155  = gl.createProgram();
	   gl.attachShader(prog155, getShader( gl, "rgl_firstexamplevshader155" ));
	   gl.attachShader(prog155, getShader( gl, "rgl_firstexamplefshader155" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog155, 0, "aPos");
	   gl.bindAttribLocation(prog155, 1, "aCol");
	   gl.linkProgram(prog155);
	   var v=new Float32Array([
	    -3.53913, -3.896656, -6.905041,
	    -3.53913, 2.976729, -6.905041,
	    -3.53913, -3.896656, 5.440905,
	    -3.53913, 2.976729, 5.440905,
	    -3.53913, -3.896656, -6.905041,
	    -3.53913, -3.896656, 5.440905,
	    -3.53913, 2.976729, -6.905041,
	    -3.53913, 2.976729, 5.440905,
	    -3.53913, -3.896656, -6.905041,
	    3.320205, -3.896656, -6.905041,
	    -3.53913, -3.896656, 5.440905,
	    3.320205, -3.896656, 5.440905,
	    -3.53913, 2.976729, -6.905041,
	    3.320205, 2.976729, -6.905041,
	    -3.53913, 2.976729, 5.440905,
	    3.320205, 2.976729, 5.440905,
	    3.320205, -3.896656, -6.905041,
	    3.320205, 2.976729, -6.905041,
	    3.320205, -3.896656, 5.440905,
	    3.320205, 2.976729, 5.440905,
	    3.320205, -3.896656, -6.905041,
	    3.320205, -3.896656, 5.440905,
	    3.320205, 2.976729, -6.905041,
	    3.320205, 2.976729, 5.440905
	   ]);
	   var buf155 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf155);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc155 = gl.getUniformLocation(prog155,"mvMatrix");
	   var prMatLoc155 = gl.getUniformLocation(prog155,"prMatrix");
	   gl.enable(gl.DEPTH_TEST);
	   gl.depthFunc(gl.LEQUAL);
	   gl.clearDepth(1.0);
	   gl.clearColor(1, 1, 1, 1);
	   var xOffs = yOffs = 0,  drag  = 0;
	   drawScene();
	   function drawScene(){
	     gl.depthMask(true);
	     gl.disable(gl.BLEND);
	     var radius = 8.387342;
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
	     mvMatrix.translate( 0.1094626, 0.4599636, 0.7320681 );
	     mvMatrix.scale( 1.322076, 1.319373, 0.7345374 );   
	     mvMatrix.multRight( userMatrix );  
	     mvMatrix.translate(0, 0, -distance);
	     gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
	     // ****** points object 144 *******
	     gl.useProgram(prog144);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf144);
	     gl.uniformMatrix4fv( prMatLoc144, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc144, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.enableVertexAttribArray( colLoc );
	     gl.vertexAttribPointer(colLoc, 4, gl.FLOAT, false, 28, 12);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawArrays(gl.POINTS, 0, 1000);
	     // ****** text object 146 *******
	     gl.useProgram(prog146);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf146);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf146);
	     gl.uniformMatrix4fv( prMatLoc146, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc146, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc146 );
	     gl.vertexAttribPointer(texLoc146, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture146);
	     gl.uniform1i( sampler146, 0);
	     gl.enableVertexAttribArray( ofsLoc146 );
	     gl.vertexAttribPointer(ofsLoc146, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
	     // ****** text object 147 *******
	     gl.useProgram(prog147);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf147);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf147);
	     gl.uniformMatrix4fv( prMatLoc147, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc147, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc147 );
	     gl.vertexAttribPointer(texLoc147, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture147);
	     gl.uniform1i( sampler147, 0);
	     gl.enableVertexAttribArray( ofsLoc147 );
	     gl.vertexAttribPointer(ofsLoc147, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
	     // ****** text object 148 *******
	     gl.useProgram(prog148);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf148);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf148);
	     gl.uniformMatrix4fv( prMatLoc148, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc148, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc148 );
	     gl.vertexAttribPointer(texLoc148, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture148);
	     gl.uniform1i( sampler148, 0);
	     gl.enableVertexAttribArray( ofsLoc148 );
	     gl.vertexAttribPointer(ofsLoc148, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
	     // ****** lines object 149 *******
	     gl.useProgram(prog149);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf149);
	     gl.uniformMatrix4fv( prMatLoc149, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc149, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.lineWidth( 1 );
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
	     gl.drawArrays(gl.LINES, 0, 16);
	     // ****** text object 150 *******
	     gl.useProgram(prog150);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf150);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf150);
	     gl.uniformMatrix4fv( prMatLoc150, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc150, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc150 );
	     gl.vertexAttribPointer(texLoc150, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture150);
	     gl.uniform1i( sampler150, 0);
	     gl.enableVertexAttribArray( ofsLoc150 );
	     gl.vertexAttribPointer(ofsLoc150, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 42, gl.UNSIGNED_SHORT, 0);
	     // ****** lines object 151 *******
	     gl.useProgram(prog151);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf151);
	     gl.uniformMatrix4fv( prMatLoc151, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc151, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.lineWidth( 1 );
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
	     gl.drawArrays(gl.LINES, 0, 14);
	     // ****** text object 152 *******
	     gl.useProgram(prog152);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf152);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf152);
	     gl.uniformMatrix4fv( prMatLoc152, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc152, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc152 );
	     gl.vertexAttribPointer(texLoc152, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture152);
	     gl.uniform1i( sampler152, 0);
	     gl.enableVertexAttribArray( ofsLoc152 );
	     gl.vertexAttribPointer(ofsLoc152, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 36, gl.UNSIGNED_SHORT, 0);
	     // ****** lines object 153 *******
	     gl.useProgram(prog153);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf153);
	     gl.uniformMatrix4fv( prMatLoc153, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc153, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.lineWidth( 1 );
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
	     gl.drawArrays(gl.LINES, 0, 14);
	     // ****** text object 154 *******
	     gl.useProgram(prog154);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf154);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf154);
	     gl.uniformMatrix4fv( prMatLoc154, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc154, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc154 );
	     gl.vertexAttribPointer(texLoc154, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture154);
	     gl.uniform1i( sampler154, 0);
	     gl.enableVertexAttribArray( ofsLoc154 );
	     gl.vertexAttribPointer(ofsLoc154, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 36, gl.UNSIGNED_SHORT, 0);
	     // ****** lines object 155 *******
	     gl.useProgram(prog155);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf155);
	     gl.uniformMatrix4fv( prMatLoc155, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc155, false, new Float32Array(mvMatrix.getAsArray()) );
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
<!-- ****** surface object 160 ****** -->
<script id="rgl_persp3dlmvshader160" type="x-shader/x-vertex">
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
<script id="rgl_persp3dlmfshader160" type="x-shader/x-fragment"> 
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
<!-- ****** lines object 161 ****** -->
<script id="rgl_persp3dlmvshader161" type="x-shader/x-vertex">
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
<script id="rgl_persp3dlmfshader161" type="x-shader/x-fragment"> 
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
<!-- ****** text object 163 ****** -->
<script id="rgl_persp3dlmvshader163" type="x-shader/x-vertex">
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
<script id="rgl_persp3dlmfshader163" type="x-shader/x-fragment"> 
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
<!-- ****** text object 164 ****** -->
<script id="rgl_persp3dlmvshader164" type="x-shader/x-vertex">
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
<script id="rgl_persp3dlmfshader164" type="x-shader/x-fragment"> 
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
<!-- ****** text object 165 ****** -->
<script id="rgl_persp3dlmvshader165" type="x-shader/x-vertex">
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
<script id="rgl_persp3dlmfshader165" type="x-shader/x-fragment"> 
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
<!-- ****** lines object 166 ****** -->
<script id="rgl_persp3dlmvshader166" type="x-shader/x-vertex">
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
<script id="rgl_persp3dlmfshader166" type="x-shader/x-fragment"> 
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
<!-- ****** text object 167 ****** -->
<script id="rgl_persp3dlmvshader167" type="x-shader/x-vertex">
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
<script id="rgl_persp3dlmfshader167" type="x-shader/x-fragment"> 
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
<!-- ****** lines object 168 ****** -->
<script id="rgl_persp3dlmvshader168" type="x-shader/x-vertex">
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
<script id="rgl_persp3dlmfshader168" type="x-shader/x-fragment"> 
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
<!-- ****** text object 169 ****** -->
<script id="rgl_persp3dlmvshader169" type="x-shader/x-vertex">
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
<script id="rgl_persp3dlmfshader169" type="x-shader/x-fragment"> 
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
<!-- ****** lines object 170 ****** -->
<script id="rgl_persp3dlmvshader170" type="x-shader/x-vertex">
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
<script id="rgl_persp3dlmfshader170" type="x-shader/x-fragment"> 
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
<!-- ****** text object 171 ****** -->
<script id="rgl_persp3dlmvshader171" type="x-shader/x-vertex">
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
<script id="rgl_persp3dlmfshader171" type="x-shader/x-fragment"> 
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
<!-- ****** lines object 172 ****** -->
<script id="rgl_persp3dlmvshader172" type="x-shader/x-vertex">
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
<script id="rgl_persp3dlmfshader172" type="x-shader/x-fragment"> 
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
	   // ****** surface object 160 ******
	   var prog160  = gl.createProgram();
	   gl.attachShader(prog160, getShader( gl, "rgl_persp3dlmvshader160" ));
	   gl.attachShader(prog160, getShader( gl, "rgl_persp3dlmfshader160" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog160, 0, "aPos");
	   gl.bindAttribLocation(prog160, 1, "aCol");
	   gl.linkProgram(prog160);
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
	   var normLoc160 = gl.getAttribLocation(prog160, "aNorm");
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
	   var buf160 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf160);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf160 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf160);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc160 = gl.getUniformLocation(prog160,"mvMatrix");
	   var prMatLoc160 = gl.getUniformLocation(prog160,"prMatrix");
	   var normMatLoc160 = gl.getUniformLocation(prog160,"normMatrix");
	   // ****** lines object 161 ******
	   var prog161  = gl.createProgram();
	   gl.attachShader(prog161, getShader( gl, "rgl_persp3dlmvshader161" ));
	   gl.attachShader(prog161, getShader( gl, "rgl_persp3dlmfshader161" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog161, 0, "aPos");
	   gl.bindAttribLocation(prog161, 1, "aCol");
	   gl.linkProgram(prog161);
	   var v=new Float32Array([
	    1.2, 1, 60.9009,
	    1.2, 1, 60.9009,
	    89.7, 53, 73.34235,
	    89.7, 53, 73.34235
	   ]);
	   var buf161 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf161);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc161 = gl.getUniformLocation(prog161,"mvMatrix");
	   var prMatLoc161 = gl.getUniformLocation(prog161,"prMatrix");
	   // ****** text object 163 ******
	   var prog163  = gl.createProgram();
	   gl.attachShader(prog163, getShader( gl, "rgl_persp3dlmvshader163" ));
	   gl.attachShader(prog163, getShader( gl, "rgl_persp3dlmfshader163" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog163, 0, "aPos");
	   gl.bindAttribLocation(prog163, 1, "aCol");
	   gl.linkProgram(prog163);
	   var texts = [
	    "Agriculture"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX163 = texinfo.canvasX;
	   var canvasY163 = texinfo.canvasY;
	   var ofsLoc163 = gl.getAttribLocation(prog163, "aOfs");
	   var texture163 = gl.createTexture();
	   var texLoc163 = gl.getAttribLocation(prog163, "aTexcoord");
	   var sampler163 = gl.getUniformLocation(prog163,"uSampler");
    	   handleLoadedTexture(texture163, document.getElementById("rgl_persp3dlmtextureCanvas"));
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
	   var buf163 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf163);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf163 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf163);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc163 = gl.getUniformLocation(prog163,"mvMatrix");
	   var prMatLoc163 = gl.getUniformLocation(prog163,"prMatrix");
	   // ****** text object 164 ******
	   var prog164  = gl.createProgram();
	   gl.attachShader(prog164, getShader( gl, "rgl_persp3dlmvshader164" ));
	   gl.attachShader(prog164, getShader( gl, "rgl_persp3dlmfshader164" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog164, 0, "aPos");
	   gl.bindAttribLocation(prog164, 1, "aCol");
	   gl.linkProgram(prog164);
	   var texts = [
	    "Education"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX164 = texinfo.canvasX;
	   var canvasY164 = texinfo.canvasY;
	   var ofsLoc164 = gl.getAttribLocation(prog164, "aOfs");
	   var texture164 = gl.createTexture();
	   var texLoc164 = gl.getAttribLocation(prog164, "aTexcoord");
	   var sampler164 = gl.getUniformLocation(prog164,"uSampler");
    	   handleLoadedTexture(texture164, document.getElementById("rgl_persp3dlmtextureCanvas"));
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
	   var buf164 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf164);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf164 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf164);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc164 = gl.getUniformLocation(prog164,"mvMatrix");
	   var prMatLoc164 = gl.getUniformLocation(prog164,"prMatrix");
	   // ****** text object 165 ******
	   var prog165  = gl.createProgram();
	   gl.attachShader(prog165, getShader( gl, "rgl_persp3dlmvshader165" ));
	   gl.attachShader(prog165, getShader( gl, "rgl_persp3dlmfshader165" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog165, 0, "aPos");
	   gl.bindAttribLocation(prog165, 1, "aCol");
	   gl.linkProgram(prog165);
	   var texts = [
	    "Fertility"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX165 = texinfo.canvasX;
	   var canvasY165 = texinfo.canvasY;
	   var ofsLoc165 = gl.getAttribLocation(prog165, "aOfs");
	   var texture165 = gl.createTexture();
	   var texLoc165 = gl.getAttribLocation(prog165, "aTexcoord");
	   var sampler165 = gl.getUniformLocation(prog165,"uSampler");
    	   handleLoadedTexture(texture165, document.getElementById("rgl_persp3dlmtextureCanvas"));
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
	   var buf165 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf165);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf165 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf165);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc165 = gl.getUniformLocation(prog165,"mvMatrix");
	   var prMatLoc165 = gl.getUniformLocation(prog165,"prMatrix");
	   // ****** lines object 166 ******
	   var prog166  = gl.createProgram();
	   gl.attachShader(prog166, getShader( gl, "rgl_persp3dlmvshader166" ));
	   gl.attachShader(prog166, getShader( gl, "rgl_persp3dlmfshader166" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog166, 0, "aPos");
	   gl.bindAttribLocation(prog166, 1, "aCol");
	   gl.linkProgram(prog166);
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
	   var buf166 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf166);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc166 = gl.getUniformLocation(prog166,"mvMatrix");
	   var prMatLoc166 = gl.getUniformLocation(prog166,"prMatrix");
	   // ****** text object 167 ******
	   var prog167  = gl.createProgram();
	   gl.attachShader(prog167, getShader( gl, "rgl_persp3dlmvshader167" ));
	   gl.attachShader(prog167, getShader( gl, "rgl_persp3dlmfshader167" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog167, 0, "aPos");
	   gl.bindAttribLocation(prog167, 1, "aCol");
	   gl.linkProgram(prog167);
	   var texts = [
	    "20",
	    "40",
	    "60",
	    "80"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX167 = texinfo.canvasX;
	   var canvasY167 = texinfo.canvasY;
	   var ofsLoc167 = gl.getAttribLocation(prog167, "aOfs");
	   var texture167 = gl.createTexture();
	   var texLoc167 = gl.getAttribLocation(prog167, "aTexcoord");
	   var sampler167 = gl.getUniformLocation(prog167,"uSampler");
    	   handleLoadedTexture(texture167, document.getElementById("rgl_persp3dlmtextureCanvas"));
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
	   var buf167 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf167);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf167 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf167);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc167 = gl.getUniformLocation(prog167,"mvMatrix");
	   var prMatLoc167 = gl.getUniformLocation(prog167,"prMatrix");
	   // ****** lines object 168 ******
	   var prog168  = gl.createProgram();
	   gl.attachShader(prog168, getShader( gl, "rgl_persp3dlmvshader168" ));
	   gl.attachShader(prog168, getShader( gl, "rgl_persp3dlmfshader168" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog168, 0, "aPos");
	   gl.bindAttribLocation(prog168, 1, "aCol");
	   gl.linkProgram(prog168);
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
	   var buf168 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf168);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc168 = gl.getUniformLocation(prog168,"mvMatrix");
	   var prMatLoc168 = gl.getUniformLocation(prog168,"prMatrix");
	   // ****** text object 169 ******
	   var prog169  = gl.createProgram();
	   gl.attachShader(prog169, getShader( gl, "rgl_persp3dlmvshader169" ));
	   gl.attachShader(prog169, getShader( gl, "rgl_persp3dlmfshader169" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog169, 0, "aPos");
	   gl.bindAttribLocation(prog169, 1, "aCol");
	   gl.linkProgram(prog169);
	   var texts = [
	    "10",
	    "20",
	    "30",
	    "40",
	    "50"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX169 = texinfo.canvasX;
	   var canvasY169 = texinfo.canvasY;
	   var ofsLoc169 = gl.getAttribLocation(prog169, "aOfs");
	   var texture169 = gl.createTexture();
	   var texLoc169 = gl.getAttribLocation(prog169, "aTexcoord");
	   var sampler169 = gl.getUniformLocation(prog169,"uSampler");
    	   handleLoadedTexture(texture169, document.getElementById("rgl_persp3dlmtextureCanvas"));
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
	   var buf169 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf169);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf169 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf169);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc169 = gl.getUniformLocation(prog169,"mvMatrix");
	   var prMatLoc169 = gl.getUniformLocation(prog169,"prMatrix");
	   // ****** lines object 170 ******
	   var prog170  = gl.createProgram();
	   gl.attachShader(prog170, getShader( gl, "rgl_persp3dlmvshader170" ));
	   gl.attachShader(prog170, getShader( gl, "rgl_persp3dlmfshader170" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog170, 0, "aPos");
	   gl.bindAttribLocation(prog170, 1, "aCol");
	   gl.linkProgram(prog170);
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
	   var buf170 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf170);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc170 = gl.getUniformLocation(prog170,"mvMatrix");
	   var prMatLoc170 = gl.getUniformLocation(prog170,"prMatrix");
	   // ****** text object 171 ******
	   var prog171  = gl.createProgram();
	   gl.attachShader(prog171, getShader( gl, "rgl_persp3dlmvshader171" ));
	   gl.attachShader(prog171, getShader( gl, "rgl_persp3dlmfshader171" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog171, 0, "aPos");
	   gl.bindAttribLocation(prog171, 1, "aCol");
	   gl.linkProgram(prog171);
	   var texts = [
	    "62",
	    "64",
	    "66",
	    "68",
	    "70",
	    "72"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX171 = texinfo.canvasX;
	   var canvasY171 = texinfo.canvasY;
	   var ofsLoc171 = gl.getAttribLocation(prog171, "aOfs");
	   var texture171 = gl.createTexture();
	   var texLoc171 = gl.getAttribLocation(prog171, "aTexcoord");
	   var sampler171 = gl.getUniformLocation(prog171,"uSampler");
    	   handleLoadedTexture(texture171, document.getElementById("rgl_persp3dlmtextureCanvas"));
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
	   var buf171 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf171);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf171 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf171);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc171 = gl.getUniformLocation(prog171,"mvMatrix");
	   var prMatLoc171 = gl.getUniformLocation(prog171,"prMatrix");
	   // ****** lines object 172 ******
	   var prog172  = gl.createProgram();
	   gl.attachShader(prog172, getShader( gl, "rgl_persp3dlmvshader172" ));
	   gl.attachShader(prog172, getShader( gl, "rgl_persp3dlmfshader172" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog172, 0, "aPos");
	   gl.bindAttribLocation(prog172, 1, "aCol");
	   gl.linkProgram(prog172);
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
	   var buf172 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf172);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc172 = gl.getUniformLocation(prog172,"mvMatrix");
	   var prMatLoc172 = gl.getUniformLocation(prog172,"prMatrix");
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
	     // ****** surface object 160 *******
	     gl.useProgram(prog160);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf160);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf160);
	     gl.uniformMatrix4fv( prMatLoc160, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc160, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( normMatLoc160, false, new Float32Array(normMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 1, 1, 1, 1 );
	     gl.enableVertexAttribArray( normLoc160 );
	     gl.vertexAttribPointer(normLoc160, 3, gl.FLOAT, false, 24, 12);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 24,  0);
	     gl.drawElements(gl.TRIANGLES, 3750, gl.UNSIGNED_SHORT, 0);
	     // ****** lines object 161 *******
	     gl.useProgram(prog161);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf161);
	     gl.uniformMatrix4fv( prMatLoc161, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc161, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.lineWidth( 1 );
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
	     gl.drawArrays(gl.LINES, 0, 4);
	     // ****** text object 163 *******
	     gl.useProgram(prog163);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf163);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf163);
	     gl.uniformMatrix4fv( prMatLoc163, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc163, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc163 );
	     gl.vertexAttribPointer(texLoc163, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture163);
	     gl.uniform1i( sampler163, 0);
	     gl.enableVertexAttribArray( ofsLoc163 );
	     gl.vertexAttribPointer(ofsLoc163, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
	     // ****** text object 164 *******
	     gl.useProgram(prog164);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf164);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf164);
	     gl.uniformMatrix4fv( prMatLoc164, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc164, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc164 );
	     gl.vertexAttribPointer(texLoc164, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture164);
	     gl.uniform1i( sampler164, 0);
	     gl.enableVertexAttribArray( ofsLoc164 );
	     gl.vertexAttribPointer(ofsLoc164, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
	     // ****** text object 165 *******
	     gl.useProgram(prog165);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf165);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf165);
	     gl.uniformMatrix4fv( prMatLoc165, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc165, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc165 );
	     gl.vertexAttribPointer(texLoc165, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture165);
	     gl.uniform1i( sampler165, 0);
	     gl.enableVertexAttribArray( ofsLoc165 );
	     gl.vertexAttribPointer(ofsLoc165, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
	     // ****** lines object 166 *******
	     gl.useProgram(prog166);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf166);
	     gl.uniformMatrix4fv( prMatLoc166, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc166, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.lineWidth( 1 );
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
	     gl.drawArrays(gl.LINES, 0, 10);
	     // ****** text object 167 *******
	     gl.useProgram(prog167);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf167);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf167);
	     gl.uniformMatrix4fv( prMatLoc167, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc167, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc167 );
	     gl.vertexAttribPointer(texLoc167, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture167);
	     gl.uniform1i( sampler167, 0);
	     gl.enableVertexAttribArray( ofsLoc167 );
	     gl.vertexAttribPointer(ofsLoc167, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 24, gl.UNSIGNED_SHORT, 0);
	     // ****** lines object 168 *******
	     gl.useProgram(prog168);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf168);
	     gl.uniformMatrix4fv( prMatLoc168, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc168, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.lineWidth( 1 );
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
	     gl.drawArrays(gl.LINES, 0, 12);
	     // ****** text object 169 *******
	     gl.useProgram(prog169);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf169);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf169);
	     gl.uniformMatrix4fv( prMatLoc169, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc169, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc169 );
	     gl.vertexAttribPointer(texLoc169, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture169);
	     gl.uniform1i( sampler169, 0);
	     gl.enableVertexAttribArray( ofsLoc169 );
	     gl.vertexAttribPointer(ofsLoc169, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 30, gl.UNSIGNED_SHORT, 0);
	     // ****** lines object 170 *******
	     gl.useProgram(prog170);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf170);
	     gl.uniformMatrix4fv( prMatLoc170, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc170, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.lineWidth( 1 );
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
	     gl.drawArrays(gl.LINES, 0, 14);
	     // ****** text object 171 *******
	     gl.useProgram(prog171);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf171);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf171);
	     gl.uniformMatrix4fv( prMatLoc171, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc171, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc171 );
	     gl.vertexAttribPointer(texLoc171, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture171);
	     gl.uniform1i( sampler171, 0);
	     gl.enableVertexAttribArray( ofsLoc171 );
	     gl.vertexAttribPointer(ofsLoc171, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 36, gl.UNSIGNED_SHORT, 0);
	     // ****** lines object 172 *******
	     gl.useProgram(prog172);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf172);
	     gl.uniformMatrix4fv( prMatLoc172, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc172, false, new Float32Array(mvMatrix.getAsArray()) );
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


