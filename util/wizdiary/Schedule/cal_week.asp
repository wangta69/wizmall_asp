<table border="0" width="100%" cellspacing="0" cellpadding="0" bordercolor="#000000" bordercolorlight="#000000">
	<tr>
		<td>
			<div align="center">
			<table border="0" width="100%" cellspacing="1" cellpadding="0" bordercolor="#000000" bordercolorlight="#000000">
<%
FDay=intThisYear&"-"&intThisMonth&"-"&intThisDay
intFW=Weekday(FDay, vbSunday) '넘겨받은 날짜의 주초기값 파악
intSD=intThisDay-intFW+1

For i=1 to 7
	nblank="yes"
	dblank="yes"

	if intSD <= 0 then
		intWday=intPrevLastDay+intSD
		intPday=intPrevMonth&"월 "&intWday&"일"
		intCday=intPrevYear&"-"&intPrevMonth&"-"&intWday
	elseif intSD > intLastday then
		intWday=intSD-intLastDay
		intPday=intNextMonth&"월 "&intWday&"일"
		intCday=intNextYear&"-"&intNextMonth&"-"&intWday
	else
		intWday=intSD
		intPday=intThisMonth&"월 "&intWday&"일"
		intCday=intThisYear&"-"&intThisMonth&"-"&intWday
	end if

	intPWeekday=Weekday(intCday)
	
	Select Case intPWeekday

	Case 1
		varPWeekday="일"	
	Case 2
		varPWeekday="월"		
	Case 3
		varPWeekday="화"		
	Case 4
		varPWeekday="수"		
	Case 5
		varPWeekday="목"		
	Case 6
		varPWeekday="금"	
	Case 7
		varPWeekday="토"		
	End Select

	If  (i mod 2) = 0 Then 
		response.write "<tr bgcolor=#EFEFCF>"&vbCR  '짝수일때 테이블 행단위로 색깔 부여
		response.write "	<td align=right width=100 height=50 bgcolor=E8E8BB >"&vbCR
	else
		response.write "<tr bgcolor=#D2E8C4>"&vbCR	
		response.write "	<td align=right width=100 height=50 bgcolor=C0DFAC >"&vbCR
	end if

	response.write "	<a href=schedule_main.asp?d=d&F_Year="&year(intCday)&"&F_month="&month(intCday)&"&F_day="&day(intCday) &">"
	
	response.write "	<font face=굴림><span style='font-size:9pt'>"& intPday &"("&varPweekday&")</span></font></a>&nbsp;<a href=schedule_main.asp?d=d&F_Year="&year(intCday)&"&F_month="&month(intCday)&"&F_day="&day(intCday)&" &m=input&sdate="&intcday&"&shour=9><img src=../../images/add.gif alt=일정추가 border=0></a>&nbsp;"&vbCR
	
	
	
	response.write "	</td>"&vbCR
	response.write "	<td align=left>"&vbCR
	

'//////////////////   해당 시간에 해당되는 일정 쿼리해서 처리하기 시작 ////////////////////////////
		strSQL = "Select cc_id, cc_title, cc_sdate, cc_shour, cc_smin, cc_ehour, cc_emin, cc_desc,cc_dtype From  Diary  Where "
		strSQL = strSQL&" (cc_m_id='" & user_id & "'  or cc_open=1) and cc_reid ='0' "
		strSQL = strSQL&"and  datediff(""d"",cc_sdate,'"&intCday&"')=0 "
		strSQL = strSQL&" and  (cc_dtype='1' or cc_dtype='2')"
		strSQL = strSQL&"  Order by  cc_shour asc"&vbCR

		set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

		If  not objRs.eof  Then
			
			Do while not objRs.eof 
				
				cc_id		=objRs(0)
				cc_title	=objRs(1)
				cc_sdate	=objRs(2)
				cc_shour	=objRs(3)
				cc_smin		=objRs(4)
				cc_ehour	=objRs(5)
				cc_emin		=objRs(6)
				cc_desc		=objRs(7)
				cc_dtype	=objRs(8)

				if  cc_dtype="2" then
					lhour= "하루종일"
				else
					lhour=trim(cc_shour&":"&cc_smin&" ~ "&cc_ehour&":"&cc_emin)
				end if
				cc_title=Replace(cc_title,"<","&lt;")
				cc_title=Replace(cc_title,">","&gt;")

				cc_desc=left(cc_desc,150)
				cc_desc=Replace(cc_desc, "<" , "&lt;")
				cc_desc=Replace(cc_desc, ">" , "&gt;")
				cc_desc=Replace(cc_desc,chr(13)&chr(10),"<br>")

				Response.Write  " <font face=굴림><span style='font-size:9pt'>"&lhour&"<a href=schedule_main.asp?d=d&d="&d&"&m=view&cid="&cc_id&" onMouseOver=""view('"&cc_title&"', '"&lhour&"','"&cc_desc&"');""  onMouseOut=""noview();"" >&nbsp;"&cc_title&"</a></span></font><br>"&vbCR	
				
				rsobjRs.MoveNext

			Loop
			nblank="no"
		End if
		rsobjRs.close
		set objRs=nothing
'/////////////////////////////////////////////  시간단위 일정등록 쿼리 종료 ////////////////////////////////////////////

'///////////////////////////////////////////// 반복일정 설정된 해당시간쿼리 검사및 처리 시작 /////////////////////
	strSQL = "Select cc_id, cc_title, cc_sdate, cc_shour, cc_smin, cc_ehour, cc_emin,cc_desc, cc_reid, cc_retype, cc_edate,cc_dtype From  Diary  Where "
	strSQL = strSQL&" (cc_m_id='" & user_id & "'  or cc_open='1') "
	strSQL = strSQL&" and cc_reid <>  '0' "
	strSQL = sqlLIst&" and datediff(""d"", cc_edate,'"&intCday&"') <= 0 "  '종료일 > 현재일 은 
	strSQL = strSQL&" and datediff(""d"", cc_sdate,'"&intCday&"') >=0 "  '시작일 < 현재일
	strSQL = strSQL&" and  (cc_dtype='1' or cc_dtype='2')  "
	strSQL = strSQL&"  Order by  cc_shour asc"&vbCR

		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

		if not rsobjRs.eof then

			Do While not rsobjRs.eof
				cc_id		=rsobjRs(0)
				cc_title	=objRs(1)
				cc_sdate	=objRs(2)
				cc_shour	=objRs(3)
				cc_smin		=objRs(4)
				cc_ehour	=objRs(5)
				cc_emin		=objRs(6)
				cc_desc		=objRs(7)
				cc_reid		=objRs(8)
				cc_retype	=objRs(9)
				cc_edate	=objRs(10)
				cc_dtype	=objRs(8)
				if  cc_dtype="2" then
					lhour= "하루종일"
				else
					lhour=trim(cc_shour&":"&cc_smin&" ~ "&cc_ehour&":"&cc_emin)
				end if
				cc_title=Replace(cc_title,"<","&lt;")
				cc_title=Replace(cc_title,">","&gt;")

				cc_desc=left(cc_desc,150)
				cc_desc=Replace(cc_desc, "<" , "&lt;")
				cc_desc=Replace(cc_desc, ">" , "&gt;")
				cc_desc=Replace(cc_desc,chr(13)&chr(10),"<br>")


				sqlday=cdate(cc_sdate)
				cday=datediff("d",sqlday,intCday) '레코드 저장일과 출력셀의 날짜와의  날짜차이
				cmonth=datediff("m",sqlday,intCday) '레코드 저장일과 출력셀의 날짜와의 월 차이
				dblank="no"
				if  cc_retype="1" and (cday mod cc_reid)=0  then '일일단위 반복설정
					'오늘날짜와 일정날짜의 차이를 반복주기로 나눠서 0이면 출력
					response.write " <font face=굴림><span style='font-size:9pt'>"&lhour&"<a href=schedule_main.asp?d=d&d="&d&"&m=view&cid="&cc_id&"  onMouseOver=""view('"&cc_title&"', '"&lhour&"','"&cc_desc&"');""  onMouseOut=""noview();"">&nbsp;"&cc_title&"</a></span></font><br>"&vbCR				

				elseif cc_retype="2" and (cday mod cc_reid*7 )=0 then '주단위 반복설정
					response.write  " <font face=굴림><span style='font-size:9pt'> "&lhour&"<a href=schedule_main.asp?d=d&d="&d&"&m=view&cid="&cc_id&"  onMouseOver=""view('"&cc_title&"', '"&lhour&"','"&cc_desc&"' );"" onMouseOut=""noview();"">&nbsp;"&cc_title&"</a></span></font><br>"&vbCR				

				elseif cc_retype="3" and day(sqlday)= day(intCday) and (cmonth mod cc_reid )=0 then '월단위 반복설정
				'오늘날짜와 일정날짜의 월 차이를 반복주기로 나눠서 0이면 출력
					response.write " <font face=굴림><span style='font-size:9pt'>"&lhour&"<a href=schedule_main.asp?d=d&d="&d&"&m=view&cid="&cc_id&" onMouseOver=""view('"&cc_title&"', '"&lhour&"','"&cc_desc&"' );""  onMouseOut=""noview();"">&nbsp;"&cc_title&"</a></span></font><br>"&vbCR				

				else 
					dblank="yes"
				end if

				rsobjRs.MoveNext
			Loop
		end if
'//////////////////////////////////////////// 반복일정 설정된 해당시간 쿼리 검사 및 처리 종료 /////////////////////
		if nblank ="yes" and dblank="yes" then
			response.write "<span style='font-size:9pt'>&nbsp;</span>"&vbCR
		end if
		response.write "	</td>"&vbCR
		response.write"</tr>"&vbCR

	intSD=intSD+1
next
%>
</table>
</td></tr></table>
<p align=right><span style='font-size:9pt'>
<table width="630" border="0">
  <tr>          
    <td width="32%" align="right">
      <a href="Schedule_main.asp?d=w&F_Year=<%=year(datThisday-7)%>&F_Month=<%=month(datThisday-7)%>&F_Day=<%=day(datThisday-7)%>"> 
      <img src="../../images/icon01_02_pre.gif" width="58" height="19" border=0></a>
    </td>
    <td width="13%" valign="middle"><font size="2">
      <a href="Schedule_main.asp?d=w&F_Year=<%=year(datThisday-7)%>&F_Month=<%=month(datThisday-7)%>&F_Day=<%=day(datThisday-7)%>">[<%=month(datThisday-7)%>월 <%=day(datThisday-7)%>일]</a></font></td>
    <td width="10%" valign="middle"></td>
    <td width="13%" valign="middle"><font size="2">
      <a href="Schedule_main.asp?d=w&F_Year=<%=year(datThisday+7)%>&F_Month=<%=month(datThisday+7)%>&F_Day=<%=day(datThisday+7)%>">
      [<%=month(datThisday+7)%>월 <%=day(datThisday+7)%>일]</a></font></td>
    <td width="32%" align="left" valign="bottom">
      <a href="Schedule_main.asp?d=w&F_Year=<%=year(datThisday+7)%>&F_Month=<%=month(datThisday+7)%>&F_Day=<%=day(datThisday+7)%>">
      <img src="../../images/icon01_02_next.gif" width="58" height="19" border=0></a>
    </td>    
  </tr>
</table>

</span></p>
