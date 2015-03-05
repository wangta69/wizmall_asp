<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->

<!-- #include file = "../../config/skin_info.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../config/membercheck_info.asp" -->
<%
Dim util
Set util = new utility	
%>

<script language="javascript">
<!--
$(function(){
	$("#select_all").click(function(){
		$('input[id="chk_List"]').attr("checked", ( $(this).is(':checked') ? 'checked' : ''));                                                     
	});  
	
	$("#btn_join_next").click(function(){
		if($("#chk_List1").is(":checked") == false){
			alert("이용약관에 동의해 주세요");
		}else if($("#chk_List2").is(":checked") == false){
			alert("회원약관에 동의해 주세요");			
		}else if($("#chk_List3").is(":checked") == false){
			alert("개인정보보호정책에 동의해 주세요");
		}else $("#agreeform").submit();
	});
});

function checkForm(f){
	if(f.agree.checked == false){
		alert('약관에 동의하셔야 회원가입단계로 진행됩니다.');
		return false;	
	}else return true;

}
//function checkForm(f){//라디오버튼 처리시
//	if(f.agree[0].checked == false){
//		alert('약관에 동의하셔야 회원가입단계로 진행됩니다.');
//		return false;	
//	}else return true;
//}
//-->
</script>
<style type="text/css">
<!--
.style1 {color: #666666}
.textboxstyle {font: 9pt 굴림; border:1 solid #cccccc}
-->
</style>
<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
  <tr> 
    <td> <table width="100%" height="18" border="0" cellpasdding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%"> 
        <tr bgcolor="#F6F6F6"> 
          <td width="15" height="22">&nbsp;</td> 
          <td width="18" height="22" valign="middle"><img src="wizmember/<%=MemberSkin%>/images/sn_arrow.gif" width="13" height="13"></td> 
          <td height="22">Home &gt; <strong>회원가입</strong></td> 
        </tr> 
      </table></td> 
  </tr> 
  <tr> 
    <td align="center"> <br> </td> 
  </tr> 
  <tr> 
    <td align="center"> <table width="95%" border="0" cellspacing="0" cellpadding="5" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%"> 
        <tr> 
          <td bgcolor="#EEEEEE">- 약관을 자세히 읽어시고 확인 버튼을 누르시면 다음 단계로 진행됩니다. </td> 
        </tr> 
      </table></td> 
  </tr> 
    <tr> 
      <td align="center"><br> 
<%			
Dim file : file		= PATH_SYSTEM & "config/useagreement_info.asp"
Dim agreement : agreement	= util.ReadFile(file)
%>
<textarea name="yakkwan" cols="100" rows="15" class="textboxstyle" readonly><%=agreement%></textarea></td> 
    </tr> 
    <tr> 
      <td align="center" height="40"> <input type="checkbox" name="chk_List1" id="chk_List1" value="1">
    위 이용약관에 동의합니다.</td> 
    </tr> 	
    <tr> 
      <td align="center"><br> 
<%			
file		= PATH_SYSTEM & "config/memberagreement_info.asp"
agreement	= util.ReadFile(file)
%>
<textarea name="yakkwan" cols="100" rows="15" class="textboxstyle" readonly><%=agreement%></textarea></td> 
    </tr> 
    <tr> 
      <td align="center" height="40"> <input type="checkbox" name="chk_List2" id="chk_List2" value="1">
    위 회원약관에 동의합니다.</td> 
    </tr> 
    <tr> 
      <td align="center"><br> 
<%			
file		= PATH_SYSTEM & "config/privacyagreement_info.asp"
agreement	= util.ReadFile(file)
%>
<textarea name="yakkwan" cols="100" rows="15" class="textboxstyle" readonly><%=agreement%></textarea></td> 
    </tr> 
    <tr> 
      <td align="center" height="40"> <input type="checkbox" name="chk_List3" id="chk_List3" value="1">
    위 개인정보보호정책에 동의합니다.</td> 
    </tr> 		
    <tr> 
      <td align="center" height="40"> <form id="agreeform" action="wizmember.asp" method="post">
	  <input type="hidden" name="smode" value="regis_step2" />
	  <table width="683" border="0" cellpadding="0" cellspacing="0">

  <tr>
    <td align="center"><table border="0" cellpadding="0" cellspacing="0"> 
          <tr> 
            <td><span class="button bull" id="btn_join_next"><a>확인</a></span></td> 
            <td>&nbsp;</td> 
            <td><span class="button bull"><a href="javascript:history.go(-1)">취소</a></span></td> 
          </tr> 
    </table></td>
  </tr>
</table>
</form></td> 
    </tr> 

  <tr> 
    <td align="right">&nbsp;</td> 
  </tr> 
</table>
