<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
''powered by 폰돌
''Reference URL : http://www.shop-wiz.com
''Contact Email : master@shop-wiz.com
''Free Distributer : 
''Copyright shop-wiz.com
''UPDATE HISTORY

Dim uid,theme,menushow,qry,page,searchField,searchKeyword
Dim sendername,senderemail,reply,subject,contenttype,mailskin,body_txt,userfile,addsource
Dim soption,mailreject,startseq,stopseq,genderselect,gradeselect,testmailaddress,usermaillist,sdate
Dim strSQL,objRs
Dim db,util
Set util = new utility : Set db = new database

uid				= Request("uid")
theme			= Request("theme")
menushow		= Request("menushow")
qry				= Request("qry")
page			= Request("page")
searchField		= Request("searchField")
searchKeyword	= Request("searchKeyword")

strSQL = "select * from wizSendmaillist where uid = '" & uid & "'"
Set objRs = db.ExecSQLReturnRS(strSQL, null, DbConnect)
''uid				= objRs("uid")		
sendername		= objRs("sendername")
senderemail		= objRs("senderemail")
reply			= objRs("reply")
subject			= objRs("subject")
contenttype		= objRs("contenttype")
mailskin		= objRs("mailskin")
body_txt		= objRs("body_txt")
userfile		= objRs("userfile")
addsource		= objRs("addsource")
soption			= objRs("soption")
mailreject		= objRs("mailreject")
startseq		= objRs("startseq")
stopseq			= objRs("stopseq")
genderselect	= objRs("genderselect")
gradeselect		= objRs("gradeselect")
testmailaddress	= objRs("testmailaddress")
usermaillist	= objRs("usermaillist")
sdate			= objRs("sdate")

%>

<table class="table_outline">
  <tr>
    <td><table class="table_main w_default">
        <tr>
          <td><font color="#FF6600">메일발송내용</b></td>
        </tr>
        <tr>
          <td><table cellspacing=0 cellpadding=0 width="100%" border=0>
              <tr>
                <td align=center width=57 valign="top"><font 
                              color=#ff6600>[note] </td>
                <td width="697">발송되었던 메일 내용입니다.</td>
              </tr>
            </table></td>
        </tr>
      </table>
      <br />
      <table cellspacing=1 bordercolordark=white width="760" bgcolor=#c0c0c0 bordercolorlight=#dddddd 
border=0 cellpadding="5">
        <tr>
          <td width="100" align=middle bgcolor=E6E9EA>보내는 분</td>
          <td align=left><%=sendername%>&lt;<%=senderemail%>&gt;</td>
        </tr>
        <tr>
          <td align=middle bgcolor=E6E9EA>제목</td>
          <td align=left><%=subject%> </td>
        </tr>
        <tr>
          <td align=middle bgcolor=E6E9EA>내 용</td>
          <td align=left><%=body_txt%> </td>
        </tr>
      </table></td>
  </tr>
</table>
