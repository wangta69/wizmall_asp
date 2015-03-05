<!-- #include file = "../util/wizdiary/schedule/cal_logic.asp"-->
<!-- #include file = "../util/wizdiary/schedule/lunartosol.asp"  -->
<!-- #include file = "../config/db_connect.asp" -->
<!-- #include file = "../lib/class.database.asp" -->
<!-- #include file = "../lib/class.board.asp" -->
<%
	Dim db,strSQL,objRs
	''Dim util
	''Set util = new utility	
	Set db = new database

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
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	WHILE NOT objRs.EOF
		cc_id = objRs("cc_id")
		cc_Title = objRs("cc_Title")
		getTitle = getTitle &"<a href=view.asp?F_Year="&fyear&"&F_Month="&fmonth&"&F_Day="&fday&"&cc_id="&cc_id&">"&cc_Title&"</a><br>"
	objRs.MOVENEXT
	WEND	
End Function


function gotopage(fyear, fmonth, fday, gostr)
	
	cc_Date = fyear&"-"&fmonth&"-"&fday
	strSQL = "select cc_id, cc_Title from wizDiary where cc_sDate = '"&cc_Date&"'"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	if NOT objRs.EOF then
		cc_id = objRs("cc_id")
		gotopage = gotopage &"<a href=view.asp?F_Year="&fyear&"&F_Month="&fmonth&"&F_Day="&fday&"&cc_id="&cc_id&">"&gostr&"</a>"
	else
		gotopage = gostr
	end if
End Function

%>
<table width="153" border=0 cellpadding=0width='146' cellspacing=1>
<%
Stop_Flag=0
Line_Flag=0
intFirstWeekday=Weekday(datFirstDay, vbSunday) '넘겨받은 날짜의 주초기값 파악
intPrintDay=1
	for intLoopWeek=1 to 6   ''주단위 루프 시작, 최대 6주 
		Line_Flag = Line_Flag + 1
		if Line_Flag mod 2 = 0 then
			bgcolor = "bgcolor = ""#efefef"""
		else
			bgcolor = "bgcolor=""#f7f7f7"""
		end if
		Response.Write "<tr class=""sft"">"&vbCR
		for intLoopDay=1 to 7 ''요일단위 루프 시작, 일요일부터

			if intFirstWeekDay > 1 then ''첫주시작일이 1보다 크면
				Response.Write "<td onMouseOver=this.style.backgroundColor='#BFF7FF' onMouseOut=this.style.backgroundColor='' class=sft>"&vbCR
				intFirstWeekDay=intFirstWeekDay-1
			else  '
				if intPrintDay > intLastDay then ''입력날짜가 월말보다 크다면
					Response.Write "<td onMouseOver=this.style.backgroundColor='#BFF7FF' onMouseOut=this.style.backgroundColor='' class=sft>"&vbCR
				else '입력날짜가 현재월에 해당되면
					if intThisYear-NowThisYear=0 and intThisMonth-NowThisMonth=0 and intPrintDay-intThisDay=0 then ''오늘 날짜이면은 글씨폰트를 다르게
						Response.Write "<td valign=top  onMouseOver=this.style.backgroundColor='#BFF7FF' onMouseOut=this.style.backgroundColor='' class=sft><b>" &intPrintDay&"</b>"&getTitle(intthisyear, intthismonth, intprintday, menushow)&vbCR

						
					elseif  intLoopDay=1 then ''일요일이면 빨간 색으로
						Response.Write "<td valign=top onMouseOver=this.style.backgroundColor='#BFF7FF' onMouseOut=this.style.backgroundColor='' class=sft><font color=ff4500>" &intPrintDay&"</font>"&getTitle(intthisyear, intthismonth, intprintday, menushow)&vbCR

					else '' 그외의 경우
						Response.Write "<td valign=top onMouseOver=this.style.backgroundColor='#BFF7FF' onMouseOut=this.style.backgroundColor='' class=sft >" &gotopage(intthisyear, intthismonth, intprintday, intPrintDay)&vbCR
					
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
