<%@LANGUAGE="VBSCRIPT" CODEPAGE="949"%>
<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/mall_config.asp" -->
<!-- #include file = "../../config/skin_info.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->

<%
''powered by 폰돌
''Reference URL : http://www.shop-wiz.com
''Contact Email : master@shop-wiz.com
''Free Distributer : 
''Copyright shop-wiz.com
''*** Updating List ***

Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

Dim enablemail(4)
enablemail("0") = "1"
enablemail("1") = "2"
enablemail("2") = "3"
enablemail("3") = "4"

Dim flag, query, message, value, messageArr, cnt, statuskey
flag	= Request("flag")
query	= Request("query")
message	= Request("message")
flag = "sms"



if query = "qin" then
	messageArr = split(message, ",")
	cnt = 0
	For Each value in messageArr
	
			statuskey	= enablemail(cnt)
			value		= trim(value)
	''		//내용이 있으면 update  아니면 insert
			strSQL = "select count(1) from wizordermail  where delivery_status = '"&statuskey&"' and flag='"&flag&"'"
			Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
			if objRs(0) <> 0 then 
				strSQL = "update wizordermail set message = '"&value&"' where delivery_status = '"&statuskey&"' and flag='"&flag&"'"
				Call db.ExecSQL(strSQL, Nothing, DbConnect)
			else
				strSQL = "insert into wizordermail (flag, delivery_status, message, enable) values('"&flag&"','"&statuskey&"','"&value&"', 1)"
				Call db.ExecSQL(strSQL, Nothing, DbConnect)
			end if
	
	cnt = cnt+1
	Next ''For Each value in enablemail

end if
%>
<html>
<head>
<title>위즈몰 - 문자메시지 관리 모드</title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<link rel="stylesheet" href="../common/admin.css" type="text/css">
</head>
<script language=javascript>
<!--
var limitlen = 50;//제한글자수

function cutText(v) {
	var tmpStr = v.value;
	var szComplete = "";
	var tcount = 0;
	var onechar;
	
	for (k=0;k<tmpStr.length;k++) {
		onechar = tmpStr.charAt(k);
		
		if (escape(onechar).length > 4) {
			tcount += 2;
		}else if (onechar!='\r') {
			tcount++;
		}
	
		if (tcount > limitlen) {
			tmpStr = szComplete;
			v.value = tmpStr;
			eval("document."+v.form.name+".cbyte.value = limitlen");
			break;
		} else {
			szComplete = szComplete + onechar;
		}
	}
}

function cal_byte(v){
    var tmpStr;
    var temp=0;
    var onechar;
    var tcount;
    tcount = 0;

    tmpStr = new String(v.value);
    temp = tmpStr.length;

    for (k=0;k<temp;k++){
        onechar = tmpStr.charAt(k);

        if (escape(onechar).length > 4) {
            tcount += 2;
        }else if (onechar!='\r') {
            tcount++;
        }
    }

    eval("document."+v.form.name+".cbyte.value = tcount");

    if(tcount>limitlen) {
        reserve = tcount-limitlen;
        alert("메시지 내용은 "+limitlen+"바이트 이상은 전송하실수 없습니다.\r\n 쓰신 메세지는 "+reserve+"바이트가 초과되었습니다.\r\n초과된 부분은 자동으로 삭제됩니다.");
        cutText(v);
        return;
    }
}
//-->
</script>
<body text="#000000">
<span><br />
SHOPWIZ 메세지 전송 서비스 - 휴대폰 문자전송 </span> 
<table cellspacing=1 bordercolordark=white width="420" bgcolor=#c0c0c0 bordercolorlight=#dddddd 
border=0 cellpadding="1">
  <tr > 
    <td colspan="5">무선메시지 &nbsp; </td>
  </tr>
</table>
<br />
<FORM NAME="msg" METHOD="post">
  <INPUT type="hidden" NAME="query" value='qin'>
  <table width="420" 
border=0 cellpadding="1" cellspacing=1 bordercolorlight=#dddddd bordercolordark=white bgcolor=#c0c0c0>
<%
For Each value in enablemail
	if value <> "" then
	
	strSQL = "select * from wizordermail where delivery_status = '"&value&"' and flag='"&flag&"'"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	message = ""
	if NOT objRs.EOF then message = objRs("message")
	
%>
    <tr  bgcolor=white height=25> 
      <td width=80 bgcolor=#f3f3f3><%=DeliveryStatusArr(value)%></td>
      <td> <textarea name="message" cols=40 rows=3 onKeyUp="javascript:cal_byte(this);"><%=message%></textarea> </td>
    </tr>
<%
	end if
Next ''For Each key in enablemail
%>    
    <tr  bgcolor=white height=25> 
      <td colspan="2" bgcolor=#f3f3f3> 
        <input size=3 name=cbyte>
        /50 bytes</td>
    </tr>
  </table>
  <br />
  <table cellspacing=0 bordercolordark=white width="420" bordercolorlight=#dddddd 
border=0 cellpadding="0">
    <tr height=25> 
      <td > <table width="200" border="0" align="center">
          <tr> 
            <td><img src="../img/dada.gif" width="75" height="20" onClick="javascript:document.forms[0].reset()";></td>
            <td><input type="image" src="../img/ju.gif" width="75" height="20"></td>
          </tr>
        </table></td>
    </tr>
  </table>
</form>
<br />
<span>※ 무선메시지는 구매자의 휴대폰으로 문자메시지를 보내는 기능입니다.<br />
※ 문자는 최대 50바이트 이하이어야 합니다.<br />
※ 발송된 문자메세지는 수신까지 대략 10초~2분 정도가 걸립니다.</span> 
</body>
</html>
