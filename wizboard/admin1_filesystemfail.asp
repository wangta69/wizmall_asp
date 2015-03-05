<% Option Explicit %>
<!-- #include file = "../lib/cfg.common.asp" -->
<!-- #include file = "../config/db_connect.asp" -->
<!-- #include file = "./func/func_admin.asp" -->
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
%>
<%
	
	Dim query, TableTop, TableBottom, BOARD_SKIN_TYPE, TABLE_WIDTH, TABLE_WIDTH_NO, TABLE_WIDTH_UNIT,TABLE_ALIGN, path, totalpath
	strBoardID = REQUEST("strBoardID")
	strGroupName = REQUEST("strGroupName")
	query = REQUEST("query")
	strPath = Server.MapPath("..") & "\"
	totalpath = strPath & "\config\wizboard_group\" & strGroupName & "\" & strBoardID

	IF SESSION("admin") <> "super" THEN
		RESPONSE.WRITE DisplayJavaAlert("접근 권한이 없습니다.", 1)
		RESPONSE.END
	END IF

	IF query = "qup" THEN
		TableTop           = REQUEST("TableTop")
		TableBottom        = REQUEST("TableBottom")
		TABLE_WIDTH_NO        = REQUEST("TABLE_WIDTH_NO")
		TABLE_WIDTH_UNIT        = REQUEST("TABLE_WIDTH_UNIT")
		TABLE_ALIGN        = REQUEST("TABLE_ALIGN")
		BOARD_SKIN_TYPE        = REQUEST("BOARD_SKIN_TYPE")
		'BOARD_SKIN_TYPE
		'TABLE_ALIGN
		TABLE_WIDTH = TABLE_WIDTH_NO & TABLE_WIDTH_UNIT
		newstr = "<%" & vbCrLf
		newstr = newstr & "BOARD_SKIN_TYPE = """ & BOARD_SKIN_TYPE & """" & vbCrLf
		newstr = newstr & "TABLE_ALIGN = """ & TABLE_ALIGN & """" & vbCrLf
		newstr = newstr & "TABLE_WIDTH = """ & TABLE_WIDTH & """" & vbCrLf
		newstr = newstr & CHR(37 ) & ">"
		
		path = totalpath  & "\config1.asp"
		CALL FileMakeTxt(path, newstr)
		
		path = totalpath  & "\top.asp"
		CALL FileMakeTxt(path, TableTop)
		
		path = totalpath  & "\bottom.asp"
		CALL FileMakeTxt(path, TableBottom)
		
		RESPONSE.WRITE htmlFromSubmit("저장되었습니다.", "admin1.asp?strBoardID=" & strBoardID & "&strGroupName=" & strGroupName)
	END IF
	
'	  출력할 내용을 가져온다	
		'strSQL = "select setSkin, setHeadMsg, setFootMsg from wiztable_board_config where strBoardID = '" & strBoardId & "' and strGroupName = '" & strGroupName & "'"
		'Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		'setSkin                 = objRs("setSkin")
		'setHeadMsg              = objRs("setHeadMsg")
		'setFootMsg              = objRs("setFootMsg")
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
  <tr> 
    <td bgcolor="#FFFFFF"><font color="#FF6600"><strong>아이디&nbsp; : <%=strBoardID%> &nbsp;&nbsp;&nbsp;그룹명 : <%=strGroupName%> </strong> </font></td>
  </tr>
</table>
<table cellspacing=0 bordercolordark=white width="607" align="center" bgcolor=#c0c0c0 bordercolorlight=#dddddd border=1 class="s1">
  <tr> 
    <td> <table width="600" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="12" bgcolor="#B9C2CC"><a href="./admin1.asp?strBoardID=<%=strBoardID%>&strGroupName=<%=strGroupName%>"><font color="#FFFF00">&nbsp;LayOut</font></a> 
            | <a href="./admin2.asp?strBoardID=<%=strBoardID%>&strGroupName=<%=strGroupName%>"><font color="#FFFFFF">제한설정</font></a> 
            | <a href="./admin3.asp?strBoardID=<%=strBoardID%>&strGroupName=<%=strGroupName%>"><font color="#FFFFFF">기능설정</font></a> 
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
            <td align="right" style="padding:5 15 0 0"> <input type="hidden" name="strBoardID" value="<%=strBoardID%>"> 
              <input type="hidden" name="strGroupName" value="<%=strGroupName%>"> 
              <input type="hidden" name="query" value="qup"></td>
          </tr>
          <tr> 
            <td style="padding:10 15 10 15"><table cellspacing=0 bordercolordark=white width="100%" align="center" bgcolor=#c0c0c0 bordercolorlight=#dddddd border=1 class="s1">
                <tr> 
                  <td height="25" bgcolor="#FFFFFF"> 게시판 출력관련 설정</td>
                </tr>
              </table>
              <table cellspacing=0 bordercolordark=white width="100%" align="center" bgcolor=#c0c0c0 bordercolorlight=#dddddd border=1 class="s1">
                <tr> 
                  <td width="120" bgcolor="E0E4E8">스킨 선택</td>
                  <td bgcolor="F7F7F7"> <select name="BOARD_SKIN_TYPE" id="BOARD_SKIN_TYPE" style="font-size:9pt; width:170;">
                            <%=util.ShowFolderList(PATH_SYSTEM & "wizboard\skin",BOARD_SKIN_TYPE)%> 
                          </select></td>
                </tr>
                <tr> 
                  <td width="120" bgcolor="E0E4E8">테이블폭</td>
                  <td bgcolor="F7F7F7">               <input type="text" name="TABLE_WIDTH_NO" value="<%=replace(TABLE_WIDTH, "%","")%>" size="5" maxlength="5">
              <select name="TABLE_WIDTH_UNIT">
                <option value="%">%</option>
                <option value="">pixels</option>
              </select></td>
                </tr>
                <tr> 
                  <td width="120" bgcolor="E0E4E8">테이블정렬</td>
                  <td bgcolor="F7F7F7">               <select name="TABLE_ALIGN">
                <option value="default">Default</option>
                <option value="left">Left</option>
                <option value="right">Right</option>
                <option value="center">Center</option>
              </select></td>
                </tr>								
                <tr> 
                  <td bgcolor="E0E4E8">상단 내용</td>
                  <td bgcolor="F7F7F7"><textarea name="TableTop" cols="60" rows="8" class="input" id="TableTop"><% response.Write(util.FileReadTxt(totalpath & "\top.asp")) %></textarea></td>
                </tr>
                <tr> 
                  <td bgcolor="E0E4E8">하단 내용 </td>
                  <td bgcolor="F7F7F7"><textarea name="TableBottom" cols="60" rows="8" class="input" id="TableBottom"><% response.Write(util.FileReadTxt(totalpath & "\bottom.asp")) %></textarea></td>
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
