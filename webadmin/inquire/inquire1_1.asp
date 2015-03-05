<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
Dim uid,theme,menushow,page,iid

Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

uid			= Request("uid")
theme		= Request("theme")
menushow	= Request("menushow")
page		= Request("page")
iid			= Request("iid")

Dim compname,name,juminno,tel,hand,fax,email,url,zip,address1,address2,subject,contents,contents1,contents2,option1,option2,option3,attached,attachedArr,attachedArrLen,wdate

strSQL = "select * from wizInquire where uid='"&uid&"'"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
iid				= objRs("iid")
compname		= objRs("compname")
name			= objRs("name")
juminno			= objRs("juminno")
tel				= objRs("tel")
hand			= objRs("hand")
fax				= objRs("fax")
email			= objRs("email")
url				= objRs("url")
zip				= objRs("zip")
address1		= objRs("address1")
address2		= objRs("address2")
subject			= objRs("subject")
contents		= objRs("contents")
contents		= util.ReplaceHtmlText(0, contents)
contents1		= objRs("contents1")
contents2		= objRs("contents2")
option1			= objRs("option1")
option2			= objRs("option2")
option3			= objRs("option3")
attached		= objRs("attached")
attachedArr		= SPLIT(attached, "|")
attachedArrLen	= ubound(attachedArr)
wdate			= objRs("wdate")
%>
<script language="JavaScript">
<!--
function DELETE_THIS(uid,page,IID,theme, menushow){
	window.open("./inquire/inquire_del.asp?uid="+uid+"&page="+page+"&IID="+IID+"&theme="+theme+"&menushow="+menushow,"","scrollbars=no, toolbar=no, width=340, height=150, top=220, left=350")
}
function down(filename, iid){
	file_url = "./inquire/inquire_down.asp?filename="+filename+"&IID="+iid
	location.href=file_url
}

function sendmail(email){
	location.href = "main.asp?menushow=<%=menushow%>&theme=mail/mailer1one&testMailAddress="+email
}
//-->
</script>
<table  class="table_outline">
  <tr>
    <td>

<fieldset class="desc">
        <legend>견적요청 관리</legend>
        <div class="notice">[note]</div>
        <div class="comment">견적요청된 내용입니다.<br />
                  클릭하시면 상세내용을 보실 수 있습니다.</div>
      </fieldset>
      <p></p>

       <table class="table_main w_default">
	  <col width="120px" />
	   <col width="*" />

		  <tr> 
			<th>이름</th>
			<td> <%=objRs("name")%></td>
		  </tr>
		  <tr> 
			<th>이메일</th>
			<td> <a href="javascript:sendmail('<%=objRs("email")%>')"><%=objRs("email")%></a></td>
		  </tr>
		  <tr> 
			<th>연락처</th>
			<td> <%=objRs("tel")%> </td>
		  </tr>
		  <tr> 
			<td colspan="2"><%=contents%></td>
		  </tr>
		  <tr> 
			<th>첨부화일</th>
			<td> <% if ubound(attachedArr) > 0 then
							  Response.Write("<a href=""javascript:down('"&attachedArr(0)&"', '"&objRs("iid")&"')"">"&attachedArr(0)&"</a>")
							  end if
							  %></td>
		  </tr>
                 
      </table>
	<div class="agn_c w_default">
		<input type="button" name="Button" value="삭 제" onClick="javascript:DELETE_THIS('<%=uid%>','<%=page%>','<%=iid%>','<%=theme%>','<%=menushow%>')">
            &nbsp; 
		<input type="button" name="Submit2" value="목 록" onClick="javascript:location.replace('./main.asp?menushow=<%=menushow%>&theme=inquire/inquire1&page=<%=page%>&iid=<%=iid%>')">
	</div>
                  
                  
                </td>
              </tr>
            </table>
