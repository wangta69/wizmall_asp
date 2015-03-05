<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "schedule/cal_logic.asp"-->
<!-- #include file = "schedule/lunartosol.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.board.asp" -->
<%
Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database
%>
<%
''/////// 헤드라인 보이기 끝   달력 시작////////
menushow = Request("menushow")
theme = Request("theme")

d=Request("d")
 If d="" Then
	d="m"
 End if
 m=Request("m")

function getTitle (fyear, fmonth, fday, menushow)
	
	cc_Date = fyear&"-"&fmonth&"-"&fday
	strSQL = "select cc_id, cc_Title from wizDiary where cc_sDate = '"&cc_Date&"'"
	objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	WHILE NOT objRs.EOF
		cc_id = objRs("cc_id")
		cc_Title = objRs("cc_Title")
		getTitle = getTitle &"<a href=view.asp?F_Year="&fyear&"&F_Month="&fmonth&"&F_Day="&fday&"&cc_id="&cc_id&">"&cc_Title&"</a><br>"
	objRs.MOVENEXT
	WEND	
End Function

%>
<html>
<head>
<title>다이어리</title>
<link href="/lib/css.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>" />
<link href="./css.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style></head>
<body>
<table width="630" height="43" border="0" cellpadding="0" cellspacing="0" bgcolor="#f7f7f7" class='s1'>
  <tr class="ft1">
    <td width="87"><img src="./images/arrow_left.gif" width="11" height="9" align="absmiddle"> <a href=index.asp?d=m&F_Year=<%=intPrevYear%>&F_Month=<%=intPrevMonth%>&F_Day=1><%=intThisYear%>년 <%=intPrevMonth%>월</a></td>
    <td width="376" align="center"><strong><%=intThisYear%>년 <span class="style1"><%=intThisMonth%></span>월 </strong></td>
    <td width="87" align="right"><a href=index.asp?d=m&F_Year=<%=intNextYear%>&F_Month=<%=intNextMonth%>&F_Day=1><%=intThisYear%>년 <%=intNextMonth%>월</a> <img src="./images/arrow_right.gif" width="11" height="9" align="absmiddle"></td>
  </tr>
</table>
<table width="636" border="0" cellspacing="2" cellpadding="0" class="s1">
  <tr align="center" bgcolor="#ffb200" class="sft">
    <td width="90" height="18">일</td>
    <td width="90"><span class="style2">월</span></td>
    <td width="90"><span class="style2">화</span></td>
    <td width="90"><span class="style2">수</span></td>
    <td width="90"><span class="style2">목</span></td>
    <td width="90"><span class="style2">금</span></td>
    <td width="90"><span class="style2">토</span></td>
  </tr>
  <%
Stop_Flag=0
intFirstWeekday=Weekday(datFirstDay, vbSunday) '넘겨받은 날짜의 주초기값 파악
intPrintDay=1
	for intLoopWeek=1 to 6   ''주단위 루프 시작, 최대 6주 

		Response.Write "<tr height=50>"&vbCR
		for intLoopDay=1 to 7 ''요일단위 루프 시작, 일요일부터

			if intFirstWeekDay > 1 then ''첫주시작일이 1보다 크면
				Response.Write "<td height=50 bgcolor=#f7f7f7 class=txt1><table cellSpacing=0 cellPadding=0 width=60 border=0 class='s1'><tr><td class=ft2 valign=top align=middle></td></tr></table>"&vbCR
				intFirstWeekDay=intFirstWeekDay-1
			else  '
				if intPrintDay > intLastDay then ''입력날짜가 월말보다 크다면
					Response.Write "<td height=50 bgcolor=#f7f7f7 class=txt1><table cellSpacing=0 cellPadding=0 width=60 border=0 class='s1'><tr><td class=ft2 valign=top align=middle></td></tr></table>"&vbCR
				else '입력날짜가 현재월에 해당되면
					if intThisYear-NowThisYear=0 and intThisMonth-NowThisMonth=0 and intPrintDay-intThisDay=0 then ''오늘 날짜이면은 글씨폰트를 다르게
						Response.Write "<td height=50 valign=top bgcolor=#efefef class=txt1><table cellSpacing=0 cellPadding=0 width=60 border=0 class='s1'><tr><td class=ft2 valign=top align=middle><b>" &intPrintDay&"</b></td><td>&nbsp;</td></tr></table>"&getTitle(intthisyear, intthismonth, intprintday, menushow)&vbCR

						
					elseif  intLoopDay=1 then ''일요일이면 빨간 색으로
						Response.Write "<td height=50 valign=top bgcolor=#efefef class=txt1><table cellSpacing=0 cellPadding=0 width=60 border=0 class='s1'><tr><td class=ft2 valign=top align=middle><font color=ff4500>" &intPrintDay&"</font></td><td>&nbsp;</td></tr></table>"&getTitle(intthisyear, intthismonth, intprintday, menushow)&vbCR

					else ' 그외의 경우
						Response.Write "<td height=50 valign=top bgcolor=#efefef class=txt1 ><table cellSpacing=0 cellPadding=0 width=60 border=0 class='s1'><tr><td class=ft2 valign=top align=middle>" &intPrintDay&"</td><td>&nbsp;</td></tr></table>"&getTitle(intthisyear, intthismonth, intprintday, menushow)&vbCR
					
					end if
				end if										
				intPrintDay=intPrintDay+1 '날짜값을 1 증가
				if intPrintDay > intLastDay then '만약 날짜값이 월말값보다 크면 루프문 탈출
					Stop_Flag=1
				end if
			end if
			Response.Write "</td>"
		next
		Response.Write "</tr>"
		if Stop_Flag=1 then
			exit for
		end if
	next
	Set rslink=Nothing
		%>
</table>
</body>
</html>
