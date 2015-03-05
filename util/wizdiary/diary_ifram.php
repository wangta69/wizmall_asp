<!-- #include file = "./schedule/cal_logic.asp"-->
<!-- #include file="./schedule/lunartosol.asp"  -->
<!-- #include file="../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->



<%
Dim strSQL,objRs
Dim whereis
Dim menushow,theme,d,m,m_id
Dim db,util
Set util = new utility	
Set db = new database

m_id	= "main"
Dim cc_id'외부에서 사용하기 위해 별도로 빼줌
Dim cc_Title

function getTitle (fyear, fmonth, fday, menushow)
	dim cc_Date
	cc_Date = fyear&"-"&fmonth&"-"&fday
	whereis	= " where cc_sDate = '"&cc_Date&"'"
	if m_id <> "" then whereis = whereis & " and cc_m_id = '" & m_id & "'"
	strSQL	= "select cc_id, cc_Title from wizDiary" & whereis
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	WHILE NOT objRs.EOF
		cc_id		= objRs("cc_id")
		cc_Title	= objRs("cc_Title")
		getTitle	= "<br>" & getTitle &"<a href=main.asp?menushow="&menushow&"&theme=util/util2_view&F_Year="&fyear&"&F_Month="&fmonth&"&F_Day="&fday&"&cc_id="&cc_id&"&m_id="&m_id&">"&cc_Title&"</a>"
	objRs.MOVENEXT
	WEND	
End Function

function getTitle2 (fyear, fmonth, fday, menushow)
	dim cc_Date
	cc_Date = fyear&"-"&fmonth&"-"&fday
	whereis	= " where cc_sDate = '"&cc_Date&"'"
	if m_id <> "" then whereis = whereis & " and cc_m_id = '" & m_id & "'"
	strSQL	= "select cc_id, cc_Title from wizDiary" & whereis
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	WHILE NOT objRs.EOF
		cc_id		= objRs("cc_id")
		cc_Title	= objRs("cc_Title")
		getTitle	= "<br>" & getTitle &"<a href=main.asp?menushow="&menushow&"&theme=util/util2_view&F_Year="&fyear&"&F_Month="&fmonth&"&F_Day="&fday&"&cc_id="&cc_id&"&m_id="&m_id&">"&cc_Title&"</a>"
	objRs.MOVENEXT
	WEND	
End Function

function isData (fyear, fmonth, fday, menushow)
	isData	= false
	dim cc_Date
	cc_Date = fyear&"-"&fmonth&"-"&fday
	whereis	= " where cc_sDate = '"&cc_Date&"'"
	if m_id <> "" then whereis = whereis & " and cc_m_id = '" & m_id & "'"
	strSQL	= "select cc_id, cc_Title from wizDiary" & whereis
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	
	If objRs.BOF or objRs.EOF Then
		isData	= false
	else 
		cc_id		= objRs("cc_id")
		cc_Title	= objRs("cc_Title")
		isData	= true
	end if
End Function
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>과천시립예술단</title>
<script language="javascript" src="/script/over.js"></script>
<script language="javascript" src="/script/swf.js"></script>
<script language="javascript" src="/js/jquery-1.4.2.min.js"></script>
<script language="javascript" src="/js/jquery.plugins/aToolTip/js/atooltip.min.jquery.js"></script>
<link type="text/css" href="/js/jquery.plugins/aToolTip/css/atooltip.css" rel="stylesheet"  media="screen" /> <!-- 툴팁용 -->
<link href="/library/index.css" rel="stylesheet" type="text/css">

<script>
$(function(){
	$(".btn_go_cal").click(function(){
		var cc_id = $(this).attr("cc_id");
		location.href = "/board/board7.asp?act=view&dtype=main&cc_id="+cc_id;
	});
	
	$(".btn_go_cal").aToolTip();  
});

</script>

</head>

<body>
<!-- 카렌다 시작 -->
<div id="calendar" style="width:345px">
	<h2><img src="/images/idx1_01.gif"></h2>
    <div class="year"><table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="20" align="center"><a href=calendar_iframe.asp?d=m&F_Year=<%=intPrevYear%>&F_Month=<%=intPrevMonth%>&m_id=<%=m_id%>><img src="/images/cal_left_arrow.gif" width="3" height="5"></a></td>
    <td><%=intThisYear%>년 <%=intThisMonth%>월</td>
    <td width="20" align="center"><a href=calendar_iframe.asp?d=m&F_Year=<%=intNextYear%>&F_Month=<%=intNextMonth%>&m_id=<%=m_id%>><img src="/images/cal_right_arrow.gif" width="3" height="5"></a></td>
  </tr>
</table>
</div>
    <div class="cal_head">&nbsp;</div>
    <div class="calendar_bg">    	
    <div class="box"><table width="100%" border="0" cellspacing="1" cellpadding="5" id="calendar_table">
  <tr>
    <td class="sun">Sun</td>
    <td class="day">Mon</td>
    <td class="day">Tue</td>
    <td class="day">Wed</td>
    <td class="day">Thur</td>
    <td class="day">Fri</td>
    <td class="sat">Sat</td>
  </tr>
    <%
Dim intLoopWeek, intLoopDay	
Stop_Flag		= 0
intFirstWeekday	= Weekday(datFirstDay, vbSunday) ''넘겨받은 날짜의 주초기값 파악
intPrintDay		= 1
	for intLoopWeek=1 to 6   ''주단위 루프 시작, 최대 6주 

		Response.Write "<tr>"&vbCR
		for intLoopDay=1 to 7 ''요일단위 루프 시작, 일요일부터

			if intFirstWeekDay > 1 then ''첫주시작일이 1보다 크면
				Response.Write "<td>"&vbCR
				intFirstWeekDay=intFirstWeekDay-1
			else 
				if intPrintDay > intLastDay then ''입력날짜가 월말보다 크다면
					Response.Write "<td>"&vbCR
				else ''입력날짜가 현재월에 해당되면
					if intThisYear-NowThisYear=0 and intThisMonth-NowThisMonth=0 and intPrintDay-intThisDay=0 then ''오늘 날짜이면은 글씨폰트를 다르게
					 if isData(intthisyear, intthismonth, intprintday, menushow) then
					 	Response.Write "<td class='recent btn_go_cal' cc_id='" & cc_id & "' title='" & cc_Title & "' style='cursor:hand' >" & intPrintDay & vbCR
						
					 else 
					 	Response.Write "<td class='recent'>" &intPrintDay & vbCR
					 end if
						
					''elseif  intLoopDay=1 then ''일요일이면 빨간 색으로
					''	Response.Write "<td valign='top'><span class='red'>" &intPrintDay&"</span> "&getTitle(intthisyear, intthismonth, intprintday, menushow)&vbCR

					''else '' 그외의 경우
					''	Response.Write "<td valign=top>" &intPrintDay&""&getTitle(intthisyear, intthismonth, intprintday, menushow)&vbCR
					else 
					 if isData(intthisyear, intthismonth, intprintday, menushow) then
					 	Response.Write "<td class='event btn_go_cal' cc_id='" & cc_id & "' title='" & cc_Title & "' style='cursor:hand' >" & intPrintDay & vbCR
						
					 else 
					 	Response.Write "<td>" &intPrintDay & vbCR
					 end if
					end if
				end if										
				intPrintDay=intPrintDay+1 ''날짜값을 1 증가
				if intPrintDay > intLastDay then ''만약 날짜값이 월말값보다 크면 루프문 탈출
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
	''Set rslink=Nothing
		%>
</table></div>

    </div>
</div>
</body>
</html>