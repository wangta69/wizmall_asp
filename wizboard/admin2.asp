<!-- #include file = "../lib/cfg.common.asp" -->
<!-- #include file = "../config/db_connect.asp" -->
<!-- #include file = "../lib/class.util.asp" -->
<!-- #include file = "../lib/class.database.asp" -->
<!-- 
제작자 : 폰돌
제작자 URL : http://www.shop-wiz.com
제작자 Email : master@shop-wiz.com
Free Distributer 
- http://www.shop-wiz.com

*** Updating List ***
2005- 06- 17 신규제작
//-->
<%
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

	Function bitInputCheck(str)
		IF str = "" THEN bitInputCheck = "0" ELSE bitInputCheck = "1"
	END Function
		
	Dim query, gid, bid, setadminonly, setBoardWidth, setBoardAlign, setSubjectCut, setPageSize, setPageLink
	Dim path
	bid = REQUEST("bid")
	gid = REQUEST("gid")
	query = REQUEST("query")

	IF util.is_Admin = False then Call util.js_close("등급이 맞지 않습니다.","")

	IF query = "qup" THEN
		setadminonly		= REQUEST("setadminonly")
		setBoardWidth		= REQUEST("setBoardWidth")
		setBoardWidthStep	= REQUEST("setBoardWidthStep")
		setBoardAlign		= REQUEST("setBoardAlign")
		setSubjectCut		= REQUEST("setSubjectCut")
		setlistorder		= REQUEST("setlistorder")
		setPageSize			= REQUEST("setPageSize")
		setPageLink			= REQUEST("setPageLink")
		setmemberonly		= REQUEST("setmemberonly")
		setrepleenable		= REQUEST("setrepleenable")
		setlistinview		= REQUEST("setlistinview")
		''setfileenable		= REQUEST("setfileenable")
		setfilenum			= REQUEST("setfilenum")
		allowfileext		= REQUEST("allowfileext")
		setsecurityscript	= REQUEST("setsecurityscript")
		setsecurityiframe	= REQUEST("setsecurityiframe")
		if setsecurityiframe = "" then setsecurityiframe = "0"
		if setsecurityscript = "" then setsecurityscript = "0"
		setsecurityflag = setsecurityiframe&"|"&setsecurityscript
		
		memberonly_mode = REQUEST("memberonly_listmode") & "|" & REQUEST("memberonly_viewmode") & "|" & REQUEST("memberonly_writemode")


		strSQL = "update wiztable_board_config set setadminonly = '" & setadminonly & "',setBoardWidth = '" & setBoardWidth & "'"
		strSQL = strSQL &" ,setBoardWidthStep = '" & setBoardWidthStep & "',setBoardAlign = '" & setBoardAlign & "'"
		strSQL = strSQL &" ,setSubjectCut = '" & setSubjectCut & "',setPageSize = '" & setPageSize & "',setPageLink = '" & setPageLink & "'"
		strSQL = strSQL &" ,setmemberonly = '" & setmemberonly & "',memberonly_mode = '" & memberonly_mode & "'"
		strSQL = strSQL &" ,setrepleenable = '" & setrepleenable & "',setlistinview = '" & setlistinview & "'"
		strSQL = strSQL &" ,setfilenum = '" & setfilenum & "',setsecurityflag = '" & setsecurityflag & "',setlistorder = '" & setlistorder & "' "
		strSQL = strSQL &" WHERE bid = '" & bid & "' AND gid = '" & gid & "' "			
		Call db.ExecSQL(strSQL, Nothing, DbConnect)
		'' 허용확장자 저장
		CALL util.FileMakeTxt(PATH_SYSTEM & "config\wizboard_group\" & gid & "\" & bid & "\allow_file_ext.txt", allowfileext)

		Response.Redirect("admin2.asp?bid=" & bid & "&gid=" & gid)
	END IF
	
''	  출력할 내용을 가져온다	
		strSQL = "select *                                                                    from wiztable_board_config where bid = '" & bid & "' and gid = '" & gid & "'"
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		settitle			= objRs("settitle")
		setadminonly		= objRs("setadminonly")
		setBoardWidth		= objRs("setBoardWidth")
		setBoardWidthStep	= objRs("setBoardWidthStep")
		setBoardAlign		= objRs("setBoardAlign")
		setSubjectCut		= objRs("setSubjectCut")
		setPageSize			= objRs("setPageSize")
		setPageLink			= objRs("setPageLink")
		setmemberonly		= objRs("setmemberonly")
		setrepleenable		= objRs("setrepleenable")
		memberonly_mode		= objRs("memberonly_mode")
		setlistinview		= objRs("setlistinview")
		setlistorder		= objRs("setlistorder")
		''setfileenable		= objRs("setfileenable")
		setfilenum			= objRs("setfilenum")
		if memberonly_mode <> "" and not isnull(memberonly_mode) then 
			memberonly_mode_arr = split(memberonly_mode, "|")
			memberonly_listmode = memberonly_mode_arr(0)
			memberonly_viewmode = memberonly_mode_arr(1)
			memberonly_writemode = memberonly_mode_arr(2)
		end If
		setsecurityflag		= objRs("setsecurityflag")
		If Not IsNull(setsecurityflag) then
			setsecurityflag		= split(objRs("setsecurityflag"), "|")
			setsecurityiframe	= setsecurityflag(0)
			setsecurityscript	= setsecurityflag(1)
		End if
		
	'' 업로드 허용 확장자
	path = PATH_SYSTEM&"config\wizboard_group\"&gid&"\"&bid&"\allow_file_ext.txt"
	allowfileext = util.FileReadTxt(path)		
%>
<html>
<head>
<title>관리자님을 환영합니다.[위즈보드 관리자모드]</title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<link rel="stylesheet" href="style.css" type="text/css">

<script language="JavaScript">
<!--
function field_check(){
}
//-->
</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table cellspacing=0 bordercolordark=white width="607" align="center" bgcolor=#c0c0c0 bordercolorlight=#dddddd border=1 class="s1">
  <form method="post" action="admin2.asp" name="BoardSelectForm">
    <tr>
      <td bgcolor="#FFFFFF"><font color="#FF6600"><strong>아이디&nbsp; :
        <select name="bid" id="bid" style="font-size:9pt" onChange="document.BoardSelectForm.submit();">
          <%	
	strSQL = "SELECT bid FROM wiztable_board_config WHERE gid = '" & gid &"'  ORDER BY bid asc "
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	while not(objRs.eof)
		IF bid = objRs("bid") THEN SELECT_VALUE = " SELECTED " ELSE SELECT_VALUE = ""
		Response.Write "<option value='" & objRs("bid") & "'" & SELECT_VALUE & ">" & objRs("bid") & vbcrlf	
	objRs.movenext
	wend
%>
        </select>
        &nbsp;&nbsp;&nbsp;그룹명 : </strong>
        <select name="gid" id="gid" style="font-size:9pt" onChange="document.BoardSelectForm.submit();">
          <%	
	strSQL = "select [gid] from [wiztable_group_config]"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	while not(objRs.eof)
		IF gid = objRs("gid") THEN SELECT_VALUE = " SELECTED " ELSE SELECT_VALUE = ""
		Response.Write "<option value='" & objRs("gid") & "'" & SELECT_VALUE & ">" & objRs("gid") & vbcrlf	
	objRs.movenext
	wend
%>
        </select>
        [<%=settitle%>]</font></td>
    </tr>
  </form>
</table>
<table cellspacing=0 bordercolordark=white width="607" align="center" bgcolor=#c0c0c0 bordercolorlight=#dddddd border=1 class="s1">
  <tr>
    <td><table width="600" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="12" bgcolor="#B9C2CC"><a href="./admin1.asp?bid=<%=bid%>&gid=<%=gid%>"><font color="#FFFFFF">&nbsp;LayOut</font></a> | <a href="./admin2.asp?bid=<%=bid%>&gid=<%=gid%>"><font color="#FFFF00">제한설정</font></a> | <a href="./admin3.asp?bid=<%=bid%>&gid=<%=gid%>"><font color="#FFFFFF">카테고리설정</font></a> </td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
        <form name="frm1" method="post" action="admin2.asp" onSubmit="return field_check();">
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
            <td align="right" style="padding:5 15 0 0"><input type="hidden" name="bid" value="<%=bid%>">
              <input type="hidden" name="gid" value="<%=gid%>">
              <input type="hidden" name="query" value="qup"></td>
          </tr>
          <tr>
            <td style="padding:10 15 10 15"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="25"><img src="../images/icon01.gif" width="9" height="9" align="absmiddle"> 게시판 제한 설정 </td>
                </tr>
                <tr>
                  <td><table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="DBDBDB">
                      <tr>
                        <td width="120" bgcolor="F7F7ED">공지게시판</td>
                        <td bgcolor="F7F7F7"><input name="setadminonly" type="checkbox" value="1" <% if setadminonly = "True" then Response.Write("checked") %>>
                          쓰기, 삭제, 수정이 관리자만 이용합니다.</td>
                      </tr>
                      <tr>
                        <td width="120" bgcolor="F7F7ED">게시판 너비</td>
                        <td bgcolor="F7F7F7"><input name="setBoardWidth" type="text" class="input" id="setBoardWidth" value="<%=setBoardWidth%>" size="4">
                          <select name="setBoardWidthStep" id="setBoardWidthStep" style="font-size:9pt">
                            <option value="px" <% IF setBoardWidthStep = "px" THEN %>SELECTED<% END IF %>>px</option>
                            <option value="%" <% IF setBoardWidthStep = "%" THEN %>SELECTED<% END IF %>>%</option>
                          </select>
                        </td>
                      </tr>
                      <tr>
                        <td bgcolor="F7F7ED">게시판 정렬</td>
                        <td bgcolor="F7F7F7"><select name="setBoardAlign" id="setBoardAlign" style="font-size:9pt">
                            <option value="left" <% IF setBoardAlign = "left" THEN %>SELECTED<% END IF %>>왼쪽</option>
                            <option value="center" <% IF setBoardAlign = "center" THEN %>SELECTED<% END IF %>>가운데</option>
                            <option value="right" <% IF setBoardAlign = "right" THEN %>SELECTED<% END IF %>>오른쪽</option>
                          </select>
                          게시판 전체적인 정렬 방식.</td>
                      </tr>
                      <tr>
                        <td bgcolor="F7F7ED">리스트 제목 길이 </td>
                        <td bgcolor="F7F7F7"><input name="setSubjectCut" type="text" class="input" id="setSubjectCut" value="<%=setSubjectCut%>" size="4">
                          리스트 출력시 게시글 제한 길이.</td>
                      </tr>
                      <tr>
                        <td bgcolor="F7F7ED">기본정렬</td>
                        <td bgcolor="F7F7F7"><select name="setlistorder" id="setlistorder">
                          <option value="bd_idx_num@desc"<% IF setlistorder = "bd_idx_num@desc" THEN  Response.Write(" SELECTED")%>>기본</option>
                          <option value="regdate@desc"<% IF setlistorder = "regdate@desc" THEN  Response.Write(" SELECTED")%>>등록순(DESC)</option>
                          <option value="regdate@asc"<% IF setlistorder = "regdate@asc" THEN  Response.Write(" SELECTED")%>>등록순(ASC)</option>
                          <option value="subject@asc"<% IF setlistorder = "subject@asc" THEN  Response.Write(" SELECTED")%>>제목순</option>
                        </select>                        
                        리스트출력시 기본정렬</td>
                      </tr>                      
                      <tr>
                        <td bgcolor="F7F7ED">리스트 개수</td>
                        <td bgcolor="F7F7F7"><input name="setPageSize" type="text" class="input" id="setPageSize" value="<%=setPageSize%>" size="4">
                          한 화면에 출력할 게시글 개수.</td>
                      </tr>
                      <tr>
                        <td bgcolor="F7F7ED">페이징 개수 </td>
                        <td bgcolor="F7F7F7"><input name="setPageLink" type="text" class="input" id="setPageLink" value="<%=setPageLink%>" size="4">
                          한 화면에 출력할 페이징 개수.</td>
                      </tr>
                      <tr>
                        <td bgcolor="F7F7ED">뷰에 리스트 출력</td>
                        <td bgcolor="F7F7F7"><input name="setlistinview" type="checkbox" value="1" <% if setlistinview = "1" then Response.Write("checked") %>>
                          뷰페이지에 리스트 출력</td>
                      </tr>
                      <tr>
                        <td bgcolor="F7F7ED">회원전용</td>
                        <td bgcolor="F7F7F7"><!--<input name="setmemberonly" type="checkbox" value="1" <% if setmemberonly = "1" then Response.Write("checked") %>> -->
                          (write
                          <%
''Response.Write("memberonly_writemode="&memberonly_writemode&"<br>")
%>
                          <select name="memberonly_writemode">
                            <%
if memberonly_writemode = "" then memberonly_writemode=11
for i=0 to 11
	if cint(memberonly_writemode) = i then
		selected = "selected"
	else
		selected = ""
	end if
	Response.Write("<option value='"&i&"' "&selected&">"&i&"</option>")
next
%>
                          </select>
                          , view
                          <select name="memberonly_viewmode">
                            <%
if memberonly_viewmode = "" then memberonly_viewmode=11
for i=0 to 11
	if cint(memberonly_viewmode) = i then
		selected = "selected"
	else
		selected = ""
	end if
	Response.Write("<option value='"&i&"' "&selected&">"&i&"</option>")
next
%>
                          </select>
                          , list
                          <select name="memberonly_listmode">
                            <%
if memberonly_listmode = "" then memberonly_listmode=11
for i=0 to 11
	if cint(memberonly_listmode) = i then
		selected = "selected"
	else
		selected = ""
	end if
	Response.Write("<option value='"&i&"' "&selected&">"&i&"</option>")
next
%>
                          </select>
                          )</td>
                      </tr>
                      <tr>
                        <td bgcolor="F7F7ED">리플달기</td>
                        <td bgcolor="F7F7F7"><input name="setrepleenable" type="checkbox" value="1" <% if setrepleenable = "1" then Response.Write("checked") %>></td>
                      </tr>
                      <tr>
                        <td bgcolor="F7F7ED">파일첨부</td>
                        <td bgcolor="F7F7F7"><select name="setfilenum">
                            <%
''Response.Write("setfilenum="&setfilenum)
for i=0 to 10
	if setfilenum = i then 
		selected = "selected"
	else 
		selected = ""
	end if
	
	Response.Write("<option value='"&i&"' "&selected&">"&i&"</option>"&Chr(13)&Chr(10))
next
%>
                          </select>
                          개</td>
                      </tr>
                      <tr>
                        <td bgcolor="F7F7ED">첨부허용확장자</td>
                        <td bgcolor="F7F7F7"><textarea name="allowfileext" id="textfield" style="width:100%"><%=allowfileext%></textarea>
                        	<br>
                        	적용예) jpg,gif</td>
                      </tr>  
                      <tr>
                        <td bgcolor="F7F7ED">보안</td>
                        <td bgcolor="F7F7F7"><input name="setsecurityiframe" type="checkbox" id="checkbox" value="1"<% if setsecurityiframe = 1 then Response.Write(" checked")%> >
                          iframe금지

                            <input name="setsecurityscript" type="checkbox" id="checkbox2" value="1"<% if setsecurityscript = 1 then Response.Write(" checked")%>>
                            script 금지</td>
                      </tr> 					                      
                    </table></td>
                </tr>
              </table></td>
          </tr>
          <tr>
            <td height="50" align="center" style="padding:10 15 10 15"><button name="" type="submit" title="수정하기">수정하기</button></td>
          </tr>
        </form>
      </table></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF">&nbsp;</td>
  </tr>
</table>
</body>
</html>
<%
SET objRs =NOTHING
%>
