<!-- #include file = "../../../config/db_connect.asp"-->
<!-- #include file = "../../../lib/class.database.asp" -->
<!-- #include file = "../../../lib/class.board.asp" -->
<%
Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database
%>
<table border="0" width="100%" cellspacing="0" cellpadding="0" bordercolor="#000000" bordercolorlight="#000000">
	<tr>
		<td>
			<div align="center">
			<table bgcolor=#ffffff border="0" width="100%" cellspacing="1" cellpadding="0" bordercolor="#ffffff" bordercolorlight="#000000">

		<form name=cal action="cal_process.asp"  method=post onSubmit="return checkForm(this);"> 
		<input type=hidden name=cp_type value="<%=m%>">
		<%
		if m="view" Then
			cid=Request("cid")
			strSQL = "Select *  From Diary Where  cc_id="&cid
			set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
			
			cc_id		=objRs(0)
			cc_m_id		=objRs(1)
			cc_title	=objRs(2)
			cc_position	=objRs(3)
			cc_kind		=objRs(4)
			cc_open		=objRs(5)
			cc_sdate	=objRs(6)
			cc_shour	=objRs(7)
			cc_smin		=objRs(8)
			cc_ehour	=objRs(9)
			cc_emin		=objRs(10)
			cc_desc		=objRs(11)
			cc_reid		=objRs(12)
			cc_retype	=objRs(13)
			cc_edate	=objRs(14)
			cc_dtype	=objRs(15)

			rsobjRs.close
			Set objRs=Nothing
			
			cc_title=Replace(cc_title,"<","&lt;")
			cc_title=Replace(cc_title,">","&gt;")


			cc_desc=Replace(cc_desc,chr(13)&chr(10),"<br>")
			%>
			<input type=hidden name=cc_id value=<%=cid%>>

			<tr>
				<td width=100 height=30 bgcolor="#B4CE82" align="center">
					<font color=#000000><span style="font-size: 9pt">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</font>
				</td>
				<td bgcolor="#DBECC8">
					<font color=#8B4500><span style="font-size: 9pt">
					<%=cc_title%>
					</span></font>
				</td>
			</tr>
			<tr>
				<td bgcolor="#B4CE82" align="center">
					<font color=#000000 align=right><span style="font-size: 9pt">장&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</font>
				</td>
				<td height=25 bgcolor="#DBECC8">
					<font color=#8B4500><span style="font-size: 9pt">
					<%=cc_position%></b>&nbsp;
					</span></font>
				</td>
			</tr>

			<tr>
				<td height=30 bgcolor="#B4CE82" align="center">
					<font color=#FFFFFF><span style="font-size: 9pt">일정 성격</b></font>
				</td>
				<td bgcolor="#DBECC8">
					<font color=#8B4500><span style="font-size: 9pt">
					<%
					response.write cc_kind
					If cc_open =1 Then
						response.write " (공개일정)"
					else
						response.write " (비공개일정)"
					end if
					%>
					</b></font>					
					
				</td>
			</tr>
			<tr>
				<td height=30 bgcolor="#B4CE82" align="center">
					<font color=#000000><span style="font-size: 9pt">일&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;자</b></font>
				</td>
				<td bgcolor="#DBECC8">
				<font color=#8B4500><span style="font-size: 9pt">
						<%
						cc_year=year(cc_sdate)
						cc_month=month(cc_sdate)
						cc_day=day(cc_sdate)
						
						if  cc_dtype="2" then
							lhour= "하루종일"
							response.write cc_year&"년 "&cc_month&"월 "&cc_day&"일 "&lhour
						elseif cc_dtype="3" then
							lhour=intThisMonth&"월중 일정"
							response.write lhour
						else
							lhour=trim(cc_shour&":"&cc_smin&" ~ "&cc_ehour&":"&cc_emin)
							response.write cc_year&"년 "&cc_month&"월 "&cc_day&"일 "&lhour
						end if
						
	
					%>
					</b></font>
				</td>
			</tr>
			<%
			if cc_reid <> 0 then
			%>
			<tr>
				<td bgcolor="#B6BA1B" align="center">
					<font color=#cc3333><span style="font-size: 9pt">반복 설정 </b></font>
				</td>
				<td bgcolor="#EFEFCF" height=50>
					<span style="font-size: 9pt">본 일정은 
					<%
					Select Case cc_reid
	
					Case 1
						txt_reid="매"
					Case 2
						txt_reid="둘째"
					Case 3
						txt_reid="셋째"
					Case 4
						txt_reid="넷째"
					End Select

					Select Case cc_retype
					
					Case 1
						txt_retype="일"
					Case 2
						txt_retype="주"
					Case 3
						txt_retype="월"
					Case 4
						txt_retype="년"
					
					End Select
					cc_ryear=year(cc_edate)
					cc_rmonth=month(cc_edate)
					cc_rday=day(cc_edate)

					response.write cc_ryear&"년 "&cc_rmonth&"월 "&cc_rday&"일까지 "
					response.write " "&txt_reid&txt_retype&"마다 반복 설정되었습니다"
					%>
					</b></font>
				</td>
			</tr>
			<%end if%>
			<tr>
				<td height=30 bgcolor="#B6BA1B" align="center">
					<font color=#000000><span style="font-size: 9pt">일정 내용</b></font>
				</td>
				<td bgcolor="#EFEFCF">
				<font color=#8B4500><span style="font-size: 9pt">

					<%
		
					response.write cc_desc
					%>
					</b></font>
				</td>
			</tr>
			<tr>
				<td bgcolor=#ffffff colspan="2" align="center" valign="middle"><br>
					
				         <!--글쓴 사람이 같을때 수정삭제 버튼 보이기 -->	
				         <%if user_id= cc_m_id  or user_id="dongan" then%>	
					<a href=Schedule_main.asp?m=edit&cid=<%=cc_id%>>
					<img src="../../images/icon01_02_modify.gif" width="49" height="15" border="0" ></a>&nbsp;
					<a href=# OnClick="Delete('<%=cc_id%>');return false">
					<img src="../../images/icon01_02_del.gif" width=47 height=15 border=0>
					</a>
				         <%end if%>	
					
					<a href='javascript:history.back(-1)'>
					<img src="../../images/icon01_02_cancel.gif" width="51" height="15" border="0">
					</a>
					</form>
					</font>
				</td>
			</tr>
		</table>
                                 
		                     
		
		
		<%
		ElseIf  m="edit" Then
		%>	
			
			<!--세션체크 해서 세션이 있으면 보여주고 없으면 뒤로 백 시작

                                         <%'if user_id="" then%>
                                           <script  language="javascript">

                                            alert("로그인 해주셔요")
                                            location.href="login2.asp"

                                           </script>
                                         <%'end if%>    
			 -->
			
			
		<%	
			cid=Request("cid")
			strSQL = "Select *  From Diary Where  cc_id="&cid
			Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
			
			cc_id		=objRs(0)
			cc_m_id		=objRs(1)
			cc_title	=objRs(2)
			cc_position	=objRs(3)
			cc_kind		=objRs(4)
			cc_open		=objRs(5)
			cc_sdate	=objRs(6)
			cc_shour	=objRs(7)
			cc_smin		=objRs(8)
			cc_ehour	=objRs(9)
			cc_emin		=objRs(10)
			cc_desc		=objRs(11)
			cc_reid		=objRs(12)
			cc_retype	=objRs(13)
			cc_edate	=objRs(14)
			cc_dtype	=objRs(15)

			Set objRs=Nothing

		%>
		<input type=hidden name=cc_id value=<%=cid%>>

			<tr>
				<td width=100 height=30 bgcolor="#B4CE82" align="center">
					<font color=#000000><span style="font-size: 9pt">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</b></font>
				</td>
				<td valign="top" bgcolor="#DBECC8">
					<input type=text name=title maxlength=20 value="<%=cc_title%>"></font>
				</td>
			</tr>
			<tr>
				<td bgcolor="#B4CE82" align="center">
					<font color=#000000><span style="font-size: 9pt">장&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</b></font>
				</td>
				<td bgcolor="#DBECC8">
					<font><input type=text name=position maxlength=40 value="<%=cc_position%>"></font>
				</td>
			</tr>

			<tr>
				<td height=30 bgcolor="#B4CE82" align="center">
					<font color=#000000><span style="font-size: 9pt">일정 성격</b></font>
				</td>
				<td bgcolor="#DBECC8">
					<font><select name="kind">
						<option value="약속" <%If cc_kind ="약속" Then%>selected<%end if%> >약속</option>
						<option value="회의" <%If cc_kind ="회의" Then%>selected<%end if%>>회의</option>
						<option value="행사" <%If cc_kind ="행사" Then%>selected<%end if%>>행사</option>
						<option value="출장" <%If cc_kind ="출장" Then%>selected<%end if%>>출장</option>
						<option value="휴가" <%If cc_kind ="휴가" Then%>selected<%end if%>>휴가</option>
					</select></font>					
					<font><select name="open">
						<option value="1" <%If cc_open =1 Then%>selected<%end if%>>공개일정</option>
						<option value="2" <%If cc_open =2 Then%>selected<%end if%>>비공개</option>
					</select></font>					
					
				</td>
			</tr>
			<tr>
				<td height=30 bgcolor="#B4CE82" align="center">
					<font color=#000000><span style="font-size: 9pt">시간 구분</b></font>
				</td>
				<td bgcolor="#DBECC8">
						<font color=black><span style="font-size: 9pt">
						<input type=radio name=cc_dtype value=1 <%If cc_dtype ="1" Then%>checked<%end if%>> 시간단위 일정&nbsp;&nbsp;
						<input type=radio name=cc_dtype value=2 <%If cc_dtype ="2" Then%>checked<%end if%>> 하루종일&nbsp;&nbsp;
						<input type=radio name=cc_dtype value=3 <%If cc_dtype ="3" Then%>checked<%end if%>> 월중행사&nbsp;&nbsp;
						
						</span></font>
				</td>
			</tr>
			<tr>
				<td height=30 bgcolor="#B4CE82" align="center">
					<font color=#000000><span style="font-size: 9pt">일&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;자</b></font>
				</td>
				<td bgcolor="#DBECC8">
					<font><select name=startYear>
						<%
						cc_year=year(cc_sdate)
						cc_month=month(cc_sdate)
						cc_day=day(cc_sdate)


						For i=2000 To 2005
							response.write "<option value="&i
							If  int(cc_year)=i Then
								response.write " selected "
							End if
							response.write " >"&i&"년"&vbCR
						Next
						%>
					</select></font>

					<font><select name=startMonth>
						<%
						For i=1 To 12
							response.write "<option value="&i
							If  int(cc_month)=i Then
								response.write " selected "
							End if
							response.write " >"&i&"월"&vbCR
						Next
						%>
					</select> </font>

					<font><select name=startDay>
						<%
						For i=1 To 31
							response.write "<option value="&i
							If  int(cc_day)=i Then
								response.write " selected "
							End if
							response.write " >"&i&"일"&vbCR
						Next
						%>

					</select></font>
				</td>
			</tr>

			<tr>
				<td height=35 bgcolor="#B6BA1B" align="center">
					<font color=#000000><span style="font-size: 9pt">시작 시간</b></font>
				</td>
				<td bgcolor=#EFEFCF>&nbsp;&nbsp;&nbsp;&nbsp;
					<select name=startHour onChange="changeEndHour()">
						<%
						For i=0 To 23
							response.write "<option value="&i
							If  cint(cc_shour)=i Then
								response.write " selected "
							End if
							If  i < 12 Then
								response.write " >"&i&" AM"&vbCR
							Else
								response.write " >"&i-12&" PM"&vbCR
							End if
						Next
						%>
					</select>
					<select name=startMin onChange="changeEndMin()">
						<%
						For i=0 To 55 Step 5
							response.write "<option value="&i
							If  cint(cc_smin)=i Then
								response.write " selected "
							End if
							response.write " >"&i&vbCR
						Next
						%>
					</select>부터&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<span style="font-size: 9pt">기간

					<font><select name="durHour" onChange="_changeEndHour()">
						<option value=0 >0</option>
						<option value=1 selected >1</option>
						<option value=2 >2</option>
						<option value=3 >3</option>
						<option value=4 >4</option>
						<option value=5 >5</option>
						<option value=6 >6</option>
						<option value=7 >7</option>
						<option value=8 >8</option>
						<option value=9 >9</option>
						<option value=10 >10</option>
						<option value=11 >11</option>
						<option value=12 >12</option>
						<option value=13 >13</option>
						<option value=14 >14</option>
						<option value=15 >15</option>
						<option value=16 >16</option>
						<option value=17 >17</option>
						<option value=18 >18</option>
						<option value=19 >19</option>
						<option value=20 >20</option>
						<option value=21 >21</option>
						<option value=22 >22</option>
						<option value=23 >23</option>
					</select>

					<span style="font-size: 9pt">시간</FONT>
					<font><select name="durMin" onChange="_changeEndMin()">

						<option selected value=00>00
						<option value=05>05
						<option value=10>10
						<option value=15>15
						<option value=20>20
						<option value=25>25
						<option value=30>30
						<option value=35>35
						<option value=40>40
						<option value=45>45
						<option value=50>50
						<option value=55>55
					</select><span style="font-size: 9pt">분 동안</FONT>
				</td>
			</tr>
			<tr>
				<td bgcolor="#B6BA1B" align="center">
					<font color=#000000><span style="font-size: 9pt">종료 시간</b></font>&nbsp;
				</td>
				<td bgcolor=#EFEFCF>
					<font color=#339999 size=3>↔</font>
					<select name=endHour onChange="changeDurHour()">
						<%
											
						
						For i = 0 To 23
							response.write "<option value="&i
							If  cint(cc_ehour)=i Then
								response.write " selected "
							End if
							If  i < 13 Then
								response.write " >"&i&" AM"&vbCR
							Else
								response.write " >"&i-12&" PM"&vbCR
							End if
						Next
						%>
					</select>
					<select name=endMin onChange="changeDurMin()">
						<%
						For i=0 To 55 Step 5
							response.write "<option value="&i
							If  int(cc_emin)=i Then
								response.write " selected "
							End if
							response.write " >"&i&vbCR
						Next
						%>
					</select>까지
				</td>
			</tr>
			<tr>
				<td bgcolor="#B6BA1B" align="center">
					<font color=#000000><span style="font-size: 9pt">내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;용</b></font>
				</td>
				<td bgcolor=#EFEFCF>
					<font><textarea name="desc" rows=5 cols=50 wrap=soft ><%=cc_desc%></textarea></font>
				</td>
			</tr>
			<tr>
				<td bgcolor="#B6BA1B" rowspan=2 align="center">
					<font color=#000000><span style="font-size: 9pt">반복 옵션</b></font>
				</td>
				<td bgcolor=#EFEFCF height=50>
					<span style="font-size: 9pt">반복적인 일정의 기간을 선택합니다.<br>

					<font><select name="reid">
						<option value=0 <%If  cc_reid=0 Then%>selected<%end if%> >반복하지 않는다</option>
						<option value=1 <%If  cc_reid=1 Then%>selected<%end if%>>매</option>
						<option value=2 <%If  cc_reid=2 Then%>selected<%end if%>>둘째</option>
						<option value=3 <%If  cc_reid=3 Then%>selected<%end if%>>셋째</option>
						<option value=4 <%If  cc_reid=4 Then%>selected<%end if%>>넷째</option>
					</select></font>
					
					<font><select name="retype">
						<option value=1 <%If  cc_retype=1 Then%>selected<%end if%>>일</option>
						<option value=2 <%If  cc_retype=2 Then%>selected<%end if%> >주</option>
						<option value=3 <%If  cc_retype=3 Then%>selected<%end if%>>월</option>
						<option value=4 <%If  cc_retype=4 Then%>selected<%end if%>>년</option>
					</select></font>
				</td>
			</tr>
			<tr>
				<td bgcolor="#EFEFCF" height=50>
					<span style="font-size: 9pt">입력한 반복 일정의 종료 기간을 선택합니다.<br>
					<font>
					<font><select name="reYear">
						<%
						cc_ryear=year(cc_edate)
						cc_rmonth=month(cc_edate)
						cc_rday=day(cc_edate)

						For i=2000 To 2005
							response.write "<option value="&i
							If  int(cc_ryear)=i Then
								response.write " selected "
							End if
							response.write " >"&i&"년"&vbCR
						Next
						%>
					</select></font>

					<font><select name="reMonth">
						<%
						For i=1 To 12
							response.write "<option value="&i
							If  int(cc_rmonth)=i Then
								response.write " selected "
							End if
							response.write " >"&i&"월"&vbCR
						Next
						%>
					</select></font>

					<font><select name="reDay">
						<%
						For i=1 To 31
							response.write "<option value="&i
							If  int(cc_rday)=i Then
								response.write " selected "
							End if
							response.write " >"&i&"일"&vbCR
						Next
						%>
					</select>
					<span style="font-size: 9pt">까지 </b>
				</td>
			</tr>
			<tr>
				<td bgcolor=#ffffff colspan="2" align="center" valign="middle"><br>
					<input type=image src="../../images/icon01_02_modify.gif" width="49" height="15" border="0" >&nbsp;
					<a href=# OnClick="Delete('<%=cc_id%>');return false">
					<img src="../../images/icon01_02_del.gif" width=47 height=15 border=0>
					</a>
					<a href='javascript:history.back(-1)'>
					<img src="../../images/icon01_02_cancel.gif" width="51" height="15" border="0">
					</a>
					</form>
					</font>
				</td>
			</tr>
		</table>
		<%
		else
			
		%>	
         		  <!--세션체크 해서 세션이 있으면 보여주고 없으면 뒤로 백 시작

                                         <%'if user_id="" then%>
                                           <script  language="javascript">

                                            alert("로그인 해주셔요")
                                            location.href="loginpage.asp"

                                           </script>
                                         <%'end if%> 	
			 -->
			
		<%	sdate=Request("sdate")
			cc_year=year(sdate)
			cc_month=month(sdate)
			cc_day=day(sdate)
			cc_shour=Request("shour")
			%>
			<tr>
				<td width=100 height=30 bgcolor="#B4CE82" align="center">
					<font color=#000000><span style="font-size: 9pt">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</b></font>
				</td>
				<td valign="top" bgcolor="#DBECC8">
					<input type=text name=title maxlength=20 value=""></font>
				</td>
			</tr>
			<tr>
				<td bgcolor="#B4CE82" align="center">
					<font color=#000000><span style="font-size: 9pt">장&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</b></font>
				</td>
				<td bgcolor="#DBECC8">
					<font><input type=text name=position maxlength=40 value=""></font>
				</td>
			</tr>

			<tr>
				<td height=30 bgcolor="#B4CE82" align="center">
					<font color=#000000><span style="font-size: 9pt">일정 성격</b></font>
				</td>
				<td bgcolor="#DBECC8">
					<font><select name="kind">
						<option value="약속" >약속</option>
						<option value="회의" >회의</option>
						<option value="행사" >행사</option>
						<option value="출장" >출장</option>
						<option value="휴가" >휴가</option>
					</select></font>					
					<font><select name="open">
						<option value="1" >공개일정</option>
						<option value="2" >비공개</option>
					</select></font>					
					
				</td>
			</tr>
			<tr>
				<td height=30 bgcolor="#B4CE82" align="center">
					<font color=#000000><span style="font-size: 9pt">시간 구분</b></font>
				</td>
				<td bgcolor="#DBECC8">
						<font color=black><span style="font-size: 9pt">
						<input type=radio name=cc_dtype value=1 checked> 시간단위 일정&nbsp;&nbsp;
						<input type=radio name=cc_dtype value=2 > 하루종일&nbsp;&nbsp;
						<input type=radio name=cc_dtype value=3 > 월중행사&nbsp;&nbsp;
						</span></font>
				</td>
			</tr>

			<tr>
				<td height=30 bgcolor="#B4CE82" align="center">
					<font color=#000000><span style="font-size: 9pt">일&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;자</b></font>
				</td>
				<td bgcolor="#DBECC8">
					<font><select name=startYear>
						<%
						For i=2000 To 2005
							response.write "<option value="&i
							If  int(cc_year)=i Then
								response.write " selected "
							End if
							response.write " >"&i&"년"&vbCR
						Next
						%>
					</select></font>

					<font><select name=startMonth>
						<%
						For i=1 To 12
							response.write "<option value="&i
							If  int(cc_month)=i Then
								response.write " selected "
							End if
							response.write " >"&i&"월"&vbCR
						Next
						%>
					</select> </font>

					<font><select name=startDay>
						<%
						For i=1 To 31
							response.write "<option value="&i
							If  int(cc_day)=i Then
								response.write " selected "
							End if
							response.write " >"&i&"일"&vbCR
						Next
						%>

					</select></font>
				</td>
			</tr>
			<tr>
				<td height=35 bgcolor="#B6BA1B" align="center">
					<font color=#000000><span style="font-size: 9pt">시작 시간</b></font>
				</td>
				<td bgcolor=#EFEFCF>&nbsp;&nbsp;&nbsp;&nbsp;
					<select name=startHour onChange="changeEndHour()">
						<%
						For i=0 To 23
							response.write "<option value="&i
							If  cint(cc_shour)=i Then
								response.write " selected "
							End if
							If  i < 12 Then
								response.write " >"&i&" AM"&vbCR
							Elseif i = 12 then
								Response.Write " >"&i&" PM"&vbcR
							Else	
								response.write " >"&i-12&" PM"&vbCR
							End if
						Next
						%>
					</select>
					<select name=startMin onChange="changeEndMin()">
						<option selected value=00>00
						<option value=05>05
						<option value=10>10
						<option value=15>15
						<option value=20>20
						<option value=25>25
						<option value=30>30
						<option value=35>35
						<option value=40>40
						<option value=45>45
						<option value=50>50
						<option value=55>55
					</select>부터&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;					
					<span style="font-size:9pt;">기간</span>

					<font><select name="durHour" onChange="_changeEndHour()">
						<option value=0 >0</option>
						<option value=1 selected >1</option>
						<option value=2 >2</option>
						<option value=3 >3</option>
						<option value=4 >4</option>
						<option value=5 >5</option>
						<option value=6 >6</option>
						<option value=7 >7</option>
						<option value=8 >8</option>
						<option value=9 >9</option>
						<option value=10 >10</option>
						<option value=11 >11</option>
						<option value=12 >12</option>
						<option value=13 >13</option>
						<option value=14 >14</option>
						<option value=15 >15</option>
						<option value=16 >16</option>
						<option value=17 >17</option>
						<option value=18 >18</option>
						<option value=19 >19</option>
						<option value=20 >20</option>
						<option value=21 >21</option>
						<option value=22 >22</option>
						<option value=23 >23</option>
					</select>

					<span style="font-size: 9pt">시간</FONT>
					<font><select name="durMin" onChange="_changeEndMin()">
						<option selected value=00>00
						<option value=05>05
						<option value=10>10
						<option value=15>15
						<option value=20>20
						<option value=25>25
						<option value=30>30
						<option value=35>35
						<option value=40>40
						<option value=45>45
						<option value=50>50
						<option value=55>55
					</select><span style="font-size: 9pt">분 동안</FONT>
				</td>
			</tr>
			<tr>
				<td bgcolor="#B6BA1B" align="center">
					<font color=#000000><span style="font-size: 9pt">종료 시간</b></font>&nbsp;
				</td>
				<td bgcolor=#EFEFCF>
					<font color=#339999 size=3>↔</font>
					<select name=endHour onChange="changeDurHour()">
						<option value=0>0 AM
						<option value=1>1 AM
						<option value=2>2 AM
						<option value=3>3 AM
						<option value=4>4 AM
						<option value=5>5 AM
						<option value=6>6 AM
						<option value=7>7 AM
						<option value=8>8 AM
						<option value=9>9 AM
						<option selected value=10>10 AM
						<option value=11>11 AM
						<option value=12>12 PM
						<option value=13>1 PM
						<option value=14>2 PM
						<option value=15>3 PM
						<option value=16>4 PM
						<option value=17>5 PM
						<option value=18>6 PM
						<option value=19>7 PM
						<option value=20>8 PM
						<option value=21>9 PM
						<option value=22>10 PM
						<option value=23>11 PM
					</select>
					<select name=endMin onChange="changeDurMin()">
						<option selected value=00>00
						<option value=05>05
						<option value=10>10
						<option value=15>15
						<option value=20>20
						<option value=25>25
						<option value=30>30
						<option value=35>35
						<option value=40>40
						<option value=45>45
						<option value=50>50
						<option value=55>55
					</select>까지
				</td>
			</tr>
			<tr>
				<td bgcolor="#B6BA1B" align="center">
					<font color=#000000><span style="font-size: 9pt">내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;용</b></font>
				</td>
				<td bgcolor=#EFEFCF>
					<font><textarea name="desc" rows=5 cols=50 wrap=soft></textarea></font>
				</td>
			</tr>
			<tr>
				<td bgcolor="#B6BA1B" rowspan=2 align="center">
					<font color=#000000><span style="font-size: 9pt">반복 옵션</b></font>
				</td>
				<td bgcolor=#EFEFCF height=50>
					<span style="font-size: 9pt">반복적인 일정의 기간을 선택합니다.<br>
					<font><select name="reid">
						<option value=0 selected >반복하지 않는다</option>
						<option value=1 >매</option>
						<option value=2 >둘째</option>
						<option value=3 >셋째</option>
						<option value=4 >넷째</option>
					</select></font>
					
					<font><select name="retype">
						<option value=1 selected >--</option>
						<option value=1 >일</option>
						<option value=2 >주</option>
						<option value=3 >월</option>
						<option value=4 >년</option>
					</select></font>
				</td>
			</tr>

			<tr>
				<td bgcolor="#EFEFCF" height=50>
					<span style="font-size: 9pt">입력한 반복 일정의 종료 기간을 선택합니다.<br>
					<font>
					<font><select name="reYear">
						<%
						cc_edate=now()
						cc_ryear=year(cc_edate)
						cc_rmonth=month(cc_edate)+1
						cc_rday=day(cc_edate)

						For i=2000 To 2005
							response.write "<option value="&i
							If  int(cc_ryear)=i Then
								response.write " selected "
							End if
							response.write " >"&i&"년"&vbCR
						Next
						%>
					</select></font>

					<font><select name="reMonth">
						<%
						For i=1 To 12
							response.write "<option value="&i
							If  int(cc_rmonth)=i Then
								response.write " selected "
							End if
							response.write " >"&i&"월"&vbCR
						Next
						%>
					</select></font>

					<font><select name="reDay">
						<%
						For i=1 To 31
							response.write "<option value="&i
							If  int(cc_rday)=i Then
								response.write " selected "
							End if
							response.write " >"&i&"일"&vbCR
						Next
						%>
					</select>
					<span style="font-size: 9pt">까지 
				</td>
			</tr>
			<tr>
				
				<td bgcolor=#ffffff colspan="2" align="center" valign="middle"><br>
					<input type=image src="../../images/icon01_02_save.gif" width="49" height="15" border="0" >&nbsp;
					<a href='javascript:history.back(-1)'>
					<img src="../../images/icon01_02_cancel.gif" width="51" height="15" border="0">
					</a>
					</form>
					</font>
				</td>
			</tr>
		</table>
		<%end if%>
		</td>
		</td>
		</table>
		
	
