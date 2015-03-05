<!-- #include file = "../../lib/cfg.common.asp" -->
<%
/* 
powered by 폰돌
Reference URL : http://www.shop-wiz.com
Contact Email : master@shop-wiz.com
Free Distributer : 
- http://www.webpiad.co.kr
- http://www.ntill.com
Copyright shop-wiz.com
*** Updating List ***
*/
%>
<%
include ("./ROOT_CHECK.php");
if (action) {
        if (MSG1) {
        if (action == 'sms') {
        MSG1 = str_replace("\r\n", " ", MSG1);
        }
        else {
        MSG1 = str_replace("\r\n", "\n", MSG1);
        }
        fp = fopen("../config/MSG1_action.cgi", "w");
        fwrite(fp, stripslashes(MSG1));
        fclose(fp);
        }
        else {
                if (file_exists("../config/MSG1_action.cgi")) {
                        unlink("../config/MSG1_action.cgi");
                }
        }
        if (MSG2) {
        if (action == 'sms') {
        MSG2 = str_replace("\r\n", " ", MSG2);
        }
        else {
        MSG2 = str_replace("\r\n", "\n", MSG2);
        }
        fp = fopen("../config/MSG2_action.cgi", "w");
        fwrite(fp, stripslashes(MSG2));
        fclose(fp);
        }
        else {
                if (file_exists("../config/MSG2_action.cgi")) {
                        unlink("../config/MSG2_action.cgi");
                }
        }
        if (MSG3) {
        if (action == 'sms') {
        MSG3 = str_replace("\r\n", " ", MSG3);
        }
        else {
        MSG3 = str_replace("\r\n", "\n", MSG3);
        }
        fp = fopen("../config/MSG3_action.cgi", "w");
        fwrite(fp, stripslashes(MSG3));
        fclose(fp);
        }
        else {
                if (file_exists("../config/MSG3_action.cgi")) {
                        unlink("../config/MSG3_action.cgi");
                }
        }
        if (MSG4) {
        if (action == 'sms') {
        MSG4 = str_replace("\r\n", " ", MSG4);
        }
        else {
        MSG4 = str_replace("\r\n", "\n", MSG4);
        }
        fp = fopen("../config/MSG4_action.cgi", "w");
        fwrite(fp, stripslashes(MSG4));
        fclose(fp);
        }
        else {
                if (file_exists("../config/MSG4_action.cgi")) {
                        unlink("../config/MSG4_action.cgi");
                }
        }
        echo "<HTML>
        <META http-equiv=\"refresh\" content =\"0;url=./order1_2.php?what=action\">
        </HTML>";
        exit;
}
%>
<html>
<head>
<title>위즈몰 - 문자메시지 관리 모드</title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<link rel="stylesheet" href="style.css" type="text/css">
</head>
<script language=javascript>
function cal_pre(mnum,mname)
{
        var tmpStr, tcount;
    tmpStr = new String(mnum);
    cal_byte(mnum,mname);
}

function cutText(str,mname) {
        var tmpStr = str;
        var szComplete = "";
        var tcount = 0;
        var onechar;

        for (k=0;k<tmpStr.length;k++) {
                onechar = tmpStr.charAt(k);

                if (escape(onechar).length > 4) {
                        tcount += 2;
                }
                else if (onechar!='\r') {
                        tcount++;
                }

                if (tcount > 50) {
                        tmpStr = szComplete;

                        if(mname == 1) {
                        document.msg.MSG1.value = tmpStr;
                        }
                        if(mname == 2) {
                        document.msg.MSG2.value = tmpStr;
                        }
                        if(mname == 3) {
                        document.msg.MSG3.value = tmpStr;
                        }
                        if(mname == 4) {
                        document.msg.MSG4.value = tmpStr;
                        }
                        document.msg.cbyte.value = 50;
                        break;
                } else {
                        szComplete = szComplete + onechar;
                }
        }
}
function cal_byte(aquery,mname)
{
    var tmpStr;
    var temp=0;
    var onechar;
    var tcount;
    tcount = 0;

    tmpStr = new String(aquery);
    temp = tmpStr.length;

    for (k=0;k<temp;k++)
    {
        onechar = tmpStr.charAt(k);

        if (escape(onechar).length > 4) {
            tcount += 2;
        }
        else if (onechar!='\r') {
            tcount++;
        }
    }

    document.msg.cbyte.value = tcount;

    if(tcount>50) {
        reserve = tcount-50;
        alert("메시지 내용은 50바이트 이상은 전송하실수 없습니다.\r\n 쓰신 메세지는 "+reserve+"바이트가 초과되었습니다.\r\n초과된 부분은 자동으로 삭제됩니다.");
        cutText(tmpStr,mname);
        return;
    }
}

</script>
<body text="#000000" leftmargin="0" topmargin="00" marginwidth="0" marginheight="0">
<span class="s1"><br>
SHOPWIZ 메세지 전송 서비스 - 휴대폰 문자전송 </span> 
<table cellspacing=1 bordercolordark=white width="600" bgcolor=#c0c0c0 bordercolorlight=#dddddd 
border=0 class="s1" cellpadding="1">
   
  <tr > 
    <td colspan="5">무선메시지 <font color="#000000">&nbsp; </td>
  </tr>
   
</table>
<br>
<FORM ACTION='<%=PHP_SELF%>' NAME=msg METHOD=post>
 <INPUT type="hidden" NAME=action value='<%=what%>'>
<table cellspacing=1 bordercolordark=white width="600" bgcolor=#c0c0c0 bordercolorlight=#dddddd 
border=0 class="s1" cellpadding="1">
   
  <tr  bgcolor=white height=25> 
    <td width=132 bgcolor=#f3f3f3>입금기다림</td>
    <td width="478"> 
      <div align="center"><b><font color="#000000"> 
        <textarea name=MSG1 cols=60 rows=3 class="dd1" id="MSG1" onKeyUp="javascript:cal_pre(document.msg.MSG1.value,1);"><%
if (file_exists(msg_file1)) {
msg_data1 = file(msg_file1);
        while(dat = each(msg_data1)) {
        dat[1] = htmlspecialchars(dat[1]);
        echo dat[1];
        }
}
%></textarea>
        </b></div>
    </td>
  </tr>
  <tr  bgcolor=white height=25> 
    <td width=132 bgcolor=#f3f3f3>입금확인됨</td>
    <td width="478"> 
      <div align="center"><b><font color="#000000"> 
        <textarea name=MSG2 cols=60 rows=3 class="dd1" id="MSG2" onKeyUp="javascript:cal_pre(document.msg.MSG2.value,2);"><%

if (file_exists(msg_file2)) {
msg_data2 = file(msg_file2);
        while(dat = each(msg_data2)) {
        dat[1] = htmlspecialchars(dat[1]);
        echo dat[1];
        }
}
%></textarea>
        </b></div>
    </td>
  </tr>
  <tr  bgcolor=white height=25> 
    <td width=132 bgcolor=#f3f3f3>배송준비중</td>
    <td width="478"> 
      <div align="center"><b><font color="#000000"> 
        <textarea name=MSG3 cols=60 rows=3 class="dd1" id="MSG3" onKeyUp="javascript:cal_pre(document.msg.MSG3.value,3);"><%
if (file_exists(msg_file3)) {
msg_data3 = file(msg_file3);
        while(dat = each(msg_data3)) {
        dat[1] = htmlspecialchars(dat[1]);
        echo dat[1];
        }
}
%></textarea>
        </b></div>
    </td>
  </tr>
  <tr  bgcolor=white height=25> 
    <td width=132 bgcolor=#f3f3f3>배송완료됨</td>
    <td width="478"> 
      <div align="center"><b><font color="#000000"> 
        <textarea name=MSG4 cols=60 rows=3 class="dd1" id="MSG4" onKeyUp="javascript:cal_pre(document.msg.MSG4.value,4);"><%
if (file_exists(msg_file4)) {
msg_data4 = file(msg_file4);
        while(dat = each(msg_data4)) {
        dat[1] = htmlspecialchars(dat[1]);
        echo dat[1];
        }
}
%></textarea>
        </b></div>
    </td>
  </tr>
  <tr  bgcolor=white height=25> 
    <td colspan="2" bgcolor=#f3f3f3><font color="#000000"> 
      <input size=3 name=cbyte class="dd1">
      /50 bytes</td>
  </tr>
   
</table>
<br>
<table cellspacing=0 bordercolordark=white width="600" bordercolorlight=#dddddd 
border=0 class="s1" cellpadding="0">
   
  <tr height=25> 
    <td >
      <table width="200" border="0" align="center">
        <tr>
          <td><img src="img/dada.gif" width="75" height="20" onClick="javascript:document.forms[0].reset()";></td>
          <td><input type="image" src="img/ju.gif" width="75" height="20"></td>
        </tr>
      </table>
      
    </td>
  </tr>
   
</table></form>
<br>
<span class="s1">※ 무선메시지는 구매자의 휴대폰으로 문자메시지를 보내는 기능입니다.<br>
※ 문자는 최대 50바이트 이하이어야 합니다.<br>
※ 발송된 문자메세지는 수신까지 대략 10초~2분 정도가 걸립니다.<br>
※ anysms 와 혼환됩니다. </span><br>
<br>
<br>
<br>
<br>
<br>
<br>
<div align="center" class="s1"><br>
</div>
</body>
</html>
