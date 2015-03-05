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
''2006-12-10 : 시험판 인스톨형 제작

Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

query = Request("query")
uid = Request("uid")
page = Request("page")
theme = Request("theme")
menushow = Request("menushow")


'CREATE TABLE [dbo].[sendmail] (
'	[uid] [int] IDENTITY (1, 1) NOT NULL ,
'	[subject] [varchar] (200) COLLATE Korean_Wansung_CI_AS NULL ,
'	[content] [text] COLLATE Korean_Wansung_CI_AS NOT NULL ,
'	[flag] [varchar] (2) COLLATE Korean_Wansung_CI_AS NULL ,
'	[total] [int] NOT NULL ,
'	[wdate] [smalldatetime] NULL 
') ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
'GO


'CREATE TABLE [dbo].[sendmailcount] (
'	[mid] [int] NOT NULL ,
'	[email] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
'	[flag] [varchar] (2) COLLATE Korean_Wansung_CI_AS NULL ,
'	[wdate] [smalldatetime] NULL 
')
'GO


if query = "qde" then

	strSQL="DELETE FROM sendmail WHERE uid="&uid
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	
	strSQL="DELETE FROM sendmailcount WHERE mid="&uid
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	
	response.Write "<script>alert('삭제했습니다.');opener.location.replace('./main.asp?menushow="&menushow&"&theme=email_send_list&page=&page&');self.close();</script>"

	Response.End()
end if
%>

<head><title>글 삭제</title>
<body>
<center>


  <table border=0 style=font-family:'굴림';font-size:12px;line-height:20px;color:#333333>
    <form name=xx action="email_send_del.asp" method=post>
      <input type='hidden' name='query' value='qde'>
      <input type='hidden' name='UID' value='<%=UID%>'>
      <input type='hidden' name='page' value='<%=page%>'>
	  <input type='hidden' name='theme' value='<%=theme%>'>
	  <input type='hidden' name='menushow' value='<%=menushow%>'>
      <tr> 

        <td colspan="2" bgcolor="#EEF7FF" height="25" align="center"> 

          <p>삭제된 데이트는 복구되지 않습니다. </p>

          <p>삭제하시겠습니까?</p>

        </td>

      </tr>

      <tr> 

        <td colspan="2" align="center" bgcolor="#EEF7FF" height="25">

          <input type="submit" value="예" name="Submit">

          <input type="button" value="아니요" onClick="window.close()" name="button">

        </td>

      </tr>

    </form>

  </table>







  </center>		
