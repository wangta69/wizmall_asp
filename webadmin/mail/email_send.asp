<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/admin_info.asp" -->
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

Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database


menushow = Request("menushow")
theme = Request("theme")
%>
<script language='JavaScript'>
<!--
function field_check() {
        var f =document.configForm;

        if ( !f.subject.value ) {
        alert('제목을 입력해 주십시오.');
		f.subject.focus();
        return false;
        }

		if ( !f.content.value ) {
        alert('내용을 입력해 주십시오.');
		f.content.focus();
        return false;
        }
       
        if (confirm('\n입력하신 모든 값들이 정말로 정확합니까?\n')) return true;
        return false;
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
<%
strSQL = "select * from wiztable_main"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
%>
<table class="table_outline">
  <tr>
    <td><table width=760 cellspacing=0 border=1 bgcolor=C0C0C0 bordercolordark="white" bordercolorlight="#DDDDDD">
        <tr>
          <td><font color="#FF6600">이메일링 </b></td>
        </tr>
      </table>
      <br />
      <table class="table_main w_default">
        <form action='main.asp?menushow=<%=menushow%>&theme=email_ok' method='POST' enctype="multipart/form-data" name=configForm onSubmit='return field_check();'>
          <input type="hidden" name="menushow" value="<%=menushow%>">
          <input type="hidden" name="theme" value="<%=theme%>">
          <input type="hidden" name="query" value='qup'>
          <tr>
            <td colSpan=4><font color="#333333">&nbsp;이메일보내기.</td>
          </tr>
          <tr>
            <td width=124 bgColor=E6E9EA><P align="center"><font color="#333333">보낼대상</P></td>
            <td colSpan=3><select name=gubun>
                <option value=total>회원전체</option>
                <option value=a>조찬회원</option>
                <option value=b>회원</option>
                <option value=c>개인</option>
              </select>
            </td>
          </tr>
          <tr>
            <td width=124 bgColor=E6E9EA><P align="center"> <font color="#333333"> 제목  </P></td>
            <td colSpan=3><font color="#333333">
              <input name="subject" size=70>
               </td>
          </tr>
          <tr>
            <td width=124 bgColor=E6E9EA><P align="center"> <font color="#333333"> 개인이메일주소  </P></td>
            <td colSpan=3><font color="#333333">
              <input name="gaein_email" size=40>
              ( 개인일때 여기다 이메일주소기입)  </td>
          </tr>
          <tr>
            <td width=124 bgColor=E6E9EA><P align="center"> <font color="#333333"> 개인성명  </P></td>
            <td colSpan=3><font color="#333333">
              <input name="gaein_name" size=40>
              ( 개인일때 여기다 성명기입)  </td>
          </tr>
          <tr>
            <td width=124 bgColor=E6E9EA><P align="center"> <font color="#333333"> 내용  </P></td>
            <td colSpan=3><font color="#333333">
              <textarea name=content rows=25>
      </textarea>
              <br />  &nbsp;&nbsp;줄바꿈 : Shift + Enter &nbsp;&nbsp;&nbsp; 
              문단바꿈 : Enter <script language='javascript1.2'>
		editor_generate('content');
		</script> </td>
          </tr>
          <tr>
            <td width=124 align="center" bgColor=E6E9EA> 첨부 </td><td colSpan=3><label>
              <input type="file" name="attachFile">
            </label></td>
          </tr>		  
          <!--  <tr> 
            <td width=124 bgColor=E6E9EA> <P align="center"><font color="#333333">관리자아이디 
              </P></td>
            <td colSpan=3><font color="#333333"> 
              <input value="<%=objRs("AdminID")%>" name="admin_id">
              </td>
          </tr>
          <tr> 
            <td width=124 bgColor=E6E9EA> <P align="center"><font color="#333333">관리패스워드 
              </P></td>
            <td width="370"><font color="#333333"> 
              <input type="password" size=15 value="" name="admin_pwd">
              </td>
            <td width=79 bgColor=E6E9EA> <div align="center"><font color="#333333">패스워드확인</div></td>
            <td width="126"><font color="#333333"> 
              <input type="password" size=15 value="" name="cadmin_pwd">
              </td>
          </tr> -->
          <!--   <tr> 
            <td colSpan=4><font color="#333333">* 관리패스워드는 관리자화면으로 
              입장시 필요한 것입니다.<br />
              * 패스워드는 중요하므로 타인에게 노출되지 않도록 해주시기 바랍니다.</td>
          </tr> -->
          <tr align="center">
            <td colSpan=4><input type="image" src="img/sul.gif" width="68" height="20">
            </td>
          </tr>
        </form>
      </table>
      <br />
    </td>
  </tr>
</table>
