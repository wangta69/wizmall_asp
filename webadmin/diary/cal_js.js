function changeEndHour(){
	var f = document.forms[0];
	var s = f.startHour.selectedIndex;
	var	d = f.durHour.selectedIndex;
	var num = s + d;

	if( num > f.endHour.options.length-1 )
		num = num - f.endHour.options.length;
	f.endHour.options[num].selected = true;
}

function changeEndMin(){
	var f = document.forms[0];
	var	s = f.startMin.selectedIndex;
	var d = f.durMin.selectedIndex;
	var num = s + d;

	if( num > f.endMin.options.length-1) {
		num = num - f.endMin.options.length;
		var curSel = f.endHour.selectedIndex+1;
		if ( curSel >= f.endHour.options.length )
			curSel = 0;
		f.endHour.options[curSel].selected = true
	}
	f.endMin.options[num].selected = true;
}

function _changeEndHour(){
	changeEndHour()
	changeEndMin()
}

function _changeEndMin(){
	changeEndMin()
}

function changeDurHour(){
	var f= document.forms[0];
	var e = f.endHour.selectedIndex ;
	var s = f.startHour.selectedIndex ;

	var num = e - s ;

	if( f.startMin.selectedIndex > f.endMin.selectedIndex )
		num--;

	if( num < 0 )
		num += 24
	f.durHour.options[num].selected = true;
}

function changeDurMin(){
	var f = document.forms[0];
	var num = f.endMin.selectedIndex - f.startMin.selectedIndex;
	var num1 = f.endHour.selectedIndex - f.startHour.selectedIndex;

	if( num1 < 0 )
		num1 += 24;
	f.durHour.options[num1].selected = true;

	if( num<0 && f.durHour.selectedIndex > 0 ){
		f.durHour.options[f.durHour.selectedIndex - 1].selected = true;
		num = num + f.durMin.options.length;
	}else if( num < 0 ){
		num = 0;
		f.endMin.options[f.startMin.selectedIndex].selected = true;
	}
	f.durMin.options[num].selected = true;
}

//function checkForm(theForm) {

//	if (isField(theForm.title.value) < 1) {
//                alert("제목을 입력해 주세요");
//                return false;
//        }

//	if (isField(theForm.desc.value) < 1) {
//                alert("내용을 입력해주세요.");
//                return false;
//        }
//	changeEndHour()
//	changeEndMin()
//
//	return true;
//	}


	function isField(keyword) {
		var st_num,key_len;
		st_num = keyword.indexOf(" ");	
		while (st_num != -1){
			keyword = keyword.replace(" ", "");
			st_num  = keyword.indexOf(" ");
			}
		key_len=keyword.length;
		return key_len;
	}

	function Delete(cc_id) {
		if (confirm('\n해당일정을 정말로 삭제하시겠습니까?')) {
			location.href="cal_process.asp?cp_type=del&cc_id="+cc_id;
		}
	}

