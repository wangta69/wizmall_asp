(function($) {
	var wizgallery_show_index	= 0;//���纸������ �ε���
	var wizgallery_select_index	= 0;//���� ���õ� �ε���
	var wizgallery_gall_cnt		= 0;//��� �̹��� ����
	var wizgallery_el;
	var wizgallery_defaults;
	$.fn.wizgallery = function(options) {
		wizgallery_defaults = {  
			autoSlideInterval: 5000
		};
		
		wizgallery_el = this;
		wizgallery_gall_cnt = wizgallery_el.size();//�ַ��� ����
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