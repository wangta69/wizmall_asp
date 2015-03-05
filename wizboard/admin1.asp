<% Option Explicit %>
<!-- #include file = "../lib/cfg.common.asp" -->
<!-- #include file = "../config/db_connect.asp" -->
<!-- #include file = "../lib/class.util.asp" -->
<!-- #include file = "../lib/class.database.asp" -->
<!-- #include file = "../lib/class.board.asp" -->
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
Dim db,util,board
Set util = new utility : Set db = new database : Set board = new boards

		
	Dim query, gid, bid
	bid		= REQUEST("bid")
	gid		= REQUEST("gid")
	query	= REQUEST("query")


	Dim setskin,sethtmleditor,settitle,setheadmsg,setheadfile,setfootmsg,setfootfile,setmallinclude
	Dim SELECT_VALUE
	
	IF util.is_Admin = False then Call util.js_close("등급이 맞지 않습니다.","")

	IF query = "qup" THEN
		setskin				= REQUEST("setskin")
		sethtmleditor		= REQUEST("sethtmleditor")
		settitle			= REQUEST("settitle")
		setheadmsg			= util.getReplaceInput(REQUEST("setheadmsg"), "")
		setheadfile			= REQUEST("setheadfile")
		setfootmsg			= util.getReplaceInput(REQUEST("setfootmsg"), "")
		setfootfile			= REQUEST("setfootfile")
		setmallinclude		= REQUEST("setmallinclude")

		strSQL = "update wiztable_board_config set "
		strSQL = strSQL & " setskin = '" & setskin & "', "
		strSQL = strSQL & " sethtmleditor = '" & sethtmleditor & "', "
		strSQL = strSQL & " settitle = '" & settitle & "',"
		strSQL = strSQL & " setheadmsg = '" & setheadmsg & "',"
		strSQL = strSQL & " setheadfile='" & setheadfile & "', "
		strSQL = strSQL & " setfootfile='" & setfootfile & "' ,"
		strSQL = strSQL & " setfootmsg = '" & setfootmsg & "',"
		strSQL = strSQL & " setmallinclude = '" & setmallinclude & "'" 
		strSQL = strSQL & " WHERE bid = '" & bid & "' AND gid = '" & gid & "' "			
		Call db.ExecSQL(strSQL, Nothing, DbConnect)
		
	END IF
	
''	  출력할 내용을 가져온다	
		strSQL = "select * from wiztable_board_config where bid = '" & bid & "' and gid = '" & gid & "'"
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		setskin				= objRs("setskin")
		sethtmleditor		= objRs("sethtmleditor")
		settitle			= objRs("settitle")
		setheadfile			= objRs("setheadfile")
		setheadmsg			= objRs("setheadmsg")
		setfootfile			= objRs("setfootfile")
		setfootmsg			= objRs("setfootmsg")
		setmallinclude		= objRs("setmallinclude")
	
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
	<form method="post" action="admin1.asp" name="BoardSelectForm">
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
%> </select> &nbsp;&nbsp;&nbsp;그룹명 :  </strong> 
<select name="gid" id="gid" style="font-size:9pt" onChange="document.BoardSelectForm.submit();">
<%	
	strSQL = "select [gid] from [wiztable_group_config]"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	while not(objRs.eof)
		IF gid = objRs("gid") THEN SELECT_VALUE = " SELECTED " ELSE SELECT_VALUE = ""
		Response.Write "<option value='" & objRs("gid") & "'" & SELECT_VALUE & ">" & objRs("gid") & vbcrlf	
	objRs.movenext
	wend
%> </select>
    [<%=settitle%>]</font></td>
  </tr></form>
</table>
<table cellspacing=0 bordercolordark=white width="607" align="center" bgcolor=#c0c0c0 bordercolorlight=#dddddd border=1 class="s1">
  <tr> 
    <td> <table width="600" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="12" bgcolor="#B9C2CC"><a href="./admin1.asp?bid=<%=bid%>&gid=<%=gid%>"><font color="#FFFF00">&nbsp;LayOut</font></a> 
            | <a href="./admin2.asp?bid=<%=bid%>&gid=<%=gid%>"><font color="#FFFFFF">제한설정</font></a> 
            | <a href="./admin3.asp?bid=<%=bid%>&gid=<%=gid%>"><font color="#FFFFFF">카테고리설정</font></a>
          </td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td bgcolor="#FFFFFF"> <table width="100%"  border="0" cellspacing="0" cellpadding="0">
        <form name="frm1" method="post" action="admin1.asp" onSubmit="return field_check();">
          <tr> 
            <td height="30">&nbsp;</td>
          </tr>
          <tr> 
            <td align="center"> <table width="97%"  border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="39%" height="4" bgcolor="B0C7C7"></td>
                  <td width="61%" height="4" bgcolor="EBEFEF"></td>
                </tr>
              </table></td>
          </tr>
          <tr> 
            <td align="right" style="padding:5 15 0 0"> <input type="hidden" name="bid" value="<%=bid%>"> 
              <input type="hidden" name="gid" value="<%=gid%>"> 
              <input type="hidden" name="query" value="qup"></td>
          </tr>
          <tr> 
            <td style="padding:10 15 10 15"> <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td height="25"><img src="../images/icon01.gif" width="9" height="9" align="absmiddle"> 
                    게시판 출력관련 설정</td>
                </tr>
                <tr> 
                  <td> <table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="DBDBDB">
                      <tr> 
                        <td width="120" bgcolor="F7F7ED">스킨 선택</td>
                        <td bgcolor="F7F7F7"> <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                            <tr> 
                              <td><select name="setskin" id="setskin" style="font-size:9pt; width:170;">
                                  <%=util.ShowFolderList(PATH_SYSTEM & "wizboard\skin",setskin)%> </select> <input name="sethtmleditor" type="checkbox" id="sethtmleditor" value="1"<% if sethtmleditor = 1 then Response.Write " checked" %>>
                                  html편집기사용</td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr> 
                        <td width="120" bgcolor="F7F7ED">타이틀</td>
                        <td bgcolor="F7F7F7"> <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                            <tr> 
                              <td><input name="settitle" type="text" class="input" id="settitle" value="<%=settitle%>" size="60"> 
                              </td>
                            </tr>
                          </table></td>
                      </tr>					  
                      <tr> 
                        <td bgcolor="F7F7ED">상단 내용</td>
                        <td bgcolor="F7F7F7"><textarea name="setheadmsg" cols="60" rows="8" class="input" id="setheadmsg"><%=setheadmsg%></textarea></td>
                      </tr>
                      <tr> 
                        <td bgcolor="F7F7ED">상단 파일경로</td>
                        <td bgcolor="F7F7F7"><input name="setheadfile" type="text" class="input" id="setheadfile" value="<%=setheadfile%>" size="60">
                          <br>
                          wizboard.asp 로부터 상대경로를 적는다.(예, ./wizboard/html/top.asp)</td>
                      </tr>					  
                      <tr> 
                        <td bgcolor="F7F7ED">하단 내용 </td>
                        <td bgcolor="F7F7F7"><textarea name="setfootmsg" cols="60" rows="8" class="input" id="setfootmsg"><%=setfootmsg%></textarea></td>
                      </tr>
                      <tr> 
                        <td bgcolor="F7F7ED">하단 파일경로</td>
                        <td bgcolor="F7F7F7"><input name="setfootfile" type="text" class="input" id="setfootfile" value="<%=setfootfile%>" size="60"></td>
                      </tr>	
                      <tr> 
                        <td bgcolor="F7F7ED">몰인클루드</td>
                        <td bgcolor="F7F7F7"><input type="checkbox" name="setmallinclude" value="1" <% IF setmallinclude = 1 then Response.Write "checked" %>>
                          (책크시 쇼핑몰 레이아웃이 삽입됩니다.) </td>
                      </tr>						  				  
                    </table></td>
                </tr>
              </table></td>
          </tr>
          <tr> 
            <td height="50" align="center" style="padding:10 15 10 15"><button name="" type="submit" title="수정하기">수정하기</button></td>
          </tr>
        </form>
      </table> </td>
  </tr>
  <tr> 
    <td bgcolor="#FFFFFF">&nbsp; </td>
  </tr>
</table>
</body>
</html>
<%
SET objRs =Nothing : Set db	= Nothing : Set util = Nothing : Set board = Nothing
%>
