<% Option Explicit %>
<!-- #include file = "../../../lib/cfg.mall.asp" -->
<%
''제작자 : 폰돌
''URL : http://www.shop-wiz.com
''Email : master@shop-wiz.com
''*** Updating List ***
Dim pid,c_id,c_name,c_pwd,c_email,c_grade,c_subject,c_comment,c_option
	
	
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
end if
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>상품평 쓰기</title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<script language="javascript" src="../../../js/wizmall.js"></script>
<script language="JavaScript">
<!--
function checkForm(f){
	if (autoCheckForm(f)){
		return true;
	}else{
		return false;
	}
}
//-->
</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="554" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="./images/prdpop_h1.gif" width="554" height="89"></td>
  </tr>
  <tr>
    <td align="center"><br>
      <table width="500" border="0" cellspacing="0" cellpadding="0">
        <form name="estimat" onsubmit='return checkForm(this);' method="post">
        <input type="hidden" name="qry" value="qin">
        <input type="hidden" name="code" value="<%=code%>">	 
        <input type="hidden" name="pid" value="<%=no%>">	 
        <tr> 
          <td width="123" height="24"><img src="./images/prdpop_co1.gif" width="35" height="12"></td>
          <td width="10" height="24">:</td>
            <td width="367" height="24" class="company"><input name="c_name" type="text" class="formline" id="c_name" value="<%=user_name%>" size="10" checkenable msg="이름을 입력하세요"></td>
        </tr>
        <tr> 
          <td background="./images/bg_w.gif" height="1" colspan="3"></td>
        </tr>
        <tr> 
          <td height="24"><img src="./images/prdpop_co2.gif" width="35" height="12"></td>
          <td height="24">:</td>
          <td height="24"><input name="Subject" type="text" class="formline" id="Subject" checkenable msg="제목을 입력하세요"></td>
        </tr>
        <tr> 
          <td background="./images/bg_w.gif" height="1" colspan="3"></td>
        </tr>
        <tr> 
          <td height="24"><img src="./images/prdpop_co5.gif" width="74" height="12"></td>
          <td height="24">:</td>
          <td height="24"><table width="355" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><input type="radio" name="c_grade" id="c_grade" value="5" checkenable msg="선호도를 선택해주세요"></td>
                <td><img src="images/star5.gif" width="88" height="15"></td>
                <td><input type="radio" name="c_grade" id="c_grade" value="4"></td>
                <td><img src="images/star4.gif" width="88" height="15"></td>
                <td><input type="radio" name="c_grade" id="c_grade" value="3"></td>
                <td><img src="images/star3.gif" width="88" height="15"></td>
              </tr>
              <tr> 
                <td><input type="radio" name="c_grade" id="c_grade" value="2"></td>
                <td><img src="images/star2.gif" width="88" height="15"></td>
                <td><input type="radio" name="c_grade" id="c_grade" value="1"></td>
                <td><img src="images/star1.gif" width="88" height="15"></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td background="./images/bg_w.gif" height="1" colspan="3"></td>
        </tr>
        <tr> 
          <td height="24"><img src="./images/prdpop_co3.gif" width="88" height="12"></td>
          <td height="24">&nbsp;</td>
          <td height="24">&nbsp;</td>
        </tr>
        <tr> 
          <td height="24" colspan="3"><textarea name="c_comment" cols="70" rows="10" id="c_comment" checkenable msg="상품후기를 입력해 주세요"></textarea></td>
        </tr>
        <tr align="center"> 
            <td height="24" colspan="3"><br>
              <table width="300" border="0" cellspacing="0" cellpadding="0">
                <tr align="center"> 
                  <td> 
                    <input type="submit" name="Submit" value="쓰기"></td>
                  <td> 
                    <input type="button" name="Submit2" value="닫기" onClick="window.close()" style="cursor:pointer"></td>
              </tr>
            </table></td>
        </tr></form>
      </table></td>
  </tr>
</table>
</body>
</html>
