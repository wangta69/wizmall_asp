/*
*  url : http://www.shop-wiz.com 
*  usage : $(this).loadingbar();
*/

(function($) {
	$.fn.loadingbar = function(options) {
		
		var opt = {
			url:"http://mall.shop-wiz.com/images/common/loading.swf",
			width:100,
			height:28
		};
		
		$.extend(opt, options);
		
		this.each(function(){
			var element = $(this);
			var win = $(window);
			
			var x = win.width();
			var y = win.height();
			
			var flashobj = "";
			var flashobj = flashobj + "<object classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' codebase='http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0' width='"+opt.width+"' height='"+opt.height+"'>";
			var flashobj = flashobj + "<param name='allowScriptAccess' value='always' /> ";
			var flashobj = flashobj + "<param name='movie' value='"+opt.url+"' /> ";
			var flashobj = flashobj + "<param name='quality' value='high' /> ";
			var flashobj = flashobj + "<param name='wmode' value='transparent'> ";
			var flashobj = flashobj + "<embed src='"+opt.url+"' quality='high' width='"+opt.width+"' height='"+opt.height+"' wmode='transparent' allowScriptAccess='sameDomain' type='application/x-shockwave-flash' pluginspage='http://www.macromedia.com/go/getflashplayer' />";
			var flashobj = flashobj + "</object>";

			$('#Loadingbarimg').remove();
			element.append('<div id="Loadingbarimg" style="display:block"></div>');
			$("#Loadingbarimg").html(flashobj);
	 		$("#Loadingbarimg").css({"position":"absolute","z-index":1000, "opacity": 0.9});
			$("#Loadingbarimg").css("left", win.scrollLeft() + x/2 - $("#Loadingbarimg").width()/2);
			$("#Loadingbarimg").css("top", win.scrollTop() + y/2 - $("#Loadingbarimg").height()/2);	
			

		});
		//return this;
	};
})(jQuery);