<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/common_array.asp" -->
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

Dim theme, menushow
Dim Loopcnt,selected,mgrade
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

theme			= Request("theme")
menushow		= Request("menushow")
%>
<style type="text/css">
<!--
.style1 {color: #000000}
-->
</style>
<script language="javascript">
<!--
function checkForm(){
	var f = document.FrmUserInfo;
	if(f.id.value == ""){
		alert('아이디를 입력하세요');
		f.id.focus();
	}else if(f.pwd.value == ""){
		alert('패스워드를 입력하세요');
		f.pwd.focus();
	}else f.submit();
}
//-->
</script>
<table class="table_outline">
  <tr>
    <td>
<fieldset class="desc">
<legend>회원가입</legend>
<div class="notice">[note]</div>
<div class="comment">회원가입폼입니다. </div>
</fieldset>
<div class="space20"></div>
  <form action='./member/memberregis_qry.asp' method=post enctype="multipart/form-data" name="FrmUserInfo">
    <input type=hidden name="qry" value="qin">
      <table class="table_main w_default">
		<col width="150px" />
		<col width="*" />
        <tr>
          <th>▷ 회원등급</th>
          <td>&nbsp;
            <select name="mgrade">
              <%
for Loopcnt=1 to Ubound(MemberGradeArr)
	if int(mgrade) = int(Loopcnt) then  selected = "selected" else selected = ""
	if MemberGradeArr(Loopcnt) <> "" then 
		Response.Write("<option value='"&Loopcnt&"' "&selected&">"&MemberGradeArr(Loopcnt)&"</option>"&Chr(13)&Chr(10))
	end if
next 
%>
            </select></td>
        </tr>
        <tr>
          <th>▷ 아이디</th>
          <td>&nbsp;
            <input name="id" type="text" id="id"></td>
        </tr>
        <tr>
          <th>▷ 비밀번호</th>
          <td>&nbsp; <input name="pwd" type="password" id="pwd"></td>
        </tr>
        <tr>
          <th>▷ 상호</th>
          <td>&nbsp; <input name="companyname" type="text" id="companyname"></td>
        </tr>
        <tr>
          <th>▷ 사업자등록번호</th>
          <td>&nbsp; <input name="companynum1" type="text" id="companynum1" size="5">
            -
            <input name="companynum2" type="text" id="companynum2" size="5" />
            -
            <input name="companynum3" type="text" id="companynum3" size="5" /></td>
        </tr>
        <tr>
          <th>▷ 대표자성명</th>
          <td>&nbsp; <input name="president" type="text" id="president"></td>
        </tr>
        <tr>
          <th>▷ 주민등록번호</th>
          <td>&nbsp; <input name="jumin1" type="text" id="jumin1" size="6" maxlength="6">
        -
        <input name="jumin2" type="text" id="jumin2" size="7" maxlength="7"></td>
        </tr>
        <tr>
          <th>▷ 주소</th>
          <td>&nbsp; <input name="address1" type="text" id="address1" size="50"></td>
        </tr>
        <tr>
          <th>▷ E-MAIL</th>
          <td>&nbsp; <input name="email" type="text" id="email"></td>
        </tr>
        <tr>
          <th>▷ 기타사항</th>
          <td>&nbsp; <textarea name="contents" rows="5" id="contents"></textarea></td>
        </tr>
        <tr>
          <td height="25" colspan="2" align="center">
<button name="reg" onClick="checkForm();"
      title="등록">등록</button>
</td>
        </tr>
      </table></form></td>
  </tr>
</table>
