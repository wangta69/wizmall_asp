/*     
	2010.04
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

	Copyright(C) 2010 pondol
	url : http://www.shop-wiz.com
	demo : http://www.shop-wiz.com/document/pop/jquery/pluginsample08
*/
(function($) {
	$.fn.formvalidate = function() {
		var result = true;
		var msg		= "";
		var input_attr	= "";
		$(':input', this).each(function (index) {
			
			input_attr = $(this).attr('type');
			input_tag = $(this).get(0).tagName;

			if($(this).hasClass('required')){
				// alert($(this).val());
				// alert(input_attr)
				
				switch(input_attr){
					case "checkbox":
						try {
							result =  $.validate.checkbox($(this));
							return result;
							
						} catch(exception) {}
					break;
					case "radio":
						try {
							//alert(input_attr);
							result =  $.validate.radio($(this));
							return result;
							
						} catch(exception) {}
					break;					
					case "text":
					case "textarea":
					case "password":
					case "hidden":
					case "select-one":
						//$.validate.text($(this));
						try {
							result =  $.validate.text($(this));
							return result;
							
						} catch(exception) {alert('occur error')}
					break;	
				
				}
				if($(this).val() == "") {
					msg = $(this).attr("msg");
					return false;
				}
			}
		});//$(':input', this).each(function (index) {
		if(msg != "") alert(msg);
		return result;
	};

	
	$.validate = {
		checkbox : function($f) { 
			var group_class	= $f.attr('group');
			var group_cnt	= eval("$('."+group_class+"').length");//Ã¼Å© ¹Ú½º ±×·ì ¼ö
			var chk_cnt		= eval("$('."+group_class+":checkbox:checked').length");//Ã¼Å©µÈ Ã¼Å© ¹Ú½º¼ö
			var is_checked	= $f.is(':checked')//ÇöÀç°ÍÀÌ Ã¼Å©µÇ¾î ÀÖ´ÂÁö Ã¼Å©
			//alert(is_checked);
			var min_len		= $.validate.getclass($f.attr('class'),'min');
			var max_len		= $.validate.getclass($f.attr('class'),'max');
			if(min_len && chk_cnt < min_len){
				alert('ÃÖ¼Ò '+min_len+' ÀÌ»ó ¼±ÅÃÇØÁÖ¼¼¿ä');
				return false;
			}else if(max_len && chk_cnt > max_len){
				alert('ÃÖ´ë '+max_len+' ÀÌÇÏ·Î ¼±ÅÃÇØÁÖ¼¼¿ä');
				return false;
			}else if(is_checked==false){
				//alert(chk_cnt);
				alert($f.attr('msg'));
				return false;
			}else return true;
		},
		radio : function($f) { 
			var group_class	= $f.attr('group');
			var group_cnt	= eval("$('."+group_class+"').length");//Ã¼Å© ¹Ú½º ±×·ì ¼ö
			var chk_cnt		= eval("$('."+group_class+":radio:checked').length");//Ã¼Å©µÈ Ã¼Å© ¹Ú½º¼ö
			//var is_checked	= $f.is(':checked')//ÇöÀç°ÍÀÌ Ã¼Å©µÇ¾î ÀÖ´ÂÁö Ã¼Å©
			if(chk_cnt==0){
				alert($f.attr('msg'));
				return false;
			}else return true;
		},		
		text : function($f) { 
			var group_class	= $f.attr('group');
			var group_email_class	= $f.attr('groupemail');			
			var min_len		= $.validate.getclass($f.attr('class'),'min');
			var max_len		= $.validate.getclass($f.attr('class'),'max');
			var str_len		= $f.val().length;
			var result;
			if(min_len && str_len < min_len){
				alert('ÃÖ¼Ò '+min_len+'ÀÚ ÀÌ»ó ÀÔ·ÂÇØÁÖ¼¼¿ä');
				$f.focus();
				return false;
			}else if(max_len && str_len > max_len){
				alert('ÃÖ´ë '+max_len+'ÀÚ ÀÌÇÏ·Î ÀÔ·ÂÇØÁÖ¼¼¿ä');
				$f.focus();
				return false;
			}else if(str_len == 0){
					alert($f.attr('msg'));
					$f.focus();
				return false;
			}else if($f.hasClass('check_email')){//ÀÌ¸ŞÀÏ Ã¼Å© ÀÎ°æ¿ì			
				if(group_email_class){//µÎ°³ÀÇ ÅØ½ºÆ® ÇÊµå ºñ±³ÇÏ±â
					var tmp	= new Array();
					eval("$('."+group_email_class+"')").each(function (index) {
						tmp[index] = $(this).val();					 
					});
					
					var tmp_email = tmp[0]+"@"+tmp[1];
					if(!$.validate.email(tmp_email)){
						alert('À¯È¿ÇÏÁö ¾ÊÀº ÀÌ¸ŞÀÏ ÀÔ´Ï´Ù.');
						$f.focus();
						return false;
					}else return true;				
				}else if(!$.validate.email($f.val())){
					alert('À¯È¿ÇÏÁö ¾ÊÀº ÀÌ¸ŞÀÏ ÀÔ´Ï´Ù.');
					$f.focus();
					return false;
				}
	
			}else if($f.hasClass('check_jumin1') || $f.hasClass('check_jumin2')){//ÁÖ¹Îµî·Ï¹øÈ£ÀÎ°æ¿ì
				eval("$('."+group_class+"')").each(function (index) {
					tmp[index] = $(this).val();					 
				});
				var jumin1 = $('.check_jumin1').val();
				var jumin2 = $('.check_jumin2').val();
				
				if(!$.validate.jumin(jumin1, jumin2)){
					alert('À¯È¿ÇÏÁö ¾ÊÀº ÁÖ¹Îµî·Ï¹øÈ£ ÀÔ´Ï´Ù.');
					$f.focus();
					return false;
				}
			}else if($f.hasClass('check_eng')){//¿µ¹® only
				if(!$.validate.alpha($f.val())){
					alert('¿µ¹®¸¸ °¡´ÉÇÕ´Ï´Ù.');
					$f.focus();
					return false;
				}	
			}else if($f.hasClass('check_num')){//¼ıÀÚ only
				if(!$.validate.num($f.val())){
					alert('¼ıÀÚ¸¸ °¡´ÉÇÕ´Ï´Ù.');
					$f.focus();
					return false;
				}	
			}else if($f.hasClass('check_kor')){//ÇÑ±Û only
				if(!$.validate.kor($f.val())){
					alert('ÇÑ±Û¸¸ °¡´ÉÇÕ´Ï´Ù.');
					$f.focus();
					return false;
				}	
			}else if($f.hasClass('check_engnum')){//¼ıÀÚ¿µ¹® only
				if(!$.validate.alphanum($f.val())){
					alert('¿µ¼ıÀÚ¸¸ °¡´ÉÇÕ´Ï´Ù.');
					$f.focus();
					return false;
				}	
			}else if($f.hasClass('check_nospecial')){//no special char
				if(!$.validate.special($f.val())){
					alert('Æ¯¼ö¹®ÀÚ´Â »ç¿ëºÒ°¡´ÉÇÕ´Ï´Ù.');
					$f.focus();
					return false;
				}				
			}else if(group_class){//µÎ°³ÀÇ ÅØ½ºÆ® ÇÊµå ºñ±³ÇÏ±â
				var tmp	= new Array();
				eval("$('."+group_class+"')").each(function (index) {
					tmp[index] = $(this).val();					 
				});
				
				var comparestr = new RegExp(tmp[0]); 
				if(comparestr.test(tmp[1]) && tmp[0].length == tmp[1].length){ //
					return true;
				}else{
					alert('¹®ÀÚ¿­ÀÌ ÀÏÄ¡ÇÏÁö ¾Ê½À´Ï´Ù.');
					$f.focus();
					return false;
				}
			}else return true;
		},		
		getclass : function(strClass, strClassName) {
			var arr = strClass.split(' ');
			var i;
			var regex = new RegExp('^'+strClassName, 'g');
			for (i=0; i < arr.length; i++)
				if(regex.test(arr[i])) {
					if(arr[i].replace(strClassName,'').length != 0)
						return arr[i].replace(strClassName,'');
				}
			
			return null;
		},		
		email : function(email) {
			var reg_email = /[-!#$%&'*+\/^_~{}|0-9a-zA-Z]+(\.[-!#$%&'*+\/^_~{}|0-9a-zA-Z]+)*@[-!#$%&'*+\/^_~{}|0-9a-zA-Z]+(\.[-!#$%&'*+\/^_~{}|0-9a-zA-Z]+)*/;
			if( !reg_email.test(email) ) {
				return false;
			}else return true;
		},	
		jumin : function(jumin1, jumin2) {
			if(jumin1.length != 6 || jumin2.length != 7) {
				return false;
			}else if(!$.validate.num(jumin1) || !$.validate.num(jumin2) ){
				return false;
			}else{
				var i;
				chk = 0;
				for (i=0; i<6; i++) chk += ( (i+2) * parseInt( jumin1.substring( i, i+1) ));
				for (i=6; i<12; i++) chk += ( (i%8+2) * parseInt( jumin2.substring( i-6, i-5) ));         
	
				chk = 11 - (chk%11);
				chk %= 10;
				if (chk != parseInt( jumin2.substring(6,7))) {
						//alert ("Á¤È®ÇÏÁö ¾ÊÀº ÁÖ¹Îµî·Ï ¹øÈ£ÀÔ´Ï´Ù.");
						return false;
				}else return true;
			}
		},			
		num : function(str) {
			if(str.length != 0 && !str.match(/^[0-9]+$/)) {
				return false;
			}else return true;
		},		
		alpha : function(str) {
			if(str.length != 0 && !str.match(/^[a-zA-Z]+$/)) {
				return false;
			}else return true;
		},		
		kor : function(str) {
			if(str.length != 0 && !str.match(/^[°¡-ÆR]+$/)) {
				return false;
			}else return true;
		},		
		alphanum : function(str) {
			if(str.length != 0 && !str.match(/^[0-9a-zA-Z]+$/)) {
				return false;
			}else return true;
		},		
		special : function(str) {
			if(str.length != 0 && !str.match(/^[°¡-ÆRa-zA-Z0-9]+$/)) {
				return false;
			}else return true;
		}
	};
	
})(jQuery);

