<!-- #include file = "../../../config/db_connect.asp" -->
<!-- #include file = "../../../config/skin_info.asp" -->
<!-- #include file = "../../../lib/class.database.asp" -->
<!-- #include file = "../../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database
%>
<%
smode		= Request("smode")
Target		= Request("Target")
keyword		= Request("keyword")
Category	= Request("Category")
price1		= Request("price1")
price2		= Request("price2")
Brand		= Request("Brand")
order		= Request("order")
page		= Request("page")


setPageSize  = "15"
setPageLink = "20"
if page = "" then page = 1
whereis = " where uid is not null "

if order <> "" then
	orderArr = split(order, "/")
	orderby = " order by " & orderArr(0) & " " & orderArr(1) 
else 
	orderby = " order by uid desc"
end if

if smode = "search" then
	whereis = "WHERE uid=pid"
	if Category <> "" then whereis = whereis & " AND category LIKE '%"&Category&"'"
	if price1 <> "" then whereis = whereis & " AND Price >= "&price1
	if price2 <> "" then whereis = whereis & " AND Price <= "&price2
	if Brand <> "" then whereis = whereis & " AND Brand LIKE '%"&Brand&"%'"
	if keyword <> "" and "&Target&" <> "" then
		//upperkeyword = strtoupper (keyword);
		//lowerkeyword = strtolower (keyword);
		if Target = "all" then 
			whereis = whereis & " AND (pname LIKE '%"&keyword&"%' OR description1 LIKE '%"&keyword&"%' OR model LIKE '%"&keyword&"%')"
		else 
			whereis = whereis & " AND "&Target&" LIKE '%"&keyword&"%'"
		end if
	end if
elseif smode = "natural" then
	if keyword  = "" then 
		Response.Write("<script language=javascript>window.alert('\n자연에 검색에 필요한 문장을 입력해 주세요.\n');history.go(-1);</script>")
		Response.End()
	end if

	Natural_Key_Spl = split(keyword," ")
	whereis = "WHERE "&Target&" LIKE '%"&Natural_Key_Spl(0)&"%'"
	
	for i = 1 to Ubound(Natural_Key_Spl)
		whereis = whereis & " andor "&Target&" LIKE '%"&Natural_Key_Spl(i)&"%'"
	next
end if




strSQL = "SELECT COUNT(uid) FROM wizmall " & whereis
''Response.Write(strSQL)
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	
TotalCount = objRs(0)
TotalPage = TotalCount / setPageSize
IF (TotalPage - (TotalCount \ setPageSize)) > 0 then
	TotalPage = int(TotalPage) + 1
Else
	TotalPage = int(TotalPage)
End if
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td align="center"><table width="579" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><img src="./skinwiz/search/<%=SearchSkin%>/images/img_top.gif" width="579" height="4"></td>
				</tr>
				<tr>
					<td height="92" align="center" background="./skinwiz/search/<%=SearchSkin%>/images/bg_body.gif"><table width="550" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><table width="496" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
										<tr>
											<td width="10"><img src="./skinwiz/search/<%=SearchSkin%>/images/img_serach01.gif" width="86" height="32"></td>
											<td width="486"><strong><font color="#0033CC"> <%=keyword%> </font></strong> 검색어로 <strong>총 <%=FormatNumber(TotalCount, 0)%> 개</strong>의 상품들을 검색하였습니다.</td>
										</tr>
									</table></td>
							</tr>
							<tr>
								<td height="1" bgcolor="#D2D2D2"></td>
							</tr>
							<tr>
								<td height="59"><table width="550" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td><table width="286" border="0" cellspacing="0" cellpadding="0">
													<form  action="./wizsearch.php">
														<input type="hidden" name="query" value="search">
														<input type="hidden" name="Target" value="all">
														<tr>
															<td width="46"><img src="./skinwiz/search/<%=SearchSkin%>/images/img_dbo.gif" width="46" height="35"></td>
															<td width="140"><input name="keyword" type="text" class="formline" size="23"></td>
															<td width="88" align="center"><input name="image" type="image" src="./skinwiz/search/<%=SearchSkin%>/images/but_serach.gif" width="77" height="27"></td>
														</tr>
													</form>
												</table></td>
											<td width="1" background="./skinwiz/search/<%=SearchSkin%>/images/bg_jumsun.gif"></td>
											<td align="center"><table width="240" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td><img src="./skinwiz/search/<%=SearchSkin%>/images/img_detail.gif" width="142" height="29"></td>
														<td><A HREF='./wizsearch.asp'><img src="./skinwiz/search/<%=SearchSkin%>/images/but_detail.gif" width="84" height="44" border="0"></a></td>
													</tr>
												</table></td>
										</tr>
									</table></td>
							</tr>
						</table></td>
				</tr>
				<tr>
					<td><img src="./skinwiz/search/<%=SearchSkin%>/images/img_bottom.gif" width="579" height="4"></td>
				</tr>
			</table></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td align="center"><table width="95%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center">&nbsp;</td>
				</tr>
				<tr>
					<td><TABLE WIDTH='100%' CELLSPACING=0 CELLPADDING=0 BORDER=0  style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
							<FORM ACTION='./wizsearch.asp'>
								<INPUT TYPE=HIDDEN NAME=smode VALUE='<%=smode%>'>
								<INPUT TYPE=HIDDEN NAME=cat VALUE='<%=cat%>'>
								<INPUT TYPE=HIDDEN NAME=page VALUE='<%=page%>'>
								<INPUT TYPE=HIDDEN NAME=price1 VALUE='<%=price1%>'>
								<INPUT TYPE=HIDDEN NAME=price2 VALUE='<%=price2%>'>
								<INPUT TYPE=HIDDEN NAME=Target VALUE='<%=Target%>'>
								<INPUT TYPE=HIDDEN NAME=keyword VALUE='<%=keyword%>'>
								<INPUT TYPE=HIDDEN NAME=brand VALUE='<%=brand%>'>
								<INPUT TYPE=HIDDEN NAME=sort VALUE='<%=sort%>'>
								<INPUT TYPE=HIDDEN NAME=andor VALUE='<%=andor%>'>
								<TR>
									<TD><B>검색된 제품</B> : <B> <%=FormatNumber(TotalCount)%> 개</B></TD>
									<TD ALIGN=RIGHT><SELECT NAME='order' onchange='this.form.submit()' style='width:140;'>
											<option value="">상품정렬하기</option>
											<option value="pname/asc" <% if order = "pname/asc" then Response.Write("selected") %>>이름순</option>
											<option value="uid/desc" <% if order = "uid/desc" then Response.Write("selected") %>>신상품순</option>
											<option value="price/asc" <% if order = "price/asc" then Response.Write("selected") %>>저가격순</option>
											<option value="price/desc" <% if order = "price/desc" then Response.Write("selected") %>>고가격순</option>
										</SELECT>
									</TD>
								</TR>
								<TR>
									<TD HEIGHT=10 COLSPAN=2></TD>
								</TR>
							</FORM>
						</TABLE>
						<TABLE WIDTH='100%' CELLSPACING=0 CELLPADDING=0 BORDER=0 style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
							<FORM ACTION='./wizmall.php' NAME='mall_list' onsubmit='return cmp()'>
								<INPUT TYPE=HIDDEN NAME=query VALUE='cmp'>
								<TR HEIGHT='22'>
									<TD width="776" BACKGROUND='./skinwiz/search/<%=SearchSkin%>/images/list_bg.gif'><IMG SRC='./skinwiz/search/<%=SearchSkin%>/images/list_2.gif'></TD>
									<TD width="230" BACKGROUND='./skinwiz/search/<%=SearchSkin%>/images/list_bg.gif'><IMG SRC='./skinwiz/search/<%=SearchSkin%>/images/list_3.gif'></TD>
									<TD width="152" BACKGROUND='./skinwiz/search/<%=SearchSkin%>/images/list_bg.gif'><IMG SRC='./skinwiz/search/<%=SearchSkin%>/images/list_4.gif'></TD>
								</TR>
								<%

strSQL = "SELECT * FROM wizmall " & whereis
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

while not objRs.eof
	uid			= objRs("uid")
	picture		= split(objRs("picture"),"|")
	pictures	= picture(0)
	pname 		= objRs("pname")
	brand 		= objRs("brand")
	price 		= objRs("price")
	point		= objRs("point")
	category	= objRs("category")
	
	link_url = "'./wizmart.asp?smode=view&code="&category&"&no="&uid&"'"

''	if ((Stock && Stock <= Output) || None == 'checked' ) {
''		link_url = "'#' onclick=""javascript:alert('제품이 품절되었습니다. 관리자에게 문의하세요.')"""
''		Multi_Disabled = " disabled";
''	}
%>
								<TR>
									<TD COLSPAN=3 BACKGROUND='./skinwiz/search/<%=SearchSkin%>/images/list_line.gif' HEIGHT=1></TD>
								</TR>
								<TR>
									<TD><TABLE WIDTH=100% style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
											<TR>
												<TD WIDTH=127 height="53"><A HREF=<%=link_url%>><IMG SRC='./config/wizstock/<%=pictures%>' WIDTH='50' HEIGHT='50' BORDER=0></A></TD>
												<TD width="634"><A HREF=<%=link_url%>> <%=pname%> </A></TD>
											</TR>
										</TABLE></TD>
									<TD ALIGN=CENTER><%=brand%> </TD>
									<TD ALIGN=CENTER><FONT COLOR='#EF7518'> <%=FormatNumber(price, 0)%> 원</FONT><BR>
										<%=FormatNumber(point, 0)%> 포인트</TD>
								</TR>
								<%
	objRs.movenext
	wend
%>
								<TR>
									<TD COLSPAN=3 BACKGROUND='./skinwiz/search/<%=SearchSkin%>/images/list_line.gif' HEIGHT=1></TD>
								</TR>
								<TR align="center">
									<TD height="44" colspan="3"><%
Dim TransDate
TransData = "&smode="&smode&"&cat="&cat&"&Target="&Target&"&keyword="&keyword&"&price1="&price1&"&price2="&price2&"&Brand="&Brand&"&order="&order&"&andor="&andor
%>
										<table width="155" height="30" border="0" cellpadding="0" cellspacing="0" class="s1">
											<tr>
												<td align="center"><%
	IntStart = INT((((page - 1) \ setPageLink)) * setPageLink + 1)
	IntEnd = INT(((((page - 1) + setPageLink) \ setPageLink)) * setPageLink)
	
	
	
	IF INT(TotalPage) < intEnd THEN IntEnd = TotalPage
		IF INT(page) > INT(setPageLink) THEN
			RESPONSE.WRITE "<a href='wizsearch.asp?page=" & int(page - setPageLink) & TransData & "'>◀"
			RESPONSE.WRITE "<a href='wizsearch.asp?page=1" & TransData & "'></a>.. &nbsp;"
		END IF
%>
												</td>
												<td align="center"><%


		FOR I = IntStart TO IntEnd 
			IF I = IntStart THEN
				'TMPSPLIT = ""
			ELSE 
				'TMPSPLIT = "/"
			END IF 
			
			IF INT(I) = INT(page) THEN
				RESPONSE.WRITE "&nbsp;<b>"&i&"</b>&nbsp;"
			ELSE
				RESPONSE.WRITE "<a href='wizsearch.asp?page=" & I & TransData & "'>&nbsp;"& I & "&nbsp;</a>"
			END IF
		NEXT
%></td>
												<td align="center"><%
		IF INT(TotalPage - IntStart + 1) > INT(setPageLink) THEN RESPONSE.WRITE "<a href='wizsearch.asp?page=" & TotalPage & TransData & "'></a>"

		IF INT(page) + setPageLink > TotalPage + 1 THEN
		ELSEIF INT(page) + setPageLink < TotalPage + 1 THEN
			Response.Write "<a href='wizsearch.asp?page=" & INT(page + setPageLink) & TransData & "'>▶"
		END IF
%>
												</td>
											</tr>
										</table></TD>
								</TR>
							</FORM>
						</TABLE>
						 </td>
				</tr>
			</table>
			 </td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
