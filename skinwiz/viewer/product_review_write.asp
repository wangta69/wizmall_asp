<% Option Explicit %>
<!-- #include file = "../../../lib/cfg.mall.asp" -->
<%
''제작자 : 폰돌
''URL : http://www.shop-wiz.com
''Email : master@shop-wiz.com
''*** Updating List ***
Dim pid,c_id,c_name,c_pwd,c_email,c_grade,c_subject,c_comment,c_option
''Dim strSQL,objRs
''Dim db
''Set util = new utility	
Set db = new database
	
If qry = "qin" then
	pid			= Request("pid")
	c_id		= Request("c_id") : If c_id = "" then c_id = user_id
	c_name		= Request("c_name")
	c_pwd		= Request("c_pwd")
	c_email		= Request("c_email")
	c_grade		= Request("c_grade")
	c_subject	= Request("c_subject")
	c_comment	= Request("c_comment")
	c_option	= Request("c_option")
	

	Set db = new database
	Set util = new utility
	
	ReDim paramInfo(10)
	Dim c_ip : c_ip	= Request.Servervariables("REMOTE_ADDR")
	paramInfo(0) = db.MakeParam("@smode", adVarChar, adParamInput,10, smode)
	paramInfo(1) = db.MakeParam("@pid", adInteger, adParamInput,11, pid)
	paramInfo(2) = db.MakeParam("@c_id", adVarChar, adParamInput, 30, c_id)
	paramInfo(3) = db.MakeParam("@c_name", adVarChar, adParamInput,30, c_name)
	paramInfo(4) = db.MakeParam("@c_pwd", adVarChar, adParamInput,30, c_pwd)
	paramInfo(5) = db.MakeParam("@c_email", adVarChar , adParamInput, 50, c_email)
	paramInfo(6) = db.MakeParam("@c_grade", adInteger, adParamInput, 5, c_grade)
	paramInfo(7) = db.MakeParam("@c_subject", adVarChar, adParamInput,200, c_subject)
	paramInfo(8) = db.MakeParam("@c_comment", adVarWChar, adParamInput,2147483647, c_comment)
	paramInfo(9) = db.MakeParam("@c_option", adVarChar, adParamInput,10, c_option)
	paramInfo(10) = db.MakeParam("@c_ip", adVarChar, adParamInput,20, c_ip)
	Call db.ExecSP("usp_pd_comment", paramInfo, DbConnect) 
	Util.arg1 = "reload"
	Call Util.js_alert("고객님의 상품평에 감사드립니다.", "close")
	db.Dispose : Set db = Nothing : Set util = Nothing
end If

''현재 물품을 구매했는지, 상품평을 이미 했는지 체크
Dim comment_status, purchase_statue

strSQL = "select count(*) from wizmall_comment where pid = " & no
SET objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
If objRs(0) <> 0 Then purchase_statue = 1

strSQL = "select count(*) from wizbuyproduct where pcode = " & no
SET objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
If objRs(0) = 0 Then comment_status = 1




%>
<script language="JavaScript">
<!--
$(function(){
	$(".btn_review_save").click(function(){
		if($('#reviewWrtieFrm').formvalidate()){
			$.post("./skinwiz/viewer/sungwonmall/product_review_write.asp", $("#reviewWrtieFrm").serialize(), function(data){
				loadReviewHTML();
			});
		}
	});
});

//-->
</script>
<form name="reviewWrtieFrm" id="reviewWrtieFrm">
  <input type="hidden" name="qry" value="qin">
  <input type="hidden" name="code" value="<%=code%>">
  <input type="hidden" name="pid" value="<%=no%>">
  <input type="hidden" name="c_name" value="<%=user_name%>">
  <input type="hidden" name="c_id" value="<%=user_id%>" class="required" msg="로그인후 이용해 주세요">
  <input type="hidden" name="purchase_statue" value="<%=purchase_statue%>" class="required" msg="상품을 구매후 이용가능합니다.">
  <input type="hidden" name="comment_status" value="<%=comment_status%>" class="required" msg="이미 후기를 남기셨습니다.">
  <table class="table_main w_default">
  <col width="100px" />
  <col width="*" />
    <tr>
     <!-- <th>작성자</th>
      <td><input name="c_name" type="text" class="required" id="c_name" value="<%=user_name%>" size="10" msg="이름을 입력하세요" /></td>-->
      <th>선호도</th>
      <td><input type="radio" name="c_grade"  id="c_grade" value="5" class="required radio_grp" group="radio_grp" msg="선호도를 선택해주세요">
        5
        <input type="radio" name="c_grade" id="c_grade2" class="radio_grp" value="4">
        4
        <input type="radio" name="c_grade" id="c_grade3" class="radio_grp" value="3">
        3
        <input type="radio" name="c_grade" id="c_grade4" class="radio_grp" value="2">
        2
        <input type="radio" name="c_grade" id="c_grade5" class="radio_grp" value="1">
        1</td>
    </tr>
    <tr>
      <th>사용후기</th>
      <td><textarea name="c_comment" rows="3" id="c_comment" class="required w100p" msg="상품후기를 입력해 주세요"></textarea></td>
    </tr>
  </table>
  <div class="w_default agn_c"> <span class="button bull btn_review_save"><a>쓰기</a></span>
    <!-- <span class="button bull"><a>닫기</a></span>-->
  </div>
</form>
