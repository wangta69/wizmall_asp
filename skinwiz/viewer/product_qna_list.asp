<% Option Explicit %>
<!-- #include file = "../../../lib/cfg.mall.asp" -->
<%
Set db = new database : Set mall = new malls : Set util = new utility
Dim whereis, TotalCount, TotalPage, ListNum

''page	= Request(page)
''Response.Write("page:" & page)
If page = "" Or page < 0 Then page = 1
whereis	= "where pid = " & no
strSQL = "SELECT COUNT(uid) FROM wizmall_product_qna " & whereis & " "
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

'' // 전체 게시물 및 전체 페이지

TotalCount = objRs(0)
TotalPage = TotalCount / setPageSize
IF (TotalPage - (TotalCount \ setPageSize)) > 0 then
	TotalPage = int(TotalPage) + 1
Else
	TotalPage = int(TotalPage)
End If
%>
<script>
$(function(){
	$(".qna_view").click(function(){
		var i = $(".qna_view").index(this);
		var uid	= $(".qna_view").eq(i).parent().attr("uid");
		$(".qnaviewer").hide();
		$(".qnaviewer").html("");
		$.post("./skinwiz/viewer/sungwonmall/product_qna_view.asp", {no:<%=no%>, uid:uid}, function(data){
			
			$(".qnaviewer").eq(i).html(data);
			$(".qnaviewer").show();
		});
	});
});

function postSubmit(page){
	//alert(page)
	loadQnaHTML(page);
}

</script>
<table class="table_main w_default">
<col width="50" title="번호" />
<col width="*" title="제목" />
<col width="100" title="작성자" />
<col width="100" title="작성일" />
<col width="50" title="조회" />
  <tr>
    <th>번호</th>
    <th>제목</th>
    <th>작성자</th>
    <th>작성일</th>
    <th>조회</th>
  </tr>
  <% 
Dim c_uid,c_name,c_id,c_coment,c_subject,c_grade
Call mall.getqnaList(10,whereis ,page,"ORDER BY bd_idx_num desc","*")
ListNum = INT(TotalCount)-(INT(setPageSize)*(INT(page)-1)) 	
if objRs.EOF then
%>	  
  <tr>
    <td colspan="5"><div class="agn_c">등록된 품평이 없습니다.</div></td>
  </tr
<%
else WHILE NOT objRs.EOF

c_uid		= objRs("uid")
c_name		= objRs("name")
c_id		= objRs("id")
c_coment	= objRs("content")
c_subject	= objRs("subject")
%>
  <tr uid="<%=c_uid%>">
    <td><%=ListNum%></td>
    <td class="qna_view"><%=c_subject%></td>
    <td><%=c_name%></td>
    <td><%=FormatDateTime(objRs("regdate"),2)%></td>
    <td><%=objRs("count")%></td>
  </tr>
  <tr><td class="none qnaviewer" colspan="5"></td></tr>
  <%
	''cnt = cnt + 1
	ListNum = ListNum -1
	objRs.MOVENEXT
	WEND
end if	

%>
</table>
<%
Dim preimg : preimg = "img/pre.gif"
Dim nextimg : nextimg = "img/next.gif"	
Dim design
Dim linkurl : linkurl = "main.asp"
Call util.pagingScript (page,setPageSize,setPageLink,TotalCount,"postSubmit")
%>
<%
db.Dispose : Set db	= Nothing : Set objRs = Nothing : Set util = Nothing
%>