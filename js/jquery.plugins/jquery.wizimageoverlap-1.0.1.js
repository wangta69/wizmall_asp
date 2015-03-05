/* 
usage sampel

$(function(){
	//로드시 초기 이미지 설정
	var iniImg = $(".thumimg:first").attr("src")
	$("#bigImg img").attr("src", iniImg) ; 
	
	$(".thumimg").mouseover(function(){
		$(this).wizimagech();
	});
});

<style type="text/css">
ul li{display:inline;}
</style>

<div id="bigImg" style="position:relative"><img src="" width="500" height="500" /></div>

<ul>
<li><img src="../actionsc/images/benz.png" width="100" height="100" class="thumimg"/></li>
<li><img src="../actionsc/images/bmw.png" width="100" height="100" class="thumimg"/></li>
<li><img src="../actionsc/images/infiniti.png" width="100" height="100" class="thumimg"/></li>
</ul>
*/
(function($) {
	$.fn.wizimagech = function(options) {
		wizgallery_defaults = {  
			fadeout:	500,
			fadein:		1000
		};
		
		var options = $.extend(wizgallery_defaults, options); 

		var el = this; 
			//초기화
		$("#bigImg img").each(function(i){if(i!=0) $(this).remove();})
		$("#bigImg img").attr("style", "position:absolute; top:0; left:0; z-index:8;").fadeOut(options.fadeout, function(){$(this).remove()});
		$("#bigImg img").clone().prependTo('#bigImg').attr("src", el.attr("src")).attr("style", "position:relative; top:0; left:0; z-index:7;").hide().fadeIn(options.fadein) ;

	};

})(jQuery);