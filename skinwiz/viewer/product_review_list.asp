<% Option Explicit %>
<!-- #include file = "../../../lib/cfg.mall.asp" -->
<script language="javascript">
$(function(){
	$(".btn_del").click(function(){
		var i	= $(".btn_del").index(this);
		var uid	= $(".btn_del").eq(i).attr("uid");
		$.post("./skinwiz/viewer/viewer.proc.del.asp", {qry:"review_del", uid:uid}, function(){
			loadReviewHTML();
		});
	});
	
});
</script>
<table class="table_main w_default">
  <tr>
    <th>작성자</th>
    <th>사용후기</th>
    <th>평점</th>
  </tr>
  <% 
Set db	= new database	  
Dim c_uid,c_name,c_id,c_coment,c_subject,c_grade
strSQL = "select * from wizmall_comment where pid = '" & no & "' ORDER BY c_wdate desc"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
if objRs.EOF then
%>
  <tr>
    <td colspan="3"><div class="agn_c">등록된 품평이 없습니다.</div></td>
  </tr>
  <%
else WHILE NOT objRs.EOF
c_uid		= objRs("uid")
c_name		= objRs("c_name")
c_id		= objRs("c_id")
c_coment	= objRs("c_comment")
c_subject	= objRs("c_subject")
c_grade		= objRs("c_grade")
%>
  <tr>

    <td><%=c_name%>

      <% if user_id = c_id then%>
       <a class="hand btn_del" uid="<%=c_uid%>">x</a>
      <% end if%></td>
    <td><%=c_coment%></td>
    <td><img src="./skinwiz/viewer/<%=ViewerSkin%>/images/star<%=c_grade%>.gif"></td>
  </tr>
  <%
	objRs.MOVENEXT
	WEND
end if
%>

</table>
<%
db.dispose : Set db = Nothing : Set util = Nothing : Set mall = Nothing
%>
