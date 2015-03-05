<% Option Explicit %>
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "./pop_function.asp"-->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database


		'변수 설정====================================================================================
		Dim gotopage,pagesize
		
		menushow = Request("menushow")
		theme = Request("theme")
		gotopage = request("gotopage")
		if gotopage = "" then gotopage = 1

		pagesize = 10
		'변수 설정 끝==================================================================================



		'게시물 가져오기================================================================================
		Dim rsCount, sqll, recordCount,pagecount

		strSQL = "select count(seq) as recCount from popup where seq > 0"
		SET objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

		recordCount = objRs(0)
		pagecount = int((recordCount-1)/pagesize) +1

		rsCount.Close
		SET rsCount=nothing


		strSQL = "SELECT TOP " & pagesize & " * FROM popup where seq>0"
		if int(gotopage) > 1 then
			strSQL = strSQL & " and seq not in"
			strSQL = strSQL & " (SELECT TOP " & ((GotoPage - 1) * pagesize) & " seq FROM popup where seq>0"
			strSQL = strSQL & " ORDER BY seq DESC) "
		end if
		strSQL = strSQL & " ORDER BY seq DESC"

		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		'게시물 가져오기 끝================================================================================	
	
%>
	<table class="table_outline">
		<tr>
			<td valign="top">
			
			
<fieldset class="desc">
<legend>베너관리</legend>
<div class="notice">[note]</div>
<div class="comment">순서가 작을 수록 상단에 위치 합니다. </div>
</fieldset>
<div class="space20"></div>

				<table width="920" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="735" valign="top">
							<table width="708" border="0" cellspacing="0" cellpadding="0" align="center">
								<tr>
									<td height="5">
									</td>
								</tr>
								<tr>
									<td>
									</td>
								</tr>
								<tr>
									<td align="center">
										<table width="708" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td height="3" bgcolor="#BCBCBC">
												</td>
											</tr>
											<tr>
												<td height="32" bgcolor="#EBEBEB">
													<table width="708" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td align="center">번호</td>
															<td align="center">제목</td>
															<td align="center">사용여부</td>
															<td align="center">등록일</td>
															<td align="center">기간설정</td>
														</tr>
													</table>
												</td>
											</tr><%IF objRs.EOF THEN%>
                    <tr> 
                      <td>
					  <table width="708" border="0" cellspacing="0" cellpadding="0" >
                          <tr> 
                            <td colspan="5" align="center">등록된 팝업이 없습니다.</td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td height="1" bgcolor="#EBEBEB"></td>
                    </tr>
                    <%
						else
						l_num = RecordCount - (gotopage - 1) * pagesize
						Do until objRs.eof 

							wdate = replace(mid(objRs("wdate"),3,8),"-",".")
							isuse = Clng(objRs("isuse"))
							IF isuse = 0 then
								isuse = "○"
							ELSE
								isuse = "X"
							END IF
					%>
											<tr>
												<td>
													<table width="708" border="0" cellspacing="0" cellpadding="0">
														<tr onClick="location.href='./main.asp?menushow=<%=menushow%>&theme=popup/write&gubun=edit&seq=<%=objRs("seq")%>'">
															<td width="5%" height="25" align="center"><%=l_num%>
															</td>
															<td width="30%" align="center"><a href="./main.asp?menushow=<%=menushow%>&theme=popup/write&gubun=edit&seq=<%=objRs("seq")%>"><%=objRs("title")%></A>
															</td>
															<td width="10%" align="center"><%=isuse%>
															</td>
															<td width="15%" align="center"><%=wdate%>
															</td>
															<td width="30%" align="center"><%=objRs("startdate")%>~<%=objRs("enddate")%>
															</td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td height="1" bgcolor="#EBEBEB">
												</td>
											</tr><%
							objRs.MOVENEXT
							L_NUM = l_num -1
							loop
						end if
					%>
											<tr>
												<form name='s_page' action="objRs.asp" method='get'>													
													<input type='hidden' name='gotopage'>
												</form>
												<td height="25" align="center" colspan="5">
													<div align="center"><%	
								CALL GOTOPAGEHTML(GOTOPAGE,PAGECOUNT,"objRs.ASP","N")
							%>
                        </div></td>
                    </tr>
                    <tr> 
                      <td align="right">
<button name="" onClick="location.href='./main.asp?menushow=<%=menushow%>&theme=popup/write'" title="등록">등록</button>
</td>
                    </tr>
                  </table></td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
</table>

</body>
</html>
