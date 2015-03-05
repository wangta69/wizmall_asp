<% Option Explicit %>
<!-- #include file = cal_logic.asp-->
<!-- #include file = "lunartosol.asp" -->
<!-- #include file = "../../config/db_connect.asp"-->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database
%>
<%@Language=vbscript%>
<%
menushow = Request("menushow")
theme = Request("theme")



d=Request("d")
If d="" Then
	d="m"
End if
m=Request("m")


Response.Expires = 0

%>
<script LANGUAGE="JavaScript" src="./diary/cal_js.js" type="Text/JavaScript"></script>
<div ID="overDiv" STYLE="position:absolute;top=50;left=100; visibility:hide; z-index:2;"></div>
<script LANGUAGE="JavaScript" src="./diary/cal_div.js" type="Text/JavaScript"></script>

<table  border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="8"></td>
    <td height="8"></td>
  </tr>
  <tr> 
    <td> </td>
    <td width="839"> <table class="table_title">
        <tr> 
          <td><font color="#FF6600">일정관리</b></td>
        </tr>
        <tr> 
          <td> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="70" align="center" valign="top"><font color=#ff6600>[note]</td>
                <td>&nbsp;</td>
              </tr>
            </table></td>
        </tr>
      </table>
      <br /> <table class="table_main w_default">
  <tr> 
    <td width="82" height="25"><a href="main.asp?menushow=<%=menushow%>&theme=<%=theme%>&d=d"><img src="./diary/images/submenu_01_02_03.gif" width="81" height="16" border=0></a></td>
    <td width="90" height="25" align="left"><a href="main.asp?menushow=<%=menushow%>&theme=<%=theme%>&d=d">[<%=NowThisMonth%>월 <%=NowThisDay%>일]</a></td>
    <!--<td height="25" width="100"><a href="main.asp?menushow=<%=menushow%>&theme=<%=theme%>&d=d&F_year=<%=intThisYear%>&F_month=<%=intThismonth%>&F_day=<%=intThisDay%>"><img src="./diary/images/submenu_01_02_02.gif" width="81" height="16" border=0></a></td>-->
    <td width="100" height="25"><a href="main.asp?menushow=<%=menushow%>&theme=<%=theme%>&d=w&F_year=<%=intThisYear%>&F_month=<%=intThismonth%>&F_day=<%=intThisDay%>"><img src="./diary/images/submenu_01_02_01.gif" width="83" height="16" border=0></a></td>
    <td width="260" height="25"><a href="main.asp?menushow=<%=menushow%>&theme=<%=theme%>&d=m&F_year=<%=intThisYear%>&F_month=<%=intThismonth%>&F_day=<%=intThisDay%>"><img src="./diary/images/submenu_01_02_04.gif" width="81" height="16" border=0></a></td>
    <td width="200" height="25" colspan="">
    <%
	response.write intThisYear&"년 " &intThisMonth&"월 "& intThisDay&"일    "&varThisWeekday&"요일"
	call gf_lun2sol(intThisYear,intThisMonth,intThisDay,0)
'	response.write "  (음력 " &exmonth&"월 "& exday&"일)"
%> 
    </td>
          <td width="200" height="25" colspan="">&nbsp; </td>	
  </tr>
  <!--<tr> 
  <td colspan="6" height="25"><font size="2" color="#000000" align="center" > -->
<%
'	response.write intThisYear&"년 " &intThisMonth&"월 "& intThisDay&"일    "&varThisWeekday&"요일"
'	call gf_lun2sol(intThisYear,intThisMonth,intThisDay,0)

%> 
       <!--
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
     
      <br />
    </td>
    <td width="140" valign="top"> 
      <table width="140" border="0" cellspacing="10" >
        <tr><td>
          <!-- #include file=cal_miniview.asp-->	
          <!-- #include file=cal_mdiary.asp-->
        </td></tr>
        
      </table>
    </td>
  </tr>
</table>
      <br /> </td>
  </tr>
</table>
