/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                         JAVASCRIPT CODE                                          
  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  function name                                                                           | description                                                                         | use process
  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  moveFocus(num,fromform,toform)                                      | 주민번호, 사업자번호작성 후 자동 다음 폼 이동    onkeyup="moveFocus(6,this,document.UserRegisForm.juminno2)"        by Phondol 2003.08.13
  IsIntChk(strTmp)                                                                      |  정수검사
  filterNum(str)                                                      | str중 ^\$|, 글자를 빼기  new_num = filterNum(document.test.old_num.value);
  TypeCheck (s, spc)                                                  |  타입책크(영문자 및 숫자로만 사용책크)T ypeCheck(f.ID.value, ALPHA+NUM)
  commaSplit(srcNumber)                                               | 숫자에서 컴마를 제거
  SetComma(frm)														  | 필드에 값을 넣을 때 자동으로 comma책크 onkeyup=setComma(this)
  SpaceChk( str )					                                       | 공백책크
  IsEmailChk( str )					                               |  유효이메일검사
  IsJuminChk(jumin1, jumin2)                                                 | 유효주민번호 책크
  function chkWorkNum(reg_no1,reg_no2,reg_no3)          | 유효 사업자등록번호 책크
  function enter(field)									/Enter key 입력시 다음 필드로 넘기기  사용법 : onKeyPress="enter(this)"
  -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
  
 
var NUM = "0123456789"; 
var SALPHA = "abcdefghijklmnopqrstuvwxyz";
var ALPHA = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"+SALPHA;
var COMMA = ",";


function moveFocus(num,fromform,toform){
    var str = fromform.value.length;
    if(str == num)
       toform.focus();
}

function IsIntChk(strTmp){
    var len, i, imsi;
    strTmp = "" + strTmp;
    len = strTmp.length;
    for(i=0; i<len; i++){
        imsi = strTmp.charAt(i);
        if(imsi<"0" || imsi>"9"){
        return false;
        }
    }
return true;
}

function filterNum(str)
{
    re = /^\$|,/g;
    str = String(str);
    return str.replace(re, "");
} 

function TypeCheck (s, spc) {
var i;
	for(i=0; i< s.length; i++) {
		if (spc.indexOf(s.substring(i, i+1)) < 0) {
		return false;
		}
	}        
return true;
}

function commaSplit(srcNumber) { 
var txtNumber = '' + srcNumber; 
var rxSplit = new RegExp('([0-9])([0-9][0-9][0-9][,.])'); 
var arrNumber = txtNumber.split('.'); 
arrNumber[0] += '.'; 
	do { 
	arrNumber[0] = arrNumber[0].replace(rxSplit, '$1,$2'); 
	} 
	while (rxSplit.test(arrNumber[0])); 
	if (arrNumber.length > 1) { 
	return arrNumber.join(''); 
	} 
	else { 
	return arrNumber[0].split('.')[0]; 
	} 
}

function SetComma1(value) {//","컴마를 붙이기
	str = value.toString();
	var rtn = "";
	var val = "";
	var j = 0;
	x = str.length;
	
	for(i=x; i>0; i--) {
		if(str.substring(i,i-1) != ",") {
			val = str.substring(i,i-1)+val;
		}
	}
	x = val.length;
	for(i=x; i>0; i--) {
		if(j%3 == 0 && j!=0) {
			rtn = val.substring(i,i-1)+","+rtn; 
		}else {
			rtn = val.substring(i,i-1)+rtn;
		}
	j++;
	}
	return rtn;
}
function SetComma(frm) {
var rtn = "";
var val = "";
var j = 0;
x = frm.value.length;

	for(i=x; i>0; i--) {
	if(frm.value.substring(i,i-1) != ",") {
	val = frm.value.substring(i,i-1)+val;
	}
	}
x = val.length;
	for(i=x; i>0; i--) {
	if(j%3 == 0 && j!=0) {
	rtn = val.substring(i,i-1)+","+rtn; 
	}else {
	rtn = val.substring(i,i-1)+rtn;
	}
	j++;
	}
frm.value = rtn;
}

function RemoveComma(str){
	var rtnstr="";
	if (str){
		for (var i=0; i<str.length; i++){
			if (str.charAt(i)!=","){
				rtnstr += str.charAt(i);
			}
		}
	}
	return parseInt(rtnstr);
}

function SpaceChk( str )
{
     if(str.search(/\s/) != -1){
         return true;
     }else {
         return "";
     }
}

function IsEmailChk( str )
{
     /* check whether input value is included space or not  */
     if(str == ""){
         alert("이메일 주소를 입력하세요.");
         return false;
     }
     var retVal = SpaceChk( str );
     if( retVal != "") {
         alert("이메일 주소를 빈공간 없이 넣으세요.");
         return false;
     }
          
     /* checkFormat */
     var isEmail = /[-!#$%&'*+\/^_~{}|0-9a-zA-Z]+(\.[-!#$%&'*+\/^_~{}|0-9a-zA-Z]+)*@[-!#$%&'*+\/^_~{}|0-9a-zA-Z]+(\.[-!#$%&'*+\/^_~{}|0-9a-zA-Z]+)*/;
     if( !isEmail.test(str) ) {
         alert("이메일 형식이 잘못 되었습니다.");
         return 0;
     }
     if( str.length > 60 ) {
         alert("이메일 주소는 60자까지 유효합니다.");
         return false;
     }
/*
     if( str.lastIndexOf("daum.net") >= 0 || str.lastIndexOf("hanmail.net") >= 0 ) {
          alert("다음 메일 계정은 사용하실 수 없습니다.");
         document.forms[0].email.focus();  
         return 0;
     }
*/

     return true;
}


function IsJuminChk(jumin1, jumin2){
	if(jumin1 == "" || jumin2 == ""){
	alert("주민번호를 넣어주세요");
	return false;
	}
	if ((!TypeCheck(jumin1, NUM)) || (!TypeCheck(jumin2, NUM)) ) {
	alert("주민등록번호에 잘못된 문자가 있습니다. ");
	return false;
	}
	var i;
	chk = 0;
	for (i=0; i<6; i++) {
	chk += ( (i+2) * parseInt( jumin1.substring( i, i+1) ));
	}
	for (i=6; i<12; i++) {
	chk += ( (i%8+2) * parseInt( jumin2.substring( i-6, i-5) ));         
	}
	chk = 11 - (chk%11);
	chk %= 10;
	if (chk != parseInt( jumin2.substring(6,7))) {
	alert ("정확하지 않은 주민등록 번호입니다.");
	return false;
	}    

	if ((jumin1.length < 6) || (jumin2.length < 7)) {
	alert("입력하신 주민등록 번호가 정확하지 않습니다. ");
	return false;
	}
	return true;
}	

function chkWorkNum(reg_no1,reg_no2,reg_no3) { 
    reg_no=reg_no1 + reg_no2 + reg_no3
        strNumb = reg_no; 
        
        sumMod        =        0; 
        sumMod        +=        parseInt(strNumb.substring(0,1)); 
        sumMod        +=        parseInt(strNumb.substring(1,2)) * 3 % 10; 
        sumMod        +=        parseInt(strNumb.substring(2,3)) * 7 % 10; 
        sumMod        +=        parseInt(strNumb.substring(3,4)) * 1 % 10; 
        sumMod        +=        parseInt(strNumb.substring(4,5)) * 3 % 10; 
        sumMod        +=        parseInt(strNumb.substring(5,6)) * 7 % 10; 
        sumMod        +=        parseInt(strNumb.substring(6,7)) * 1 % 10; 
        sumMod        +=        parseInt(strNumb.substring(7,8)) * 3 % 10; 
        sumMod        +=        Math.floor(parseInt(strNumb.substring(8,9)) * 5 / 10); 
        sumMod        +=        parseInt(strNumb.substring(8,9)) * 5 % 10; 
        sumMod        +=        parseInt(strNumb.substring(9,10)); 
         
        if (sumMod % 10 != 0) { 
                return false; 
        }
        return true; 
} 

function enter(field) {
  if (event.keyCode == 13) {
    var i;
    for (i = 0; i < field.form.elements.length; i++)
      if (field == field.form.elements[i])
        break;
	  i = (i + 1) % field.form.elements.length;
    field.form.elements[i].focus();
    return false;
  } else {
	  return true;
  }
}



// 유연한 책크폼 시작
/* <FORM name="form1" onSubmit="return chkForm(this)">
* input tag에 대한 설명 
* <input 
*    type="text" //체크할 형식 
*    name="id" //넘어갈이름 
*    msg="아이디" //경고창에 나타낼 문자열 
*    option="regId" //어떤 정규식으로 처리할지 선언 
*    checkenable //꼭 체크를 원하는 항목에 설정 
*    기존 name책크를 id 책크로 변경
* 동일 아이디 존재시 하나만 책크해도 됨
* 예 <input type="radio" name="chk[0]" id="check01" value="1" checkenable msg="갯수를 선택해주세요"> 
* -------------------
* <input type="radio" name="chk[1]" id="check01" value="2">
*<input type="checkbox" name="multichk[8][1]" id="multichk8" checkenable msg="Q9 : 선택해주세요">
* <input type="checkbox" name="multichk[8][2]" id="multichk8">
*<input type="text" name="desc[11]" id="desc11" checkenable msg="Q12 : 입력해주세요">
* <input name="semail" type="text" id="semail" checkenable msg="고객 이메일을 입력해 주세요" option="regMail">

* 바로 사용은 피하시고 다른 함수안에 넣어 처리해주세요
* function checkForm(){
*	var f=document.view_form;
*	if(autoCheckForm(f)) return true;
*	else return false;
}
***************************************/
function autoCheckForm(f)
{ 
    var i,currEl,currMsg;

    for(i = 0; i < f.elements.length; i++){ 
        currEl = f.elements[i]; 
        //필수 항목을 체크한다.  
        if (currEl.getAttribute("checkenable") != null) { 
			currMsg = currEl.getAttribute("msg");
            if(currEl.type == "TEXT" || currEl.type == "text" || 
               currEl.tagName == "SELECT" || currEl.tagName == "select" || 
               currEl.tagName == "TEXTAREA" || currEl.tagName == "textarea"){ 
                if(!chkText(currEl,currMsg)) return false; 

            } else if(currEl.type == "PASSWORD" || currEl.type == "password"){ 
                if(!chkText(currEl,currMsg)) return false; 

            } else if(currEl.type == "CHECKBOX" || currEl.type == "checkbox"){ 
                if(!chkCheckbox(f, currEl,currMsg)) return false; 

            } else if(currEl.type == "RADIO" || currEl.type == "radio"){ 
                if(!chkRadio(f, currEl,currMsg)) return false; 

            }
        }
        // 입력 페턴을 체크한다.
        if(currEl.getAttribute("option") != null && currEl.value.length > 0){ 
            if(!chkPatten(currEl,currEl.option,currMsg)) return false; 
        } 
    }

	return true;
}  

function chkPatten(field,patten,msg)
{ 
    var regNum =/^[0-9]+$/; 
    var regPhone =/^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/; 
    var regMail =/^[_a-zA-Z0-9-]+@[._a-zA-Z0-9-]+.[a-zA-Z]+$/; 
    var regDomain =/^[.a-zA-Z0-9-]+.[a-zA-Z]+$/; 
    var regAlpha =/^[a-zA-Z]+$/; 
    var regHost =/^[a-zA-Z-]+$/; 
    var regHangul =/[가-힣]/; 
    var regHangulEng =/[가-힣a-zA-Z]/; 
    var regHangulOnly =/^[가-힣]*$/; 
    var regId = /^[a-zA-Z]{1}[a-zA-Z0-9_-]{4,15}$/; 
    var regDate =/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/; 

    patten = eval(patten); 
    if(!patten.test(field.value)){ 
        alert(msg + "\n항목의 형식이 올바르지 않습니다."); 
        field.focus(); 
        return false; 
    } 
    return true; 
} 

function chkText(field, msg)
{ 
    if(field.value.trim().length < 1){ 
        alert(msg); 
        field.focus(); 
        return false; 
    } 
    return true; 
}

function chkCheckbox(form, field, msg)
{
    fieldname = eval(form.name+'.'+field.id);
	if (fieldname.length == undefined) {//배열이 아니라 하나의 단일값 존재
		fieldname.length = 1;
		fieldname[0] = fieldname;
	}
	for( i = 0, nChecked = 0; i < fieldname.length; i++) if( fieldname[i].checked) nChecked++;
	if(!nChecked){
        alert(msg); 
        field.focus(); 
        return false; 
	}
	/*
    if (!fieldname.checked){
        alert(msg); 
        field.focus(); 
        return false; 
    }
	*/
    return true; 
}

function chkRadio(form, field, msg)
{
    fieldname = eval(form.name+'.'+field.id);
    for (i=0;i<fieldname.length;i++) {
        if (fieldname[i].checked)
            return true; 
    }
    alert(msg); 
    field.focus(); 
    return false; 
} 

function radiocheck(name){//name : documnet.Forms.name
var namelength = name.length
 for(i=0; i<namelength; i++){ 
 	if(name[i].checked==true) return true;
 }
}

function  checkboxcheck(name){
var i = 0;
var chked = 0;

	for(i = 0; i < name.length; i++ ) {
		if(name[i].checked) {
			chked++;
		}
	}
	if( chked < 1 ) {
		alert('한개이상 체크해주시기 바랍니다.');
		return false;
	}
}
// 유연한 책크폼 끝

function wizwindow(url,name,flag){
	var newwin = window.open(url,name,flag);
	if(newwin){
		newwin.focus();
	}else{
		alert('팝업창이 차단되어 있습니다.\n\n해제해 주세요');	
	}
}


String.prototype.trim = function ()
{
    return this.replace(/^ *| *$/g, "");
}