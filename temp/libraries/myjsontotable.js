// require: jsonTable.js
// https://github.com/omkarkhair/jsonTable

function jsontotable(selector, data, columns, colnames=columns, rowclass="classy", callback=function(){}){
	var options = {
		source: data,
		rowClass: rowclass,
		callback: callback
	};
	$(selector).jsonTable({
		head : colnames,
		json : columns
	});
	$(selector).jsonTableUpdate(options);
}

// example

    //<head>
	    //<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		//<script type="text/javascript" src="https://rawgit.com/omkarkhair/jsonTable/master/jsonTable.js"></script>

        //<script type="text/javascript" src="thisfile"></script>

	    //<style type="text/css">
	        //#dataTable.classy {
	            //color: red;
	        //}
	    //</style>

        //<script type="text/javascript">
        //var data = [
                //{"model" : "Iphone 18", "name" : "iOS", "share" : 57.56},
                //{"model" : "Nexus 23", "name" : "Android", "share" : 24.66},
                //{"model" : "Tom-tom", "name" : "Java ME", "share" : 10.72},
                //{"model" : "Nokia 66610", "name" : "Symbian", "share" : 2.49},
                //{"model" : "Blackberry", "name" : "Blackberry", "share" : 2.26},
                //{"model" : "Lumia", "name" : "Windows Phone", "share" : 1.33}
            //];
        //var columns = ['model', 'name', 'share'];
        //</script>

        //<script type="text/javascript">
            //$(document).ready(function(){
				//jsontotable("#dataTable", data, columns);
			//})
        //</script>

    //</head>

    //<body>
        //<table id="dataTable" style="color: red;">
        //</table>
    //</body>

