(function($) {
	var wizgallery_show_index	= 0;//현재보여지는 인덱스
	var wizgallery_select_index	= 0;//현재 선택된 인덱스
	var wizgallery_gall_cnt		= 0;//모든 이미지 갯수
	var wizgallery_el;
	var wizgallery_defaults;
	$.fn.wizgallery = function(options) {
		wizgallery_defaults = {  
			autoSlideInterval: 5000
		};
		
		wizgallery_el = this;
		wizgallery_gall_cnt = wizgallery_el.size();//겔러리 갯수
		var options = $.extend(wizgallery_defaults, options); 

		$(this).hover(function() {
				//alert('over');
				return clearInterval (autoPlay);
		}, function() {
			return autoPlay = setInterval( $.ch_gallery, options.autoSlideInterval);
		});
		return autoPlay = setInterval( $.ch_gallery, options.autoSlideInterval);
	};
	

	$.ch_gallery = function() {
		wizgallery_el.addClass('wizgallery');
		wizgallery_select_index = wizgallery_show_index % wizgallery_el.size();

		wizgallery_el.each(function(index){
			if(index == wizgallery_select_index) $(this).show();
			else $(this).hide();
		});
		wizgallery_show_index++;
	};	
})(jQuery);