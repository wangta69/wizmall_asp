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
			var group_cnt	= eval("$('."+group_class+"').length");//üũ �ڽ� �׷� ��
			var chk_cnt		= eval("$('."+group_class+":checkbox:checked').length");//üũ�� üũ �ڽ���
			var is_checked	= $f.is(':checked')//������� üũ�Ǿ� �ִ��� üũ
			//alert(is_checked);
			var min_len		= $.validate.getclass($f.attr('class'),'min');
			var max_len		= $.validate.getclass($f.attr('class'),'max');
			if(min_len && chk_cnt < min_len){
				alert('�ּ� '+min_len+' �̻� �������ּ���');
				return false;
			}else if(max_len && chk_cnt > max_len){
				alert('�ִ� '+max_len+' ���Ϸ� �������ּ���');
				return false;
			}else if(is_checked==false){
				//alert(chk_cnt);
				alert($f.attr('msg'));
				return false;
			}else return true;
		},
		radio : function($f) { 
			var group_class	= $f.attr('group');
			var group_cnt	= eval("$('."+group_class+"').length");//üũ �ڽ� �׷� ��
			var chk_cnt		= eval("$('."+group_class+":radio:checked').length");//üũ�� üũ �ڽ���
			//var is_checked	= $f.is(':checked')//������� üũ�Ǿ� �ִ��� üũ
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
				alert('�ּ� '+min_len+'�� �̻� �Է����ּ���');
				$f.focus();
				return false;
			}else if(max_len && str_len > max_len){
				alert('�ִ� '+max_len+'�� ���Ϸ� �Է����ּ���');
				$f.focus();
				return false;
			}else if(str_len == 0){
					alert($f.attr('msg'));
					$f.focus();
				return false;
			}else if($f.hasClass('check_email')){//�̸��� üũ �ΰ��			
				if(group_email_class){//�ΰ��� �ؽ�Ʈ �ʵ� ���ϱ�
					var tmp	= new Array();
					eval("$('."+group_email_class+"')").each(function (index) {
						tmp[index] = $(this).val();					 
					});
					
					var tmp_email = tmp[0]+"@"+tmp[1];
					if(!$.validate.email(tmp_email)){
						alert('��ȿ���� ���� �̸��� �Դϴ�.');
						$f.focus();
						return false;
					}else return true;				
				}else if(!$.validate.email($f.val())){
					alert('��ȿ���� ���� �̸��� �Դϴ�.');
					$f.focus();
					return false;
				}
	
			}else if($f.hasClass('check_jumin1') || $f.hasClass('check_jumin2')){//�ֹε�Ϲ�ȣ�ΰ��
				eval("$('."+group_class+"')").each(function (index) {
					tmp[index] = $(this).val();					 
				});
				var jumin1 = $('.check_jumin1').val();
				var jumin2 = $('.check_jumin2').val();
				
				if(!$.validate.jumin(jumin1, jumin2)){
					alert('��ȿ���� ���� �ֹε�Ϲ�ȣ �Դϴ�.');
					$f.focus();
					return false;
				}
			}else if($f.hasClass('check_eng')){//���� only
				if(!$.validate.alpha($f.val())){
					alert('������ �����մϴ�.');
					$f.focus();
					return false;
				}	
			}else if($f.hasClass('check_num')){//���� only
				if(!$.validate.num($f.val())){
					alert('���ڸ� �����մϴ�.');
					$f.focus();
					return false;
				}	
			}else if($f.hasClass('check_kor')){//�ѱ� only
				if(!$.validate.kor($f.val())){
					alert('�ѱ۸� �����մϴ�.');
					$f.focus();
					return false;
				}	
			}else if($f.hasClass('check_engnum')){//���ڿ��� only
				if(!$.validate.alphanum($f.val())){
					alert('�����ڸ� �����մϴ�.');
					$f.focus();
					return false;
				}	
			}else if($f.hasClass('check_nospecial')){//no special char
				if(!$.validate.special($f.val())){
					alert('Ư�����ڴ� ���Ұ����մϴ�.');
					$f.focus();
					return false;
				}				
			}else if(group_class){//�ΰ��� �ؽ�Ʈ �ʵ� ���ϱ�
				var tmp	= new Array();
				eval("$('."+group_class+"')").each(function (index) {
					tmp[index] = $(this).val();					 
				});
				
				var comparestr = new RegExp(tmp[0]); 
				if(comparestr.test(tmp[1]) && tmp[0].length == tmp[1].length){ //
					return true;
				}else{
					alert('���ڿ��� ��ġ���� �ʽ��ϴ�.');
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
						//alert ("��Ȯ���� ���� �ֹε�� ��ȣ�Դϴ�.");
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
			if(str.length != 0 && !str.match(/^[��-�R]+$/)) {
				return false;
			}else return true;
		},		
		alphanum : function(str) {
			if(str.length != 0 && !str.match(/^[0-9a-zA-Z]+$/)) {
				return false;
			}else return true;
		},		
		special : function(str) {
			if(str.length != 0 && !str.match(/^[��-�Ra-zA-Z0-9]+$/)) {
				return false;
			}else return true;
		}
	};
	
})(jQuery);

