<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file="../../config/admin_info.asp" -->
<!-- #include file="../../config/common_array.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
''powered by 폰돌
''Reference URL : http://www.shop-wiz.com
''Contact Email : master@shop-wiz.com
''Free Distributer : 
''Copyright shop-wiz.com
''UPDATE HISTORY

Dim theme, menushow
Dim MailSkin,maxseq,Loopcnt, testMailAddress
Dim strSQL,objRs
Dim db,util
Set util = new utility : Set db = new database

theme			= Request("theme")
menushow		= Request("menushow")
testMailAddress	= Request("testMailAddress")
%>

<script language="Javascript">
<!--
function display1(box){
	member1.style.display = 'block';
	indivisual1.style.display = 'none';
	mass1.style.display = 'none';
	var f= document.messageform;
	f.theme.value="mail/mailer2";
}

function display2(box){
	member1.style.display = 'none';
	indivisual1.style.display = 'block';
	mass1.style.display = 'none';
	var f= document.messageform;
	f.theme.value="mail/mailer2_1";
}


function display3(box){
	member1.style.display = 'none';
	indivisual1.style.display = 'none';
	mass1.style.display = 'block';
	var f= document.messageform;
	f.theme.value="mail/mailer2_2";
}

function checkForm(f){


}
//-->
</script>
<script language="Javascript1.2" >
<!-- // load htmlarea
_editor_url = "../js/";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// -->
</script>
<table class="table_outline">
  <tr>
    <td><table class="table_title">
        <tbody>
          <tr> 
            <td><font color="#FF6600">메일발송하기</b></td>
          </tr>
          <tr> 
            <td> <table cellspacing=0 cellpadding=0 width="100%" border=0>
                <tbody>
                  <tr> 
                    <td align="center" width=57 valign="top"><font 
                              color=#ff6600>[note] </td>
                    <td>&nbsp;</td>
                  </tr>
                </tbody>
              </table></td>
          </tr>
        </tbody>
      </table>
      <br /> <table cellspacing=1 bordercolordark=white width="760" bgcolor=#c0c0c0 bordercolorlight=#dddddd 
border=0 cellpadding="5">
        <form name="messageform" method=post action="mail/mailer2.asp" enctype='multipart/form-data' onsubmit="return checkForm(this)">
        <input type="hidden" name=menushow value=<%=menushow%>>
        <input type="hidden" name="theme" value="mail/mailer2">
		 <input type="hidden" value=0 name=contenttype>
          <tr> 
            <td bgcolor=E6E9EA>보내는 분</td>
            <td align=left>  
              <input size=50 name="FromName" value="<%=ADMIN_NAME%>">
            </td>
          </tr>
          <tr> 
            <td bgcolor=E6E9EA>Email</td>
            <td align=left>  
              <input name="FromEmail" value="<%=ADMIN_EMAIL%>" size="50">
            </td>
          </tr>
          <tr> 
            <td bgcolor=E6E9EA>Reply-To </td>
            <td align=left> <input name="reply" value="<%=ADMIN_EMAIL%>" size=50></td>
          </tr>
          <tr> 
            <td bgcolor=E6E9EA>받는분이메일</td>
            <td align=left> <input type=hidden checked value=amail 
                              name=query><input name="testMailAddress" size="50" value="<%=testMailAddress%>"></td>
          </tr>          
          <tr> 
            <td bgcolor=E6E9EA>제목</td>
            <td align=left>  
              <input size=81 
                        name=subject>
              </td>
          </tr>
          <tr> 
            <td bgcolor=E6E9EA height=27>스킨선택</td>
            <td align=left height=27>  
              <select name=MailSkin>
                <option value="">스킨없슴</option>
<%=util.ShowFolderList(PATH_SYSTEM & "webadmin/mailskin",MailSkin)%> 
              </select>
              </td>
          </tr>
          <tr> 
            <td bgcolor=E6E9EA>내용</td>
            <td align=left> <textarea name=body_txt rows=15 cols=80></textarea> 
			<br />  &nbsp;&nbsp;줄바꿈 : Shift + Enter &nbsp;&nbsp;&nbsp; 
              문단바꿈 : Enter <script language='javascript1.2'>
		editor_generate('body_txt');
		</script>
            </td>
          </tr>
          <!--<tr> 
            <td bgcolor=E6E9EA>파일첨부 </td>
            <td align=left>&nbsp;  
              <input name="attached" type="file" id="userfile"></td>
          </tr>-->

          <tr align="center"> 
            <td colspan=2> <input type="image" src="img/mail.gif" width="90" height="20">
              &nbsp;&nbsp;&nbsp; </td>
          </tr>
        </form>
      </table>
      <br /> </b> </td>
  </tr>
</table>
<%
SET objRs =Nothing : Set db	= Nothing : Set util = Nothing
%>
