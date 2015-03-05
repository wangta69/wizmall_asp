<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/admin_info.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

Dim menushow, theme
menushow	= Request("menushow")
theme		= Request("theme")
%>
<script language='JavaScript'>
<!--
function field_check() {
        var f =document.configForm;
        if ( !f.admin_id.value ) {
        alert('관리자 이름을 입력해 주십시오.');
		f.admin_id.focus();
        return false;
        }
        else if ( !f.admin_pwd.value ) {
        alert('관리자 패스워드를 입력해 주십시오.');
		f.admin_pwd.focus();
        return false;
        }
        else if ( !f.cadmin_pwd.value ) {
        alert('관리자 패스워드를 한번더  입력해 주십시오.');
		f.cadmin_pwd.focus();
        return false;
        }
        else if ( f.admin_pwd.value != f.cadmin_pwd.value ) {
        alert('초기로 등록하실 관리자 패스워드와 확인하신 패스워드가 다릅니다.');
		f.admin_id.focus();
        return false;
        }
        else if (confirm('\n입력하신 모든 값들이 정말로 정확합니까?\n')) return true;
        return false;
}
//-->
</script>
<%
strSQL = "select * from wiztable_main"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
%>

<table class="table_outline">
  <tr>
    <td><fieldset class="desc">
						<legend>기본환경 설정</legend>
						<div class="notice">[note]</div>
						<div class="comment"> 기본정보 및 환경을 설정하실 수 있습니다.</div>
						</fieldset>
						<p></p>
		<form name=configForm action="main.asp?qry=qup" onSubmit="return field_check();" method="post">
      <table class="table_main w_default">
        
          <input type="hidden" name="theme" value="basicinfo/basic_info2_qry">
          <input type="hidden" name="menushow" value="<%=menushow%>">
          <tr>
            <td colSpan=4>&nbsp;관리자정보 및 환경을 변경합니다.</td>
          </tr>
          <tr>
            <th>관리자성명</th>
            <td colSpan=3><input value="<%=ADMIN_NAME%>" name="ADMIN_NAME"></td>
          </tr>
          <tr>
            <th>이메일주소</th>
            <td colSpan=3><input value="<%=ADMIN_EMAIL%>" name="ADMIN_EMAIL"></td>
          </tr>
          <tr>
            <th>관리자아이디</th>
            <td colSpan=3><input value="<%=objRs("AdminID")%>" name="admin_id"></td>
          </tr>
          <tr>
            <th>관리패스워드</th>
            <td>
              <input type="password" size=15 value="" name="admin_pwd" />              </td>
            <th><div align="center">패스워드확인</div></td>
            <td>
              <input type="password" size=15 value="" name="cadmin_pwd">              </td>
          </tr>
          <tr>
            <th>html title</th>
            <td colSpan=3><input value="<%=SET_TITLE%>" name="SET_TITLE"></td>
          </tr>		  
          <tr>
            <th>세팅경로</th>
            <td colSpan=3><input value="<%=SET_URL%>" name="SET_URL">
              (예)http://www.shop-wiz.com/mall/)</td>
          </tr>
          <tr>
            <td colSpan=4>* 관리패스워드는 관리자화면으로 
              입장시 필요한 것입니다.<br />
              * 패스워드는 중요하므로 타인에게 노출되지 않도록 해주시기 바랍니다.</td>
          </tr>
          <tr>
            <td colSpan=4>&nbsp;쇼핑몰 정보 입력</td>
          </tr>
          <tr>
            <th>쇼핑몰명</th>
            <td><input value="<%=mall_name%>" name="mall_name" /></td>
          	<th>회사명</th>
          	<td><input value="<%=mall_company%>" name="mall_company" /></td>
          </tr>
          <tr>
            <th>담당자</th>
            <td><input value="<%=mall_charge%>" name="mall_charge" /></td>
          	<th>대표이사</th>
          	<td><input value="<%=mall_ceo%>" name="mall_ceo" /></td>
          </tr>
          <tr>
            <th>팩스</th>
            <td><input value="<%=mall_fax%>" name="mall_fax" /></td>
          	<th>연락처</th>
          	<td><input value="<%=mall_tel%>" name="mall_tel" /></td>
          </tr>
          <tr>
            <th>사업자등록번호</th>
            <td><input value="<%=mall_company_no%>" name="mall_company_no" /></td>
          	<th>이메일</th>
          	<td><input value="<%=mall_email%>" name="mall_email" /></td>
          </tr>	
          <tr>
            <th>통신판매업신고번호</th>
            <td><input value="<%=mall_reg_no%>" name="mall_reg_no" /></td>
            <th>&nbsp;</td>
          	<td>&nbsp;</td>
          </tr>		  
          <tr>
            <th>주소지</th>
            <td colSpan=3><input value="<%=mall_address%>" name="mall_address"></td>
          </tr>			  		  		  		  		  	  
          <tr align="center">
            <td colSpan=4><input type="image" src="img/sul.gif"  height="20"></td>
          </tr>
        
      </table>
	  </form>
      <br />
    </td>
  </tr>
</table>
