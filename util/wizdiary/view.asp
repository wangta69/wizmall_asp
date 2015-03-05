<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.board.asp" -->

<%
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

page		= Request("page")
F_Year		= Request("F_Year")
F_Month		= Request("F_Month")
F_Day		= Request("F_Day")
cc_id		= Request("cc_id")
menushow	= Request("menushow")
theme		= Request("theme")

'count 수를 올린다.
strSQL = "update wizDiary set cc_count = cc_count + 1 where cc_id = "&cc_id
Call db.ExecSQL(strSQL, Nothing, DbConnect)

strSQL = "select * from wizDiary where cc_id = "&cc_id
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
cc_sdate = objRs("cc_sdate")
cc_title = objRs("cc_title")
cc_m_name = objRs("cc_m_name")
cc_count = objRs("cc_count")
'cc_desc = objRs("cc_desc")
cc_desc = util.ReplaceHtmlText(0, objRs("cc_desc"))
tmpdate = split(cc_sdate, "-")
F_Year = tmpdate(0)
F_Month = tmpdate(1)
F_Day = tmpdate(2)
%>
<html>
<head>
<title>다이어리</title>
<link href="/lib/css.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="./css.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
</head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" valign="top"><!-- ##################일정등록달력 view 테이블시작입니다##########################-->
      <table width="100%" height="63" border="0" cellpadding="0" cellspacing="1" bgcolor="D7D7D7">
        <tr>
          <td height="30" bgcolor="#F3F3F3"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s1">
              <tr>
                <td align="center" valign="bottom" class="font1"><%=cc_title%></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td height="30" bgcolor="#F3F3F3"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s1">
              <tr>
                <td width="43" align="center" valign="bottom" class="font1">성명</td>
                <td width="15" align="left"><img src="../../webadmin/image/board/bar_1.gif" width="1" height="15"><img src="../../webadmin/image/board/bar_1.gif" width="2" height="15"></td>
                <td align="left" valign="bottom"><%=cc_m_name%></td>
                <td width="52" align="center" valign="bottom" class="font1">일정</td>
                <td width="15" align="left"><img src="../../webadmin/image/board/bar_1.gif" width="1" height="15"><img src="../../webadmin/image/board/bar_1.gif" width="2" height="15"></td>
                <td align="left" valign="bottom" ><%=cc_sdate%></td>
                <td width="52" align="center" valign="bottom"  class="font1">조회수</td>
                <td align="left"><img src="../../webadmin/image/board/bar_1.gif" width="1" height="15"><img src="../../webadmin/image/board/bar_1.gif" width="2" height="15"></td>
                <td width="26" align="left" valign="bottom"><%=cc_count%></td>
              </tr>
            </table></td>
        </tr>
      </table>
      <table width="100%" border="0" cellpadding="0" cellspacing="10" class="s1">
        <tr>
          <td align="left" style="padding:10px"><%=cc_desc%> </td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="10"></td>
        </tr>
        <tr>
          <td height="1" bgcolor="D7D7D7"></td>
        </tr>
        <tr>
          <td height="40" align="right"><table border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><a href="index.asp?page=<%=page%>&F_Year=<%=F_Year%>&F_Month=<%=F_Month%>&F_Day=<%=F_Day%>"><img src="images/list_btn.gif" width="60" height="18" border="0" /></a></td>
              </tr>
            </table></td>
        </tr>
      </table>
      <!--##################일정등록달력 view 테이블끝입니다##########################-->
    </td>
  </tr>
</table>
</body>
</html>
