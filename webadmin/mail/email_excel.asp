<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file="../config/admin_info.asp" -->
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

		if ( !f.attachFile.value ) {
        alert('내용을 입력해 주십시오.');
		
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
<%
strSQL = "select * from wiztable_main"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
%>
<table class="table_outline">
  <tr>
    <td>
      <table class="table_title">
        <tr> 
          <td><font color="#FF6600">엑셀로이메일링 
            </b></td>
        </tr>
       
      </table>
      <br />
      <table class="table_main w_default">
        <form name=configForm action='main.asp?menushow=<%=menushow%>&theme=excel_email_ok' method='POST' onSubmit='return field_check();' enctype="multipart/form-data">
          <input type=HIDDEN name="menushow" value="<%=menushow%>">
          <input type=HIDDEN name="theme" value="<%=theme%>">
          <input type=HIDDEN name="query" value='qup'>
          <tr bgColor=E0E4E8> 
            <td colSpan=4><font color="#333333">&nbsp;이메일보내기.</td>
          </tr>

		   


          <tr> 
            <td width=124 bgColor=E6E9EA> <P align=center><font color="#333333">제목</P></td>
            <td colSpan=3><font color="#333333"> 
              <input name="subject" size=70>
              </td>
          </tr>

		  <tr> 
            <td width=124 bgColor=E6E9EA> <P align=center><font color="#333333">업로드</P></td>
            <td colSpan=3><font color="#333333"> 
              <input name="attachFile" size=30 type=file>
              </td>
          </tr>


		   <tr> 
            <td width=124 bgColor=E6E9EA> <P align=center><font color="#333333">pppt 파일 업로드</P></td>
            <td colSpan=3><font color="#333333"> 
              <input name="attachFile_ppt" size=30 type=file>
              </td>
          </tr>

		  

		  
          <tr> 
            <td width=124 bgColor=E6E9EA> <P align=center><font color="#333333">내용</P></td>
            <td colSpan=3><font color="#333333"> 
             <textarea name=content cols=90 rows=25></textarea>
              </td>
          </tr>
         <!--  <tr> 
            <td width=124 bgColor=E6E9EA> <P align=center><font color="#333333">관리자아이디 
              </P></td>
            <td colSpan=3><font color="#333333"> 
              <input value="<%=objRs("AdminID")%>" name="admin_id">
              </td>
          </tr>
          <tr> 
            <td width=124 bgColor=E6E9EA> <P align=center><font color="#333333">관리패스워드 
              </P></td>
            <td width="370"><font color="#333333"> 
              <input type="password" size=15 value="" name="admin_pwd">
              </td>
            <td width=79 bgColor=E6E9EA> <div align=center><font color="#333333">패스워드확인</div></td>
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
            <td colSpan=4><input type="image" src="img/sul.gif" width="68" height="20"></td>
          </tr>
        </form>
      </table>
      <br />
    </td>
              </tr>
            </table>
