<%
Dim uid
uid			= Request("uid")
%>
<!-- #include file = "../lib/cfg.common.asp" -->
<!--#include file="../config/common_array.asp"-->
<script language="javascript" src="../js/jquery-1.4.2.min.js"></script>
<script language="javascript" src="../js/jquery.plugins/jquery.validator-1.0.1.js"></script>
<script language="javascript" src="../js/wizmall.js"></script>
<link rel="stylesheet" href="../css/base.css" type="text/css">
<link rel="stylesheet" href="../css/mall.css" type="text/css">
<script language="javascript">
<!--
$(function(){
	$("#btn_send").click(function(){
		if($('#wizInquireForm').formvalidate()){

			$('#wizInquireForm').submit();

		}

	});
});

function SearchZipcode(){
window.open("../util/zipcode/default/index.asp?form=wizInquireForm&zip1=zip1&zip2=zip2&firstaddress=address1&secondaddress=address2","ZipWin","width=350,height=250,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no");
}

//-->
</script>
<form name="wizInquireForm" method="POST" id="wizInquireForm" action="wizinquire_qry.asp" enctype="multipart/form-data">
  <input type="hidden" name="qry" value="qin">
  <input type="hidden" name="iid" value="inq1">
  <input type="hidden" name="uid" value="<%=uid%>">
  <table cellspacing="0" cellpadding="0" border="0" width="549" class="table_main">
    <tr>
      <th>회사명</th>
      <td height="30"><input type="text" name="compname" size="20" maxlength="30"  class="required" msg="회사명을 입력해주세요" ></td>
    </tr>
    <tr>
      <th>성명</th>
      <td height="30"><input type="text" name="name" size="20" maxlength="30"  msg="성명을 입력해주세요"  class="required"></td>
    </tr>
    <tr>
      <th>제목</th>
      <td height="30"><input name="subject" type="text" id="subject"  size="20" maxlength="30" msg="제목을 입력해주세요"  class="required"></td>
    </tr>
    <tr>
      <th>주민번호</th>
      <td height="30"><input maxlength=6 size=6 name="juminno1" msg="주민번호를 입력해주세요"  class="required">
        -
        <input maxlength=7 size=7 name="juminno2" msg="주민번호를 입력해주세요"  class="required"></td>
    </tr>
    <tr>
      <th>전화번호</th>
      <td height="30"><select name="tel1"  msg="전화번호를 선택해주세요"  class="required">
          <%
for i=1 to Ubound(PhoneArr)
	Response.Write("<option value="&PhoneArr(i)&">"&PhoneArr(i)&"</option>"&Chr(13)&Chr(10))
next
%>
        </select>
        -
        <input maxlength=4 size=4 name=tel2 msg="연락처를 입력해주세요"  class="required">
        -
        <input maxlength=4 size=4 name=tel3 msg="연락처를 입력해주세요"  class="required"></td>
    </tr>
    <tr>
      <th>휴대폰</th>
      <td height="30"><select name="hand1"  msg="핸드폰번호를 선택해주세요"  class="required">
          <%
for i=1 to Ubound(HandPhoneArr)
	Response.Write("<option value=" & HandPhoneArr(i) & ">" & HandPhoneArr(i) & "</option>"&Chr(13)&Chr(10))
next
%>
        </select>
        -
        <input maxlength=4 size=4 name=hand2>
        -
        <input maxlength=4 size=4 name=hand3></td>
    </tr>
    <tr>
      <th>팩스</th>
      <td height="30"><input maxlength=4 size=4 name=fax1>
        -
        <input maxlength=4 size=4 name=fax2>
        -
        <input maxlength=4 size=4 name=fax3></td>
    </tr>
    <tr>
      <th>email</th>
      <td height="30"><input type="text" name="email" size="20" maxlength="30" ></td>
    </tr>
    <tr>
      <th>url</th>
      <td height="30"><input type="text" name="url" size="20" maxlength="30" ></td>
    </tr>
    <tr>
      <th>주소</th>
      <td height="30"><input  maxlength=3 size=3 name=zip1 READONLY>
        -
        <input  maxlength=3 size=3 name=zip2 READONLY>
        <img src="images/side-01.gif" width="91" height="17" align="absmiddle" onClick='javascript: SearchZipcode()'><br>
        <input size=39 name=address1>
        <br>
        <input size=39 name=address2>
    </tr>
    <tr>
      <th height="30">contents</th>
      <td><textarea name="contents" cols="45" rows="10"></textarea></td>
    </tr>
    <tr>
      <th>첨부</th>
      <td height="30"><input type="file" name="attached"></td>
    </tr>
  </table>
  <br>
  <div class="agn_c btn_box"> <span class="button bull" id="btn_send"><a>확인</a></span> <span class="button bull"><a onClick="javascript:history.go(-1);" >취소</a></span> </div>
  <br>
</form>
