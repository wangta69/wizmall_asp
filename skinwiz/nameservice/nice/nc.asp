<!-- saved from url=(0022)http://internet.e-mail -->

<SCRIPT LANGUAGE=JavaScript>

	//maxlength 만큼 옮기면 다음으로 이동하기....
	function nextFocus(sFormName,sNow,sNext)
	{
		var sForm = 'document.'+ sFormName +'.'
		var oNow = eval(sForm + sNow);
	
		if (typeof oNow == 'object')
		{
			if ( oNow.value.length == oNow.maxLength)
			{
				var oNext = eval(sForm + sNext);
	
				if ((typeof oNext) == 'object')
					oNext.focus();
			}
		}
	}
	
	function fnSubmit()
	{
		with(document.form1)
		{
			if (jumin1.value.length != 6 )
			{
				alert('주민번호를 확인하세요.');
				jumin1.focus();
				return;
			}

			if (jumin2.value.length != 7 )
			{
				alert('주민번호를 확인하세요.');
				jumin2.focus();
				return;
			}

			
			if ( name.value == '' )
			{
				alert('성명을 입력하십시요.');
				name.focus();
				return;
			}
		}
		
		document.form1.action = "nc_p.asp";
		document.form1.submit();
	}

	
</SCRIPT>

<!-- saved from url=(0022)http://internet.e-mail -->
<!-- saved from url=(0022)http://internet.e-mail -->
<!-- saved from url=(0022)http://internet.e-mail -->
<html>
<head>
<title>▒ 실명확인 샘플페이지 </title>
<meta http-equiv='Content-Type' content='text/html;charset=euc-kr'>

<link rel='stylesheet' type='text/css' href='http://image.creditbank.co.kr/static/css/main.css'>

</head>
<body topmargin=0 leftmargin=0 rightmargin=0 bottommargin=0>
<table width=650 height=470 cellpadding=0 cellspacing=0 border=0>
<form name="form1" method="post">	
  <tr>
    <td height="20" align=center valign=top bgcolor=#FFFFFF>&nbsp;</td>
  </tr>
  <tr> 
    <td align=center valign=top bgcolor=#FFFFFF>
    	
    	
    	
    	<table width="583" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="5"><img src="http://image.creditbank.co.kr/static/img/pop/pop04_001_01.gif" width="583" height="156" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="http://image.creditbank.co.kr/static/img/pop/pop04_001_02.gif" width="38" height="62" alt=""></td>
		<td>
			<img src="http://image.creditbank.co.kr/static/img/pop/pop04_001_03.gif" width="150" height="62" alt=""></td>
		<td width="263">
			<table width="" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="28">
            <input name="jumin1" type="text"  maxlength=6 style='width:68;font-size:9pt;height:18' class="input_textfield"  onkeyup="nextFocus('form1','jumin1','jumin2')"> - <input name="jumin2" type="text" maxlength=7  style='width:68;font-size:9pt;height:18' class="input_textfield" onkeyup="nextFocus('form1','jumin2','name')"></td>
          </tr>
          <tr>
            <td height="28"><input name="name" type="text"  style='width:68;font-size:9pt;height:18' class="input_textfield" onkeyup=""></td>
          </tr>
        </table></td>
		<td>
			<img src="http://image.creditbank.co.kr/static/img/pop/pop04_001_05.gif" alt="" width="150" height="62" border="0" usemap="#Map"></td>
		<td>
			<img src="http://image.creditbank.co.kr/static/img/pop/pop04_001_06.gif" width="39" height="62" alt=""></td>
	</tr>
	<tr>
		<td colspan="5">
			<img src="http://image.creditbank.co.kr/static/img/pop/pop04_001_07.gif" alt="" width="583" height="277" border="0" usemap="#Map2"></td>
	</tr>
</table>
</td>
  </tr>
  <tr>
  	<td height="20"></td>
</tr>
</form>
</table>
<map name="Map">
  <area shape="circle" coords="50,31,28" href="JavaScript:fnSubmit();">
</map>
<map name="Map2">
  <area shape="rect" coords="20,207,172,257" href="http://www.namecheck.co.kr" target="_blank">
  <area shape="rect" coords="44,133,547,146" href="http://www.namecheck.co.kr/per/p00.asp" target="_blank">
</map>
</body>
</html>

