<% Option Explicit %>
<!-- #include file = "../lib/cfg.common.asp" -->
<!-- #include file = "../config/db_connect.asp" -->
<!-- #include file = "../lib/class.util.asp" -->
<!-- #include file = "../lib/class.database.asp" -->
<%

Dim query, smode
Dim gid, bid, setOpenGroup, setGroupHeadFile, setGroupHeadMsg, setGroupFootFile, setGroupFootMsg
Dim page, pagesize, TotalRecCount, pagecount, sql_query
Dim setGroupCount, iCount, exec, SELECT_VALUE, LoopNum, ListNum, blockpage, i
Dim strGorupName, setTitle, setSkin, orderby, setorder,intnum
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

if util.is_Admin() = False then Call util.js_alert("등급이 맞지 않습니다.","")

gid				= Request("gid")
bid				= Request("bid")
query			= Request("query")
smode			= Request("smode")
gid				= Request("gid")
setOpenGroup	= Request("setOpenGroup")

'	group 관련 query 시작 
SELECT CASE smode
CASE "addgroup"
	Set objRs	= db.ExecSQLReturnRS("SELECT COUNT(intNum) FROM wiztable_group_config WHERE gid = '" & gid & "' ", Nothing, DbConnect)
	IF objRs(0) <> 0 THEN
		RESPONSE.WRITE WindowAlert("그룹명이 중복됩니다.", 1,"")
	ELSE
		strSQL = "INSERT INTO wiztable_group_config (gid, setOpenGroup, setGroupHeadFile, setGroupHeadMsg, setGroupFootFile, setGroupFootMsg) VALUES ('" & gid & "', '" & setOpenGroup & "', '" & setGroupHeadFile & "', '" & setGroupHeadMsg & "', '" & setGroupFootFile & "', '" & setGroupFootMsg & "') "
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		CALL util.folderMaker(PATH_SYSTEM & "config\wizboard_group")
		CALL util.folderMaker(PATH_SYSTEM & "config\wizboard_group\" & gid)
		''CALL folderMaker(PATH_SYSTEM & "config\wizboard_group\" & gid & "\attached")
		RESPONSE.WRITE util.js_alert("신규 그룹 생성이 완료되었습니다.", "admin.asp")
	END IF
CASE "edit"
	strSQL = "UPDATE wiztable_group_config SET setOpenGroup = '" & setOpenGroup & "', setGroupHeadFile = '" & setGroupHeadFile & "', setGroupHeadMsg = '" & setGroupHeadMsg & "', setGroupFootFile = '" & setGroupFootFile & "', setGroupFootMsg = '" & setGroupFootMsg & "' WHERE gid = '" & gid & "' "
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	RESPONSE.WRITE util.js_alert("그룹정보 수정이 완료되었습니다.", "admin.asp")
CASE "qde"

		Set objRs = db.ExecSQLReturnRS("SELECT bid FROM wiztable_board_config WHERE gid = '" & gid & "' ", Nothing, DbConnect)

		IF NOT(objRs.EOF) THEN
			RESPONSE.WRITE WindowAlert("해당 그룹에 속해 있는 게시판 정보가 있습니다.\n\n그룹을 삭제하기 전에 게시판을 먼저 삭제해 주시기 바랍니다.", 1,"")
		ELSE
			Call db.ExecSQL("DELETE FROM wiztable_group_config WHERE gid = '" & gid & "' ", Nothing, DbConnect)
			CALL util.folderDelete(PATH_SYSTEM & "config\wizboard_group\" & gid)
		END IF

	RESPONSE.WRITE util.js_alert("그룹정보 삭제가 완료되었습니다.", "admin.asp")
CASE "board_delete"
		'strSQL = "select * from wiztable_board_config where bid = '" & bid & "' and gid = '" & gid & "'"
		'Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		Call db.ExecSQL("DELETE FROM wiztable_board_config WHERE bid = '" & bid & "' AND gid = '" & gid & "' ", Nothing, DbConnect)
		Call db.ExecSQL("DELETE FROM wiztable_category WHERE bid = '" & bid & "' AND gid = '" & gid & "' ", Nothing, DbConnect)
		Call db.ExecSQL("DROP TABLE wizboard_" & bid & "_" & gid, Nothing, DbConnect)
		Call db.ExecSQL("DROP TABLE wizboard_" & bid & "_" & gid & "_reply", Nothing, DbConnect)
		CALL util.folderDelete(PATH_SYSTEM & "config\wizboard_group\" & gid & "\" & bid)
		CALL util.folderDelete(PATH_SYSTEM & "config\wizboard_group\" & gid & "\check_txt\" & bid)
		RESPONSE.WRITE util.js_alert("게시판 삭제가 완료되었습니다.", "admin.asp?bid=" & bid & "&gid=" & gid)
		RESPONSE.END
	SET objRs = NOTHING
END SELECT
'	group 관련 query 끝
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>관리자님을 환영합니다.위즈보드 관리자모드</title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg("lan")%>">
<link rel="stylesheet" href="style.css" type="text/css">
</head>
<script language=javascript src="../js/wizmall.js"></script>
<script id="dynamic"></script>
<SCRIPT>
<!--
function delete_board(bid, gid){
	if(confirm("" + bid + " 게시판을 삭제하시겠습니까?\n\n게시판을 삭제하시면 영구적으로 복구가 불가능하며,\n\n업로드된 모든 파일또한 삭제가 됩니다."))
	{
		location.href="admin.asp?bid=" + bid + "&gid=" + gid + "&smode=board_delete";
	}
}

function mktbl_form_check(){
	var f = document.mkboardForm;
	if(f.gid.value == ""){
		alert('그룹명을 선택해주세요');
		f.gid.focus();
	}else if(f.bid.value == ""){
		alert('영문및 숫자로 게시판이름을 입력해주세요');
		f.bid.focus();
	}else if(f.setTitle.value == ""){
		alert('타이틀을 입력해주세요');
		f.setTitle.focus();
	}else if(f.setSkin.value == ""){
		alert('게시판 스킨을 선택해주세요');
		f.setSkin.focus();
	}else f.submit();
}

function really(){
con = confirm("그룹을 삭제합니다. \n\n 그룹삭제전 테이블을 먼저 삭제하셔야 합니다.. \n\n 그룹을 삭제하시겠습니까?")
if (con==true) return true;
else return false;
}

function downforExel(){
location.href="downforexcel.php?DownForExel=yes";
}

function gotoURL(url){
window.open(url,'','')
}

function gotopage(page){
	location.href="admin.asp?bid=<%=bid%>&gid=<%=gid%>&page="+page;
}

function group_delete(num, gname){
	if(confirm('삭제된 그룹은 복구되지 않습니다.\n\n삭제하시겠습니까?\n\n')){
		location.href = "admin.asp?smode=qde&gid="+gname;
	}else return false
}

function orderfnc(flag, c_no){
	dynamic.src = "./admin_board_order.asp?flag=" + flag + "&c_no=" + c_no;
}
//-->
</SCRIPT>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
				<td width="200" valign="top">&nbsp;</td>
				<td width="10" valign="top"></td>
				<td align="right" valign="top"><span class="style1"><a href="../" target="_blank">홈</a></span> | <a href="logout.asp">로그아웃</a> </td>
		</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
				<td width="200" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
										<td height="31" align="center" bgcolor="E0E4E8"><strong>그룹관리</strong></td>
								</tr>
								<tr>
										<td>&nbsp;</td>
								</tr>
								<tr>
										<td><table width="100%"  border="0" cellspacing="0" cellpadding="0">
														<%
strSQL = "SELECT intNum, gid, setOpenGroup, setGroupHeadFile, setGroupHeadMsg, setGroupFootFile, setGroupFootMsg, setGroupCount = (SELECT COUNT(intNum) FROM wiztable_group_config), countBoard = (SELECT COUNT(intNum) FROM wiztable_board_config WHERE gid = wiztable_group_config.gid), dateRegDate FROM wiztable_group_config"			  
SET objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

IF objRs.EOF THEN setGroupCount = 0 ELSE setGroupCount = objRs("setGroupCount")
%>
														<tr>
																<td height="25" colspan="9">등록된 그룹 개수 : <font color="#b02832"><%=setGroupCount%></font> 개 </td>
														</tr>
														<tr>
																<td><table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="DBDBDB">
																				<tr align="center" bgcolor="E0E4E8">
																						<td>번호</td>
																						<td>그룹아이디</td>
																						<td>게시판수</td>
																						<td width="60" headers="30">삭제</td>
																				</tr>
																				<% IF objRs.EOF THEN %>
																				<tr align="center" bgcolor="F7F7F7">
																						<td colspan="4"><span style="color: #b02832">등록된 그룹이 없습니다. </span></td>
																				</tr>
																				<%
	ELSE
		
		WHILE NOT(objRs.EOF)
		iCount = iCount + 1
%>
																				<tr align="center" bgcolor="F7F7F7">
																						<td><%=iCount%></td>
																						<td><%=objRs("gid")%></td>
																						<td><%=objRs("countBoard")%></td>
																						<td width="60"><button type="button" name="그룹삭제" onClick="group_delete('<%=objRs("intNum")%>','<%=objRs("gid")%>');"
      title="그룹삭제">그룹삭제</button></td>
																				</tr>
																				<%
		objRs.MOVENEXT
		WEND
	END IF
%>
																		</table></td>
														</tr>
												</table></td>
								</tr>
								<tr>
										<td>&nbsp;</td>
								</tr>
								<tr>
										<td><table width="100%"  border="0" cellspacing="0" cellpadding="0">
														<form name="frm1" method="post" action="admin.asp">
																<input type="hidden" name="smode" value="addgroup">
																<tr>
																		<td height="25"><img src="../images/icon01.gif" width="9" height="9" align="absmiddle"> 신규 그룹 생성(그룹아이디는 영문자/숫자로 넣어주세요)</td>
																</tr>
																<tr>
																		<td><table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="#DBDBDB">
																						<tr>
																								<td width="120" height="30" bgcolor="E0E4E8">그룹아이디</td>
																								<td height="30" bgcolor="#F7F7F7"><input name="gid" type="text" class="input" id="gid" value="<%=gid%>" size="15" maxlength="30" <% IF smode = "EDIT" THEN %>READONLY<% END IF %> >
																								</td>
																						</tr>
																				</table></td>
																</tr>
																<tr>
																		<td height="50" align="center"><button name="그룹 생성하기" type="submit" title="그룹 생성하기">그룹 생성하기</button></td>
																</tr>
														</form>
												</table></td>
								</tr>
								<tr>
										<td>&nbsp;</td>
								</tr>
								<tr>
										<td>&nbsp;</td>
								</tr>
								<tr>
										<td>&nbsp;</td>
								</tr>
						</table></td>
				<td width="10" valign="top"></td>
				<td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
										<td><%
bid		= REQUEST("bid")
exec	= REQUEST("exec") : IF exec	= "" THEN exec = "edit"
%>
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
														<form name="mkboardForm" method="post" action="admin_mkboard_qry.asp">
																<input type="hidden" name="exec" value="add">
																<tr>
																		<td height="30">&nbsp;</td>
																</tr>
																<tr>
																		<td align="center"><table width="97%"  border="0" cellspacing="0" cellpadding="0">
																						<tr>
																								<td width="39%" height="4" bgcolor="B0C7C7"></td>
																								<td width="61%" height="4" bgcolor="EBEFEF"></td>
																						</tr>
																				</table></td>
																</tr>
																<tr>
																		<td align="right" style="padding:5 15 0 0"></td>
																</tr>
																<%
	IF exec = "edit" THEN
	ELSEIF exec = "add" THEN
	END IF
%>
																<tr>
																		<td><table width="100%"  border="0" cellspacing="0" cellpadding="0">
																						<tr>
																								<td height="25"><img src="../images/icon01.gif" width="9" height="9" align="absmiddle"> 게시판 기본 생성(상세변경은 리스트의 옵션에서 변경해 주세요)<br>
																								</td>
																						</tr>
																						<tr>
																								<td><table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="DBDBDB">
																												<tr>
																														<td bgcolor="E0E4E8">그룹</td>
																														<td bgcolor="F7F7F7"><select name="gid" id="gid" style="font-size:9pt">
																																		<option value="">선택해주세요</option>
																																		<%	

	strSQL = "select [gid] from [wiztable_group_config]"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	while not objRs.eof
		IF strGorupName = objRs("gid") THEN SELECT_VALUE = " SELECTED " ELSE SELECT_VALUE = ""
		Response.Write "<option value='" & objRs("gid") & "'" & SELECT_VALUE & ">" & objRs("gid") & vbcrlf	
	objRs.movenext
	wend
%>
																																</select>
																														</td>
																												</tr>
																												<tr>
																														<td bgcolor="E0E4E8">게시판 아이디</td>
																														<td bgcolor="F7F7F7"><input name="bid" type="text" class="input" id="bid" size="20" maxlength="20">
																																(게시판아이디는 영문자/숫자로 넣어주세요)</td>
																												</tr>
																												<tr>
																														<td width="120" bgcolor="E0E4E8">게시판 타이틀</td>
																														<td bgcolor="F7F7F7"><input name="setTitle" type="text" class="input" id="setTitle" value="<%=setTitle%>" size="50"></td>
																												</tr>
																												<tr>
																														<td width="120" bgcolor="E0E4E8">게시판 스킨</td>
																														<td bgcolor="F7F7F7"><select name="setSkin" id="setSkin" style="font-size:9pt; width:170;">
																																		<%=util.ShowFolderList(PATH_SYSTEM & "wizboard\skin",setSkin)%>
																																</select></td>
																												</tr>
																										</table></td>
																						</tr>
																				</table></td>
																</tr>
																<tr>
																		<td height="50" align="center"><button type="button" onClick="mktbl_form_check();" title="게시판 생성하기">게시판 생성하기</button></td>
																</tr>
														</form>
												</table></td>
								</tr>
								<tr>
										<td><table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
																<td align="right">&nbsp;&nbsp;&nbsp;</td>
														</tr>
												</table>
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
														<form name="frm1" method="get">
																<tr>
																		<td align="right" style="padding:10 15 10 15"> 그룹 선택&nbsp;
																				<select name="gid" id="gid" style="font-size:9pt" onChange="submit();">
																						<option value="">선택해주세요</option>
																						<%	
	strSQL = "select [gid] from [wiztable_group_config]"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	while not(objRs.eof)
		IF strGorupName = objRs("gid") THEN SELECT_VALUE = " SELECTED " ELSE SELECT_VALUE = ""
		Response.Write "<option value='" & objRs("gid") & "'" & SELECT_VALUE & ">" & objRs("gid") & vbcrlf	
	objRs.movenext
	wend
%>
																				</select></td>
																</tr>
																<%
	IF gid = "" THEN
		Set objRs = db.ExecSQLReturnRS("SELECT TOP 1 gid FROM wiztable_group_config" , Nothing, DbConnect)
		''IF objRs.EOF THEN RESPONSE.WRITE WindowAlert("그룹을 먼저 생성해 주시기 바랍니다.", 1,"") ELSE gid = objRs("gid")

		Function MemberInputCheck(str)
			IF str = "1" THEN MemberInputCheck = " CHECKED " ELSE MemberInputCheck = ""
		End Function

	END IF
	%>
																<%
	
	page            = REQUEST("page")     : IF page = "" THEN page = 1
	pagesize        = REQUEST("pagesize") : IF pagesize = "" THEN pagesize = 20

	IF SESSION("admin") = "board" THEN
		strSQL = "SELECT bid FROM wiztable_main_BOARD WHERE strLoginID = '" & SESSION("login_id") & "' AND gid = '" & gid & "' "
		Set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		sql_query = " AND bid IN ("
		WHILE NOT(objRs.EOF)
			sql_query = sql_query & "'" & objRs("bid") & "',"
		objRs.MOVENEXT
		WEND
		sql_query = LEFT(sql_query, LEN(sql_query)-1)
		sql_query = sql_query & ")"
	END IF

	Set objRs	= db.ExecSQLReturnRS("SELECT COUNT(intNum) FROM wiztable_board_config WHERE gid = '" & gid & "' " & sql_query, Nothing, DbConnect)
	TotalRecCount = objRs(0)
	pagecount = INT((TotalRecCount-1) / pagesize) + 1
%>
																<tr>
																		<td style="padding:10 15 10 15"><% 
if gid <> "" then 
%>
																				<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																						<tr>
																								<td height="25" colspan="9"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
																												<tr>
																														<td>PAGE : <font color="#b02832"><%=page%></font> / <font color="#b02832"><%=pagecount%></font></td>
																														<td align="right">전체 <font color="#b02832"><%=TotalRecCount%></font>개</td>
																												</tr>
																										</table></td>
																						</tr>
																						<tr>
																								<td><table width="100%"  border="0" cellspacing="1" cellpadding="6" bgcolor="DBDBDB">
																												<tr align="center" bgcolor="E0E4E8">
																														<td>번호</td>
																														<td>게시판<br>
																																아이디 </td>
																														<td>게시판<br>
																																타이틀</td>
																														<td>게시판<br>
																																스킨</td>
																														<td>링크<br>
																																경로</td>
																														<td>옵션<br>
																																설정</td>
																														<td>게시물<br>
																																관리</td>
																														<td>미리<br>
																																보기</td>
																														<td>삭제</td>
																												</tr>
																												<%
	orderby = " order by setorder asc, bid asc"		
						
	IF gid = "" THEN
		strSQL = "SELECT TOP " & pagesize & " * FROM wiztable_board_config WHERE intNum NOT IN (SELECT TOP " & ((page-1) * pagesize ) & " intNum FROM wiztable_board_config WHERE gid = '" & gid & "' " & sql_query &  orderby & ") " & sql_query & orderby
	ELSE
		strSQL = "SELECT TOP " & pagesize & " * FROM wiztable_board_config WHERE gid = '" & gid & "' AND intNum NOT IN (SELECT TOP " & ((page-1) * pagesize ) & " intNum FROM wiztable_board_config WHERE gid = '" & gid & "' " & sql_query &  orderby & ") " & sql_query & orderby
	END IF

	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	IF objRs.EOF THEN
%>
																												<tr align="center" bgcolor="F7F7F7">
																														<td colspan="9">등록된 게시판이 없습니다. </td>
																												</tr>
																												<%
	ELSE
		
		LoopNum = 0
		WHILE NOT(objRs.EOF)
			LoopNum		= LoopNum + 1
			ListNum		= INT(TotalRecCount)-(INT(pagesize)*(INT(page)-1)) - LoopNum + 1
			setorder	= objRs("setorder")
			intnum		= objRs("intnum")
%>
																												<tr align="center" bgcolor="F7F7F7">
																														<td><table width="100%" border="0" cellspacing="0" cellpadding="0">
																																		<tr>
																																				<td><%=setorder%></td>
																																				<td><table width="100%" border="0" cellspacing="0" cellpadding="0">
																																								<tr>
																																										<td align="center"><a href="javascript:orderfnc('up','<%=intnum%>')">▲</a></td>
																																								</tr>
																																								<tr>
																																										<td align="center"><a href="javascript:orderfnc('down','<%=intnum%>')">▼</a></td>
																																								</tr>
																																						</table></td>
																																		</tr>
																																</table></td>
																														<td><%=objRs("bid")%></td>
																														<td><%=objRs("settitle")%></td>
																														<td><%=objRs("setskin")%></td>
																														<td><% response.write("wizboard.asp?bid=" & objRs("bid") & "&amp;gid=" & objRs("gid"))%></td>
																														<td bgcolor="F7F7F7"><button type="button" name="" onClick="wizwindow('./admin1.asp?bid=<%=objRs("bid")%>&gid=<%=gid%>','','scrollbars=yes,resizable=yes,width=630,height=500');" title="옵션수정">옵션수정</button></td>
																														<td><button type="button" name="" onClick="wizwindow('./boardlist.asp?bid=<%=objRs("bid")%>&gid=<%=gid%>','','scrollbars=yes,resizable=yes,width=630,height=500');" title="게시물관리">게시물관리</button></td>
																														<td><button type="button" name="미리보기" onClick="wizwindow('../wizboard.asp?bid=<%=objRs("bid")%>&gid=<%=gid%>','','scrollbars=yes,resizable=yestoolbar=1, location=1, directories=1, status=1, menubar=1, scrollbars=1, resizable=1');" title="미리보기">미리보기</button></td>
																														<td><button type="button" name="삭제" onClick="delete_board('<%=objRs("bid")%>', '<%=gid%>')" title="삭제">삭제</button></td>
																												</tr>
																												<%
		objRs.MOVENEXT
		WEND
	END IF
%>
																										</table></td>
																						</tr>
																						<tr>
																								<td colspan="9" align="center"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
																												<tr>
																														<td height="1" bgcolor="C6C6C6"></td>
																												</tr>
																												<tr>
																														<td height="2" bgcolor="EFEFEF"></td>
																												</tr>
																												<tr>
																														<td height="25" align="center"><% call GotoPageHTML(page, pagecount) %></td>
																												</tr>
																										</table></td>
																						</tr>
																				</table>
																				<%
else 'if gid <> "" then 
%>
																				<table width="100%"  border="0" cellspacing="1" cellpadding="6" bgcolor="DBDBDB">
																						<tr align="center" bgcolor="F7F7F7">
																								<td colspan="7">그룹을 선택해 주시기 바랍니다. </td>
																						</tr>
																				</table>
																				<%
end if 'if gid <> "" then 
%>
																		</td>
																</tr>
														</form>
												</table>
												<%
	SUB GotoPageHTML(page,pagecount)
	
	
	blockpage = Int((page-1)/10)*10+1

	IF blockpage = 1 THEN RESPONSE.WRITE "<img src=./images/pre.gif border=0 align=absmiddle> "	ELSE RESPONSE.WRITE "<a href=""javascript:;"" OnClick=""gotopage('" & blockpage - 10 & "');return false;""><img src=./images/pre.gif border=0 align=absmiddle></a> "
	i = 1
	DO UNTIL i > 10 OR blockpage > pagecount
	IF blockpage = INT(page) THEN 
		RESPONSE.WRITE " <b>" & blockpage & "</b> "
	ELSE
		RESPONSE.WRITE "<a href=""javascript:;"" OnClick=""gotopage('" & blockpage & "');return false;"">" & blockpage & "</a>"
	END IF

	blockpage = blockpage + 1
	i = i + 1
	LOOP

	IF blockpage > pagecount THEN RESPONSE.WRITE " <img src=./images/next.gif border=0 align=absmiddle>"	ELSE RESPONSE.WRITE " <a href=""javascript:;"" OnClick=""gotopage('" & blockpage & "');return false;""><img src=./images/next.gif border=0 align=absmiddle></a> "
	END SUB
%>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
																<td align="center">&nbsp;</td>
														</tr>
												</table></td>
								</tr>
								<tr>
										<td>&nbsp;</td>
								</tr>
								<tr>
										<td>&nbsp;</td>
								</tr>
						</table></td>
		</tr>
</table>
<br>
</body>
</html>
<%
SET objRs =Nothing : Set db	= Nothing : Set util = Nothing
%>
