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
<!-- ****** points object 94 ****** -->
<script id="rgl_firstexamplevshader94" type="x-shader/x-vertex">
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
<script id="rgl_firstexamplefshader94" type="x-shader/x-fragment"> 
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
<!-- ****** text object 96 ****** -->
<script id="rgl_firstexamplevshader96" type="x-shader/x-vertex">
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
<script id="rgl_firstexamplefshader96" type="x-shader/x-fragment"> 
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
<!-- ****** text object 97 ****** -->
<script id="rgl_firstexamplevshader97" type="x-shader/x-vertex">
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
<script id="rgl_firstexamplefshader97" type="x-shader/x-fragment"> 
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
<!-- ****** text object 98 ****** -->
<script id="rgl_firstexamplevshader98" type="x-shader/x-vertex">
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
<script id="rgl_firstexamplefshader98" type="x-shader/x-fragment"> 
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
<!-- ****** lines object 99 ****** -->
<script id="rgl_firstexamplevshader99" type="x-shader/x-vertex">
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
<script id="rgl_firstexamplefshader99" type="x-shader/x-fragment"> 
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
<!-- ****** text object 100 ****** -->
<script id="rgl_firstexamplevshader100" type="x-shader/x-vertex">
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
<script id="rgl_firstexamplefshader100" type="x-shader/x-fragment"> 
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
<!-- ****** lines object 101 ****** -->
<script id="rgl_firstexamplevshader101" type="x-shader/x-vertex">
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
<script id="rgl_firstexamplefshader101" type="x-shader/x-fragment"> 
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
<!-- ****** text object 102 ****** -->
<script id="rgl_firstexamplevshader102" type="x-shader/x-vertex">
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
<script id="rgl_firstexamplefshader102" type="x-shader/x-fragment"> 
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
<!-- ****** lines object 103 ****** -->
<script id="rgl_firstexamplevshader103" type="x-shader/x-vertex">
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
<script id="rgl_firstexamplefshader103" type="x-shader/x-fragment"> 
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
<!-- ****** text object 104 ****** -->
<script id="rgl_firstexamplevshader104" type="x-shader/x-vertex">
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
<script id="rgl_firstexamplefshader104" type="x-shader/x-fragment"> 
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
<!-- ****** lines object 105 ****** -->
<script id="rgl_firstexamplevshader105" type="x-shader/x-vertex">
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
<script id="rgl_firstexamplefshader105" type="x-shader/x-fragment"> 
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
	   // ****** points object 94 ******
	   var prog94  = gl.createProgram();
	   gl.attachShader(prog94, getShader( gl, "rgl_firstexamplevshader94" ));
	   gl.attachShader(prog94, getShader( gl, "rgl_firstexamplefshader94" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog94, 0, "aPos");
	   gl.bindAttribLocation(prog94, 1, "aCol");
	   gl.linkProgram(prog94);
	   var v=new Float32Array([
	    -3.103769, 2.151248, -1.843156, 1, 0, 0, 1,
	    -3.03061, 0.1090807, -2.120064, 1, 0.007843138, 0, 1,
	    -2.848763, 1.402372, -1.941187, 1, 0.01176471, 0, 1,
	    -2.687578, -1.561553, -3.175622, 1, 0.01960784, 0, 1,
	    -2.620412, -0.7344285, -3.296712, 1, 0.02352941, 0, 1,
	    -2.479565, 0.5873669, -0.8915918, 1, 0.03137255, 0, 1,
	    -2.378986, 0.7532235, -0.8933498, 1, 0.03529412, 0, 1,
	    -2.377848, -0.09630676, -2.489486, 1, 0.04313726, 0, 1,
	    -2.36307, -0.4977866, -3.349663, 1, 0.04705882, 0, 1,
	    -2.351101, 0.219155, -2.540146, 1, 0.05490196, 0, 1,
	    -2.259215, -0.8646529, -2.51932, 1, 0.05882353, 0, 1,
	    -2.258767, 0.6225954, -0.4472273, 1, 0.06666667, 0, 1,
	    -2.167717, -0.9842703, -1.278667, 1, 0.07058824, 0, 1,
	    -2.141946, -0.8121981, -0.01980316, 1, 0.07843138, 0, 1,
	    -2.137162, 0.040836, -0.5770628, 1, 0.08235294, 0, 1,
	    -2.126595, -0.4874297, -1.678975, 1, 0.09019608, 0, 1,
	    -2.102748, 1.217123, -0.5687733, 1, 0.09411765, 0, 1,
	    -2.081701, -2.031528, -4.602645, 1, 0.1019608, 0, 1,
	    -2.07818, 0.2687683, -1.152975, 1, 0.1098039, 0, 1,
	    -2.046343, -0.6887213, -0.2202601, 1, 0.1137255, 0, 1,
	    -2.020189, -0.6266344, -1.861856, 1, 0.1215686, 0, 1,
	    -2.015748, 0.06448382, -2.687936, 1, 0.1254902, 0, 1,
	    -2.00954, -0.8219378, -2.597384, 1, 0.1333333, 0, 1,
	    -1.994238, 0.7442034, -1.929573, 1, 0.1372549, 0, 1,
	    -1.9795, -1.182146, -1.965972, 1, 0.145098, 0, 1,
	    -1.969517, 0.5328557, -1.321956, 1, 0.1490196, 0, 1,
	    -1.95743, 0.6457586, -0.8829104, 1, 0.1568628, 0, 1,
	    -1.956233, 0.3675039, -1.828308, 1, 0.1607843, 0, 1,
	    -1.955718, 2.315402, 1.478726, 1, 0.1686275, 0, 1,
	    -1.871736, -0.5444381, -2.555974, 1, 0.172549, 0, 1,
	    -1.857544, -0.08651767, -1.499019, 1, 0.1803922, 0, 1,
	    -1.844441, 0.6879352, -1.594037, 1, 0.1843137, 0, 1,
	    -1.833974, -2.310319, -3.119606, 1, 0.1921569, 0, 1,
	    -1.82158, -1.232581, -3.073749, 1, 0.1960784, 0, 1,
	    -1.787494, -0.5606846, -0.05086945, 1, 0.2039216, 0, 1,
	    -1.785618, -1.23372, -1.553525, 1, 0.2117647, 0, 1,
	    -1.784317, -0.6710498, -3.731372, 1, 0.2156863, 0, 1,
	    -1.772385, -0.3384894, -1.680132, 1, 0.2235294, 0, 1,
	    -1.740364, -0.7109162, -0.3012328, 1, 0.227451, 0, 1,
	    -1.699043, -0.1163049, -1.629038, 1, 0.2352941, 0, 1,
	    -1.681666, -1.541344, -4.379778, 1, 0.2392157, 0, 1,
	    -1.659044, 0.6564338, -1.617959, 1, 0.2470588, 0, 1,
	    -1.646303, -0.07403623, -3.089958, 1, 0.2509804, 0, 1,
	    -1.638483, -1.220395, -1.951922, 1, 0.2588235, 0, 1,
	    -1.616503, -0.5572962, -4.567562, 1, 0.2627451, 0, 1,
	    -1.605283, -0.3190906, -1.291134, 1, 0.2705882, 0, 1,
	    -1.602558, 0.8991472, -3.548562, 1, 0.2745098, 0, 1,
	    -1.597342, -0.5069604, -2.659352, 1, 0.282353, 0, 1,
	    -1.59549, -0.7864802, -0.09703743, 1, 0.2862745, 0, 1,
	    -1.595296, 0.6465555, -0.4690668, 1, 0.2941177, 0, 1,
	    -1.586522, -1.130645, -2.725849, 1, 0.3019608, 0, 1,
	    -1.586211, -1.435929, -2.236791, 1, 0.3058824, 0, 1,
	    -1.581228, 0.1976274, -1.988114, 1, 0.3137255, 0, 1,
	    -1.570359, 0.9471345, -1.589995, 1, 0.3176471, 0, 1,
	    -1.557213, 0.1629614, -1.35468, 1, 0.3254902, 0, 1,
	    -1.557023, -0.08841632, -0.9426658, 1, 0.3294118, 0, 1,
	    -1.550829, 1.008517, -3.754171, 1, 0.3372549, 0, 1,
	    -1.53979, -0.9170102, -3.117188, 1, 0.3411765, 0, 1,
	    -1.539599, -0.02503971, 0.1914808, 1, 0.3490196, 0, 1,
	    -1.526438, -0.7468507, -1.727564, 1, 0.3529412, 0, 1,
	    -1.521819, -0.3618452, -1.962493, 1, 0.3607843, 0, 1,
	    -1.518287, 1.479975, -0.0238541, 1, 0.3647059, 0, 1,
	    -1.498949, 0.112119, -2.335064, 1, 0.372549, 0, 1,
	    -1.494736, -0.2228545, -2.703753, 1, 0.3764706, 0, 1,
	    -1.489374, -0.3231218, -2.154682, 1, 0.3843137, 0, 1,
	    -1.484669, -0.1435736, -0.7440678, 1, 0.3882353, 0, 1,
	    -1.483877, -0.7881138, -2.213239, 1, 0.3960784, 0, 1,
	    -1.475818, -0.2524485, 0.1407919, 1, 0.4039216, 0, 1,
	    -1.460253, -0.5176622, -2.303113, 1, 0.4078431, 0, 1,
	    -1.455567, -0.7401516, -2.98116, 1, 0.4156863, 0, 1,
	    -1.449013, 1.113574, 0.5583297, 1, 0.4196078, 0, 1,
	    -1.446182, 0.640082, -1.84815, 1, 0.427451, 0, 1,
	    -1.444389, 0.8904048, -0.9179664, 1, 0.4313726, 0, 1,
	    -1.434852, 0.2140445, -2.762388, 1, 0.4392157, 0, 1,
	    -1.432093, -0.7530435, -1.204469, 1, 0.4431373, 0, 1,
	    -1.427527, 0.5547331, -0.5552571, 1, 0.4509804, 0, 1,
	    -1.407346, -0.360127, -3.608857, 1, 0.454902, 0, 1,
	    -1.402685, -1.245423, -3.368604, 1, 0.4627451, 0, 1,
	    -1.401935, -1.507173, -0.95149, 1, 0.4666667, 0, 1,
	    -1.401745, 0.1344761, -0.1909598, 1, 0.4745098, 0, 1,
	    -1.391066, 1.554063, -0.634583, 1, 0.4784314, 0, 1,
	    -1.388827, 0.926151, -2.428713, 1, 0.4862745, 0, 1,
	    -1.385927, 0.5427196, -2.909057, 1, 0.4901961, 0, 1,
	    -1.384584, -0.9193659, -0.9873942, 1, 0.4980392, 0, 1,
	    -1.376313, -0.3011727, -0.8482243, 1, 0.5058824, 0, 1,
	    -1.372979, -1.570156, -3.49098, 1, 0.509804, 0, 1,
	    -1.363511, 1.2745, -1.310768, 1, 0.5176471, 0, 1,
	    -1.361177, -0.1567948, -2.607277, 1, 0.5215687, 0, 1,
	    -1.358501, -0.7184387, -2.027645, 1, 0.5294118, 0, 1,
	    -1.350118, 0.3068433, -2.70648, 1, 0.5333334, 0, 1,
	    -1.349018, 0.9938598, -0.8457783, 1, 0.5411765, 0, 1,
	    -1.345788, -1.981588, -4.547023, 1, 0.5450981, 0, 1,
	    -1.34387, 0.1213195, -1.316027, 1, 0.5529412, 0, 1,
	    -1.343712, -0.5879016, -2.942647, 1, 0.5568628, 0, 1,
	    -1.327402, -0.9151489, -2.11854, 1, 0.5647059, 0, 1,
	    -1.326609, 0.2539823, -0.9762565, 1, 0.5686275, 0, 1,
	    -1.319775, 0.7906637, -0.3685284, 1, 0.5764706, 0, 1,
	    -1.319121, -0.661207, -2.118642, 1, 0.5803922, 0, 1,
	    -1.317932, 0.05685496, -0.5440436, 1, 0.5882353, 0, 1,
	    -1.314454, 0.4321873, -1.446301, 1, 0.5921569, 0, 1,
	    -1.311689, 0.07295603, -1.544572, 1, 0.6, 0, 1,
	    -1.301895, -0.5264899, -2.948663, 1, 0.6078432, 0, 1,
	    -1.299555, -0.1819028, -1.706976, 1, 0.6117647, 0, 1,
	    -1.29104, -0.4061037, -1.71299, 1, 0.6196079, 0, 1,
	    -1.287172, -0.2362993, -2.988178, 1, 0.6235294, 0, 1,
	    -1.279512, -0.6026297, -2.058026, 1, 0.6313726, 0, 1,
	    -1.279333, -0.1415821, -0.4876006, 1, 0.6352941, 0, 1,
	    -1.27595, 0.3860475, -1.186168, 1, 0.6431373, 0, 1,
	    -1.270444, -1.531584, -2.852485, 1, 0.6470588, 0, 1,
	    -1.26664, -1.123492, -3.176513, 1, 0.654902, 0, 1,
	    -1.249017, -1.092598, 0.1302617, 1, 0.6588235, 0, 1,
	    -1.2451, 0.03898945, -2.351835, 1, 0.6666667, 0, 1,
	    -1.242661, -0.2595551, -1.512643, 1, 0.6705883, 0, 1,
	    -1.216857, -0.6837976, -1.901629, 1, 0.6784314, 0, 1,
	    -1.212275, -0.1586003, 0.0950674, 1, 0.682353, 0, 1,
	    -1.203582, -0.3650811, -1.746154, 1, 0.6901961, 0, 1,
	    -1.200683, -0.6132688, -0.3648649, 1, 0.6941177, 0, 1,
	    -1.176405, -1.570155, -3.224936, 1, 0.7019608, 0, 1,
	    -1.17393, -0.6779169, 0.1677639, 1, 0.7098039, 0, 1,
	    -1.170227, 1.32296, -0.3065745, 1, 0.7137255, 0, 1,
	    -1.161329, 0.5093299, -1.572694, 1, 0.7215686, 0, 1,
	    -1.159757, -0.7860461, -0.876587, 1, 0.7254902, 0, 1,
	    -1.158305, 0.05883943, -0.2665921, 1, 0.7333333, 0, 1,
	    -1.156822, 1.073768, -0.8336475, 1, 0.7372549, 0, 1,
	    -1.150073, -2.011135, -2.674135, 1, 0.7450981, 0, 1,
	    -1.142655, -0.3036955, -2.438124, 1, 0.7490196, 0, 1,
	    -1.137511, 1.163188, 0.5454677, 1, 0.7568628, 0, 1,
	    -1.136124, 0.5175388, -1.111315, 1, 0.7607843, 0, 1,
	    -1.135964, 0.4801027, -1.76691, 1, 0.7686275, 0, 1,
	    -1.135489, 1.410087, 1.867283, 1, 0.772549, 0, 1,
	    -1.133839, 0.4093586, -1.159368, 1, 0.7803922, 0, 1,
	    -1.129119, 0.005803762, -2.474753, 1, 0.7843137, 0, 1,
	    -1.124323, -0.3065609, -2.803238, 1, 0.7921569, 0, 1,
	    -1.120548, -1.675961, -1.885957, 1, 0.7960784, 0, 1,
	    -1.120045, -1.728105, -1.563279, 1, 0.8039216, 0, 1,
	    -1.111018, -0.5409635, -1.696633, 1, 0.8117647, 0, 1,
	    -1.100685, 0.6664127, -2.814713, 1, 0.8156863, 0, 1,
	    -1.098048, 1.198267, -1.190513, 1, 0.8235294, 0, 1,
	    -1.093137, 0.1105708, -1.685541, 1, 0.827451, 0, 1,
	    -1.091052, -0.008623834, -3.695066, 1, 0.8352941, 0, 1,
	    -1.085315, 0.7353471, 0.6787243, 1, 0.8392157, 0, 1,
	    -1.083021, -2.121128, -2.611383, 1, 0.8470588, 0, 1,
	    -1.082204, -1.548063, -2.207261, 1, 0.8509804, 0, 1,
	    -1.072032, 1.025876, 0.3690585, 1, 0.8588235, 0, 1,
	    -1.071316, -0.1027506, -2.620237, 1, 0.8627451, 0, 1,
	    -1.070765, 0.9140024, 0.2990761, 1, 0.8705882, 0, 1,
	    -1.062833, -0.3266091, -0.2552003, 1, 0.8745098, 0, 1,
	    -1.062541, 0.4689133, 0.4542371, 1, 0.8823529, 0, 1,
	    -1.054328, 0.4535399, -1.716524, 1, 0.8862745, 0, 1,
	    -1.046364, 0.2502703, -2.266101, 1, 0.8941177, 0, 1,
	    -1.045847, 0.8183613, -0.1997463, 1, 0.8980392, 0, 1,
	    -1.0298, 0.195836, -0.759449, 1, 0.9058824, 0, 1,
	    -1.022435, 0.3483729, -0.3775752, 1, 0.9137255, 0, 1,
	    -1.019036, -0.3363078, -2.360278, 1, 0.9176471, 0, 1,
	    -1.001727, -1.001803, -1.977638, 1, 0.9254902, 0, 1,
	    -1.001364, 0.7014454, -0.7602586, 1, 0.9294118, 0, 1,
	    -0.9988554, 0.2384587, -1.720045, 1, 0.9372549, 0, 1,
	    -0.9988032, 0.5747332, -1.365944, 1, 0.9411765, 0, 1,
	    -0.9983435, -1.051588, -4.780455, 1, 0.9490196, 0, 1,
	    -0.9972133, -0.1824369, -0.720242, 1, 0.9529412, 0, 1,
	    -0.9948265, 0.6293594, 0.1299679, 1, 0.9607843, 0, 1,
	    -0.9934153, 1.806595, -0.5503916, 1, 0.9647059, 0, 1,
	    -0.9843801, -1.107309, -3.925747, 1, 0.972549, 0, 1,
	    -0.9751381, -0.9259814, -2.996865, 1, 0.9764706, 0, 1,
	    -0.9748333, 1.680851, -1.015597, 1, 0.9843137, 0, 1,
	    -0.9683982, -0.4990243, 0.04575123, 1, 0.9882353, 0, 1,
	    -0.9680924, -0.3349319, -3.660733, 1, 0.9960784, 0, 1,
	    -0.9680815, -0.923339, -1.497174, 0.9960784, 1, 0, 1,
	    -0.964187, -0.5863439, -2.759059, 0.9921569, 1, 0, 1,
	    -0.962316, -2.451164, -3.195791, 0.9843137, 1, 0, 1,
	    -0.9506739, -0.3120884, -1.570325, 0.9803922, 1, 0, 1,
	    -0.940005, 0.1766618, -0.2269135, 0.972549, 1, 0, 1,
	    -0.9392761, 0.9481807, -1.65331, 0.9686275, 1, 0, 1,
	    -0.9384385, 1.412433, 1.315185, 0.9607843, 1, 0, 1,
	    -0.9282774, 1.319431, -1.060655, 0.9568627, 1, 0, 1,
	    -0.9262547, -1.145433, -2.703137, 0.9490196, 1, 0, 1,
	    -0.9120103, -0.01537977, -0.7665948, 0.945098, 1, 0, 1,
	    -0.9102334, 0.4666592, -1.500224, 0.9372549, 1, 0, 1,
	    -0.9009093, 0.984297, -0.4349201, 0.9333333, 1, 0, 1,
	    -0.8986702, -0.9355921, -2.241413, 0.9254902, 1, 0, 1,
	    -0.8941373, 1.796094, 0.5084087, 0.9215686, 1, 0, 1,
	    -0.8904485, -1.041322, -2.021962, 0.9137255, 1, 0, 1,
	    -0.8849577, -0.5503141, -1.022672, 0.9098039, 1, 0, 1,
	    -0.8759872, -1.124527, -1.536423, 0.9019608, 1, 0, 1,
	    -0.863606, 1.313844, -0.5789222, 0.8941177, 1, 0, 1,
	    -0.8630707, 0.285921, -1.554763, 0.8901961, 1, 0, 1,
	    -0.8584186, 0.5192795, -3.045105, 0.8823529, 1, 0, 1,
	    -0.8578612, 2.056551, -1.516013, 0.8784314, 1, 0, 1,
	    -0.8570443, -0.6933672, 0.266702, 0.8705882, 1, 0, 1,
	    -0.8451803, 0.5249166, -1.408481, 0.8666667, 1, 0, 1,
	    -0.8439004, 0.08718148, -0.67772, 0.8588235, 1, 0, 1,
	    -0.8361687, 2.57241, 0.9445385, 0.854902, 1, 0, 1,
	    -0.8327494, 1.9201, -1.911381, 0.8470588, 1, 0, 1,
	    -0.832532, 0.3427416, -2.325807, 0.8431373, 1, 0, 1,
	    -0.82555, -0.6155449, -2.352887, 0.8352941, 1, 0, 1,
	    -0.820446, -0.3312352, 0.06483328, 0.8313726, 1, 0, 1,
	    -0.8171585, 0.6291246, -0.984892, 0.8235294, 1, 0, 1,
	    -0.8158595, 1.214534, -0.3280824, 0.8196079, 1, 0, 1,
	    -0.8037022, 0.1599173, -0.9437063, 0.8117647, 1, 0, 1,
	    -0.8017702, 0.132127, -1.695047, 0.8078431, 1, 0, 1,
	    -0.8017679, -0.7410884, -3.182261, 0.8, 1, 0, 1,
	    -0.8007844, 0.383866, -1.583735, 0.7921569, 1, 0, 1,
	    -0.7999609, 0.2619436, -1.174084, 0.7882353, 1, 0, 1,
	    -0.7969176, -0.9245212, -4.718897, 0.7803922, 1, 0, 1,
	    -0.7934695, -0.4933785, -1.126205, 0.7764706, 1, 0, 1,
	    -0.7897841, 0.4308728, 0.5913422, 0.7686275, 1, 0, 1,
	    -0.7845916, 1.091426, -1.762786, 0.7647059, 1, 0, 1,
	    -0.7801669, -1.003686, -1.181305, 0.7568628, 1, 0, 1,
	    -0.7792757, -0.4372371, -2.12504, 0.7529412, 1, 0, 1,
	    -0.7758873, -0.647067, -3.431733, 0.7450981, 1, 0, 1,
	    -0.7584245, -0.3205963, -1.088357, 0.7411765, 1, 0, 1,
	    -0.7575817, -0.580644, -1.309503, 0.7333333, 1, 0, 1,
	    -0.7571479, 0.4144619, -1.18903, 0.7294118, 1, 0, 1,
	    -0.7559995, 0.8954205, -1.391957, 0.7215686, 1, 0, 1,
	    -0.7480186, -0.9791623, -2.720284, 0.7176471, 1, 0, 1,
	    -0.7423298, -0.2484175, -0.5862084, 0.7098039, 1, 0, 1,
	    -0.7411908, 1.092175, 0.5320806, 0.7058824, 1, 0, 1,
	    -0.7383368, -0.4228143, -4.824044, 0.6980392, 1, 0, 1,
	    -0.7379549, 0.2556867, -2.472533, 0.6901961, 1, 0, 1,
	    -0.7319259, -0.09234077, -2.127036, 0.6862745, 1, 0, 1,
	    -0.7271342, 0.2588935, -1.810001, 0.6784314, 1, 0, 1,
	    -0.7266389, 1.172743, -0.1356806, 0.6745098, 1, 0, 1,
	    -0.7249267, -0.3403232, -1.234469, 0.6666667, 1, 0, 1,
	    -0.7183563, -0.8439624, -3.363302, 0.6627451, 1, 0, 1,
	    -0.7138528, -2.142735, -1.964043, 0.654902, 1, 0, 1,
	    -0.7134763, 0.4003545, -0.578858, 0.6509804, 1, 0, 1,
	    -0.7105266, -1.028946, -3.134834, 0.6431373, 1, 0, 1,
	    -0.6938615, 0.9519362, 0.1842162, 0.6392157, 1, 0, 1,
	    -0.6922936, 0.9764464, -0.5685201, 0.6313726, 1, 0, 1,
	    -0.6907317, -0.08556126, -2.512707, 0.627451, 1, 0, 1,
	    -0.6872652, -0.473258, -3.648338, 0.6196079, 1, 0, 1,
	    -0.6870683, -0.5358779, -1.991022, 0.6156863, 1, 0, 1,
	    -0.6868176, -1.326261, -4.401165, 0.6078432, 1, 0, 1,
	    -0.6814346, 0.117649, -2.053404, 0.6039216, 1, 0, 1,
	    -0.6748987, -1.133602, -1.399938, 0.5960785, 1, 0, 1,
	    -0.674882, -0.962263, -1.920608, 0.5882353, 1, 0, 1,
	    -0.6735657, -0.2237176, -2.660398, 0.5843138, 1, 0, 1,
	    -0.6691982, 0.3721908, -2.029763, 0.5764706, 1, 0, 1,
	    -0.6650809, 1.985012, 0.1595134, 0.572549, 1, 0, 1,
	    -0.6637599, -0.1389744, -2.72498, 0.5647059, 1, 0, 1,
	    -0.658519, 0.5443553, -0.8627701, 0.5607843, 1, 0, 1,
	    -0.6570274, -0.9816534, -3.894879, 0.5529412, 1, 0, 1,
	    -0.6471385, 1.793041, 1.469393, 0.5490196, 1, 0, 1,
	    -0.6452298, 1.001431, -1.722068, 0.5411765, 1, 0, 1,
	    -0.6420119, 0.6607069, -1.783264, 0.5372549, 1, 0, 1,
	    -0.64012, -0.8053604, -2.471117, 0.5294118, 1, 0, 1,
	    -0.6375887, 1.63245, -0.2261735, 0.5254902, 1, 0, 1,
	    -0.6315449, 0.9115609, -1.980918, 0.5176471, 1, 0, 1,
	    -0.6266161, -1.177032, -1.474715, 0.5137255, 1, 0, 1,
	    -0.6241111, 1.549564, -2.752141, 0.5058824, 1, 0, 1,
	    -0.6230686, -0.1909857, -1.26203, 0.5019608, 1, 0, 1,
	    -0.6225927, -0.2214126, -2.976119, 0.4941176, 1, 0, 1,
	    -0.6212004, 0.161331, -0.4674349, 0.4862745, 1, 0, 1,
	    -0.6210245, 1.5147, -0.339759, 0.4823529, 1, 0, 1,
	    -0.6179527, -0.5149537, -1.41466, 0.4745098, 1, 0, 1,
	    -0.6160833, -0.1878877, -1.729901, 0.4705882, 1, 0, 1,
	    -0.6139492, -0.9723181, -3.572436, 0.4627451, 1, 0, 1,
	    -0.6061262, -0.2874621, -2.48442, 0.4588235, 1, 0, 1,
	    -0.6058798, -0.9740598, -3.157059, 0.4509804, 1, 0, 1,
	    -0.6038949, 0.6455714, 0.2355675, 0.4470588, 1, 0, 1,
	    -0.6035618, 0.02541887, -0.6225902, 0.4392157, 1, 0, 1,
	    -0.5998701, 0.6861036, -0.7040362, 0.4352941, 1, 0, 1,
	    -0.5980545, 0.03971142, -2.453792, 0.427451, 1, 0, 1,
	    -0.5936152, 1.442493, 0.8192097, 0.4235294, 1, 0, 1,
	    -0.5888603, -1.631574, -4.524597, 0.4156863, 1, 0, 1,
	    -0.5846075, 0.8657881, -0.9306845, 0.4117647, 1, 0, 1,
	    -0.5833748, -1.209696, -1.405248, 0.4039216, 1, 0, 1,
	    -0.5769174, 0.8043394, 0.3061261, 0.3960784, 1, 0, 1,
	    -0.5768287, 0.9359342, 1.385605, 0.3921569, 1, 0, 1,
	    -0.5764967, -1.801044, -1.323284, 0.3843137, 1, 0, 1,
	    -0.5703974, -0.498446, -0.9228435, 0.3803922, 1, 0, 1,
	    -0.5698517, 0.07744116, -0.6703385, 0.372549, 1, 0, 1,
	    -0.5688158, -0.8563312, -4.550195, 0.3686275, 1, 0, 1,
	    -0.5687057, -0.507553, -1.875835, 0.3607843, 1, 0, 1,
	    -0.5577565, 0.1896349, -1.895675, 0.3568628, 1, 0, 1,
	    -0.5514869, 0.4086357, 0.04182097, 0.3490196, 1, 0, 1,
	    -0.5398352, -0.0008000008, -2.142089, 0.345098, 1, 0, 1,
	    -0.5397846, -1.347903, -4.708817, 0.3372549, 1, 0, 1,
	    -0.5371801, 1.699786, -1.570387, 0.3333333, 1, 0, 1,
	    -0.5336661, 1.279177, -0.7083117, 0.3254902, 1, 0, 1,
	    -0.5260924, 0.3937286, -1.101308, 0.3215686, 1, 0, 1,
	    -0.5209115, -2.3489, -2.722697, 0.3137255, 1, 0, 1,
	    -0.5200592, -0.4137437, -2.202182, 0.3098039, 1, 0, 1,
	    -0.5119806, 0.5165349, -0.9310308, 0.3019608, 1, 0, 1,
	    -0.5062205, -0.3442533, -3.972046, 0.2941177, 1, 0, 1,
	    -0.5002748, -1.280132, -2.077107, 0.2901961, 1, 0, 1,
	    -0.4980447, 0.8013512, -1.386186, 0.282353, 1, 0, 1,
	    -0.4974563, -1.186617, -1.16956, 0.2784314, 1, 0, 1,
	    -0.4941863, 1.65467, -0.6707562, 0.2705882, 1, 0, 1,
	    -0.4897163, -0.4646556, -0.3026025, 0.2666667, 1, 0, 1,
	    -0.4838223, 0.9240313, -1.125041, 0.2588235, 1, 0, 1,
	    -0.4825782, 0.08768822, -1.484686, 0.254902, 1, 0, 1,
	    -0.4815719, -1.345282, -3.245721, 0.2470588, 1, 0, 1,
	    -0.480125, -0.6050443, -2.04952, 0.2431373, 1, 0, 1,
	    -0.4760485, -0.9842713, -2.783687, 0.2352941, 1, 0, 1,
	    -0.4726295, 0.8605907, -1.302736, 0.2313726, 1, 0, 1,
	    -0.4723531, -0.4200444, -2.479342, 0.2235294, 1, 0, 1,
	    -0.4720052, -0.07988469, -0.8860063, 0.2196078, 1, 0, 1,
	    -0.4669372, -0.6765052, -0.7606933, 0.2117647, 1, 0, 1,
	    -0.4665228, 0.2645122, 0.7589402, 0.2078431, 1, 0, 1,
	    -0.4619984, -0.87534, -2.143691, 0.2, 1, 0, 1,
	    -0.4607653, -1.870359, -2.367742, 0.1921569, 1, 0, 1,
	    -0.4581733, -0.1796978, -1.548855, 0.1882353, 1, 0, 1,
	    -0.4568826, 0.4353916, -0.3569188, 0.1803922, 1, 0, 1,
	    -0.4547513, -0.1730085, -1.207762, 0.1764706, 1, 0, 1,
	    -0.4537456, 1.204974, 0.7183257, 0.1686275, 1, 0, 1,
	    -0.4495248, 1.136001, 0.3916061, 0.1647059, 1, 0, 1,
	    -0.4425051, -1.479139, -2.293972, 0.1568628, 1, 0, 1,
	    -0.4385752, 0.2356798, -1.304877, 0.1529412, 1, 0, 1,
	    -0.4376342, -0.3208921, -3.138858, 0.145098, 1, 0, 1,
	    -0.4372941, -0.5195372, -1.527655, 0.1411765, 1, 0, 1,
	    -0.4372345, -0.1585431, -1.667651, 0.1333333, 1, 0, 1,
	    -0.4355629, -1.304564, -1.178629, 0.1294118, 1, 0, 1,
	    -0.4349251, -1.376398, -4.732049, 0.1215686, 1, 0, 1,
	    -0.4306054, -0.2379006, -1.951203, 0.1176471, 1, 0, 1,
	    -0.4301011, 0.7613515, 0.5610576, 0.1098039, 1, 0, 1,
	    -0.4299199, -0.09768046, -2.616378, 0.1058824, 1, 0, 1,
	    -0.4124089, -0.7381591, -2.946392, 0.09803922, 1, 0, 1,
	    -0.4110183, -0.7262331, -2.268483, 0.09019608, 1, 0, 1,
	    -0.4090599, -0.8605613, -2.443142, 0.08627451, 1, 0, 1,
	    -0.4086692, 0.2724251, -0.1138999, 0.07843138, 1, 0, 1,
	    -0.4067079, 0.886777, -1.282811, 0.07450981, 1, 0, 1,
	    -0.4010576, -2.007818, -2.418399, 0.06666667, 1, 0, 1,
	    -0.4000274, -1.475392, -3.906206, 0.0627451, 1, 0, 1,
	    -0.395774, -0.09461121, -0.8811527, 0.05490196, 1, 0, 1,
	    -0.3929695, 0.1940483, -0.6813296, 0.05098039, 1, 0, 1,
	    -0.3917288, -0.9430545, -3.631945, 0.04313726, 1, 0, 1,
	    -0.3882264, -0.3430443, -3.203662, 0.03921569, 1, 0, 1,
	    -0.3856331, -1.320601, -2.046689, 0.03137255, 1, 0, 1,
	    -0.3851339, -0.4934844, -3.902893, 0.02745098, 1, 0, 1,
	    -0.3802514, 0.6851487, -0.7097318, 0.01960784, 1, 0, 1,
	    -0.3755834, 1.091415, 0.4853616, 0.01568628, 1, 0, 1,
	    -0.3722327, 0.5160635, -0.5882556, 0.007843138, 1, 0, 1,
	    -0.3689753, -0.2363771, -2.560064, 0.003921569, 1, 0, 1,
	    -0.3633092, -0.453583, -1.326872, 0, 1, 0.003921569, 1,
	    -0.3591253, 0.7230499, -1.98143, 0, 1, 0.01176471, 1,
	    -0.3528946, -0.94737, -3.324986, 0, 1, 0.01568628, 1,
	    -0.3423124, 0.2422457, -0.3844138, 0, 1, 0.02352941, 1,
	    -0.3417656, 2.035921, 0.78662, 0, 1, 0.02745098, 1,
	    -0.3397354, 0.2112535, 0.2129428, 0, 1, 0.03529412, 1,
	    -0.3351687, 0.8694578, 0.3811456, 0, 1, 0.03921569, 1,
	    -0.3345967, 0.9469796, 1.057091, 0, 1, 0.04705882, 1,
	    -0.3342884, -0.7571941, -2.360044, 0, 1, 0.05098039, 1,
	    -0.3333454, 0.1733068, -2.073017, 0, 1, 0.05882353, 1,
	    -0.3321935, 0.8259566, 0.5771478, 0, 1, 0.0627451, 1,
	    -0.3272672, 0.7318233, 0.4718744, 0, 1, 0.07058824, 1,
	    -0.3249727, -1.376919, -3.514101, 0, 1, 0.07450981, 1,
	    -0.3164917, 0.1739027, -0.3820891, 0, 1, 0.08235294, 1,
	    -0.3157667, 2.358226, 1.287455, 0, 1, 0.08627451, 1,
	    -0.3149306, -1.468944, -2.432461, 0, 1, 0.09411765, 1,
	    -0.3145859, 0.2483844, -0.6000438, 0, 1, 0.1019608, 1,
	    -0.3088075, -0.4258591, -3.38636, 0, 1, 0.1058824, 1,
	    -0.3052467, 0.1352269, -2.032222, 0, 1, 0.1137255, 1,
	    -0.302209, -0.5992568, -2.831613, 0, 1, 0.1176471, 1,
	    -0.3008513, 0.9255686, 0.3509325, 0, 1, 0.1254902, 1,
	    -0.2979078, 0.4235777, 0.8998426, 0, 1, 0.1294118, 1,
	    -0.2956622, 0.5409221, -0.186619, 0, 1, 0.1372549, 1,
	    -0.2954942, -0.4836506, -2.364669, 0, 1, 0.1411765, 1,
	    -0.294187, 1.566116, -1.454702, 0, 1, 0.1490196, 1,
	    -0.2841185, -0.7667273, -1.741219, 0, 1, 0.1529412, 1,
	    -0.2809695, 0.5625246, 0.07817792, 0, 1, 0.1607843, 1,
	    -0.2808872, 0.1036331, -0.8923236, 0, 1, 0.1647059, 1,
	    -0.280609, -1.571724, -2.831681, 0, 1, 0.172549, 1,
	    -0.2798006, 1.12006, -1.00736, 0, 1, 0.1764706, 1,
	    -0.2704588, 0.6679914, 1.395315, 0, 1, 0.1843137, 1,
	    -0.2704075, 0.8714411, -0.5671114, 0, 1, 0.1882353, 1,
	    -0.2674742, -0.1271055, -1.351289, 0, 1, 0.1960784, 1,
	    -0.2656493, 1.903466, -0.620619, 0, 1, 0.2039216, 1,
	    -0.2647487, -1.878359, -2.454569, 0, 1, 0.2078431, 1,
	    -0.26414, 0.09991039, -1.343627, 0, 1, 0.2156863, 1,
	    -0.2615986, 0.1735623, -0.6133329, 0, 1, 0.2196078, 1,
	    -0.2598422, -0.1632577, -2.392942, 0, 1, 0.227451, 1,
	    -0.2576244, 1.490574, 1.146429, 0, 1, 0.2313726, 1,
	    -0.2562437, -0.6634913, -1.278195, 0, 1, 0.2392157, 1,
	    -0.251687, -0.6240631, -2.674614, 0, 1, 0.2431373, 1,
	    -0.2506477, -1.413933, -2.327481, 0, 1, 0.2509804, 1,
	    -0.2486379, -0.3525626, -0.7353641, 0, 1, 0.254902, 1,
	    -0.2435722, 1.27083, -1.156187, 0, 1, 0.2627451, 1,
	    -0.2411383, -1.591919, -2.855029, 0, 1, 0.2666667, 1,
	    -0.2378505, 0.07597501, -0.008185384, 0, 1, 0.2745098, 1,
	    -0.2298586, -0.2321021, -2.782258, 0, 1, 0.2784314, 1,
	    -0.2229011, 0.3969898, -0.866721, 0, 1, 0.2862745, 1,
	    -0.2149083, 1.156535, 0.5901629, 0, 1, 0.2901961, 1,
	    -0.2148668, 0.2930601, -0.305723, 0, 1, 0.2980392, 1,
	    -0.2124658, 0.3634472, -0.914817, 0, 1, 0.3058824, 1,
	    -0.2113021, -2.616294, -2.814839, 0, 1, 0.3098039, 1,
	    -0.2097144, -0.2229155, -2.297438, 0, 1, 0.3176471, 1,
	    -0.2053322, -0.5160332, -1.574647, 0, 1, 0.3215686, 1,
	    -0.2050758, -1.450643, -3.706548, 0, 1, 0.3294118, 1,
	    -0.2043335, 0.6521446, -0.6468897, 0, 1, 0.3333333, 1,
	    -0.2035689, -1.049971, -3.745349, 0, 1, 0.3411765, 1,
	    -0.199506, -0.6977345, -2.76861, 0, 1, 0.345098, 1,
	    -0.1958714, 0.06131787, -0.8792552, 0, 1, 0.3529412, 1,
	    -0.1932516, 1.530922, 0.9297247, 0, 1, 0.3568628, 1,
	    -0.1927217, -0.2172276, -1.769449, 0, 1, 0.3647059, 1,
	    -0.1905731, -0.7248958, -4.878359, 0, 1, 0.3686275, 1,
	    -0.1897256, 0.825735, -0.1399465, 0, 1, 0.3764706, 1,
	    -0.1809757, -0.7448835, -4.499066, 0, 1, 0.3803922, 1,
	    -0.1807985, 0.9711443, -0.4909883, 0, 1, 0.3882353, 1,
	    -0.1758944, 1.994061, 2.441819, 0, 1, 0.3921569, 1,
	    -0.1721245, -1.039278, -1.328398, 0, 1, 0.4, 1,
	    -0.1659971, 0.08139135, 0.1548479, 0, 1, 0.4078431, 1,
	    -0.1607728, -0.0783264, -1.626621, 0, 1, 0.4117647, 1,
	    -0.1606564, 0.3113486, -0.1762025, 0, 1, 0.4196078, 1,
	    -0.1601666, -0.04936608, -2.725666, 0, 1, 0.4235294, 1,
	    -0.1592531, -0.9142474, -1.666006, 0, 1, 0.4313726, 1,
	    -0.1587624, 1.181761, -0.9736547, 0, 1, 0.4352941, 1,
	    -0.1567861, 0.6748482, 1.703413, 0, 1, 0.4431373, 1,
	    -0.1543567, 0.8317468, 0.2087116, 0, 1, 0.4470588, 1,
	    -0.1510852, 1.119914, -1.12174, 0, 1, 0.454902, 1,
	    -0.1468024, 1.042329, 0.01626759, 0, 1, 0.4588235, 1,
	    -0.1428913, -0.1383515, -4.695455, 0, 1, 0.4666667, 1,
	    -0.1413248, 0.05984287, -1.657433, 0, 1, 0.4705882, 1,
	    -0.1404386, -1.278636, -3.615939, 0, 1, 0.4784314, 1,
	    -0.1391578, -0.162294, -3.550304, 0, 1, 0.4823529, 1,
	    -0.1380765, -2.517401, -1.740193, 0, 1, 0.4901961, 1,
	    -0.1246507, -1.161332, -3.074, 0, 1, 0.4941176, 1,
	    -0.1213381, -1.394513, -0.1800642, 0, 1, 0.5019608, 1,
	    -0.119576, 0.4272334, -1.061696, 0, 1, 0.509804, 1,
	    -0.1178606, 0.3041493, -0.8354764, 0, 1, 0.5137255, 1,
	    -0.117138, 1.00869, -0.9127445, 0, 1, 0.5215687, 1,
	    -0.1169753, 0.6586829, -0.8642981, 0, 1, 0.5254902, 1,
	    -0.1168504, -1.462076, -2.904655, 0, 1, 0.5333334, 1,
	    -0.1155094, -0.1761197, -1.623343, 0, 1, 0.5372549, 1,
	    -0.1136699, 1.026891, 0.05468743, 0, 1, 0.5450981, 1,
	    -0.1098699, 0.845043, 0.4930641, 0, 1, 0.5490196, 1,
	    -0.1096928, -0.7193965, -3.841461, 0, 1, 0.5568628, 1,
	    -0.1093202, -0.6504142, -3.291993, 0, 1, 0.5607843, 1,
	    -0.109313, 0.4122153, 0.2553068, 0, 1, 0.5686275, 1,
	    -0.1089126, 0.5196432, -1.178023, 0, 1, 0.572549, 1,
	    -0.1024368, 1.075393, -0.1719241, 0, 1, 0.5803922, 1,
	    -0.1013398, -0.4099342, -3.060699, 0, 1, 0.5843138, 1,
	    -0.09834351, -0.1944009, -1.972049, 0, 1, 0.5921569, 1,
	    -0.09634567, 1.277887, -1.30194, 0, 1, 0.5960785, 1,
	    -0.09440506, 0.7971768, -0.1681588, 0, 1, 0.6039216, 1,
	    -0.09132516, -0.142189, -4.056698, 0, 1, 0.6117647, 1,
	    -0.09032404, 0.298486, -1.025282, 0, 1, 0.6156863, 1,
	    -0.08815698, -1.074523, -1.842102, 0, 1, 0.6235294, 1,
	    -0.08814421, 1.439695, 1.720114, 0, 1, 0.627451, 1,
	    -0.08669153, -0.08761304, -3.63187, 0, 1, 0.6352941, 1,
	    -0.08506767, -0.5683488, -2.794384, 0, 1, 0.6392157, 1,
	    -0.08445286, -1.122886, -2.529787, 0, 1, 0.6470588, 1,
	    -0.0843455, 0.9934797, 1.70822, 0, 1, 0.6509804, 1,
	    -0.08092277, -2.17299, -2.916212, 0, 1, 0.6588235, 1,
	    -0.07685111, 0.455862, -0.5098398, 0, 1, 0.6627451, 1,
	    -0.07376783, -1.837622, -1.955045, 0, 1, 0.6705883, 1,
	    -0.07189178, -2.357075, -1.921939, 0, 1, 0.6745098, 1,
	    -0.06806726, 1.3641, 0.5092027, 0, 1, 0.682353, 1,
	    -0.06605568, 1.493398, -0.346942, 0, 1, 0.6862745, 1,
	    -0.0656896, -1.135257, -2.312277, 0, 1, 0.6941177, 1,
	    -0.0651053, -0.4350039, -2.440046, 0, 1, 0.7019608, 1,
	    -0.06494287, -0.5771737, -2.088737, 0, 1, 0.7058824, 1,
	    -0.06482498, -1.152554, -2.483595, 0, 1, 0.7137255, 1,
	    -0.06471013, -1.868217, -2.937654, 0, 1, 0.7176471, 1,
	    -0.06392502, 1.250102, -0.7408851, 0, 1, 0.7254902, 1,
	    -0.06316692, -0.07585391, -2.20885, 0, 1, 0.7294118, 1,
	    -0.06206095, -0.9919841, -3.612582, 0, 1, 0.7372549, 1,
	    -0.04804239, 0.1825911, -0.2055077, 0, 1, 0.7411765, 1,
	    -0.04786605, -0.2129228, -3.156884, 0, 1, 0.7490196, 1,
	    -0.04439145, 1.543668, 0.7899745, 0, 1, 0.7529412, 1,
	    -0.04180722, 1.181261, 0.05395512, 0, 1, 0.7607843, 1,
	    -0.03944497, 0.6287355, -0.6962522, 0, 1, 0.7647059, 1,
	    -0.03887837, 0.3559391, -1.633666, 0, 1, 0.772549, 1,
	    -0.03276254, -1.312383, -4.666195, 0, 1, 0.7764706, 1,
	    -0.03195861, 0.4454325, 1.434657, 0, 1, 0.7843137, 1,
	    -0.03087584, 0.7392802, 0.7185706, 0, 1, 0.7882353, 1,
	    -0.03063207, -1.197013, -3.76267, 0, 1, 0.7960784, 1,
	    -0.02941194, 2.324847, -0.5681573, 0, 1, 0.8039216, 1,
	    -0.02901856, 1.585003, 0.9084568, 0, 1, 0.8078431, 1,
	    -0.02780912, 0.2135091, 0.660699, 0, 1, 0.8156863, 1,
	    -0.02563426, -1.044041, -4.22323, 0, 1, 0.8196079, 1,
	    -0.02539822, 0.9437197, 1.362003, 0, 1, 0.827451, 1,
	    -0.02319324, -1.324192, -2.484858, 0, 1, 0.8313726, 1,
	    -0.02186525, 0.3564605, -2.48117, 0, 1, 0.8392157, 1,
	    -0.02107761, -0.06942944, -1.501841, 0, 1, 0.8431373, 1,
	    -0.01654774, -0.8971802, -5.074194, 0, 1, 0.8509804, 1,
	    -0.01622891, -0.09668388, -3.613518, 0, 1, 0.854902, 1,
	    -0.0136885, 0.2213553, 0.4774333, 0, 1, 0.8627451, 1,
	    -0.01083822, -1.18392, -4.360388, 0, 1, 0.8666667, 1,
	    -0.002112255, -0.2170373, -3.203021, 0, 1, 0.8745098, 1,
	    -0.001277257, -0.4676526, -3.60521, 0, 1, 0.8784314, 1,
	    0.00109565, -0.06791448, 1.757625, 0, 1, 0.8862745, 1,
	    0.0065479, 1.731506, 0.576281, 0, 1, 0.8901961, 1,
	    0.007235385, 1.621075, 0.8851656, 0, 1, 0.8980392, 1,
	    0.007305135, -1.730532, 3.669037, 0, 1, 0.9058824, 1,
	    0.007996491, -1.546947, 2.567564, 0, 1, 0.9098039, 1,
	    0.01000887, -0.2519036, 3.051034, 0, 1, 0.9176471, 1,
	    0.01049008, 0.4922134, 0.0642366, 0, 1, 0.9215686, 1,
	    0.01598426, -0.4256099, 2.675262, 0, 1, 0.9294118, 1,
	    0.01719673, -0.1070961, 1.901454, 0, 1, 0.9333333, 1,
	    0.01906673, 0.2112879, -0.3006978, 0, 1, 0.9411765, 1,
	    0.02178797, 0.6927544, 0.1284952, 0, 1, 0.945098, 1,
	    0.02254725, 0.5641271, 0.005777624, 0, 1, 0.9529412, 1,
	    0.02293142, -0.9425886, 3.095216, 0, 1, 0.9568627, 1,
	    0.02313663, -0.1978112, 2.44242, 0, 1, 0.9647059, 1,
	    0.02448767, -0.7265925, 2.847798, 0, 1, 0.9686275, 1,
	    0.02516872, -1.896128, 5.77419, 0, 1, 0.9764706, 1,
	    0.02963101, -1.083988, 2.479448, 0, 1, 0.9803922, 1,
	    0.03070519, -0.9216022, 3.185864, 0, 1, 0.9882353, 1,
	    0.03101763, -0.6753556, 1.259447, 0, 1, 0.9921569, 1,
	    0.03353935, 1.258534, 0.7078465, 0, 1, 1, 1,
	    0.03555871, -0.4418988, 3.182755, 0, 0.9921569, 1, 1,
	    0.03558733, 0.4162143, -0.5494773, 0, 0.9882353, 1, 1,
	    0.03707151, 0.008990203, 0.2581889, 0, 0.9803922, 1, 1,
	    0.03720941, -0.6583515, 3.180821, 0, 0.9764706, 1, 1,
	    0.03748226, -1.371925, 3.706375, 0, 0.9686275, 1, 1,
	    0.04133748, 0.933325, 1.086378, 0, 0.9647059, 1, 1,
	    0.04233965, 0.559011, 1.949665, 0, 0.9568627, 1, 1,
	    0.04737714, 3.088356, 1.007669, 0, 0.9529412, 1, 1,
	    0.04762843, 0.7410877, -0.3772374, 0, 0.945098, 1, 1,
	    0.0486577, -0.3713195, 2.799018, 0, 0.9411765, 1, 1,
	    0.04990186, 0.9144936, -1.175158, 0, 0.9333333, 1, 1,
	    0.05163516, -1.080757, 4.173158, 0, 0.9294118, 1, 1,
	    0.05443631, -0.8640078, 3.7008, 0, 0.9215686, 1, 1,
	    0.05446646, -0.4018265, 2.922895, 0, 0.9176471, 1, 1,
	    0.05569802, -0.1386427, 4.406629, 0, 0.9098039, 1, 1,
	    0.05796159, 0.6465452, 0.4382841, 0, 0.9058824, 1, 1,
	    0.06242638, -1.91924, 3.621982, 0, 0.8980392, 1, 1,
	    0.062847, -0.204186, 2.740284, 0, 0.8901961, 1, 1,
	    0.06764124, -0.7120736, 2.295303, 0, 0.8862745, 1, 1,
	    0.06897785, 0.5562999, -0.1077167, 0, 0.8784314, 1, 1,
	    0.07030936, 1.492524, -0.6106367, 0, 0.8745098, 1, 1,
	    0.0704453, 2.039462, -0.4367281, 0, 0.8666667, 1, 1,
	    0.07309717, 1.066765, -1.385401, 0, 0.8627451, 1, 1,
	    0.07503876, 1.066495, -0.06204309, 0, 0.854902, 1, 1,
	    0.09224268, -0.856713, 2.847942, 0, 0.8509804, 1, 1,
	    0.09375853, -1.421069, 3.298914, 0, 0.8431373, 1, 1,
	    0.09661748, 0.7327167, -1.065083, 0, 0.8392157, 1, 1,
	    0.09855438, 0.5784623, -0.5953506, 0, 0.8313726, 1, 1,
	    0.1010555, 0.2940952, -1.319111, 0, 0.827451, 1, 1,
	    0.1024935, -0.5507484, 1.739128, 0, 0.8196079, 1, 1,
	    0.1024974, 1.160283, 0.02182011, 0, 0.8156863, 1, 1,
	    0.1050195, -0.1232628, 2.013679, 0, 0.8078431, 1, 1,
	    0.1086131, 0.1114838, 1.36165, 0, 0.8039216, 1, 1,
	    0.1122857, 0.656593, 0.5854101, 0, 0.7960784, 1, 1,
	    0.1142318, 1.220837, 0.5685057, 0, 0.7882353, 1, 1,
	    0.1159318, -1.069394, 1.328745, 0, 0.7843137, 1, 1,
	    0.1219882, -1.144302, 2.11958, 0, 0.7764706, 1, 1,
	    0.1249326, -0.7187751, 5.193005, 0, 0.772549, 1, 1,
	    0.1273686, 1.484987, 0.8926842, 0, 0.7647059, 1, 1,
	    0.1277577, -1.227353, 2.371562, 0, 0.7607843, 1, 1,
	    0.1287554, -0.2729055, 1.672258, 0, 0.7529412, 1, 1,
	    0.129343, -0.007289428, 1.891174, 0, 0.7490196, 1, 1,
	    0.1360062, 0.654065, -0.5404584, 0, 0.7411765, 1, 1,
	    0.1422989, -0.8815889, 3.291749, 0, 0.7372549, 1, 1,
	    0.1437884, -0.7073942, 3.216519, 0, 0.7294118, 1, 1,
	    0.1438015, -0.9802638, 3.976486, 0, 0.7254902, 1, 1,
	    0.1441945, 1.069486, 1.251221, 0, 0.7176471, 1, 1,
	    0.1470499, 0.5682387, 1.091156, 0, 0.7137255, 1, 1,
	    0.1470676, 0.6319802, 0.1464476, 0, 0.7058824, 1, 1,
	    0.147402, -2.035466, 5.036943, 0, 0.6980392, 1, 1,
	    0.1523945, -0.5814658, 3.245713, 0, 0.6941177, 1, 1,
	    0.1532763, 0.7057228, -0.7642672, 0, 0.6862745, 1, 1,
	    0.1586428, 0.8341512, 0.07918645, 0, 0.682353, 1, 1,
	    0.1615901, -0.3690507, 2.676911, 0, 0.6745098, 1, 1,
	    0.161822, 1.182642, 2.069902, 0, 0.6705883, 1, 1,
	    0.1635175, -1.84608, 4.601362, 0, 0.6627451, 1, 1,
	    0.1668099, 1.396107, -0.09424166, 0, 0.6588235, 1, 1,
	    0.167349, 3.074263, -0.4789416, 0, 0.6509804, 1, 1,
	    0.1673977, 0.7409151, 0.09647071, 0, 0.6470588, 1, 1,
	    0.1681215, -0.3093894, 2.296367, 0, 0.6392157, 1, 1,
	    0.1727454, -0.2751749, 1.671811, 0, 0.6352941, 1, 1,
	    0.1734983, 0.5741809, -0.7058357, 0, 0.627451, 1, 1,
	    0.1752371, 0.4166706, -0.8814247, 0, 0.6235294, 1, 1,
	    0.17672, 0.4270968, 1.17857, 0, 0.6156863, 1, 1,
	    0.1774405, -0.6892486, 4.494312, 0, 0.6117647, 1, 1,
	    0.1788572, 0.4187342, 0.633212, 0, 0.6039216, 1, 1,
	    0.1789402, -1.367649, 2.473867, 0, 0.5960785, 1, 1,
	    0.1790497, -0.9155599, 3.30196, 0, 0.5921569, 1, 1,
	    0.1792483, -1.777774, 3.287176, 0, 0.5843138, 1, 1,
	    0.1826932, -1.036979, 1.866625, 0, 0.5803922, 1, 1,
	    0.1831357, 0.1244469, 0.3389153, 0, 0.572549, 1, 1,
	    0.1863338, 0.1061693, 2.612781, 0, 0.5686275, 1, 1,
	    0.1870283, -0.2302791, 2.137876, 0, 0.5607843, 1, 1,
	    0.1895647, -0.7230839, 3.072178, 0, 0.5568628, 1, 1,
	    0.1899878, 1.715159, -0.3003629, 0, 0.5490196, 1, 1,
	    0.1937375, -0.1748276, 2.504979, 0, 0.5450981, 1, 1,
	    0.2005642, -1.833384, 3.976099, 0, 0.5372549, 1, 1,
	    0.20676, -1.159332, 1.610402, 0, 0.5333334, 1, 1,
	    0.210363, -0.3665119, 2.593509, 0, 0.5254902, 1, 1,
	    0.2134157, -0.5212857, 2.934844, 0, 0.5215687, 1, 1,
	    0.2141087, 0.4305936, 2.117582, 0, 0.5137255, 1, 1,
	    0.2202082, -2.752893, 2.403479, 0, 0.509804, 1, 1,
	    0.2231747, -0.1126817, 1.528448, 0, 0.5019608, 1, 1,
	    0.2244411, -1.595097, 1.74915, 0, 0.4941176, 1, 1,
	    0.2328205, -1.010354, 2.090829, 0, 0.4901961, 1, 1,
	    0.2349697, -0.221541, 3.999756, 0, 0.4823529, 1, 1,
	    0.2355807, 0.1682843, 0.2450091, 0, 0.4784314, 1, 1,
	    0.2361868, -1.464927, 2.098823, 0, 0.4705882, 1, 1,
	    0.243553, 1.986387, -1.375451, 0, 0.4666667, 1, 1,
	    0.2438514, -0.09528416, 1.485196, 0, 0.4588235, 1, 1,
	    0.2449506, 0.6935057, 0.8699234, 0, 0.454902, 1, 1,
	    0.247334, -0.1423384, 3.078326, 0, 0.4470588, 1, 1,
	    0.2479177, -1.014548, 1.671896, 0, 0.4431373, 1, 1,
	    0.2479641, -0.4263787, 4.811787, 0, 0.4352941, 1, 1,
	    0.2509226, -0.1293052, 2.458205, 0, 0.4313726, 1, 1,
	    0.2538646, -0.07491988, 0.2771419, 0, 0.4235294, 1, 1,
	    0.2548181, 0.1771671, 0.3156326, 0, 0.4196078, 1, 1,
	    0.2561797, 0.2421107, 0.3452185, 0, 0.4117647, 1, 1,
	    0.261842, 0.7867448, 1.08258, 0, 0.4078431, 1, 1,
	    0.2622564, -0.4496627, 4.38941, 0, 0.4, 1, 1,
	    0.2629577, -0.7049139, 1.563412, 0, 0.3921569, 1, 1,
	    0.2691282, -0.4747863, 2.544745, 0, 0.3882353, 1, 1,
	    0.274572, -1.614927, 4.203139, 0, 0.3803922, 1, 1,
	    0.2769723, -0.4743656, 2.79792, 0, 0.3764706, 1, 1,
	    0.2776703, -0.8729205, 2.346436, 0, 0.3686275, 1, 1,
	    0.2794469, 0.2866025, 2.114558, 0, 0.3647059, 1, 1,
	    0.2818347, -1.494389, 5.499467, 0, 0.3568628, 1, 1,
	    0.282791, 1.525267, -0.030856, 0, 0.3529412, 1, 1,
	    0.2849537, -0.6580731, 1.285715, 0, 0.345098, 1, 1,
	    0.2920239, 0.5150383, 0.3753101, 0, 0.3411765, 1, 1,
	    0.292331, 0.6649519, 0.6760862, 0, 0.3333333, 1, 1,
	    0.2962304, -1.720861, 5.043606, 0, 0.3294118, 1, 1,
	    0.2985317, 0.7921628, 2.010181, 0, 0.3215686, 1, 1,
	    0.2988777, 1.047635, -0.2589526, 0, 0.3176471, 1, 1,
	    0.302854, 1.080208, -0.3620825, 0, 0.3098039, 1, 1,
	    0.3051152, 0.65252, 0.4600465, 0, 0.3058824, 1, 1,
	    0.307146, 0.8485416, 2.05924, 0, 0.2980392, 1, 1,
	    0.3116832, 0.4387279, 1.212669, 0, 0.2901961, 1, 1,
	    0.3134838, -1.774708, 3.496145, 0, 0.2862745, 1, 1,
	    0.3273294, -2.119538, 3.18884, 0, 0.2784314, 1, 1,
	    0.3276031, -1.0335, 3.175228, 0, 0.2745098, 1, 1,
	    0.3281737, -0.3822259, 0.8897666, 0, 0.2666667, 1, 1,
	    0.3360463, -0.5495034, 3.159167, 0, 0.2627451, 1, 1,
	    0.3363014, 0.3531942, 0.6648608, 0, 0.254902, 1, 1,
	    0.343129, -0.2472105, 5.107963, 0, 0.2509804, 1, 1,
	    0.3434161, 0.4777001, -0.3451844, 0, 0.2431373, 1, 1,
	    0.3437983, 0.452844, 1.623497, 0, 0.2392157, 1, 1,
	    0.344274, -0.5004833, 2.680132, 0, 0.2313726, 1, 1,
	    0.344989, 0.5603529, 1.145674, 0, 0.227451, 1, 1,
	    0.3472735, -0.8850209, 2.847362, 0, 0.2196078, 1, 1,
	    0.3487613, 0.882973, 1.666815, 0, 0.2156863, 1, 1,
	    0.3515497, -0.1940525, 1.917513, 0, 0.2078431, 1, 1,
	    0.3548901, 1.948647, 1.102376, 0, 0.2039216, 1, 1,
	    0.3572818, -0.9276016, 3.379504, 0, 0.1960784, 1, 1,
	    0.3591712, -1.435886, 3.267424, 0, 0.1882353, 1, 1,
	    0.3596931, 0.2972161, 1.50007, 0, 0.1843137, 1, 1,
	    0.360819, -1.882608, 1.235511, 0, 0.1764706, 1, 1,
	    0.3622853, -1.00221, 2.25588, 0, 0.172549, 1, 1,
	    0.3632241, -0.9262624, 3.122253, 0, 0.1647059, 1, 1,
	    0.3633218, 1.356123, 0.4108647, 0, 0.1607843, 1, 1,
	    0.3690629, -0.4286597, 2.22938, 0, 0.1529412, 1, 1,
	    0.3702483, 0.289211, 1.40042, 0, 0.1490196, 1, 1,
	    0.370737, -0.4452392, 2.664884, 0, 0.1411765, 1, 1,
	    0.372358, 0.4988986, -1.455382, 0, 0.1372549, 1, 1,
	    0.3759991, 0.04860494, 1.388825, 0, 0.1294118, 1, 1,
	    0.378771, 0.1702418, 2.45581, 0, 0.1254902, 1, 1,
	    0.3804216, -0.19474, 4.201309, 0, 0.1176471, 1, 1,
	    0.3812452, -0.9738524, 2.874264, 0, 0.1137255, 1, 1,
	    0.381423, -0.5025603, 2.186516, 0, 0.1058824, 1, 1,
	    0.3831681, -0.2718766, 2.735496, 0, 0.09803922, 1, 1,
	    0.3998964, -1.483865, 3.362049, 0, 0.09411765, 1, 1,
	    0.4092464, 0.4196513, -0.4266123, 0, 0.08627451, 1, 1,
	    0.4098565, -0.2660565, 1.878039, 0, 0.08235294, 1, 1,
	    0.4103414, 0.1281351, 1.420076, 0, 0.07450981, 1, 1,
	    0.411001, 0.04839282, 0.5751044, 0, 0.07058824, 1, 1,
	    0.412714, 1.813006, 0.360827, 0, 0.0627451, 1, 1,
	    0.4151072, -0.2203957, 1.627377, 0, 0.05882353, 1, 1,
	    0.4157812, 0.03117689, 2.737738, 0, 0.05098039, 1, 1,
	    0.4187352, 1.61889, -0.7215161, 0, 0.04705882, 1, 1,
	    0.418817, -0.4898649, 3.316353, 0, 0.03921569, 1, 1,
	    0.4194226, 0.6067457, 0.5038468, 0, 0.03529412, 1, 1,
	    0.4202521, 1.206376, 0.1884862, 0, 0.02745098, 1, 1,
	    0.424558, -0.1608112, 3.423247, 0, 0.02352941, 1, 1,
	    0.4254547, -0.3597859, 1.833257, 0, 0.01568628, 1, 1,
	    0.4259818, 0.8478398, 1.307832, 0, 0.01176471, 1, 1,
	    0.4263385, 1.173773, 0.9935434, 0, 0.003921569, 1, 1,
	    0.4324065, -1.39928, 3.717436, 0.003921569, 0, 1, 1,
	    0.4394974, 0.8168605, 0.9877462, 0.007843138, 0, 1, 1,
	    0.4451285, 0.04131979, 0.5907137, 0.01568628, 0, 1, 1,
	    0.4489293, -1.758702, 2.429346, 0.01960784, 0, 1, 1,
	    0.4497581, 0.7212042, 1.932239, 0.02745098, 0, 1, 1,
	    0.4498868, 1.016846, 1.293717, 0.03137255, 0, 1, 1,
	    0.4499572, 0.3290527, 3.208633, 0.03921569, 0, 1, 1,
	    0.4576727, 1.280277, 1.337481, 0.04313726, 0, 1, 1,
	    0.4612485, 0.9442429, -1.051013, 0.05098039, 0, 1, 1,
	    0.4623654, -0.7846414, 3.389879, 0.05490196, 0, 1, 1,
	    0.4706065, 0.7011909, 1.964418, 0.0627451, 0, 1, 1,
	    0.4731317, 1.286678, -0.6766689, 0.06666667, 0, 1, 1,
	    0.4813165, -2.08966, 4.39206, 0.07450981, 0, 1, 1,
	    0.4868344, 1.032996, 1.475092, 0.07843138, 0, 1, 1,
	    0.4882021, -0.1110521, 1.388713, 0.08627451, 0, 1, 1,
	    0.4906792, 1.389982, -1.174424, 0.09019608, 0, 1, 1,
	    0.4940831, -0.4096155, 2.495072, 0.09803922, 0, 1, 1,
	    0.4941366, 1.504194, 1.020343, 0.1058824, 0, 1, 1,
	    0.4963015, -0.0673045, 2.578846, 0.1098039, 0, 1, 1,
	    0.4999675, -0.1641859, 3.901078, 0.1176471, 0, 1, 1,
	    0.5024136, 0.5541518, 0.01600879, 0.1215686, 0, 1, 1,
	    0.504916, -0.3860767, 3.924174, 0.1294118, 0, 1, 1,
	    0.5074919, -0.8738189, 3.43772, 0.1333333, 0, 1, 1,
	    0.5122615, -0.4913135, 2.092088, 0.1411765, 0, 1, 1,
	    0.5178556, 0.0170896, 1.702696, 0.145098, 0, 1, 1,
	    0.5191342, 0.2451269, 1.613284, 0.1529412, 0, 1, 1,
	    0.5227172, -0.182495, 2.33039, 0.1568628, 0, 1, 1,
	    0.5254764, -1.12383, 4.794782, 0.1647059, 0, 1, 1,
	    0.5255129, -0.6007454, 3.431696, 0.1686275, 0, 1, 1,
	    0.5352439, 0.5782455, 1.196324, 0.1764706, 0, 1, 1,
	    0.5380077, 1.23267, -0.02915829, 0.1803922, 0, 1, 1,
	    0.5404524, -0.06322595, 2.246572, 0.1882353, 0, 1, 1,
	    0.5404626, -1.777739, 5.263954, 0.1921569, 0, 1, 1,
	    0.5416763, -2.262716, 1.262578, 0.2, 0, 1, 1,
	    0.5444983, -0.5898017, 1.475742, 0.2078431, 0, 1, 1,
	    0.5470377, -1.627784, 4.370689, 0.2117647, 0, 1, 1,
	    0.5578081, -1.511649, 2.025086, 0.2196078, 0, 1, 1,
	    0.5582839, -0.2522666, 1.194287, 0.2235294, 0, 1, 1,
	    0.5597494, 0.3120884, 0.6533695, 0.2313726, 0, 1, 1,
	    0.5603607, 0.07730357, 2.029174, 0.2352941, 0, 1, 1,
	    0.5605841, -1.143345, 0.6896272, 0.2431373, 0, 1, 1,
	    0.5635611, -0.8129856, 2.578114, 0.2470588, 0, 1, 1,
	    0.5688521, -0.1209421, 2.825252, 0.254902, 0, 1, 1,
	    0.5692651, 1.300024, 0.08597384, 0.2588235, 0, 1, 1,
	    0.5715644, -0.6644364, 2.994212, 0.2666667, 0, 1, 1,
	    0.5751989, 0.8851245, 1.008114, 0.2705882, 0, 1, 1,
	    0.5791294, 0.1567672, 1.903584, 0.2784314, 0, 1, 1,
	    0.5950398, 0.5269277, 0.9633486, 0.282353, 0, 1, 1,
	    0.5955276, -1.03238, 1.976529, 0.2901961, 0, 1, 1,
	    0.600877, 1.260799, 0.7925345, 0.2941177, 0, 1, 1,
	    0.607968, 0.9517656, 2.38561, 0.3019608, 0, 1, 1,
	    0.6090586, 1.311153, -1.316363, 0.3098039, 0, 1, 1,
	    0.611244, 0.5248854, -0.1499395, 0.3137255, 0, 1, 1,
	    0.6131964, 0.5571191, 0.6328409, 0.3215686, 0, 1, 1,
	    0.6138809, -0.7517436, 4.006473, 0.3254902, 0, 1, 1,
	    0.6140264, 0.3429809, -0.5734726, 0.3333333, 0, 1, 1,
	    0.6184772, 0.6230396, 1.512359, 0.3372549, 0, 1, 1,
	    0.6211417, -0.1037652, 1.929161, 0.345098, 0, 1, 1,
	    0.6229474, 0.9610382, 0.8589711, 0.3490196, 0, 1, 1,
	    0.625995, -2.286388, 1.966969, 0.3568628, 0, 1, 1,
	    0.6349403, 0.3908305, 1.505025, 0.3607843, 0, 1, 1,
	    0.6453364, 0.1361905, 0.7720458, 0.3686275, 0, 1, 1,
	    0.6519851, -0.6405858, 1.2775, 0.372549, 0, 1, 1,
	    0.6597902, 1.080614, 2.985252, 0.3803922, 0, 1, 1,
	    0.6622047, -0.5643041, 2.230125, 0.3843137, 0, 1, 1,
	    0.6627669, 1.079806, 0.9661276, 0.3921569, 0, 1, 1,
	    0.6710027, -0.06379458, 2.204203, 0.3960784, 0, 1, 1,
	    0.6727808, -0.3929994, 0.2461328, 0.4039216, 0, 1, 1,
	    0.6814516, -0.4025313, 1.699971, 0.4117647, 0, 1, 1,
	    0.6816725, -1.116338, 1.78948, 0.4156863, 0, 1, 1,
	    0.6819355, -0.7601537, 2.082764, 0.4235294, 0, 1, 1,
	    0.6891435, -0.3611485, 2.524622, 0.427451, 0, 1, 1,
	    0.6944064, -0.1055482, 0.9283483, 0.4352941, 0, 1, 1,
	    0.6984833, -1.929495, 2.514333, 0.4392157, 0, 1, 1,
	    0.702174, -1.279474, 3.74434, 0.4470588, 0, 1, 1,
	    0.7037408, -0.08987854, 2.618031, 0.4509804, 0, 1, 1,
	    0.7066045, -1.198702, 3.374518, 0.4588235, 0, 1, 1,
	    0.7080805, 0.8260463, 0.08996578, 0.4627451, 0, 1, 1,
	    0.710131, -0.7081677, 3.072386, 0.4705882, 0, 1, 1,
	    0.7113363, -0.3410518, 4.367281, 0.4745098, 0, 1, 1,
	    0.7127508, -0.6226503, 0.5331324, 0.4823529, 0, 1, 1,
	    0.7238306, 0.3203066, 0.9875374, 0.4862745, 0, 1, 1,
	    0.7246929, 0.6446179, 0.8637269, 0.4941176, 0, 1, 1,
	    0.7249858, 0.4316204, -0.8904052, 0.5019608, 0, 1, 1,
	    0.728462, -1.835423, 4.383247, 0.5058824, 0, 1, 1,
	    0.7315201, 0.4238932, 0.4645581, 0.5137255, 0, 1, 1,
	    0.7360055, -0.4895482, 3.647432, 0.5176471, 0, 1, 1,
	    0.7410832, -0.8419479, 3.344769, 0.5254902, 0, 1, 1,
	    0.7417914, 0.4757371, 1.284339, 0.5294118, 0, 1, 1,
	    0.7470177, 0.345905, 0.3547497, 0.5372549, 0, 1, 1,
	    0.7528266, -0.7347727, 3.053867, 0.5411765, 0, 1, 1,
	    0.7530535, -1.498389, 0.2065786, 0.5490196, 0, 1, 1,
	    0.7539676, -1.090404, 0.9617269, 0.5529412, 0, 1, 1,
	    0.7548347, 1.921682, 0.07157177, 0.5607843, 0, 1, 1,
	    0.757623, -0.1562001, 2.512093, 0.5647059, 0, 1, 1,
	    0.7589115, 0.8442144, -0.3414577, 0.572549, 0, 1, 1,
	    0.7633253, 0.4347659, 3.38094, 0.5764706, 0, 1, 1,
	    0.7659301, 1.056944, 1.67539, 0.5843138, 0, 1, 1,
	    0.7662777, -0.6231197, 1.751733, 0.5882353, 0, 1, 1,
	    0.7684813, 1.415976, 0.9097987, 0.5960785, 0, 1, 1,
	    0.7807057, -0.2680493, 0.5554414, 0.6039216, 0, 1, 1,
	    0.7812838, -1.367332, 1.985722, 0.6078432, 0, 1, 1,
	    0.7838265, 0.001092662, 1.801815, 0.6156863, 0, 1, 1,
	    0.7876445, -1.193718, 2.928486, 0.6196079, 0, 1, 1,
	    0.7882392, 1.087014, 1.975915, 0.627451, 0, 1, 1,
	    0.7919544, -1.692347, 2.493053, 0.6313726, 0, 1, 1,
	    0.7921774, 1.513593, 1.185014, 0.6392157, 0, 1, 1,
	    0.7927187, -1.173653, 3.962795, 0.6431373, 0, 1, 1,
	    0.793206, -1.870292, 3.818037, 0.6509804, 0, 1, 1,
	    0.7955205, -1.036197, 1.268497, 0.654902, 0, 1, 1,
	    0.8000839, 1.353203, -0.2227535, 0.6627451, 0, 1, 1,
	    0.800212, 0.6407818, 0.527019, 0.6666667, 0, 1, 1,
	    0.804897, -0.149667, 3.087264, 0.6745098, 0, 1, 1,
	    0.8060815, 0.890847, 2.600581, 0.6784314, 0, 1, 1,
	    0.8148207, -0.4706783, 1.112368, 0.6862745, 0, 1, 1,
	    0.817595, -1.28564, 3.871298, 0.6901961, 0, 1, 1,
	    0.8184184, -1.358738, 1.472849, 0.6980392, 0, 1, 1,
	    0.8204806, -1.085387, 1.85209, 0.7058824, 0, 1, 1,
	    0.8311378, -0.7128175, 2.420058, 0.7098039, 0, 1, 1,
	    0.835934, -1.695087, 2.581361, 0.7176471, 0, 1, 1,
	    0.8388139, 1.514956, -0.24313, 0.7215686, 0, 1, 1,
	    0.8397609, 2.624379, 1.338991, 0.7294118, 0, 1, 1,
	    0.8442553, 0.1668306, 1.790274, 0.7333333, 0, 1, 1,
	    0.8444817, -1.964154, 2.315265, 0.7411765, 0, 1, 1,
	    0.8455405, 1.468555, 0.8933362, 0.7450981, 0, 1, 1,
	    0.8517442, 1.071927, -0.3318838, 0.7529412, 0, 1, 1,
	    0.8548843, 1.128758, 1.289351, 0.7568628, 0, 1, 1,
	    0.8593917, 0.4076754, 2.283858, 0.7647059, 0, 1, 1,
	    0.8603824, 0.07529636, 1.106083, 0.7686275, 0, 1, 1,
	    0.8614287, -0.1557988, 0.9843956, 0.7764706, 0, 1, 1,
	    0.8614558, -0.0262247, 3.200078, 0.7803922, 0, 1, 1,
	    0.8668433, 1.300994, 0.5040203, 0.7882353, 0, 1, 1,
	    0.8669451, -0.6147588, 3.352688, 0.7921569, 0, 1, 1,
	    0.8713655, -0.522885, -0.01427145, 0.8, 0, 1, 1,
	    0.8725779, -0.3523104, 1.275966, 0.8078431, 0, 1, 1,
	    0.875747, -0.4485716, 1.558951, 0.8117647, 0, 1, 1,
	    0.8771843, -0.5079439, 1.612616, 0.8196079, 0, 1, 1,
	    0.8774449, -1.596835, 2.596426, 0.8235294, 0, 1, 1,
	    0.8786662, 0.561179, 1.222718, 0.8313726, 0, 1, 1,
	    0.8810309, -1.074555, 1.984032, 0.8352941, 0, 1, 1,
	    0.8846303, 0.100877, 2.373741, 0.8431373, 0, 1, 1,
	    0.8847474, -0.08133902, 2.327663, 0.8470588, 0, 1, 1,
	    0.8855723, 0.2717589, -0.3190808, 0.854902, 0, 1, 1,
	    0.8873895, -1.57849, 2.190678, 0.8588235, 0, 1, 1,
	    0.8893023, -0.7246734, 0.9072828, 0.8666667, 0, 1, 1,
	    0.8902302, 0.3199386, 0.5047436, 0.8705882, 0, 1, 1,
	    0.8919818, -1.59965, 3.741197, 0.8784314, 0, 1, 1,
	    0.9032634, -0.1197205, 1.060065, 0.8823529, 0, 1, 1,
	    0.9054361, 0.03377908, 2.503705, 0.8901961, 0, 1, 1,
	    0.9057852, -0.893815, 4.126166, 0.8941177, 0, 1, 1,
	    0.9068796, 0.6569833, 0.5829431, 0.9019608, 0, 1, 1,
	    0.9120908, 1.034582, 1.607218, 0.9098039, 0, 1, 1,
	    0.9151357, 0.7385849, 1.858609, 0.9137255, 0, 1, 1,
	    0.9199781, 0.6049035, 1.267913, 0.9215686, 0, 1, 1,
	    0.9206105, -0.2790399, 2.086583, 0.9254902, 0, 1, 1,
	    0.9221742, 0.446971, 2.321392, 0.9333333, 0, 1, 1,
	    0.9248801, 0.3124012, 0.1263286, 0.9372549, 0, 1, 1,
	    0.9371196, 0.4868475, 2.044115, 0.945098, 0, 1, 1,
	    0.9460634, 1.083819, 0.6254053, 0.9490196, 0, 1, 1,
	    0.958353, 1.015254, 0.7492709, 0.9568627, 0, 1, 1,
	    0.9609236, 0.2969047, 2.277372, 0.9607843, 0, 1, 1,
	    0.9628545, 1.394046, 0.5857646, 0.9686275, 0, 1, 1,
	    0.9653386, -1.137495, 1.490569, 0.972549, 0, 1, 1,
	    0.9723992, 0.6131573, 1.026476, 0.9803922, 0, 1, 1,
	    0.9805968, -0.5097299, 1.292086, 0.9843137, 0, 1, 1,
	    0.981813, 0.008295264, 1.490739, 0.9921569, 0, 1, 1,
	    0.9880706, -0.9728348, 2.697592, 0.9960784, 0, 1, 1,
	    0.9882421, -0.009097888, -0.05366536, 1, 0, 0.9960784, 1,
	    0.9883885, 0.0758557, 1.959549, 1, 0, 0.9882353, 1,
	    0.9922783, 0.2996379, 2.400736, 1, 0, 0.9843137, 1,
	    1.001823, 0.3803546, 2.402492, 1, 0, 0.9764706, 1,
	    1.025446, 1.480896, 2.322358, 1, 0, 0.972549, 1,
	    1.033643, 0.9427634, 1.886744, 1, 0, 0.9647059, 1,
	    1.039457, -0.2970746, 1.376828, 1, 0, 0.9607843, 1,
	    1.043555, 0.8624995, 2.748404, 1, 0, 0.9529412, 1,
	    1.052137, 0.001438138, -0.2140081, 1, 0, 0.9490196, 1,
	    1.05346, 1.447298, 0.08788187, 1, 0, 0.9411765, 1,
	    1.05956, 3.07489, 0.7242675, 1, 0, 0.9372549, 1,
	    1.062503, -0.2577375, 1.183173, 1, 0, 0.9294118, 1,
	    1.069176, -1.537476, 3.842601, 1, 0, 0.9254902, 1,
	    1.070175, -0.4236529, 1.594716, 1, 0, 0.9176471, 1,
	    1.077232, 1.008455, 1.536872, 1, 0, 0.9137255, 1,
	    1.079193, 0.5490627, 0.7122967, 1, 0, 0.9058824, 1,
	    1.082339, 0.8424557, 0.4263262, 1, 0, 0.9019608, 1,
	    1.085328, 0.4627362, 0.9469602, 1, 0, 0.8941177, 1,
	    1.089431, 0.05613875, 1.263393, 1, 0, 0.8862745, 1,
	    1.096051, 0.3824755, 2.965347, 1, 0, 0.8823529, 1,
	    1.097645, 0.8080127, 1.835153, 1, 0, 0.8745098, 1,
	    1.098913, -0.5933962, 2.720047, 1, 0, 0.8705882, 1,
	    1.105421, -0.3270273, 0.4847586, 1, 0, 0.8627451, 1,
	    1.109296, 0.1465434, 1.024337, 1, 0, 0.8588235, 1,
	    1.112286, -0.4210125, -0.2246854, 1, 0, 0.8509804, 1,
	    1.115235, -0.6064724, 3.422931, 1, 0, 0.8470588, 1,
	    1.115382, -0.7640532, 2.877956, 1, 0, 0.8392157, 1,
	    1.122502, -0.7427902, 2.303925, 1, 0, 0.8352941, 1,
	    1.133807, -0.8878242, 2.668266, 1, 0, 0.827451, 1,
	    1.138666, 0.9848185, 0.242027, 1, 0, 0.8235294, 1,
	    1.138698, 0.8056787, 0.6706122, 1, 0, 0.8156863, 1,
	    1.139332, 0.3548799, 2.022973, 1, 0, 0.8117647, 1,
	    1.144246, -2.09138, 2.554002, 1, 0, 0.8039216, 1,
	    1.148661, -0.3781465, 1.964876, 1, 0, 0.7960784, 1,
	    1.152788, 1.385678, 0.3261668, 1, 0, 0.7921569, 1,
	    1.154372, -0.02477717, 1.94442, 1, 0, 0.7843137, 1,
	    1.15778, 0.14989, 2.219815, 1, 0, 0.7803922, 1,
	    1.161054, 0.5013525, 2.293988, 1, 0, 0.772549, 1,
	    1.163731, 0.1149024, 2.915088, 1, 0, 0.7686275, 1,
	    1.172546, 1.302884, 0.07911372, 1, 0, 0.7607843, 1,
	    1.173409, 0.6832283, 0.7100959, 1, 0, 0.7568628, 1,
	    1.174014, -1.159731, 2.032714, 1, 0, 0.7490196, 1,
	    1.174102, 0.09390096, 1.978979, 1, 0, 0.7450981, 1,
	    1.19487, -0.1205537, 4.371417, 1, 0, 0.7372549, 1,
	    1.200877, 0.09226339, -0.4510924, 1, 0, 0.7333333, 1,
	    1.201006, 0.9903899, 0.3745951, 1, 0, 0.7254902, 1,
	    1.209646, 1.404592, -0.3420476, 1, 0, 0.7215686, 1,
	    1.212382, 0.171467, 2.472562, 1, 0, 0.7137255, 1,
	    1.218815, 1.740726, 0.620522, 1, 0, 0.7098039, 1,
	    1.219519, 1.052911, -0.4070341, 1, 0, 0.7019608, 1,
	    1.220533, -1.056638, -0.08412589, 1, 0, 0.6941177, 1,
	    1.232426, 2.298429, 0.1420964, 1, 0, 0.6901961, 1,
	    1.233701, -0.7279106, 2.298405, 1, 0, 0.682353, 1,
	    1.244144, 0.5063895, 2.763235, 1, 0, 0.6784314, 1,
	    1.2466, -1.025542, 1.414207, 1, 0, 0.6705883, 1,
	    1.24822, -1.84791, 1.902351, 1, 0, 0.6666667, 1,
	    1.250157, 0.4740781, 1.186246, 1, 0, 0.6588235, 1,
	    1.250661, -1.109785, 3.054701, 1, 0, 0.654902, 1,
	    1.253375, 1.246823, -0.07971154, 1, 0, 0.6470588, 1,
	    1.253886, 0.4214151, 1.256201, 1, 0, 0.6431373, 1,
	    1.260454, 0.5302634, 1.096402, 1, 0, 0.6352941, 1,
	    1.262239, -0.157026, 1.999545, 1, 0, 0.6313726, 1,
	    1.263467, 0.2435635, 0.2140212, 1, 0, 0.6235294, 1,
	    1.273203, 1.910979, -0.746671, 1, 0, 0.6196079, 1,
	    1.277789, -0.08665111, 1.404626, 1, 0, 0.6117647, 1,
	    1.282532, 0.1360601, 1.495181, 1, 0, 0.6078432, 1,
	    1.28539, 0.8126817, 1.105394, 1, 0, 0.6, 1,
	    1.311738, -1.400755, 0.8133212, 1, 0, 0.5921569, 1,
	    1.314226, -0.1689791, 1.121629, 1, 0, 0.5882353, 1,
	    1.315113, 0.8243285, 1.360163, 1, 0, 0.5803922, 1,
	    1.318489, 0.7455073, 1.257836, 1, 0, 0.5764706, 1,
	    1.332067, -0.1431432, 1.315379, 1, 0, 0.5686275, 1,
	    1.334883, 0.3320971, 1.300497, 1, 0, 0.5647059, 1,
	    1.338825, 1.236726, 0.9352123, 1, 0, 0.5568628, 1,
	    1.354083, -1.416749, 2.991322, 1, 0, 0.5529412, 1,
	    1.357678, -0.3343149, 1.164591, 1, 0, 0.5450981, 1,
	    1.358887, -1.328583, 1.287254, 1, 0, 0.5411765, 1,
	    1.362471, -1.648594, 4.655566, 1, 0, 0.5333334, 1,
	    1.366021, 1.318052, 1.498337, 1, 0, 0.5294118, 1,
	    1.373572, -0.2841989, 4.090307, 1, 0, 0.5215687, 1,
	    1.392126, 0.07300881, 1.140209, 1, 0, 0.5176471, 1,
	    1.398708, 1.236838, 1.690118, 1, 0, 0.509804, 1,
	    1.407888, 0.8702138, 2.572253, 1, 0, 0.5058824, 1,
	    1.408151, 0.2100274, 1.693199, 1, 0, 0.4980392, 1,
	    1.4225, -0.7317731, 2.241725, 1, 0, 0.4901961, 1,
	    1.425399, 1.259023, 1.148899, 1, 0, 0.4862745, 1,
	    1.44098, 0.4964122, 1.369524, 1, 0, 0.4784314, 1,
	    1.441418, 0.5049395, 1.648372, 1, 0, 0.4745098, 1,
	    1.442535, 0.6186194, 1.86286, 1, 0, 0.4666667, 1,
	    1.447263, -1.168696, 0.6109323, 1, 0, 0.4627451, 1,
	    1.447818, 0.1239106, 2.896993, 1, 0, 0.454902, 1,
	    1.44819, -0.02011312, 3.673188, 1, 0, 0.4509804, 1,
	    1.457835, -0.4666112, 3.868449, 1, 0, 0.4431373, 1,
	    1.478422, -1.123358, 1.83021, 1, 0, 0.4392157, 1,
	    1.482454, -0.3721066, 1.491453, 1, 0, 0.4313726, 1,
	    1.488151, -0.08486922, 0.4866546, 1, 0, 0.427451, 1,
	    1.49051, 0.3994811, 1.79625, 1, 0, 0.4196078, 1,
	    1.512456, -1.215373, 2.77379, 1, 0, 0.4156863, 1,
	    1.515315, -0.7683685, 3.406448, 1, 0, 0.4078431, 1,
	    1.516525, 0.8246656, 2.000193, 1, 0, 0.4039216, 1,
	    1.516945, 0.2902507, 1.49416, 1, 0, 0.3960784, 1,
	    1.536787, -0.4908462, 2.429593, 1, 0, 0.3882353, 1,
	    1.540851, 1.078707, 1.437597, 1, 0, 0.3843137, 1,
	    1.557457, 0.1410002, 0.3769924, 1, 0, 0.3764706, 1,
	    1.561564, 0.3665491, 0.5362626, 1, 0, 0.372549, 1,
	    1.571571, -0.274195, 2.238415, 1, 0, 0.3647059, 1,
	    1.572648, 0.6104268, 1.824522, 1, 0, 0.3607843, 1,
	    1.575885, 0.1353796, 2.661653, 1, 0, 0.3529412, 1,
	    1.587721, 1.218659, -0.5176783, 1, 0, 0.3490196, 1,
	    1.590888, 0.5271495, 1.626133, 1, 0, 0.3411765, 1,
	    1.591695, 1.788445, 0.5053697, 1, 0, 0.3372549, 1,
	    1.593118, 1.89158, 0.06893425, 1, 0, 0.3294118, 1,
	    1.600501, -0.812046, 4.086628, 1, 0, 0.3254902, 1,
	    1.624632, -1.800519, 1.196284, 1, 0, 0.3176471, 1,
	    1.634354, 1.280653, 1.073799, 1, 0, 0.3137255, 1,
	    1.644194, 1.222427, 2.178789, 1, 0, 0.3058824, 1,
	    1.646602, -0.8331063, 1.973781, 1, 0, 0.2980392, 1,
	    1.648261, 0.01036541, 0.7627305, 1, 0, 0.2941177, 1,
	    1.680038, -0.2198014, 3.383401, 1, 0, 0.2862745, 1,
	    1.68049, 0.4107388, 2.850506, 1, 0, 0.282353, 1,
	    1.737989, 1.437905, 1.070542, 1, 0, 0.2745098, 1,
	    1.739171, -0.7431176, 1.697772, 1, 0, 0.2705882, 1,
	    1.750009, -0.05380336, 1.389675, 1, 0, 0.2627451, 1,
	    1.756026, -0.2219166, 1.009197, 1, 0, 0.2588235, 1,
	    1.796674, 0.4809958, 1.45921, 1, 0, 0.2509804, 1,
	    1.814064, 1.224899, -0.1891897, 1, 0, 0.2470588, 1,
	    1.818731, 0.5697278, 1.90366, 1, 0, 0.2392157, 1,
	    1.831731, -0.9714949, 2.214581, 1, 0, 0.2352941, 1,
	    1.851842, 0.8788774, 0.328842, 1, 0, 0.227451, 1,
	    1.856032, 0.4766942, 0.8075128, 1, 0, 0.2235294, 1,
	    1.862379, -0.6511331, 2.538857, 1, 0, 0.2156863, 1,
	    1.887083, 0.4123512, 1.567918, 1, 0, 0.2117647, 1,
	    1.893406, -0.5785898, 2.127049, 1, 0, 0.2039216, 1,
	    1.924162, -0.7615853, 2.197102, 1, 0, 0.1960784, 1,
	    1.928057, -0.1677306, 1.196021, 1, 0, 0.1921569, 1,
	    1.928972, 0.522891, 1.409226, 1, 0, 0.1843137, 1,
	    1.937916, 0.2283457, 1.591947, 1, 0, 0.1803922, 1,
	    1.954389, 0.2101214, 1.15943, 1, 0, 0.172549, 1,
	    1.971638, -0.6599066, 2.365544, 1, 0, 0.1686275, 1,
	    1.983711, 0.2683032, 1.41542, 1, 0, 0.1607843, 1,
	    1.987854, 0.9229794, -0.04857757, 1, 0, 0.1568628, 1,
	    1.989848, 0.6300479, 0.5750114, 1, 0, 0.1490196, 1,
	    2.026719, -1.392504, 3.144569, 1, 0, 0.145098, 1,
	    2.030261, -0.4194579, 3.376236, 1, 0, 0.1372549, 1,
	    2.033329, -1.628956, 2.435318, 1, 0, 0.1333333, 1,
	    2.056229, 0.02484826, 1.951075, 1, 0, 0.1254902, 1,
	    2.090678, -0.3661546, 1.335972, 1, 0, 0.1215686, 1,
	    2.100643, 0.08958956, 2.441906, 1, 0, 0.1137255, 1,
	    2.146927, -0.601202, 2.518482, 1, 0, 0.1098039, 1,
	    2.148003, 0.6851684, 2.112093, 1, 0, 0.1019608, 1,
	    2.168629, -0.7538414, 1.445533, 1, 0, 0.09411765, 1,
	    2.182184, 1.615881, -0.6151592, 1, 0, 0.09019608, 1,
	    2.185539, -0.5208295, 0.9196709, 1, 0, 0.08235294, 1,
	    2.210595, 1.769366, 0.5166512, 1, 0, 0.07843138, 1,
	    2.254024, -0.1621146, 1.832189, 1, 0, 0.07058824, 1,
	    2.32202, -0.7852765, 1.615611, 1, 0, 0.06666667, 1,
	    2.335371, 1.93373, 1.127572, 1, 0, 0.05882353, 1,
	    2.507262, 1.27764, 1.23793, 1, 0, 0.05490196, 1,
	    2.658177, -1.692049, 0.4120746, 1, 0, 0.04705882, 1,
	    2.663361, -0.1932414, 1.221831, 1, 0, 0.04313726, 1,
	    2.716237, 0.4531519, 1.53517, 1, 0, 0.03529412, 1,
	    2.747841, 1.951353, 0.9343942, 1, 0, 0.03137255, 1,
	    2.807147, -0.3758324, -0.1678264, 1, 0, 0.02352941, 1,
	    2.920232, 0.5120769, 2.614038, 1, 0, 0.01960784, 1,
	    3.193073, -0.9633678, 2.376825, 1, 0, 0.01176471, 1,
	    3.435417, -0.6198777, 2.867938, 1, 0, 0.007843138, 1
	   ]);
	   var buf94 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf94);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc94 = gl.getUniformLocation(prog94,"mvMatrix");
	   var prMatLoc94 = gl.getUniformLocation(prog94,"prMatrix");
	   // ****** text object 96 ******
	   var prog96  = gl.createProgram();
	   gl.attachShader(prog96, getShader( gl, "rgl_firstexamplevshader96" ));
	   gl.attachShader(prog96, getShader( gl, "rgl_firstexamplefshader96" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog96, 0, "aPos");
	   gl.bindAttribLocation(prog96, 1, "aCol");
	   gl.linkProgram(prog96);
	   var texts = [
	    "x"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX96 = texinfo.canvasX;
	   var canvasY96 = texinfo.canvasY;
	   var ofsLoc96 = gl.getAttribLocation(prog96, "aOfs");
	   var texture96 = gl.createTexture();
	   var texLoc96 = gl.getAttribLocation(prog96, "aTexcoord");
	   var sampler96 = gl.getUniformLocation(prog96,"uSampler");
    	   handleLoadedTexture(texture96, document.getElementById("rgl_firstexampletextureCanvas"));
	   var v=new Float32Array([
	    0.1658238, -3.742984, -6.912995, 0, -0.5, 0.5, 0.5,
	    0.1658238, -3.742984, -6.912995, 1, -0.5, 0.5, 0.5,
	    0.1658238, -3.742984, -6.912995, 1, 1.5, 0.5, 0.5,
	    0.1658238, -3.742984, -6.912995, 0, 1.5, 0.5, 0.5
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
	   var buf96 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf96);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf96 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf96);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc96 = gl.getUniformLocation(prog96,"mvMatrix");
	   var prMatLoc96 = gl.getUniformLocation(prog96,"prMatrix");
	   // ****** text object 97 ******
	   var prog97  = gl.createProgram();
	   gl.attachShader(prog97, getShader( gl, "rgl_firstexamplevshader97" ));
	   gl.attachShader(prog97, getShader( gl, "rgl_firstexamplefshader97" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog97, 0, "aPos");
	   gl.bindAttribLocation(prog97, 1, "aCol");
	   gl.linkProgram(prog97);
	   var texts = [
	    "y"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX97 = texinfo.canvasX;
	   var canvasY97 = texinfo.canvasY;
	   var ofsLoc97 = gl.getAttribLocation(prog97, "aOfs");
	   var texture97 = gl.createTexture();
	   var texLoc97 = gl.getAttribLocation(prog97, "aTexcoord");
	   var sampler97 = gl.getUniformLocation(prog97,"uSampler");
    	   handleLoadedTexture(texture97, document.getElementById("rgl_firstexampletextureCanvas"));
	   var v=new Float32Array([
	    -4.212162, 0.1677315, -6.912995, 0, -0.5, 0.5, 0.5,
	    -4.212162, 0.1677315, -6.912995, 1, -0.5, 0.5, 0.5,
	    -4.212162, 0.1677315, -6.912995, 1, 1.5, 0.5, 0.5,
	    -4.212162, 0.1677315, -6.912995, 0, 1.5, 0.5, 0.5
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
	   var buf97 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf97);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf97 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf97);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc97 = gl.getUniformLocation(prog97,"mvMatrix");
	   var prMatLoc97 = gl.getUniformLocation(prog97,"prMatrix");
	   // ****** text object 98 ******
	   var prog98  = gl.createProgram();
	   gl.attachShader(prog98, getShader( gl, "rgl_firstexamplevshader98" ));
	   gl.attachShader(prog98, getShader( gl, "rgl_firstexamplefshader98" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog98, 0, "aPos");
	   gl.bindAttribLocation(prog98, 1, "aCol");
	   gl.linkProgram(prog98);
	   var texts = [
	    "z"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX98 = texinfo.canvasX;
	   var canvasY98 = texinfo.canvasY;
	   var ofsLoc98 = gl.getAttribLocation(prog98, "aOfs");
	   var texture98 = gl.createTexture();
	   var texLoc98 = gl.getAttribLocation(prog98, "aTexcoord");
	   var sampler98 = gl.getUniformLocation(prog98,"uSampler");
    	   handleLoadedTexture(texture98, document.getElementById("rgl_firstexampletextureCanvas"));
	   var v=new Float32Array([
	    -4.212162, -3.742984, 0.3499982, 0, -0.5, 0.5, 0.5,
	    -4.212162, -3.742984, 0.3499982, 1, -0.5, 0.5, 0.5,
	    -4.212162, -3.742984, 0.3499982, 1, 1.5, 0.5, 0.5,
	    -4.212162, -3.742984, 0.3499982, 0, 1.5, 0.5, 0.5
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
	   var buf98 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf98);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf98 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf98);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc98 = gl.getUniformLocation(prog98,"mvMatrix");
	   var prMatLoc98 = gl.getUniformLocation(prog98,"prMatrix");
	   // ****** lines object 99 ******
	   var prog99  = gl.createProgram();
	   gl.attachShader(prog99, getShader( gl, "rgl_firstexamplevshader99" ));
	   gl.attachShader(prog99, getShader( gl, "rgl_firstexamplefshader99" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog99, 0, "aPos");
	   gl.bindAttribLocation(prog99, 1, "aCol");
	   gl.linkProgram(prog99);
	   var v=new Float32Array([
	    -3, -2.840512, -5.23692,
	    3, -2.840512, -5.23692,
	    -3, -2.840512, -5.23692,
	    -3, -2.990924, -5.516265,
	    -2, -2.840512, -5.23692,
	    -2, -2.990924, -5.516265,
	    -1, -2.840512, -5.23692,
	    -1, -2.990924, -5.516265,
	    0, -2.840512, -5.23692,
	    0, -2.990924, -5.516265,
	    1, -2.840512, -5.23692,
	    1, -2.990924, -5.516265,
	    2, -2.840512, -5.23692,
	    2, -2.990924, -5.516265,
	    3, -2.840512, -5.23692,
	    3, -2.990924, -5.516265
	   ]);
	   var buf99 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf99);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc99 = gl.getUniformLocation(prog99,"mvMatrix");
	   var prMatLoc99 = gl.getUniformLocation(prog99,"prMatrix");
	   // ****** text object 100 ******
	   var prog100  = gl.createProgram();
	   gl.attachShader(prog100, getShader( gl, "rgl_firstexamplevshader100" ));
	   gl.attachShader(prog100, getShader( gl, "rgl_firstexamplefshader100" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog100, 0, "aPos");
	   gl.bindAttribLocation(prog100, 1, "aCol");
	   gl.linkProgram(prog100);
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
	   var canvasX100 = texinfo.canvasX;
	   var canvasY100 = texinfo.canvasY;
	   var ofsLoc100 = gl.getAttribLocation(prog100, "aOfs");
	   var texture100 = gl.createTexture();
	   var texLoc100 = gl.getAttribLocation(prog100, "aTexcoord");
	   var sampler100 = gl.getUniformLocation(prog100,"uSampler");
    	   handleLoadedTexture(texture100, document.getElementById("rgl_firstexampletextureCanvas"));
	   var v=new Float32Array([
	    -3, -3.291748, -6.074957, 0, -0.5, 0.5, 0.5,
	    -3, -3.291748, -6.074957, 1, -0.5, 0.5, 0.5,
	    -3, -3.291748, -6.074957, 1, 1.5, 0.5, 0.5,
	    -3, -3.291748, -6.074957, 0, 1.5, 0.5, 0.5,
	    -2, -3.291748, -6.074957, 0, -0.5, 0.5, 0.5,
	    -2, -3.291748, -6.074957, 1, -0.5, 0.5, 0.5,
	    -2, -3.291748, -6.074957, 1, 1.5, 0.5, 0.5,
	    -2, -3.291748, -6.074957, 0, 1.5, 0.5, 0.5,
	    -1, -3.291748, -6.074957, 0, -0.5, 0.5, 0.5,
	    -1, -3.291748, -6.074957, 1, -0.5, 0.5, 0.5,
	    -1, -3.291748, -6.074957, 1, 1.5, 0.5, 0.5,
	    -1, -3.291748, -6.074957, 0, 1.5, 0.5, 0.5,
	    0, -3.291748, -6.074957, 0, -0.5, 0.5, 0.5,
	    0, -3.291748, -6.074957, 1, -0.5, 0.5, 0.5,
	    0, -3.291748, -6.074957, 1, 1.5, 0.5, 0.5,
	    0, -3.291748, -6.074957, 0, 1.5, 0.5, 0.5,
	    1, -3.291748, -6.074957, 0, -0.5, 0.5, 0.5,
	    1, -3.291748, -6.074957, 1, -0.5, 0.5, 0.5,
	    1, -3.291748, -6.074957, 1, 1.5, 0.5, 0.5,
	    1, -3.291748, -6.074957, 0, 1.5, 0.5, 0.5,
	    2, -3.291748, -6.074957, 0, -0.5, 0.5, 0.5,
	    2, -3.291748, -6.074957, 1, -0.5, 0.5, 0.5,
	    2, -3.291748, -6.074957, 1, 1.5, 0.5, 0.5,
	    2, -3.291748, -6.074957, 0, 1.5, 0.5, 0.5,
	    3, -3.291748, -6.074957, 0, -0.5, 0.5, 0.5,
	    3, -3.291748, -6.074957, 1, -0.5, 0.5, 0.5,
	    3, -3.291748, -6.074957, 1, 1.5, 0.5, 0.5,
	    3, -3.291748, -6.074957, 0, 1.5, 0.5, 0.5
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
	   var buf100 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf100);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf100 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf100);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc100 = gl.getUniformLocation(prog100,"mvMatrix");
	   var prMatLoc100 = gl.getUniformLocation(prog100,"prMatrix");
	   // ****** lines object 101 ******
	   var prog101  = gl.createProgram();
	   gl.attachShader(prog101, getShader( gl, "rgl_firstexamplevshader101" ));
	   gl.attachShader(prog101, getShader( gl, "rgl_firstexamplefshader101" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog101, 0, "aPos");
	   gl.bindAttribLocation(prog101, 1, "aCol");
	   gl.linkProgram(prog101);
	   var v=new Float32Array([
	    -3.201857, -2, -5.23692,
	    -3.201857, 3, -5.23692,
	    -3.201857, -2, -5.23692,
	    -3.370241, -2, -5.516265,
	    -3.201857, -1, -5.23692,
	    -3.370241, -1, -5.516265,
	    -3.201857, 0, -5.23692,
	    -3.370241, 0, -5.516265,
	    -3.201857, 1, -5.23692,
	    -3.370241, 1, -5.516265,
	    -3.201857, 2, -5.23692,
	    -3.370241, 2, -5.516265,
	    -3.201857, 3, -5.23692,
	    -3.370241, 3, -5.516265
	   ]);
	   var buf101 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf101);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc101 = gl.getUniformLocation(prog101,"mvMatrix");
	   var prMatLoc101 = gl.getUniformLocation(prog101,"prMatrix");
	   // ****** text object 102 ******
	   var prog102  = gl.createProgram();
	   gl.attachShader(prog102, getShader( gl, "rgl_firstexamplevshader102" ));
	   gl.attachShader(prog102, getShader( gl, "rgl_firstexamplefshader102" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog102, 0, "aPos");
	   gl.bindAttribLocation(prog102, 1, "aCol");
	   gl.linkProgram(prog102);
	   var texts = [
	    "-2",
	    "-1",
	    "0",
	    "1",
	    "2",
	    "3"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX102 = texinfo.canvasX;
	   var canvasY102 = texinfo.canvasY;
	   var ofsLoc102 = gl.getAttribLocation(prog102, "aOfs");
	   var texture102 = gl.createTexture();
	   var texLoc102 = gl.getAttribLocation(prog102, "aTexcoord");
	   var sampler102 = gl.getUniformLocation(prog102,"uSampler");
    	   handleLoadedTexture(texture102, document.getElementById("rgl_firstexampletextureCanvas"));
	   var v=new Float32Array([
	    -3.707009, -2, -6.074957, 0, -0.5, 0.5, 0.5,
	    -3.707009, -2, -6.074957, 1, -0.5, 0.5, 0.5,
	    -3.707009, -2, -6.074957, 1, 1.5, 0.5, 0.5,
	    -3.707009, -2, -6.074957, 0, 1.5, 0.5, 0.5,
	    -3.707009, -1, -6.074957, 0, -0.5, 0.5, 0.5,
	    -3.707009, -1, -6.074957, 1, -0.5, 0.5, 0.5,
	    -3.707009, -1, -6.074957, 1, 1.5, 0.5, 0.5,
	    -3.707009, -1, -6.074957, 0, 1.5, 0.5, 0.5,
	    -3.707009, 0, -6.074957, 0, -0.5, 0.5, 0.5,
	    -3.707009, 0, -6.074957, 1, -0.5, 0.5, 0.5,
	    -3.707009, 0, -6.074957, 1, 1.5, 0.5, 0.5,
	    -3.707009, 0, -6.074957, 0, 1.5, 0.5, 0.5,
	    -3.707009, 1, -6.074957, 0, -0.5, 0.5, 0.5,
	    -3.707009, 1, -6.074957, 1, -0.5, 0.5, 0.5,
	    -3.707009, 1, -6.074957, 1, 1.5, 0.5, 0.5,
	    -3.707009, 1, -6.074957, 0, 1.5, 0.5, 0.5,
	    -3.707009, 2, -6.074957, 0, -0.5, 0.5, 0.5,
	    -3.707009, 2, -6.074957, 1, -0.5, 0.5, 0.5,
	    -3.707009, 2, -6.074957, 1, 1.5, 0.5, 0.5,
	    -3.707009, 2, -6.074957, 0, 1.5, 0.5, 0.5,
	    -3.707009, 3, -6.074957, 0, -0.5, 0.5, 0.5,
	    -3.707009, 3, -6.074957, 1, -0.5, 0.5, 0.5,
	    -3.707009, 3, -6.074957, 1, 1.5, 0.5, 0.5,
	    -3.707009, 3, -6.074957, 0, 1.5, 0.5, 0.5
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
	   var buf102 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf102);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf102 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf102);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc102 = gl.getUniformLocation(prog102,"mvMatrix");
	   var prMatLoc102 = gl.getUniformLocation(prog102,"prMatrix");
	   // ****** lines object 103 ******
	   var prog103  = gl.createProgram();
	   gl.attachShader(prog103, getShader( gl, "rgl_firstexamplevshader103" ));
	   gl.attachShader(prog103, getShader( gl, "rgl_firstexamplefshader103" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog103, 0, "aPos");
	   gl.bindAttribLocation(prog103, 1, "aCol");
	   gl.linkProgram(prog103);
	   var v=new Float32Array([
	    -3.201857, -2.840512, -4,
	    -3.201857, -2.840512, 4,
	    -3.201857, -2.840512, -4,
	    -3.370241, -2.990924, -4,
	    -3.201857, -2.840512, -2,
	    -3.370241, -2.990924, -2,
	    -3.201857, -2.840512, 0,
	    -3.370241, -2.990924, 0,
	    -3.201857, -2.840512, 2,
	    -3.370241, -2.990924, 2,
	    -3.201857, -2.840512, 4,
	    -3.370241, -2.990924, 4
	   ]);
	   var buf103 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf103);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc103 = gl.getUniformLocation(prog103,"mvMatrix");
	   var prMatLoc103 = gl.getUniformLocation(prog103,"prMatrix");
	   // ****** text object 104 ******
	   var prog104  = gl.createProgram();
	   gl.attachShader(prog104, getShader( gl, "rgl_firstexamplevshader104" ));
	   gl.attachShader(prog104, getShader( gl, "rgl_firstexamplefshader104" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog104, 0, "aPos");
	   gl.bindAttribLocation(prog104, 1, "aCol");
	   gl.linkProgram(prog104);
	   var texts = [
	    "-4",
	    "-2",
	    "0",
	    "2",
	    "4"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX104 = texinfo.canvasX;
	   var canvasY104 = texinfo.canvasY;
	   var ofsLoc104 = gl.getAttribLocation(prog104, "aOfs");
	   var texture104 = gl.createTexture();
	   var texLoc104 = gl.getAttribLocation(prog104, "aTexcoord");
	   var sampler104 = gl.getUniformLocation(prog104,"uSampler");
    	   handleLoadedTexture(texture104, document.getElementById("rgl_firstexampletextureCanvas"));
	   var v=new Float32Array([
	    -3.707009, -3.291748, -4, 0, -0.5, 0.5, 0.5,
	    -3.707009, -3.291748, -4, 1, -0.5, 0.5, 0.5,
	    -3.707009, -3.291748, -4, 1, 1.5, 0.5, 0.5,
	    -3.707009, -3.291748, -4, 0, 1.5, 0.5, 0.5,
	    -3.707009, -3.291748, -2, 0, -0.5, 0.5, 0.5,
	    -3.707009, -3.291748, -2, 1, -0.5, 0.5, 0.5,
	    -3.707009, -3.291748, -2, 1, 1.5, 0.5, 0.5,
	    -3.707009, -3.291748, -2, 0, 1.5, 0.5, 0.5,
	    -3.707009, -3.291748, 0, 0, -0.5, 0.5, 0.5,
	    -3.707009, -3.291748, 0, 1, -0.5, 0.5, 0.5,
	    -3.707009, -3.291748, 0, 1, 1.5, 0.5, 0.5,
	    -3.707009, -3.291748, 0, 0, 1.5, 0.5, 0.5,
	    -3.707009, -3.291748, 2, 0, -0.5, 0.5, 0.5,
	    -3.707009, -3.291748, 2, 1, -0.5, 0.5, 0.5,
	    -3.707009, -3.291748, 2, 1, 1.5, 0.5, 0.5,
	    -3.707009, -3.291748, 2, 0, 1.5, 0.5, 0.5,
	    -3.707009, -3.291748, 4, 0, -0.5, 0.5, 0.5,
	    -3.707009, -3.291748, 4, 1, -0.5, 0.5, 0.5,
	    -3.707009, -3.291748, 4, 1, 1.5, 0.5, 0.5,
	    -3.707009, -3.291748, 4, 0, 1.5, 0.5, 0.5
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
	   var buf104 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf104);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf104 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf104);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc104 = gl.getUniformLocation(prog104,"mvMatrix");
	   var prMatLoc104 = gl.getUniformLocation(prog104,"prMatrix");
	   // ****** lines object 105 ******
	   var prog105  = gl.createProgram();
	   gl.attachShader(prog105, getShader( gl, "rgl_firstexamplevshader105" ));
	   gl.attachShader(prog105, getShader( gl, "rgl_firstexamplefshader105" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog105, 0, "aPos");
	   gl.bindAttribLocation(prog105, 1, "aCol");
	   gl.linkProgram(prog105);
	   var v=new Float32Array([
	    -3.201857, -2.840512, -5.23692,
	    -3.201857, 3.175975, -5.23692,
	    -3.201857, -2.840512, 5.936916,
	    -3.201857, 3.175975, 5.936916,
	    -3.201857, -2.840512, -5.23692,
	    -3.201857, -2.840512, 5.936916,
	    -3.201857, 3.175975, -5.23692,
	    -3.201857, 3.175975, 5.936916,
	    -3.201857, -2.840512, -5.23692,
	    3.533505, -2.840512, -5.23692,
	    -3.201857, -2.840512, 5.936916,
	    3.533505, -2.840512, 5.936916,
	    -3.201857, 3.175975, -5.23692,
	    3.533505, 3.175975, -5.23692,
	    -3.201857, 3.175975, 5.936916,
	    3.533505, 3.175975, 5.936916,
	    3.533505, -2.840512, -5.23692,
	    3.533505, 3.175975, -5.23692,
	    3.533505, -2.840512, 5.936916,
	    3.533505, 3.175975, 5.936916,
	    3.533505, -2.840512, -5.23692,
	    3.533505, -2.840512, 5.936916,
	    3.533505, 3.175975, -5.23692,
	    3.533505, 3.175975, 5.936916
	   ]);
	   var buf105 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf105);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc105 = gl.getUniformLocation(prog105,"mvMatrix");
	   var prMatLoc105 = gl.getUniformLocation(prog105,"prMatrix");
	   gl.enable(gl.DEPTH_TEST);
	   gl.depthFunc(gl.LEQUAL);
	   gl.clearDepth(1.0);
	   gl.clearColor(1, 1, 1, 1);
	   var xOffs = yOffs = 0,  drag  = 0;
	   drawScene();
	   function drawScene(){
	     gl.depthMask(true);
	     gl.disable(gl.BLEND);
	     var radius = 7.671831;
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
	     mvMatrix.translate( -0.1658238, -0.1677315, -0.3499982 );
	     mvMatrix.scale( 1.23155, 1.378701, 0.7423533 );   
	     mvMatrix.multRight( userMatrix );  
	     mvMatrix.translate(0, 0, -distance);
	     gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
	     // ****** points object 94 *******
	     gl.useProgram(prog94);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf94);
	     gl.uniformMatrix4fv( prMatLoc94, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc94, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.enableVertexAttribArray( colLoc );
	     gl.vertexAttribPointer(colLoc, 4, gl.FLOAT, false, 28, 12);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawArrays(gl.POINTS, 0, 1000);
	     // ****** text object 96 *******
	     gl.useProgram(prog96);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf96);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf96);
	     gl.uniformMatrix4fv( prMatLoc96, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc96, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc96 );
	     gl.vertexAttribPointer(texLoc96, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture96);
	     gl.uniform1i( sampler96, 0);
	     gl.enableVertexAttribArray( ofsLoc96 );
	     gl.vertexAttribPointer(ofsLoc96, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
	     // ****** text object 97 *******
	     gl.useProgram(prog97);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf97);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf97);
	     gl.uniformMatrix4fv( prMatLoc97, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc97, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc97 );
	     gl.vertexAttribPointer(texLoc97, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture97);
	     gl.uniform1i( sampler97, 0);
	     gl.enableVertexAttribArray( ofsLoc97 );
	     gl.vertexAttribPointer(ofsLoc97, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
	     // ****** text object 98 *******
	     gl.useProgram(prog98);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf98);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf98);
	     gl.uniformMatrix4fv( prMatLoc98, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc98, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc98 );
	     gl.vertexAttribPointer(texLoc98, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture98);
	     gl.uniform1i( sampler98, 0);
	     gl.enableVertexAttribArray( ofsLoc98 );
	     gl.vertexAttribPointer(ofsLoc98, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
	     // ****** lines object 99 *******
	     gl.useProgram(prog99);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf99);
	     gl.uniformMatrix4fv( prMatLoc99, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc99, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.lineWidth( 1 );
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
	     gl.drawArrays(gl.LINES, 0, 16);
	     // ****** text object 100 *******
	     gl.useProgram(prog100);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf100);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf100);
	     gl.uniformMatrix4fv( prMatLoc100, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc100, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc100 );
	     gl.vertexAttribPointer(texLoc100, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture100);
	     gl.uniform1i( sampler100, 0);
	     gl.enableVertexAttribArray( ofsLoc100 );
	     gl.vertexAttribPointer(ofsLoc100, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 42, gl.UNSIGNED_SHORT, 0);
	     // ****** lines object 101 *******
	     gl.useProgram(prog101);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf101);
	     gl.uniformMatrix4fv( prMatLoc101, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc101, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.lineWidth( 1 );
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
	     gl.drawArrays(gl.LINES, 0, 14);
	     // ****** text object 102 *******
	     gl.useProgram(prog102);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf102);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf102);
	     gl.uniformMatrix4fv( prMatLoc102, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc102, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc102 );
	     gl.vertexAttribPointer(texLoc102, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture102);
	     gl.uniform1i( sampler102, 0);
	     gl.enableVertexAttribArray( ofsLoc102 );
	     gl.vertexAttribPointer(ofsLoc102, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 36, gl.UNSIGNED_SHORT, 0);
	     // ****** lines object 103 *******
	     gl.useProgram(prog103);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf103);
	     gl.uniformMatrix4fv( prMatLoc103, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc103, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.lineWidth( 1 );
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
	     gl.drawArrays(gl.LINES, 0, 12);
	     // ****** text object 104 *******
	     gl.useProgram(prog104);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf104);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf104);
	     gl.uniformMatrix4fv( prMatLoc104, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc104, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc104 );
	     gl.vertexAttribPointer(texLoc104, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture104);
	     gl.uniform1i( sampler104, 0);
	     gl.enableVertexAttribArray( ofsLoc104 );
	     gl.vertexAttribPointer(ofsLoc104, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 30, gl.UNSIGNED_SHORT, 0);
	     // ****** lines object 105 *******
	     gl.useProgram(prog105);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf105);
	     gl.uniformMatrix4fv( prMatLoc105, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc105, false, new Float32Array(mvMatrix.getAsArray()) );
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
<!-- ****** surface object 127 ****** -->
<script id="rgl_persp3dlmvshader127" type="x-shader/x-vertex">
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
<script id="rgl_persp3dlmfshader127" type="x-shader/x-fragment"> 
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
<!-- ****** lines object 128 ****** -->
<script id="rgl_persp3dlmvshader128" type="x-shader/x-vertex">
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
<script id="rgl_persp3dlmfshader128" type="x-shader/x-fragment"> 
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
<!-- ****** text object 130 ****** -->
<script id="rgl_persp3dlmvshader130" type="x-shader/x-vertex">
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
<script id="rgl_persp3dlmfshader130" type="x-shader/x-fragment"> 
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
<!-- ****** text object 131 ****** -->
<script id="rgl_persp3dlmvshader131" type="x-shader/x-vertex">
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
<script id="rgl_persp3dlmfshader131" type="x-shader/x-fragment"> 
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
<!-- ****** text object 132 ****** -->
<script id="rgl_persp3dlmvshader132" type="x-shader/x-vertex">
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
<script id="rgl_persp3dlmfshader132" type="x-shader/x-fragment"> 
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
<!-- ****** lines object 133 ****** -->
<script id="rgl_persp3dlmvshader133" type="x-shader/x-vertex">
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
<script id="rgl_persp3dlmfshader133" type="x-shader/x-fragment"> 
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
<!-- ****** text object 134 ****** -->
<script id="rgl_persp3dlmvshader134" type="x-shader/x-vertex">
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
<script id="rgl_persp3dlmfshader134" type="x-shader/x-fragment"> 
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
<!-- ****** lines object 135 ****** -->
<script id="rgl_persp3dlmvshader135" type="x-shader/x-vertex">
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
<script id="rgl_persp3dlmfshader135" type="x-shader/x-fragment"> 
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
<!-- ****** text object 136 ****** -->
<script id="rgl_persp3dlmvshader136" type="x-shader/x-vertex">
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
<script id="rgl_persp3dlmfshader136" type="x-shader/x-fragment"> 
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
<!-- ****** lines object 137 ****** -->
<script id="rgl_persp3dlmvshader137" type="x-shader/x-vertex">
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
<script id="rgl_persp3dlmfshader137" type="x-shader/x-fragment"> 
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
<!-- ****** text object 138 ****** -->
<script id="rgl_persp3dlmvshader138" type="x-shader/x-vertex">
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
<script id="rgl_persp3dlmfshader138" type="x-shader/x-fragment"> 
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
<!-- ****** lines object 139 ****** -->
<script id="rgl_persp3dlmvshader139" type="x-shader/x-vertex">
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
<script id="rgl_persp3dlmfshader139" type="x-shader/x-fragment"> 
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
	   // ****** surface object 127 ******
	   var prog127  = gl.createProgram();
	   gl.attachShader(prog127, getShader( gl, "rgl_persp3dlmvshader127" ));
	   gl.attachShader(prog127, getShader( gl, "rgl_persp3dlmfshader127" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog127, 0, "aPos");
	   gl.bindAttribLocation(prog127, 1, "aCol");
	   gl.linkProgram(prog127);
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
	   var normLoc127 = gl.getAttribLocation(prog127, "aNorm");
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
	   var buf127 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf127);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf127 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf127);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc127 = gl.getUniformLocation(prog127,"mvMatrix");
	   var prMatLoc127 = gl.getUniformLocation(prog127,"prMatrix");
	   var normMatLoc127 = gl.getUniformLocation(prog127,"normMatrix");
	   // ****** lines object 128 ******
	   var prog128  = gl.createProgram();
	   gl.attachShader(prog128, getShader( gl, "rgl_persp3dlmvshader128" ));
	   gl.attachShader(prog128, getShader( gl, "rgl_persp3dlmfshader128" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog128, 0, "aPos");
	   gl.bindAttribLocation(prog128, 1, "aCol");
	   gl.linkProgram(prog128);
	   var v=new Float32Array([
	    1.2, 1, 60.9009,
	    1.2, 1, 60.9009,
	    89.7, 53, 73.34235,
	    89.7, 53, 73.34235
	   ]);
	   var buf128 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf128);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc128 = gl.getUniformLocation(prog128,"mvMatrix");
	   var prMatLoc128 = gl.getUniformLocation(prog128,"prMatrix");
	   // ****** text object 130 ******
	   var prog130  = gl.createProgram();
	   gl.attachShader(prog130, getShader( gl, "rgl_persp3dlmvshader130" ));
	   gl.attachShader(prog130, getShader( gl, "rgl_persp3dlmfshader130" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog130, 0, "aPos");
	   gl.bindAttribLocation(prog130, 1, "aCol");
	   gl.linkProgram(prog130);
	   var texts = [
	    "Agriculture"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX130 = texinfo.canvasX;
	   var canvasY130 = texinfo.canvasY;
	   var ofsLoc130 = gl.getAttribLocation(prog130, "aOfs");
	   var texture130 = gl.createTexture();
	   var texLoc130 = gl.getAttribLocation(prog130, "aTexcoord");
	   var sampler130 = gl.getUniformLocation(prog130,"uSampler");
    	   handleLoadedTexture(texture130, document.getElementById("rgl_persp3dlmtextureCanvas"));
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
	   var buf130 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf130);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf130 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf130);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc130 = gl.getUniformLocation(prog130,"mvMatrix");
	   var prMatLoc130 = gl.getUniformLocation(prog130,"prMatrix");
	   // ****** text object 131 ******
	   var prog131  = gl.createProgram();
	   gl.attachShader(prog131, getShader( gl, "rgl_persp3dlmvshader131" ));
	   gl.attachShader(prog131, getShader( gl, "rgl_persp3dlmfshader131" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog131, 0, "aPos");
	   gl.bindAttribLocation(prog131, 1, "aCol");
	   gl.linkProgram(prog131);
	   var texts = [
	    "Education"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX131 = texinfo.canvasX;
	   var canvasY131 = texinfo.canvasY;
	   var ofsLoc131 = gl.getAttribLocation(prog131, "aOfs");
	   var texture131 = gl.createTexture();
	   var texLoc131 = gl.getAttribLocation(prog131, "aTexcoord");
	   var sampler131 = gl.getUniformLocation(prog131,"uSampler");
    	   handleLoadedTexture(texture131, document.getElementById("rgl_persp3dlmtextureCanvas"));
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
	   var buf131 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf131);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf131 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf131);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc131 = gl.getUniformLocation(prog131,"mvMatrix");
	   var prMatLoc131 = gl.getUniformLocation(prog131,"prMatrix");
	   // ****** text object 132 ******
	   var prog132  = gl.createProgram();
	   gl.attachShader(prog132, getShader( gl, "rgl_persp3dlmvshader132" ));
	   gl.attachShader(prog132, getShader( gl, "rgl_persp3dlmfshader132" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog132, 0, "aPos");
	   gl.bindAttribLocation(prog132, 1, "aCol");
	   gl.linkProgram(prog132);
	   var texts = [
	    "Fertility"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX132 = texinfo.canvasX;
	   var canvasY132 = texinfo.canvasY;
	   var ofsLoc132 = gl.getAttribLocation(prog132, "aOfs");
	   var texture132 = gl.createTexture();
	   var texLoc132 = gl.getAttribLocation(prog132, "aTexcoord");
	   var sampler132 = gl.getUniformLocation(prog132,"uSampler");
    	   handleLoadedTexture(texture132, document.getElementById("rgl_persp3dlmtextureCanvas"));
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
	   var buf132 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf132);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf132 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf132);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc132 = gl.getUniformLocation(prog132,"mvMatrix");
	   var prMatLoc132 = gl.getUniformLocation(prog132,"prMatrix");
	   // ****** lines object 133 ******
	   var prog133  = gl.createProgram();
	   gl.attachShader(prog133, getShader( gl, "rgl_persp3dlmvshader133" ));
	   gl.attachShader(prog133, getShader( gl, "rgl_persp3dlmfshader133" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog133, 0, "aPos");
	   gl.bindAttribLocation(prog133, 1, "aCol");
	   gl.linkProgram(prog133);
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
	   var buf133 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf133);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc133 = gl.getUniformLocation(prog133,"mvMatrix");
	   var prMatLoc133 = gl.getUniformLocation(prog133,"prMatrix");
	   // ****** text object 134 ******
	   var prog134  = gl.createProgram();
	   gl.attachShader(prog134, getShader( gl, "rgl_persp3dlmvshader134" ));
	   gl.attachShader(prog134, getShader( gl, "rgl_persp3dlmfshader134" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog134, 0, "aPos");
	   gl.bindAttribLocation(prog134, 1, "aCol");
	   gl.linkProgram(prog134);
	   var texts = [
	    "20",
	    "40",
	    "60",
	    "80"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX134 = texinfo.canvasX;
	   var canvasY134 = texinfo.canvasY;
	   var ofsLoc134 = gl.getAttribLocation(prog134, "aOfs");
	   var texture134 = gl.createTexture();
	   var texLoc134 = gl.getAttribLocation(prog134, "aTexcoord");
	   var sampler134 = gl.getUniformLocation(prog134,"uSampler");
    	   handleLoadedTexture(texture134, document.getElementById("rgl_persp3dlmtextureCanvas"));
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
	   var buf134 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf134);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf134 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf134);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc134 = gl.getUniformLocation(prog134,"mvMatrix");
	   var prMatLoc134 = gl.getUniformLocation(prog134,"prMatrix");
	   // ****** lines object 135 ******
	   var prog135  = gl.createProgram();
	   gl.attachShader(prog135, getShader( gl, "rgl_persp3dlmvshader135" ));
	   gl.attachShader(prog135, getShader( gl, "rgl_persp3dlmfshader135" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog135, 0, "aPos");
	   gl.bindAttribLocation(prog135, 1, "aCol");
	   gl.linkProgram(prog135);
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
	   var buf135 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf135);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc135 = gl.getUniformLocation(prog135,"mvMatrix");
	   var prMatLoc135 = gl.getUniformLocation(prog135,"prMatrix");
	   // ****** text object 136 ******
	   var prog136  = gl.createProgram();
	   gl.attachShader(prog136, getShader( gl, "rgl_persp3dlmvshader136" ));
	   gl.attachShader(prog136, getShader( gl, "rgl_persp3dlmfshader136" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog136, 0, "aPos");
	   gl.bindAttribLocation(prog136, 1, "aCol");
	   gl.linkProgram(prog136);
	   var texts = [
	    "10",
	    "20",
	    "30",
	    "40",
	    "50"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX136 = texinfo.canvasX;
	   var canvasY136 = texinfo.canvasY;
	   var ofsLoc136 = gl.getAttribLocation(prog136, "aOfs");
	   var texture136 = gl.createTexture();
	   var texLoc136 = gl.getAttribLocation(prog136, "aTexcoord");
	   var sampler136 = gl.getUniformLocation(prog136,"uSampler");
    	   handleLoadedTexture(texture136, document.getElementById("rgl_persp3dlmtextureCanvas"));
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
	   var buf136 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf136);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf136 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf136);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc136 = gl.getUniformLocation(prog136,"mvMatrix");
	   var prMatLoc136 = gl.getUniformLocation(prog136,"prMatrix");
	   // ****** lines object 137 ******
	   var prog137  = gl.createProgram();
	   gl.attachShader(prog137, getShader( gl, "rgl_persp3dlmvshader137" ));
	   gl.attachShader(prog137, getShader( gl, "rgl_persp3dlmfshader137" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog137, 0, "aPos");
	   gl.bindAttribLocation(prog137, 1, "aCol");
	   gl.linkProgram(prog137);
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
	   var buf137 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf137);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc137 = gl.getUniformLocation(prog137,"mvMatrix");
	   var prMatLoc137 = gl.getUniformLocation(prog137,"prMatrix");
	   // ****** text object 138 ******
	   var prog138  = gl.createProgram();
	   gl.attachShader(prog138, getShader( gl, "rgl_persp3dlmvshader138" ));
	   gl.attachShader(prog138, getShader( gl, "rgl_persp3dlmfshader138" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog138, 0, "aPos");
	   gl.bindAttribLocation(prog138, 1, "aCol");
	   gl.linkProgram(prog138);
	   var texts = [
	    "62",
	    "64",
	    "66",
	    "68",
	    "70",
	    "72"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
	   var canvasX138 = texinfo.canvasX;
	   var canvasY138 = texinfo.canvasY;
	   var ofsLoc138 = gl.getAttribLocation(prog138, "aOfs");
	   var texture138 = gl.createTexture();
	   var texLoc138 = gl.getAttribLocation(prog138, "aTexcoord");
	   var sampler138 = gl.getUniformLocation(prog138,"uSampler");
    	   handleLoadedTexture(texture138, document.getElementById("rgl_persp3dlmtextureCanvas"));
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
	   var buf138 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf138);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf138 = gl.createBuffer();
	   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf138);
	   gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc138 = gl.getUniformLocation(prog138,"mvMatrix");
	   var prMatLoc138 = gl.getUniformLocation(prog138,"prMatrix");
	   // ****** lines object 139 ******
	   var prog139  = gl.createProgram();
	   gl.attachShader(prog139, getShader( gl, "rgl_persp3dlmvshader139" ));
	   gl.attachShader(prog139, getShader( gl, "rgl_persp3dlmfshader139" ));
	   //  Force aPos to location 0, aCol to location 1 
	   gl.bindAttribLocation(prog139, 0, "aPos");
	   gl.bindAttribLocation(prog139, 1, "aCol");
	   gl.linkProgram(prog139);
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
	   var buf139 = gl.createBuffer();
	   gl.bindBuffer(gl.ARRAY_BUFFER, buf139);
	   gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc139 = gl.getUniformLocation(prog139,"mvMatrix");
	   var prMatLoc139 = gl.getUniformLocation(prog139,"prMatrix");
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
	     // ****** surface object 127 *******
	     gl.useProgram(prog127);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf127);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf127);
	     gl.uniformMatrix4fv( prMatLoc127, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc127, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( normMatLoc127, false, new Float32Array(normMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 1, 1, 1, 1 );
	     gl.enableVertexAttribArray( normLoc127 );
	     gl.vertexAttribPointer(normLoc127, 3, gl.FLOAT, false, 24, 12);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 24,  0);
	     gl.drawElements(gl.TRIANGLES, 3750, gl.UNSIGNED_SHORT, 0);
	     // ****** lines object 128 *******
	     gl.useProgram(prog128);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf128);
	     gl.uniformMatrix4fv( prMatLoc128, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc128, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.lineWidth( 1 );
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
	     gl.drawArrays(gl.LINES, 0, 4);
	     // ****** text object 130 *******
	     gl.useProgram(prog130);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf130);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf130);
	     gl.uniformMatrix4fv( prMatLoc130, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc130, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc130 );
	     gl.vertexAttribPointer(texLoc130, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture130);
	     gl.uniform1i( sampler130, 0);
	     gl.enableVertexAttribArray( ofsLoc130 );
	     gl.vertexAttribPointer(ofsLoc130, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
	     // ****** text object 131 *******
	     gl.useProgram(prog131);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf131);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf131);
	     gl.uniformMatrix4fv( prMatLoc131, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc131, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc131 );
	     gl.vertexAttribPointer(texLoc131, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture131);
	     gl.uniform1i( sampler131, 0);
	     gl.enableVertexAttribArray( ofsLoc131 );
	     gl.vertexAttribPointer(ofsLoc131, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
	     // ****** text object 132 *******
	     gl.useProgram(prog132);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf132);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf132);
	     gl.uniformMatrix4fv( prMatLoc132, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc132, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc132 );
	     gl.vertexAttribPointer(texLoc132, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture132);
	     gl.uniform1i( sampler132, 0);
	     gl.enableVertexAttribArray( ofsLoc132 );
	     gl.vertexAttribPointer(ofsLoc132, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
	     // ****** lines object 133 *******
	     gl.useProgram(prog133);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf133);
	     gl.uniformMatrix4fv( prMatLoc133, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc133, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.lineWidth( 1 );
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
	     gl.drawArrays(gl.LINES, 0, 10);
	     // ****** text object 134 *******
	     gl.useProgram(prog134);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf134);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf134);
	     gl.uniformMatrix4fv( prMatLoc134, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc134, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc134 );
	     gl.vertexAttribPointer(texLoc134, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture134);
	     gl.uniform1i( sampler134, 0);
	     gl.enableVertexAttribArray( ofsLoc134 );
	     gl.vertexAttribPointer(ofsLoc134, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 24, gl.UNSIGNED_SHORT, 0);
	     // ****** lines object 135 *******
	     gl.useProgram(prog135);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf135);
	     gl.uniformMatrix4fv( prMatLoc135, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc135, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.lineWidth( 1 );
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
	     gl.drawArrays(gl.LINES, 0, 12);
	     // ****** text object 136 *******
	     gl.useProgram(prog136);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf136);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf136);
	     gl.uniformMatrix4fv( prMatLoc136, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc136, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc136 );
	     gl.vertexAttribPointer(texLoc136, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture136);
	     gl.uniform1i( sampler136, 0);
	     gl.enableVertexAttribArray( ofsLoc136 );
	     gl.vertexAttribPointer(ofsLoc136, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 30, gl.UNSIGNED_SHORT, 0);
	     // ****** lines object 137 *******
	     gl.useProgram(prog137);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf137);
	     gl.uniformMatrix4fv( prMatLoc137, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc137, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.lineWidth( 1 );
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
	     gl.drawArrays(gl.LINES, 0, 14);
	     // ****** text object 138 *******
	     gl.useProgram(prog138);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf138);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf138);
	     gl.uniformMatrix4fv( prMatLoc138, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc138, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
	     gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc138 );
	     gl.vertexAttribPointer(texLoc138, 2, gl.FLOAT, false, 28, 12);
	     gl.activeTexture(gl.TEXTURE0);
	     gl.bindTexture(gl.TEXTURE_2D, texture138);
	     gl.uniform1i( sampler138, 0);
	     gl.enableVertexAttribArray( ofsLoc138 );
	     gl.vertexAttribPointer(ofsLoc138, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 36, gl.UNSIGNED_SHORT, 0);
	     // ****** lines object 139 *******
	     gl.useProgram(prog139);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf139);
	     gl.uniformMatrix4fv( prMatLoc139, false, new Float32Array(prMatrix.getAsArray()) );
	     gl.uniformMatrix4fv( mvMatLoc139, false, new Float32Array(mvMatrix.getAsArray()) );
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


