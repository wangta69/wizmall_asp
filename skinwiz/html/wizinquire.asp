<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<!-- #include file = "./lib/cfg.common.asp" -->
<!--#include file="./config/common_array.asp"-->
<script language="javascript" src="js/wizmall.js"></script>
<script language="javascript">
<!--
function SearchZipcode(){
window.open("./util/zipcode/default/zipcode.asp?form=wizInquireForm&zip1=zip1&zip2=zip2&firstaddress=address1&secondaddress=address2","ZipWin","width=490,height=250,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no");
}

function CheckForm(f){
	if(autoCheckForm(f)){
		return true;
	}else return false;
}
//-->
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="txt" height="300">
  <form name="wizInquireForm" method="POST" action="wizinquire_qry.asp" onsubmit='return CheckForm(this);' enctype="multipart/form-data">
    <input type="hidden" name="qry" value="in">
    <input type="hidden" name="iid" value="inq1">
    <tr>
      <td align="center"><br>
        <table cellspacing="0" cellpadding="0" border="0" width="549" class="txt">
          <tr>
            <td bgcolor="d7d7d7" height="1" colspan="3">
          </tr>
          <tr>
            <td width="150" height="30" bgcolor="#F3F3F3" align="center">회사명</td>
            <td valign="top" width="1" height="30" align="center"><img src="images/com-line1.gif" width="1" height="10"></td>
            <td height="30"><font color="#FFFFFF">---</font>
              <input type="text" name="compname" size="20" maxlength="30"  style="border:1 solid #999999" msg="회사명을 입력해주세요" checkenable>
              &nbsp;&nbsp;</td>
          </tr>
          <tr>
            <td bgcolor="d7d7d7" height="1" colspan="3">
          </tr>
          <tr>
            <td height="30" bgcolor="#F3F3F3" align="center">성명</td>
            <td valign="top" width="1" height="30" align="center"><img src="images/com-line1.gif" width="1" height="10"></td>
            <td height="30"><font color="#FFFFFF">---</font>
              <input type="text" name="name" size="20" maxlength="30"  style="border:1 solid #999999" msg="성명을 입력해주세요" checkenable>
              &nbsp;&nbsp;</td>
          </tr>
          <tr>
            <td bgcolor="d7d7d7" height="1" colspan="3">
          </tr>
          <tr>
            <td height="30" bgcolor="#F3F3F3" align="center">주민번호</td>
            <td valign="top" width="1" height="30" align="center"><img src="images/com-line1.gif" width="1" height="10"></td>
            <td height="30"><font color="#FFFFFF">---</font>
              <input style="border:1 solid #999999" maxlength=6 size=6 name="juminno1" msg="주민번호를 입력해주세요" checkenable>
              -
              <input style="border:1 solid #999999" maxlength=7 size=7 name="juminno2" msg="주민번호를 입력해주세요" checkenable></td>
          </tr>
          <tr>
            <td bgcolor="d7d7d7" height="1" colspan="3">
          </tr>
          <tr>
            <td height="30" bgcolor="#F3F3F3" align="center">전화번호</td>
            <td valign="top" width="1" height="30" align="center"><img src="images/com-line1.gif" width="1" height="10"></td>
            <td height="30"><font color="#FFFFFF">---</font>
              <select name="tel1" class="frm"  msg="전화번호를 선택해주세요" checkenable>
                <%
for i=1 to Ubound(PhoneArr)
	Response.Write("<option value="&PhoneArr(i)&">"&PhoneArr(i)&"</option>"&Chr(13)&Chr(10))
next
%>
              </select>
              -
              <input style="border:1 solid #999999" maxlength=4 size=4 name=tel2 msg="연락처를 입력해주세요" checkenable>
              -
              <input style="border:1 solid #999999" maxlength=4 size=4 name=tel3 msg="연락처를 입력해주세요" checkenable>
              &nbsp;&nbsp;</td>
          </tr>
          <tr>
            <td bgcolor="d7d7d7" height="1" colspan="3">
          </tr>
          <tr>
            <td height="30" bgcolor="#F3F3F3" align="center">휴대폰</td>
            <td valign="top" width="1" height="30" align="center"><img src="images/com-line1.gif" width="1" height="10"></td>
            <td height="30"><font color="#FFFFFF">---</font>
              <select name="hand1" class="frm"  msg="핸드폰번호를 선택해주세요" checkenable>
<%
for i=1 to Ubound(HandPhoneArr)
	Response.Write("<option value=" & HandPhoneArr(i) & ">" & HandPhoneArr(i) & "</option>"&Chr(13)&Chr(10))
next
%>
              </select>
              -
              <input style="border:1 solid #999999" maxlength=4 size=4 name=hand2>
              -
              <input style="border:1 solid #999999" maxlength=4 size=4 name=hand3>
            </td>
          </tr>
          <tr>
            <td bgcolor="d7d7d7" height="1" colspan="3">
          </tr>
          <tr>
          <tr>
            <td height="30" bgcolor="#F3F3F3" align="center">팩스</td>
            <td valign="top" width="1" height="30" align="center"><img src="images/com-line1.gif" width="1" height="10"></td>
            <td height="30"><font color="#FFFFFF">---</font>
              <input style="border:1 solid #999999" maxlength=4 size=4 name=fax1>
              -
              <input style="border:1 solid #999999" maxlength=4 size=4 name=fax2>
              -
              <input style="border:1 solid #999999" maxlength=4 size=4 name=fax3></td>
          </tr>
          <tr>
            <td bgcolor="d7d7d7" height="1" colspan="3">
          </tr>
          <tr>
            <td height="30" bgcolor="#F3F3F3" align="center">email</td>
            <td valign="top" width="1" height="30" align="center"><img src="images/com-line1.gif" width="1" height="10"></td>
            <td height="30"><font color="#FFFFFF">---</font>
              <input type="text" name="email" size="20" maxlength="30"  style="border:1 solid #999999">
            </td>
          </tr>
          <tr>
            <td bgcolor="d7d7d7" height="1" colspan="3">
          </tr>
          <tr>
            <td height="30" bgcolor="#F3F3F3" align="center">url</td>
            <td valign="top" width="1" height="30" align="center"><img src="images/com-line1.gif" width="1" height="10"></td>
            <td height="30"><font color="#FFFFFF">---</font>
              <input type="text" name="url" size="20" maxlength="30"  style="border:1 solid #999999">
            </td>
          </tr>
          <td height="75" bgcolor="#F3F3F3" align="center" rowspan="3">주소</td>
            <td valign="top" width="1" height="30" align="center" rowspan="3"><img src="images/com-line1.gif" width="1" height="10"></td>
            <td height="30"><font color="#FFFFFF">---</font>
              <input  style="border:1 solid #999999" maxlength=3 size=3 name=zip1 READONLY>
              -
              <input  style="border:1 solid #999999" maxlength=3 size=3 name=zip2 READONLY>
              <img src="images/side-01.gif" width="91" height="17" align="absmiddle" onClick='javascript: SearchZipcode()' style='CURSOR: hand;'> 
          </tr>
          <tr>
            <td height="28"><font color="#FFFFFF">---</font>
              <input style="border:1 solid #999999" size=39 name=address1>
            </td>
          </tr>
          <tr>
            <td height="28"><font color="#FFFFFF">---</font>
              <input style="border:1 solid #999999" size=39 name=address2>
            </td>
          </tr>
          <tr>
            <td bgcolor="d7d7d7" height="1" colspan="3">
          </tr>
          <tr>
            <td height="170" bgcolor="#F3F3F3" align="center">contents</td>
            <td valign="top" width="1" height="30" align="center"><img src="images/com-line1.gif" width="1" height="10"></td>
            <td><font color="#FFFFFF">---</font>
              <textarea name="contents" cols="45" style="border:1 solid #999999" rows="10"></textarea>
              &nbsp;&nbsp;</td>
          </tr>
          <tr>
            <td bgcolor="d7d7d7" height="1" colspan="3">
          </tr>
          <tr>
            <td height="30" bgcolor="#F3F3F3" align="center">첨부</td>
            <td valign="top" width="1" height="30" align="center"><img src="images/com-line1.gif" width="1" height="10"></td>
            <td height="30"><font color="#FFFFFF">---</font>
              <input type="file" name="attached"></td>
          </tr>
          <tr>
            <td bgcolor="d7d7d7" height="1" colspan="3">
          </tr>
        </table>
        <br>
        <table width="100" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><input type="image" src="images/side-02.gif" width="43" height="17"></td>
            <td align="right"><img src="images/side-03.gif" width="43" height="17" onClick="javascript:history.go(-1);" style="cursor:pointer";></td>
          </tr>
        </table>
        <br>
      </td>
    </tr>
  </FORM>
</table>
