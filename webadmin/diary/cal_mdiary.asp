<% Option Explicit %>
<table border="0" width="140" cellspacing="0" cellpadding="0" bordercolor="#000000" bordercolorlight="#000000">
	<tr>
		<td>
			<table border="0" width="100%" cellspacing="1" cellpadding="0" bordercolor="#ffffff" bordercolorlight="#000000">
				<tr height=25>
					<td bgcolor=E8E8BB>
						<span>
						&nbsp;<%=intThisMonth%>월중 일정
						</span>
					</td>
				</tr>
				<tr height=40>
					<td bgcolor=EFEFCF>
					<%
					intMday=intThisYear&"-"&intThisMonth&"-1"
					strSQL = "Select cc_id, cc_title,cc_sdate, cc_shour, cc_smin, cc_ehour, cc_emin,cc_desc From  wizDiary  Where "
					strSQL = strSQL&" (cc_m_id='" & user_id & "'  or cc_open='1') and cc_reid = '0' "
					strSQL = strSQL&" and  datediff(""d"",cc_sdate,'"&intMday&"') = 0 "
					strSQL = strSQL&" and  cc_dtype='3'  "
					strSQL = strSQL&"  Order by  cc_shour asc"&vbCR

					Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)					
					
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

							cc_title=Replace(cc_title,"<","&lt;")
							cc_title=Replace(cc_title,">","&gt;")

							cc_desc=left(cc_desc,150)
							cc_desc=Replace(cc_desc, "<" , "&lt;")
							cc_desc=Replace(cc_desc, ">" , "&gt;")
							cc_desc=Replace(cc_desc,chr(13)&chr(10),"<br />")


							lhour=intThisMonth&"월중 일정"

							Response.write "<img src=../../images/micon.gif border=0>"
							Response.Write  "<span><a href=schedule_main.asp?d="&d&"&m=view&cid="&cc_id&" onMouseOver=""view('"&cc_title&"', '"&lhour&"','"&cc_desc&"');""  onMouseOut=""noview();"" >"&cc_title&"</a></span><br />"&vbCR	
							objRs.MoveNext
						Loop
					Else
						response.write "<span>&nbsp;</span>"&vbCR
					End if
					objRs.close
					set objRs=nothing

					%>

					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

