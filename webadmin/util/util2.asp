<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../../util/wizdiary/schedule/cal_logic.asp"-->
<!-- #include file = "../../util/wizdiary/schedule/lunartosol.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<%

Dim strSQL,objRs
Dim whereis
Dim menushow,theme,d,m,m_id
Dim db,util
Set util = new utility	
Set db = new database

menushow	= Request("menushow")
theme		= Request("theme")
d			= Request("d")	: If d="" Then d="m"
m			= Request("m")
m_id		= Request("m_id")

function getTitle (fyear, fmonth, fday, menushow)
	dim cc_Date, cc_id, cc_Title
	cc_Date = fyear&"-"&fmonth&"-"&fday
	whereis	= " where cc_sDate = '"&cc_Date&"'"
	if m_id <> "" then whereis = whereis & " and cc_m_id = '" & m_id & "'"
	strSQL	= "select cc_id, cc_Title from wizDiary" & whereis
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	WHILE NOT objRs.EOF
		cc_id		= objRs("cc_id")
		cc_Title	= objRs("cc_Title")
		getTitle	= "<br />" & getTitle &"<a href=main.asp?menushow="&menushow&"&theme=util/util2_view&F_Year="&fyear&"&F_Month="&fmonth&"&F_Day="&fday&"&cc_id="&cc_id&"&m_id="&m_id&">"&cc_Title&"</a>"
	objRs.MOVENEXT
	WEND	
End Function

%>

<fieldset class="desc w_desc">
<legend>일정관리</legend>
<div class="notice">[note]</div>
<div class="comment">원하시는 날짜를 클릭하신 후 메모를 넣어주세요</div>
</fieldset>
<div class="space20"></div>
<table class="w_default" bgcolor="#f7f7f7">
  <tr>
    <td width="87"><img src="../util/wizdiary/images/arrow_left.gif" width="11" height="9" border="0" align="absmiddle">&nbsp; <a href=./main.asp?menushow=<%=menushow%>&theme=<%=theme%>&d=m&F_Year=<%=intPrevYear%>&F_Month=<%=intPrevMonth%>&F_Day=1&m_id=<%=m_id%>><%=intPrevMonth%>월</a></td>
    <td width="376" align="center"><strong><%=intThisYear%>년 <%=intThisMonth%>월 </strong></td>
    <td width="87" align="right"><a href=./main.asp?menushow=<%=menushow%>&theme=<%=theme%>&d=m&F_Year=<%=intNextYear%>&F_Month=<%=intNextMonth%>&F_Day=1&m_id=<%=m_id%>><%=intNextMonth%>월</a>&nbsp; <img src="../util/wizdiary/images/arrow_right.gif" width="11" height="9" border="0" align="absmiddle"></td>
  </tr>
</table>
<table class="table_main w_default">
    <col width="90px" title="일"/>
    <col width="90px" title="월"/>
    <col width="90px" title="화"/>
    <col width="90px" title="수"/>
    <col width="90px" title="목"/>
    <col width="90px" title="금"/>
    <col width="90px" title="토"/>

  <tr>
    <th height="18">일</th>
    <th>월</th>
    <th>화</th>
    <th>수</th>
    <th>목</th>
    <th>금</th>
    <th>토</th>
  </tr>
  <%
Dim intLoopWeek, intLoopDay	
Stop_Flag		= 0
intFirstWeekday	= Weekday(datFirstDay, vbSunday) ''넘겨받은 날짜의 주초기값 파악
intPrintDay		= 1
	for intLoopWeek=1 to 6   ''주단위 루프 시작, 최대 6주 

		Response.Write "<tr height=100>"&vbCR
		for intLoopDay=1 to 7 ''요일단위 루프 시작, 일요일부터

			if intFirstWeekDay > 1 then ''첫주시작일이 1보다 크면
				Response.Write "<td height=100>"&vbCR
				intFirstWeekDay=intFirstWeekDay-1
			else 
				if intPrintDay > intLastDay then ''입력날짜가 월말보다 크다면
					Response.Write "<td>"&vbCR
				else ''입력날짜가 현재월에 해당되면
					if intThisYear-NowThisYear=0 and intThisMonth-NowThisMonth=0 and intPrintDay-intThisDay=0 then ''오늘 날짜이면은 글씨폰트를 다르게
						Response.Write "<td valign='top'><span class='blue b'>" &intPrintDay&"</span> <a href=./main.asp?menushow="&menushow&"&theme=util/util2_write&smode=qin&F_Year="&intthisyear&"&F_Month="&intthismonth&"&F_Day="&intprintday&"&m_id="&m_id&">[등록]</a>"&getTitle(intthisyear, intthismonth, intprintday, menushow)&vbCR

						
					elseif  intLoopDay=1 then ''일요일이면 빨간 색으로
						Response.Write "<td valign='top'><span class='red'>" &intPrintDay&"</span> <a href=./main.asp?menushow="&menushow&"&theme=util/util2_write&smode=qin&F_Year="&intthisyear&"&F_Month="&intthismonth&"&F_Day="&intprintday&"&m_id="&m_id&">[등록]</a>"&getTitle(intthisyear, intthismonth, intprintday, menushow)&vbCR

					else '' 그외의 경우
						Response.Write "<td valign=top>" &intPrintDay&"<a href=./main.asp?menushow="&menushow&"&theme=util/util2_write&smode=qin&F_Year="&intthisyear&"&F_Month="&intthismonth&"&F_Day="&intprintday&"&m_id="&m_id&">[등록]</a>"&getTitle(intthisyear, intthismonth, intprintday, menushow)&vbCR
					
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
</table>
