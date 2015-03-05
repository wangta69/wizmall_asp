<%@Language=vbscript%>
<!-- #include file = "../../../lib/cfg.common.asp" -->
<!-- #include file = cal_logic.asp-->
<!-- #include file = "lunartosol.asp" -->
<!--#include file = "../../../config/db_connect.asp"-->
<!-- #include file = "../../../lib/class.database.asp" -->
<!-- #include file = "../../../lib/class.board.asp" -->
<%
Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database
%>
<%

d=Request("d")
If d="" Then
	d="m"
End if
m=Request("m")


Response.Expires = 0

%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<script LANGUAGE="JavaScript" src="cal_js.js" type="Text/JavaScript"></script>
<link rel="stylesheet" href="../../common/StyleSheet.css" type="text/css">
<script language="JavaScript">
<!--
function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}
//-->
</script>
</head>
<body bgcolor="#FFFFFF" topmargin=0>

<div ID="overDiv" STYLE="position:absolute;top=50;left=100; visibility:hide; z-index:2;"></div>
<script LANGUAGE="JavaScript" src="cal_div.js" type="Text/JavaScript"></script>
<table width="800" border="0" cellspacing="10">
  <tr valign=top> 
    <td colspan="6" height="30"><font class="Add">▶ 일정관리</font></td>
  </tr>
  <tr> 
    <td height="25" width="82"><a href="Schedule_main.asp?d=d"><img src="../../images/submenu_01_02_03.gif" width="81" height="16" border=0></a></td>
    <td height="25" width="90" align="left"><a href="Schedule_main.asp?d=d">[<%=NowThisMonth%>월 <%=NowThisDay%>일]</a></td>
    <!--<td height="25" width="100"><a href="Schedule_main.asp?d=d&F_year=<%=intThisYear%>&F_month=<%=intThismonth%>&F_day=<%=intThisDay%>"><img src="../../images/submenu_01_02_02.gif" width="81" height="16" border=0></a></td>-->
    <td height="25" width="100"><a href="Schedule_main.asp?d=w&F_year=<%=intThisYear%>&F_month=<%=intThismonth%>&F_day=<%=intThisDay%>"><img src="../images/submenu_01_02_01.gif" width="83" height="16" border=0></a></td>
    <td height="25" width="260"><a href="Schedule_main.asp?d=m&F_year=<%=intThisYear%>&F_month=<%=intThismonth%>&F_day=<%=intThisDay%>"><img src="../images/submenu_01_02_04.gif" width="81" height="16" border=0></a></td>
    <td width="200" height="25">
    <%
	response.write intThisYear&"년 " &intThisMonth&"월 "& intThisDay&"일    "&varThisWeekday&"요일"
	call gf_lun2sol(intThisYear,intThisMonth,intThisDay,0)
'	response.write "  (음력 " &exmonth&"월 "& exday&"일)"
%> 
    </td>
  </tr>
  <!--<tr> 
  <td colspan="6" height="25" style="padding-left:250;"><font size="2" color="#000000" align="center" > -->
<%
'	response.write intThisYear&"년 " &intThisMonth&"월 "& intThisDay&"일    "&varThisWeekday&"요일"
'	call gf_lun2sol(intThisYear,intThisMonth,intThisDay,0)

%> 
       <!--</font>
    </td>
  </tr> -->
  <tr> 
    <td colspan="5"> 
      <%
		If  m="input" or m="edit"  or m="view"  Then
		%>
			<!-- #include file=cal_input.asp-->
		<%
		Elseif d="d" Then
		%>
			<!-- #include file=cal_day.asp-->		
		<%
		Elseif d="w" Then
		%>
			<!-- #include file=cal_week.asp-->		
		<%
		Elseif d="m" Then
		%>
			<!-- #include file=cal_month.asp-->	
		<%
		End if
		%>
     
      <br>
    </td>
    <td width="140" valign="top"> 
      <table width="140" border="0" cellspacing="10">
        <tr> 
          <!-- #include file=cal_miniview.asp-->	
          <!-- #include file=cal_mdiary.asp-->
        </tr>
        
      </table>
    </td>
  </tr>
</table>
</body>
</html>
