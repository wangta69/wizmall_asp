<% Option Explicit %>
<!-- #include file = "../../../lib/cfg.mall.asp" -->
<%
''Dim qry
Dim subject, content
Set util	= new utility : Set db	= new database
''등록된 게시물을 불러온다
Dim w_id,w_name, w_pass,w_subject
Dim w_content,w_op_flag,w_count,w_reccount,w_replecount,w_filename
Dim w_filesize,w_filedown,w_ip,w_moddate,w_regdate
Dim op_flag_value, i, option_html, option_secret, option_notice, filenameArr, attached_file
Dim qnaParamInfo(1)
uid	= Request("uid")
no	= Request("no")		
qry	= Request("qry")
If qry = "qna_up" Then
''등록된 게시물, 게시물 보기 카운트올리기, 이전, 다음 항목 가져오기 프로시저
	qnaParamInfo(0) = db.MakeParam("@smode", adVarChar, adParamInput,30, "")
	qnaParamInfo(1) = db.MakeParam("@uid", adInteger, adParamInput,11, uid)


	Set objRs	= db.ExecSPReturnRS("usp_product_qna_view", qnaParamInfo, DbConnect)




	w_id			= objRs("id")
	w_name			= objRs("name")
	w_subject		= objRs("subject")
	w_content		= objRs("content")
	w_op_flag		= objRs("op_flag")
	w_count			= objRs("count")
	w_reccount		= objRs("reccount")
	w_replecount	= objRs("replecount")
	w_filename		= objRs("filename")
	w_ip			= objRs("ip")
	''w_moddate		= objRs("moddate")
	w_regdate		= objRs("regdate")

	if IsNull(w_op_flag) = false then 
		op_flag_value	= SPLIT(w_op_flag, "|")
		for i=0 to UBound(op_flag_value)
			if i = 0 then option_html	= op_flag_value(0)
			if i = 1 then option_secret	= op_flag_value(1)
			if i = 2 then option_notice	= op_flag_value(2)
		next
	end if
	If option_secret = "" Then option_secret = 0

	if IsNull(w_filename) = True then w_filename = "|" ''에러방지용으로 처리
	filenameArr		= SPLIT(w_filename, "|")
	for i=0 to ubound(filenameArr)
		''attached_file(i) =  filenameArr(i)
	next

	w_content = util.ReplaceHtmlText(option_html, w_content)
	Set objRs = Nothing
ElseIf qry = "qna_reply" Then
''등록된 게시물, 게시물 보기 카운트올리기, 이전, 다음 항목 가져오기 프로시저
	
	''qnaParamInfo(0) = db.MakeParam("@smode", adVarChar, adParamInput,30, "")
	''qnaParamInfo(1) = db.MakeParam("@uid", adInteger, adParamInput,11, uid)


	''Set objRs	= db.ExecSPReturnRS("usp_product_qna_view", qnaParamInfo, DbConnect)


	strSQL = "select subject, content from wizmall_product_qna where uid=" & uid
	Set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	w_subject	= objRs("subject")
	w_content	= objRs("content")
	w_subject 	= "Re : " & util.ReplaceHtmlText("0", w_subject)
	w_content	= util.ReplaceHtmlText("1", w_content)
	w_content	= Chr(13)&Chr(10)&Chr(13)&Chr(10)&Chr(13)&Chr(10)&Chr(13)&Chr(10)&Chr(13)&Chr(10)&_
					"------------ [Original Message] --------------------------"&Chr(13)&Chr(10)&"&gt;&gt;"&_
					w_content
Else
	qry = "qna_in"
End If
%>


<script  language="javascript" src="/js/jquery.plugins/jquery.validator-1.0.1.js"></script>
<script  language="javascript" src="/js/jquery.plugins/jquery.form.js"></script>
<script language="JavaScript">
<!--
$(function(){
 var options = { 
        beforeSubmit:  showRequest,  // pre-submit callback 
        success:       showResponse  // post-submit callback 
    }; 
   $('#reviewWrtieFrm').ajaxForm(options); 
});

function showRequest(formData, jqForm, options) { 

	if($('#reviewWrtieFrm').formvalidate()){
		return true;
	}else
		return false; 

} 
 
// post-submit callback 
function showResponse(responseText, statusText, xhr, $form)  { 
	loadQnaHTML(1);
	$("#review_subject").val("");
	$("#review_content").val("");
} 


//-->
</script>
<form name="reviewWrtieFrm" id="reviewWrtieFrm" action="/skinwiz/viewer/viewer.proc.asp" method="post" enctype="multipart/form-data"><!-- -->
  <input type="hidden" name="qry" value="<%=qry%>">
  <input type="hidden" name="code" value="<%=code%>">
  <input type="hidden" name="pid" value="<%=no%>">
  <input type="hidden" name="uid" value="<%=uid%>">
  
      <input type="hidden" name="userid" value="<%=user_id%>" class="required" msg="로그인후 이용해 주세요">
	  <input type="hidden" name="name" value="<%=user_name%>"> 
      <input type="hidden" id="spamfree" name="spamfree" value=""> 
	  <input type="hidden" id="hidden_tmp_spamfree" value="<%=util.Linuxtime%>"> 
  <table class="table_main w_default">
  <col width="100px" />
  <col width="*" />
    <!--<tr>
      <th>작성자</th>
      <td><input name="name" type="text" class="required" id="name" size="10" msg="이름을 입력하세요" /></td>
    </tr> -->
   <tr>
      <th>제목</th>
      <td><input name="subject" type="text" class="required" id="review_subject" value="<%=w_subject%>"  msg="제목을 입력하세요"></td>
    </tr>
    <tr>
      <th>내용</th>
      <td colspan="3"><textarea name="content" rows="3" id="review_content" class="required w100p" msg="상품후기를 입력해 주세요"><%=w_content%></textarea></td>
    </tr>
  </table>
  <div class="w_default agn_c">
<button type="submit" name="submitButton" value="Submit5"><span>쓰기</span></button>
</div>
  <!--<div class="w_default agn_c"> <span class="button bull btn_review_save"><a>쓰기</a></span>-->
    <!-- <span class="button bull"><a>닫기</a></span>-->
  </div>
</form>