<% Option Explicit %>
<!-- 역서부터-->		
<center>
<table border=0 width=140 bgcolor=#E8F0E1>
    <tr><td colspan=2 align="center">
    <%=intThisYear%>년 <%=intThisMonth%>월 <%=intThisDay%>일</font>
    </tr></td>
	<tr>
		<td align=left valign="top">
			<a href=main.asp?menushow=<%=menushow%>&theme=<%=theme%>&d=m&F_Year=<%=intPrevYear&"&F_Month="&intPrevMonth&"&F_Day=1"%>><font color=navy >&lt;&lt;</font></a>
		</td>
		<td align=right>
			<a href=main.asp?menushow=<%=menushow%>&theme=<%=theme%>&d=m&F_Year=<%=intNextYear&"&F_Month="&intNextMonth&"&F_Day=1"%>><font color=navy >&gt;&gt;</font></a>
		</td>
	</tr>
</table>
<table border=0 width=140 cellpadding=0 cellspacing=0 >
	<tr >
		<td  align=center bgcolor=#9BC05C><font color=#FFFFFF>일</font></td>
		<td  align=center bgcolor=#9BC05C><font color=#FFFFFF>월</font></td>
		<td  align=center bgcolor=#9BC05C><font color=#FFFFFF>화</font></td>
		<td  align=center bgcolor=#9BC05C><font color=#FFFFFF>수</font></td>
		<td  align=center bgcolor=#9BC05C><font color=#FFFFFF>목</font></td>
		<td  align=center bgcolor=#9BC05C><font color=#FFFFFF>금</font></td>
		<td  align=center bgcolor=#9BC05C><font color=#FFFFFF>토</font></td>
	</tr>
	<%
Stop_Flag=0
intFirstWeekday=Weekday(datFirstDay, vbSunday) '넘겨받은 날짜의 주초기값 파악
intPrintDay=1
	for intLoopWeek=1 to 6   '주단위 루프 시작, 최대 6주 

		Response.Write "<tr>"&vbCR
		for intLoopDay=1 to 7 '요일단위 루프 시작, 일요일부터

			if intFirstWeekDay > 1 then '첫주시작일이 1보다 크면
				Response.Write "<td  bgcolor=#E8F0E1  align=right valign=top><font color=white>.</font>"&vbCR
				intFirstWeekDay=intFirstWeekDay-1
			else  '
				if intPrintDay > intLastDay then '입력날짜가 월말보다 크다면
					Response.Write "<td  bgcolor=#E8F0E1  align=right valign=top><font color=white>.</font>"&vbCR
				else '입력날짜가 현재월에 해당되면
					if intThisYear-NowThisYear=0 and intThisMonth-NowThisMonth=0 and intPrintDay-intThisDay=0 then '오늘 날짜이면은 글씨폰트를 다르게
						Response.Write "<td  bgcolor=#E8F0E1 align=right valign=top><a href=main.asp?menushow="&menushow&"&theme="&theme&"&d=d&F_Year="&intThisYear&"&F_Month="&intThisMonth&"&F_Day="&intPrintDay&" ><font color=000000>"&intPrintDay&"</font></a></b><br />"&vbCR
					elseif  intLoopDay=1 then '일요일이면 빨간 색으로
						Response.Write "<td bgcolor=#E8F0E1  align=right valign=top><a href=main.asp?menushow="&menushow&"&theme="&theme&"&d=d&F_Year="&intThisYear&"&F_Month="&intThisMonth&"&F_Day="&intPrintDay&" ><font color=ff4500>"&intPrintDay&"</font></a><br />"&vbCR
					else ' 그외의 경우
						Response.Write "<td bgcolor=#E8F0E1  align=right valign=top><font color=#000000><a href=main.asp?menushow="&menushow&"&theme="&theme&"&d=d&F_Year="&intThisYear&"&F_Month="&intThisMonth&"&F_Day="&intPrintDay&" >"&intPrintDay&"</a></font><br />"&vbCR
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
	<form method="POST" action="./main.asp" id=form1 name=cal>
	<input type="hidden" name="menushow" value="<%=menushow%>">
	<input type="hidden" name="theme" value="<%=theme%>">
	<tr>
		<td colspan=7 align=center bgcolor=#E8F0E1 height="25" valign="bottom">
					<select name="F_Year" size="1">
					<%
					for i=2000 to 2010
						if i-intThisYear = 0 then
							Response.Write "<option selected value="&i&">"&i&"</option>"&vbCR
						else
							Response.Write "<option value="&i&">"&i&"</option>"&vbCR
						end if
					next
					%>
					</select><font color=black>년</font>
					
					<select name=F_Month size=1  onchange="window.open('./main.asp?menushow=<%=menushow%>&theme=<%=theme%>&d=m&F_Day=1&F_Month='+document.cal.F_Month.value+'&F_Year='+document.cal.F_Year.value,'_self')" >
					<%
					for i=1 to 12
						if i-intThisMonth = 0 then
							Response.Write "<option selected value="&i&">"&i&"</option>"&vbCR
						else
							Response.Write "<option value="&i&">"&i&"</option>"&vbCR
						end if
					next
					%>
					</select>
					<font color=black>월</font>
					</div> 
		</td>
	</tr></form>
</table>
<!--달력삽입 끝-->
