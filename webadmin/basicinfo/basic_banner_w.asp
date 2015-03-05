<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/admin_info.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/cfg.array.asp" -->
<%
Dim uid, flag1, ordernum, subject, url, target, attached, showflag, wdate, smode
Dim menushow, theme
Dim LoopCount
Dim strSQL,objRs
Dim db,util

Set util = new utility	
Set db = new database


menushow	= Request("menushow")
theme		= Request("theme")
uid			= Request("uid")
flag1		= Request("flag1")

if uid <> "" then 
	strSQL = "select * from wizbanner where uid = " & uid 
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	uid			= objRs("uid")
	flag1		= objRs("flag1")
	ordernum	= objRs("ordernum")
	subject		= objRs("subject")
	url			= objRs("url")
	target		= objRs("target")
	attached	= objRs("attached")
	showflag	= objRs("showflag")
	wdate		= objRs("wdate")
	smode		= "qup"
else
	smode		= "qin"
end if
%>
<script language="javascript">
<!--
function check_field(){
	var f = document.forms.BrdList;
}
//-->
</script>
<table class="table_outline">
  <tr>
    <td valign="top"><fieldset class="desc">
						<legend>베너관리</legend>
						<div class="notice">[note]</div>
						<div class="comment"> order가 작은 순서가 상위에 위치합니다. </div>
						</fieldset>
						<p></p>        <form action="./basicinfo/basic_banner_qry.asp?smode=<%=smode%>" enctype="multipart/form-data" Name="BrdList" method="post" onsubmit='return check_field()'>
					    <table class="table_main w_default">
				<col width="150px" />
				<col width="*" />
          <input type='hidden' name='menushow' value='<%=menushow%>'>
          <input type="hidden" name="theme" value="<%=theme%>">
          <input type="hidden" name="uid" value="<%=uid%>">
		  <input type="hidden" name="flag1" value="<%=flag1%>">
          <tr> 
            <th>우선순위</th>
            <td><input name="ordernum" type="text" size="3" value="<%=ordernum%>"></td>
          </tr>
          <tr> 
            <th>URL </th>
            <td><input name="url" type="text" size="30" value="<%=url%>"> 
            </td>
          </tr>
          <tr> 
            <th>target </th>
            <td><select name="target" id="target">
              <option value="_self"<% if target = "_self" Then Response.Write(" selected='selected''") %>>_self</option>
              <option value="_blank"<% if target = "_blank" Then Response.Write(" selected='selected''") %>>_blank</option>
            </select>
            </td>
          </tr>          
          <tr> 
            <th>첨부화일</th>
            <td><input type="file" name="attached"></td>
          </tr>
          <tr> 
            <td colspan="2" align="center"><input type="image" src="img/dung.gif" width="55" height="20" border="0" align="absmiddle"></td>
          </tr>
      
      </table>  </form></td>
  </tr>
</table>