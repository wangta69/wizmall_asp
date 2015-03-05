<% Option Explicit %>
<!-- #include file = "../../../lib/cfg.mall.asp" -->
<%
''Dim no
Dim subject, content
Set util	= new utility : Set db	= new database
''등록된 게시물을 불러온다
Dim v_id,v_name, v_pass,v_subject
Dim v_content,v_op_flag,v_count,v_reccount,v_replecount,v_filename
Dim v_filesize,v_filedown,v_ip,v_moddate,v_regdate
Dim op_flag_value, i, option_html, option_secret, option_notice, filenameArr, attached_file

uid	= Request("uid")
no	= Request("no")		
''등록된 게시물, 게시물 보기 카운트올리기, 이전, 다음 항목 가져오기 프로시저
Dim qnaParamInfo(1)
qnaParamInfo(0) = db.MakeParam("@smode", adVarChar, adParamInput,30, "")
qnaParamInfo(1) = db.MakeParam("@uid", adInteger, adParamInput,11, uid)


Set objRs	= db.ExecSPReturnRS("usp_product_qna_view", qnaParamInfo, DbConnect)




v_id			= objRs("id")
v_name			= objRs("name")
v_subject		= objRs("subject")
v_content		= objRs("content")
v_op_flag		= objRs("op_flag")
v_count			= objRs("count")
v_reccount		= objRs("reccount")
v_replecount	= objRs("replecount")
v_filename		= objRs("filename")
v_ip			= objRs("ip")
''v_moddate		= objRs("moddate")
v_regdate		= objRs("regdate")

if IsNull(v_op_flag) = false then 
	op_flag_value	= SPLIT(v_op_flag, "|")
	for i=0 to UBound(op_flag_value)
		if i = 0 then option_html	= op_flag_value(0)
		if i = 1 then option_secret	= op_flag_value(1)
		if i = 2 then option_notice	= op_flag_value(2)
	next
end if
If option_secret = "" Then option_secret = 0

if IsNull(v_filename) = True then v_filename = "|" ''에러방지용으로 처리
filenameArr		= SPLIT(v_filename, "|")
for i=0 to ubound(filenameArr)
	''attached_file(i) =  filenameArr(i)
next

v_content = util.ReplaceHtmlText(option_html, v_content)
Set objRs = Nothing


%>
<script>
$(function(){
	$(".btn_qna_modify").click(function(){
		$.post("./skinwiz/viewer/sungwonmall/product_qna_write.asp", {no:<%=no%>, qry:"qna_up", uid:<%=uid%>}, function(data){
			//$("#qnaWriteHTML").html("");//현재 쓰기 모드창이 있으면 닫기
			$("#qnaWriteHTML").html(data);//현재viewer창에 쓰기 모드 입히기
		});	
	});
	$(".btn_qna_del").click(function(){
		//alert(<%=uid%>)
		$.post("./skinwiz/viewer/viewer.proc.del.asp", {qry:"qna_del",uid:<%=uid%> }, function(data){
			loadQnaHTML(1)
		});
	});

	$(".btn_qna_reply").click(function(){
		//alert(<%=uid%>);
		$.post("./skinwiz/viewer/sungwonmall/product_qna_write.asp", {no:<%=no%>, qry:"qna_reply", uid:<%=uid%>}, function(data){
			//$("#qnaWriteHTML").html("");//현재 쓰기 모드창이 있으면 닫기
			$("#qnaWriteHTML").html(data);//현재viewer창에 쓰기 모드 입히기
		});	
	});
});
</script>
  <table class="table_main w_default">
  <col width="100px" />
  <col width="*" />
    <!--<tr>
      <th>작성자</th>
      <td><input name="name" type="text" class="required" id="name" size="10" msg="이름을 입력하세요" /></td>
    </tr> -->
   <tr>
      <th>제목</th>
      <td><%=v_subject%></td>
    </tr>
    <tr>
      <th>내용</th>
      <td colspan="3"><%=v_content%></td>
    </tr>
  </table>
  <div class="w_default agn_r">
	  <span class="button bull btn_qna_modify"><a>수정</a></span>
	  <span class="button bull btn_qna_del"><a>삭제</a></span>
	  <span class="button bull btn_qna_reply"><a>답변</a></span>
  </div> 