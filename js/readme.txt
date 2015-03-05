************* Calendar.js
<script language=javascript src="/js/Calendar.js"></script>
<input type="text" name="sTransDay" size="10" maxlength="10" readonly> 											<input type="text" id="sTransDay"><a href="javascript:ShowCalendar('all.sTransDay')"><img src="./img/cal.gif"></a>
주의점 : 이미지 경로를 현재 카렌다를 불러오는 파일 이하 폴더에 있어야 한다.



*************** SelectBox.js
<html>
<head>
<script language=javascript src="/js/SelectBox.js"></script>
<body>

<script>
// onchange='updateHintQ2ByHint();'
var strCombo = ""
	+ "<select name=pageSize style='width:65; height:18;' onchange='javascript:changeGoPS(this.value);'>"
	+ "<option value='10'>선택"
	+ "<option value='10' selected>10 개</option>"
	+ "<option value='20' >20 개</option>"
	+ "<option value='30' >30 개</option>"
	+ "<option value='50' >50 개</option>"
	+ "</select>";
  SS_write(strCombo, 10);
</script>
</body>
</html>

주의점 : 
- SelectBox.js 에서 SS_ENV.ImgPrefix = '/js/img_SelectBox'부분의 경로가 맞아야 합니다.
- 자바스크립트 에러 발생시 height가 맞지 않아서 그러하므로 stylesheet 에서 height가 규정되어 있으면 이부분을 삭제합니다.


*************** button.js
<script language="javascript" src="./js/button.js"></script>
<script>nhnButton('이전달','black9','javascript:GoLastMonthPS();',4,0,'#565656','#FFFFFF','#C4C4C4','#ffffff','#ffffff','#ffffff')</script>
<script>nhnButton('반송처리','black9','./order1_1.php?uid=action=none',4,0,'#565656','#FFFFFF','#C4C4C4','#ffffff','#ffffff','#ffffff')</script>



<script language="Javascript1.2" >
<!-- // load htmlarea
_editor_url = "../js/";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// -->
</script>

<TEXTAREA name=Description1 rows=15 style="width:98%" class="dd1"></TEXTAREA> 
              <br> <font color="#000000"> &nbsp;&nbsp;줄바꿈 : Shift + Enter &nbsp;&nbsp;&nbsp; 
              문단바꿈 : Enter</B></font> <script language='javascript1.2'>
		editor_generate('Description1');
		</script></font>
