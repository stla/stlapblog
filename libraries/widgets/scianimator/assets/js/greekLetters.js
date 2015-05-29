(function($) {
	Index = {
		// Visible images
		images_vis: ["assets/images/greekLetters001.png","assets/images/greekLetters002.png","assets/images/greekLetters003.png","assets/images/greekLetters004.png","assets/images/greekLetters005.png","assets/images/greekLetters006.png","assets/images/greekLetters007.png","assets/images/greekLetters008.png","assets/images/greekLetters009.png","assets/images/greekLetters010.png","assets/images/greekLetters011.png","assets/images/greekLetters012.png","assets/images/greekLetters013.png","assets/images/greekLetters014.png","assets/images/greekLetters015.png","assets/images/greekLetters016.png","assets/images/greekLetters017.png","assets/images/greekLetters018.png","assets/images/greekLetters019.png","assets/images/greekLetters020.png","assets/images/greekLetters021.png","assets/images/greekLetters022.png","assets/images/greekLetters023.png","assets/images/greekLetters024.png","assets/images/greekLetters025.png","assets/images/greekLetters026.png","assets/images/greekLetters027.png","assets/images/greekLetters028.png","assets/images/greekLetters029.png","assets/images/greekLetters030.png","assets/images/greekLetters031.png","assets/images/greekLetters032.png","assets/images/greekLetters033.png","assets/images/greekLetters034.png","assets/images/greekLetters035.png","assets/images/greekLetters036.png","assets/images/greekLetters037.png","assets/images/greekLetters038.png","assets/images/greekLetters039.png","assets/images/greekLetters040.png","assets/images/greekLetters041.png","assets/images/greekLetters042.png","assets/images/greekLetters043.png","assets/images/greekLetters044.png","assets/images/greekLetters045.png","assets/images/greekLetters046.png","assets/images/greekLetters047.png","assets/images/greekLetters048.png","assets/images/greekLetters049.png","assets/images/greekLetters050.png","assets/images/greekLetters051.png","assets/images/greekLetters052.png","assets/images/greekLetters053.png","assets/images/greekLetters054.png","assets/images/greekLetters055.png","assets/images/greekLetters056.png","assets/images/greekLetters057.png","assets/images/greekLetters058.png","assets/images/greekLetters059.png","assets/images/greekLetters060.png","assets/images/greekLetters061.png","assets/images/greekLetters062.png","assets/images/greekLetters063.png","assets/images/greekLetters064.png","assets/images/greekLetters065.png","assets/images/greekLetters066.png","assets/images/greekLetters067.png","assets/images/greekLetters068.png","assets/images/greekLetters069.png","assets/images/greekLetters070.png","assets/images/greekLetters071.png","assets/images/greekLetters072.png","assets/images/greekLetters073.png","assets/images/greekLetters074.png","assets/images/greekLetters075.png","assets/images/greekLetters076.png","assets/images/greekLetters077.png","assets/images/greekLetters078.png","assets/images/greekLetters079.png","assets/images/greekLetters080.png","assets/images/greekLetters081.png","assets/images/greekLetters082.png","assets/images/greekLetters083.png","assets/images/greekLetters084.png","assets/images/greekLetters085.png","assets/images/greekLetters086.png","assets/images/greekLetters087.png","assets/images/greekLetters088.png","assets/images/greekLetters089.png","assets/images/greekLetters090.png","assets/images/greekLetters091.png","assets/images/greekLetters092.png","assets/images/greekLetters093.png","assets/images/greekLetters094.png","assets/images/greekLetters095.png","assets/images/greekLetters096.png","assets/images/greekLetters097.png","assets/images/greekLetters098.png","assets/images/greekLetters099.png","assets/images/greekLetters100.png"],
			
		/**
		 * Initialize the page
		 */
		init: function() 
		{
			//$.fn.scianimator.defaults.debug = true;
			//$.fn.scianimator.defaults.theme = 'blue';

			// Construct 1st animator
			$('#scianimator1').scianimator({
				'images': Index.images_vis,
				'width': 640,
				'utf8': false,
				'theme': 'dark'
			});
			
		}
	};
	
	$(document).ready(Index.init);
})(jQuery);
