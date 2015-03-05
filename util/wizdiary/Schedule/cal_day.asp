<table border="0" width="100%" cellspacing="0" cellpadding="0" bordercolor="#000000" bordercolorlight="#000000">
	<tr>
		<td>
			<div align="center">
			<table border="0" width="100%" cellspacing="1" cellpadding="0" bordercolor="#ffffff" bordercolorlight="#000000">
<%
for  i=7 to 22 '8:00 부터 22:00까지 1시간 단위로 일정을 보여주기 위해 루프
	nblank="yes"
	dblank="yes"
	If  (i mod 2) = 0 Then 
		response.write "<tr bgcolor=#EFEFCF>"&vbCR  '짝수일때 테이블 행단위로 색깔 부여
		response.write "	<td align=right width=70 height=22 bgcolor=#E8E8BB>"&vbCR
	else
		response.write "<tr bgcolor=#D2E8C4>"&vbCR	
		response.write "	<td align=right width=70 height=22 bgcolor=#C0DFAC>"&vbCR
	end if

		response.write "		<font face=굴림><a href=schedule_main.asp?d=d&F_Year="&intThisYear&"&F_Month="&intThisMonth&"&F_Day="&IntthisDay & "&m=input&sdate="&datThisday&"&shour="&i&"><span style='font-size:9pt'>"& i &" : 00 </span><img src=../../images/add.gif alt=일정추가 border=0></a></font> &nbsp;"&vbCR
		response.write "	</td>"&vbCR
		response.write "	<td align=left >"&vbCR

'//////////////////   해당 시간에 해당되는 일정 쿼리해서 처리하기 시작 ////////////////////////////
		strSQL = "Select cc_id, cc_title, cc_sdate, cc_shour, cc_smin, cc_ehour, cc_emin, cc_desc, cc_dtype From  Diary  Where "
		strSQL = strSQL&" (cc_m_id='"&Session("id")&"' or cc_open=1) and cc_reid = '0' "
		strSQL = strSQL&" and datediff(""d"",cc_sdate,'"&datThisday&"')=0 "
		strSQL = strSQL&" and  (cc_dtype='1' or cc_dtype='2')  "
		
		if i=7 then  '8:00 이전이면 0시부터 9시 전까지의 일정을
			strSQL = strSQL&" and  abs(cc_shour) < "&i+1&"   Order by  cc_shour asc"&vbCR
		elseif i=22 then '20:00 이후이면 20:00 부터의 일정을
			strSQL = strSQL&" and (abs(cc_shour) >="&i&" ) Order by  cc_shour asc"&vbCR
		else '그외의 경우는 1시간 단위로
			strSQL = strSQL&" and (abs(cc_shour) >="&i&"  and abs(cc_shour) < "&i+1&" ) Order by  cc_shour asc"&vbCR
		end if
		set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
				
		If  not objRs.eof  Then

			Do while not objRs.eof 

				cc_id=objRs(0)
				cc_title=objRs(1)
				cc_sdate=objRs(2)
				cc_shour=objRs(3)
				cc_smin=objRs(4)
				cc_ehour=objRs(5)
				cc_emin=objRs(6)
				cc_desc=objRs(7)
				cc_dtype=objRs(8)
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
				
				objRs.MoveNext

			Loop
			nblank="no"
		End if
		objRs.close
		set objRs=nothing
'/////////////////////////////////////////////  시간단위 일정등록 쿼리 종료 ////////////////////////////////////////////

'///////////////////////////////////////////// 반복일정 설정된 해당시간쿼리 검사및 처리 시작 /////////////////////
		strSQL = "Select cc_id, cc_title, cc_sdate, cc_shour, cc_smin, cc_ehour, cc_emin, cc_desc, cc_reid, cc_retype, cc_edate,cc_dtype From  Diary  Where "
		strSQL = strSQL&" (cc_m_id='"&Session("id")&"'  or cc_open='1') "
		strSQL = strSQL&" and cc_reid <>  '0' "
		strSQL = strSQL&" and datediff(""d"", cc_edate,'"&datThisday&"') <= 0 "  '종료일 > 현재일 은 
		strSQL = strSQL&" and datediff(""d"", cc_sdate,'"&datThisday&"') >=0 "  '시작일 < 현재일
		strSQL = strSQL&" and  (cc_dtype='1' or cc_dtype='2')  "
		if i=8 then  '8:00 이전이면 0시부터 9시 전까지의 일정을
			strSQL = strSQL&" and (abs(cc_shour) >=0  and abs(cc_shour) < "&i+1&" ) Order by  cc_shour asc"&vbCR
		elseif i=20 then '20:00 이후이면 20:00 부터의 일정을
			strSQL = strSQL&" and (abs(cc_shour) >="&i&" ) Order by  cc_shour asc"&vbCR
		else '그외의 경우는 1시간 단위로
			strSQL = strSQL&" and (abs(cc_shour) >="&i&"  and abs(cc_shour) < "&i+1&" ) Order by  cc_shour asc"&vbCR
		end if
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		

		if not  objRs.eof   then

			Do While not objRs.eof

				cc_id=objRs(0)
				cc_title=objRs(1)
				cc_sdate=objRs(2)
				cc_shour=objRs(3)
				cc_smin=objRs(4)
				cc_ehour=objRs(5)
				cc_emin=objRs(6)
				cc_desc=objRs(7)
				cc_reid=objRs(8)
				cc_retype=objRs(9)
				cc_edate=objRs(10)
				cc_dtype=objRs(11)
				if  cc_dtype="2" then
					lhour= "하루종일"
				else
					lhour=trim(cc_shour&":"&cc_smin&" ~ "&cc_ehour&":"&cc_emin)
				end if

				sqlday=cdate(cc_sdate)
				cday=datediff("d",sqlday,datThisDay)
				cmonth=datediff("m",sqlday,datThisDay)

				cc_title=Replace(cc_title,"<","&lt;")
				cc_title=Replace(cc_title,">","&gt;")

				cc_desc=left(cc_desc,150)
				cc_desc=Replace(cc_desc, "<" , "&lt;")
				cc_desc=Replace(cc_desc, ">" , "&gt;")
				cc_desc=Replace(cc_desc,chr(13)&chr(10),"<br>")

				
				dblank="no"
				if  cc_retype="1" and (cday mod cc_reid)=0  then '일일단위 반복설정
					'오늘날짜와 일정날짜의 차이를 반복주기로 나눠서 0이면 출력
					response.write "<font face=굴림><span style='font-size:9pt'>"&lhour&"<a href=schedule_main.asp?d=d&d="&d&"&m=view&cid="&cc_id&"  onMouseOver=""view('"&cc_title&"', '"&lhour&"','"&cc_desc&"');""  onMouseOut=""noview();"">&nbsp;"&cc_title&"</a></span></font><br>"&vbCR				
				elseif cc_retype="2" and (cday mod cc_reid*7 )=0 then '주단위 반복설정
					response.write  "<font face=굴림><span style='font-size:9pt'> "&lhour&"<a href=schedule_main.asp?d=d&d="&d&"&m=view&cid="&cc_id&"  onMouseOver=""view('"&cc_title&"', '"&lhour&"','"&cc_desc&"' );"" onMouseOut=""noview();"">&nbsp;"&cc_title&"</a></span></font><br>"&vbCR				
				elseif cc_retype="3" and day(sqlday)= cint(intThisDay) and (cmonth mod cc_reid )=0 then '월단위 반복설정
					'오늘날짜와 일정날짜의 월 차이를 반복주기로 나눠서 0이면 출력
					response.write "<font face=굴림><span style='font-size:9pt'>"&lhour&"<a href=schedule_main.asp?d=d&d="&d&"&m=view&cid="&cc_id&" onMouseOver=""view('"&cc_title&"', '"&lhour&"','"&cc_desc&"' );""  onMouseOut=""noview();"">&nbsp;"&cc_title&"</a></span></font><br>"&vbCR				
				else 
					dblank="yes"
				end if

				objRs.MoveNext
			Loop

		end if


		if nblank ="yes" and dblank="yes" then
			response.write "<span style='font-size:9pt'>&nbsp;</span>"&vbCR
		end if
		'//////////////////////////////////////////// 반복일정 설정된 해당시간 쿼리 검사 및 처리 종료 /////////////////////

	response.write "	</td>"&vbCR
	response.write"</tr>"&vbCR

next
%>
</table>
</td></tr></table>
<p align=right><span style='font-size:9pt'>
 <table width="630" border="0">
  <tr>          
    <td width="32%" align="right">
      <a href="Schedule_main.asp?d=d&F_Year=<%=year(datThisday-1)%>&F_Month=<%=month(datThisday-1)%>&F_Day=<%=day(datThisday-1)%>"> 
      <img src="../../images/icon01_02_pre.gif" width="58" height="19" border=0></a>
    </td>
    <td width="13%" valign="middle"><font size="2">
      <a href="Schedule_main.asp?d=d&F_Year=<%=year(datThisday-1)%>&F_Month=<%=month(datThisday-1)%>&F_Day=<%=day(datThisday-1)%>">[<%=month(datThisday-1)%>월 <%=day(datThisday-1)%>일]</a></font></td>
    <td width="10%" valign="middle"></td>
    <td width="13%" valign="middle"><font size="2">
      <a href="Schedule_main.asp?d=d&F_Year=<%=year(datThisday+1)%>&F_Month=<%=month(datThisday+1)%>&F_Day=<%=day(datThisday+1)%>">
      [<%=month(datThisday+1)%>월 <%=day(datThisday+1)%>일]</a></font></td>
    <td width="32%" align="left" valign="bottom">
      <a href="Schedule_main.asp?d=d&F_Year=<%=year(datThisday+1)%>&F_Month=<%=month(datThisday+1)%>&F_Day=<%=day(datThisday+1)%>">
      <img src="../../images/icon01_02_next.gif" width="58" height="19" border=0></a>
    </td>    
  </tr>
</table>

</span></p>
