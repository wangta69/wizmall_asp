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
''*** Updating List ***

Dim theme, menushow, qry, uid
theme		= Request("theme")
menushow	= Request("menushow")
qry			= Request("qry")
uid			= Request("uid")


Dim pid,c_name,c_subject,c_comment,c_grade, c_wdate,pname,p_picture, p_picture_2
	
Dim strSQL, objRs, params, whereis, joinon, sqlcountstr, counting
Dim setPageSize, setPageLink, page, realtotal, TotalCount, TotalPage, LoopNum, ListNum,IntStart, IntEnd, addstr, TMPSPLIT
Dim searchField,searchKeyword, Loopcnt
Dim db, util
Set db		= new database
Set util	= new utility

if	page = "" or page <= 0 then  page = 1
setPageSize		= 10
setPageLink		= 10

if qry = "deleteComment" then 
	strSQL = "delete FROM wizmall_comment where uid=" & uid
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	Call util.js_alert("정상적으로 삭제되었습니다.","main.asp?theme=" & theme & "&menushow=" & menushow)
end if
%>
<script language="JavaScript">
<!--
function confirm_del(uid){
	if(confirm('정말로 삭제하시겠습니까?')){
		location.href = 'main.asp?theme=<%=theme%>&menushow=<%=menushow%>&qry=deleteComment&uid='+uid;
	}
	else return false;
}
//-->
</script>

<table class="table_outline">
  <tr>
    <td>
	
	
<fieldset class="desc">
<legend>상품평관리</legend>
<div class="notice">[note]</div>
<div class="comment">제품당 달려있는 상품평을 일목요연하게 관리할 수 있습니다. </div>
</fieldset>
<div class="space20"></div>

      <table class="table_main w_default">
		<col width="100px" />
		<col width="*" />
		<col width="70px" />
		<col width="70px" />
        <%
''whereis		= "WHERE uid <> ''"
''if category then  whereis = "WHERE and BID = 'category'"
''if SEARCHTITLE and searchkeyword then  whereis = "WHERE and SEARCHTITLE LIKE '%searchkeyword%'"

'' 총 갯수 구하기
strSQL		= "SELECT count(uid) FROM wizmall_comment " & whereis
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
TotalCount	= objRs(0)

TotalPage = TotalCount / setPageSize
IF (TotalPage - (TotalCount \ setPageSize)) > 0 then
	TotalPage = int(TotalPage) + 1
Else
	TotalPage = int(TotalPage)
End if


ListNum = INT(TotalCount)-(INT(setPageSize)*(INT(page)-1))
strSQL	=" SELECT TOP " & setPageSize & " c.uid, c.pid, c.c_name, c.c_subject, c.c_comment, c.c_grade, c.c_wdate, m.picture, m.pname " &_
		" FROM wizmall_comment c  " &_
		" left join wizmall m  on m.uid = c.pid " &_
		" where c.uid not in  (SELECT TOP " & ((page - 1) * setPageSize) & " c.uid from wizmall_comment c order by c.c_wdate desc) " &_
		" ORDER BY c.c_wdate desc"
%>
        <tr align="center">
          <th>상품</th>
          <th>멘트</th>
          <th>평점</th>
          <th>삭제</th>
        </tr>
        <%
Set objRs = db.ExecSQLReturnRS(strSQL, params, DbConnect)
If objRs.BOF or objRs.EOF Then
%>
        <tr>
          <td colspan="4"> 등록된 상품평이 없습니다.</td>
        </tr>
        <%
Else
	Do Until objRs.EOF
	uid			= objRs("uid")
	pid			= objRs("pid")
	c_name		= objRs("c_name")
	c_subject	= objRs("c_subject")
	c_comment	= objRs("c_comment")
	c_wdate		= objRs("c_wdate")
	c_grade		= objRs("c_grade")
	pname		= objRs("pname")
	If Not IsNull(objRs("picture")) Then
		p_picture 	= split(objRs("picture"),"|")
		if Ubound(p_picture) > 1 Then p_picture_2 = p_picture(2)
	End If
	
	'If IsNull(objRs("picture")) Then
	'Else
		'p_picture 	= split(objRs("picture"),"|")
		'if Ubound(p_picture) > 1 Then p_picture_2 = p_picture(2)
	'End if
%>
        <tr>
          <td><img src="../config/wizstock/<%=p_picture_2%>" width="50" height="50"><br /><%=pname%></td>
          <td><%=c_subject%><br />
            &nbsp;<%=c_comment%></td>
          <td align="center"><%=c_grade%></td>
          <td align="center"><a href="javascript:confirm_del('<%=uid%>')">삭제</a></td>
        </tr>
        <%
		  	ListNum = ListNum - 1
            objRs.MoveNext
        Loop
    End If

    
%>
    </table>
	
	<div class="agn_c w_default">
		<%
		Dim preimg : preimg = "img/pre.gif"
		Dim nextimg : nextimg = "img/next.gif"	
		Dim design
		Dim linkurl : linkurl = "main.asp?menushow="&menushow&"&theme="&theme
		Call util.paging (page,setPageSize,setPageLink,TotalCount,linkurl,design)
		Set objRs = Nothing : db.Dispose : Set db = nothing : Set util = Nothing
		%>
	</div>
	
	</td>
  </tr>
</table>