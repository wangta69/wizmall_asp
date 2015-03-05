<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../config/membercheck_info.asp" -->
<%
Dim menushow, theme
Dim util
Set util = new utility	
menushow	= Request("menushow")
theme		= Request("theme")
%>
<script language='JavaScript'>
$(function(){

});

function install_check() {
 if (confirm('\n입력하신 모든 값들이 정말로 정확합니까?\n')) return true;
        return false;
}
</script>

<table  class="table_outline">
  <tr>
    <td valign="top"><fieldset class="desc">
        <legend>회원가입 옵션 관리</legend>
        <div class="notice">[note]</div>
        <div class="comment">회원가입시 다양한 기능들을 적용하실 수 있습니다.<br />
          아래 스킨들은 default 스킨일 경우 100% 활용가능하며 기타 스킨은 프로그램에 따라
          적용되지 않을 수도 있습니다.</div>
      </fieldset>
      <p></p>
      <form action="./basicinfo/basic_info8_1.asp" method=post onSubmit='return install_check();'>
        <input type=hidden name="menushow" value="<%=menushow%>">
        <input type=hidden name="theme" value="<%=theme%>">
        <input type=hidden name="qry" value="qup">
        <table class="table_main w_default">
          <!-------------- 메인화면 스킨 시작 ----------------------------------------------------------------------------------->
          <tr>
            <th colspan="2">회원가입옵션</th>
          </tr>
          <tr>
            <th>필수</th>
            <td><input disabled type="checkbox" checked value="checkbox" name="checkbox">
              회원아이디&nbsp;
              <input disabled type="checkbox" checked value="checkbox" name="checkbox2">
              비밀번호
              <input disabled type="checkbox" checked value="checkbox" name="checkbox3">
              이름
              <input disabled type="checkbox" checked value="checkbox" name="checkbox4">
              주민등록번호
              <input disabled type="checkbox" checked value="checkbox" name="checkbox5">
              전화번호
              <input disabled type="checkbox" checked value="checkbox" name="checkbox6">
              전자우편 </td>
          </tr>
          <tr>
            <th>선택</th>
            <td><input type="checkbox" value=checked name="ESex" <%=ESex%>>
              성별(
              <input type="checkbox" value=checked name="CSex" <%=CSex%>>
              )
              <input type="checkbox" value=checked name="ECompany" <%=ECompany%>>
              회사명(
              <input type="checkbox" value=checked name="CCompany" <%=CCompany%>>
              )
              <input type="checkbox" value=checked name="ECompnum" <%=ECompnum%>>
              사업자등록번호(
              <input type="checkbox" value=checked name="CCompnum" <%=CCompnum%>>
              )
              <input type="checkbox" value=checked name="ETel2" <%=ETel2%>>
              이동전화(
              <input type="checkbox" value=checked name="CTel2" <%=CTel2%>>
              ) <br />
              <input type="checkbox" value=checked name="EMailReceive" <%=EMailReceive%>>
              정기소식메일(
              <input type="checkbox" value=checked name="CMailReceive" <%=CMailReceive%>>
              )<br />
              <input type="checkbox" value=checked name="EBirthDay" <%=EBirthDay%>>
              생년월일(
              <input type="checkbox" value=checked name="CBirthDay" <%=CBirthDay%>>
              )
              <input type="checkbox" value=checked name="EMarrStatus" <%=EMarrStatus%>>
              결혼여부(
              <input type="checkbox" value=checked name="CMarrStatus" <%=CMarrStatus%>>
              )
              <input type="checkbox" value=checked name="EJob" <%=EJob%>>
              직업(
              <input type="checkbox" value=checked name="CJob" <%=CJob%>>
              )
              <input type="checkbox" value=checked name="EScholarship" <%=EScholarship%>>
              학력(
              <input type="checkbox" value=checked name="CScholarship" <%=CScholarship%>>
              )
              <input type="checkbox" value=checked name="EAddress3" <%=EAddress3%>>
              직장주소(
              <input type="checkbox" value=checked name="CAddress3" <%=CAddress3%>>
              )<br />
              <input type="checkbox" value=checked name="ERecID" <%=ERecID%>>
              추천인(
              <input type="checkbox" value=checked name="CRecID" <%=CRecID%>>
              ) <br />
              * (
              <input type="checkbox" checked 
                        value=checked name="checkbox7">
              ) 책크박스 책크시 필수 입력으로 전환됩니다. </td>
          </tr>
          <tr>
            <th>실명인증서비스</th>
            <td >  <select name="realnameModule">
                        <%=util.ShowFolderList(PATH_SYSTEM & "skinwiz\nameservice",realnameModule)%>
                      </select> 인증아이디
              <input name="realnameID" value="<%=realnameID%>">
              인증패스워드
              <input name="realnamePWD" value="<%=realnamePWD%>"></td>
          </tr>
          <tr>
            <th>상세설정1</th>
            <td ><input name="EGrantSta" type="radio" value="03" <% if EGrantSta ="03" then Response.Write "checked" %>>
              회원가입시 인증
              <input type="radio" name="EGrantSta" value="04" <%if EGrantSta = "" or EGrantSta="04" then Response.Write "checked" %>>
              회원가입 후 관리자 인증 </td>
          </tr>
          <tr>
            <th>상세설정2</th>
            <td ><input name="INCLUDE_MALL_SKIN" type="radio" value="yes" <% if INCLUDE_MALL_SKIN = "yes" then Response.Write "checked"%>>
              몰인클루드
              <input type="radio" name="INCLUDE_MALL_SKIN" value="no" <% if INCLUDE_MALL_SKIN = "no" then Response.Write "checked"%>>
              몰인클루드 하지 않음</td>
          </tr>
          <tr>
            <th>상세설정3</th>
            <td ><input name="SendMail" type="radio" value="yes" <%if SendMail = "yes" then Response.Write "checked"%>>
              회원가입메일발송
              <input type="radio" name="SendMail" value="no" <% if SendMail = "no"  then Response.Write "checked"%>>
              회원가입시 메일발송안함</td>
          </tr>
          <tr>
            <th>포인트설정1</th>
            <td >회원가입시 포인트 설정 :
              <input value="<%=EPoint%>" name=EPoint>
              포인트 </td>
          </tr>
          <tr>
            <th>포인트설정2</th>
            <td >회원추천시 포인트 설정 :
              <input name=RPoint value="<%=RPoint%>">
              포인트</td>
          </tr>
          <tr>
            <th>포인트설정3</th>
            <td >로그인 포인트
              설정 :
              <input name=LPoint value="<%=LPoint%>">
              포인트(1일 1회) </td>
          </tr>
          <tr>
            <th colspan="2" >이용약관</th>
            
          </tr>
          <tr>
            <td colspan="2"><%
Set util = new utility			
Dim file : file		= PATH_SYSTEM & "config/useagreement_info.asp"
Dim agreement : agreement	= util.ReadFile(file)
%>
              <textarea name="use_agreement" id="use_agreement" rows=8 wrap="virtual" style="width:100%"><%=agreement%></textarea></td>
          </tr>
          <tr>
            <td colspan="2" >&nbsp;</td>
          </tr>
          <tr>
            <th colspan="2" >회원약관</th>
          </tr>
          <tr>
            <td colspan="2" ><%
	
file		= PATH_SYSTEM & "config/memberagreement_info.asp"
agreement	= util.ReadFile(file)
%>
              <textarea name="member_agreement" id="member_agreement" rows=8 wrap="virtual" style="width:100%"><%=agreement%></textarea></td>
          </tr>
          <tr>
            <th colspan="2">개인정보보호정책</th>
          </tr>
          <tr>
            <td colspan="2" ><%
		
file		= PATH_SYSTEM & "config/privacyagreement_info.asp"
agreement	= util.ReadFile(file)
Set util = Nothing
%>
              <textarea name="privacy_agreement" id="privacy_agreement" rows=8 wrap="virtual" style="width:100%"><%=agreement%></textarea></td>
          </tr>
          <tr>
            <td colspan="2" >스킨입력(몰스킨외에
              스킨을 사용하실려면 &quot;몰인크루드 하지않음&quot;을 선택후 코딩하세요</td>
          </tr>
          <tr>
            <th>회원스킨 Top</th>
            <td ><%
Set util = new utility			
file		= PATH_SYSTEM & "config/member_skin_top.asp"
Dim MemberSkinTop : MemberSkinTop	= util.ReadFile(file)
Set util = Nothing
%>
              <textarea name="MemberSkinTop" rows="8" id="MemberSkinTop" style="width:100%"> 
</textarea></td>
          </tr>
          <tr>
            <th>회원스킨 Bottom</th>
            <td ><%
Set util = new utility			
file		= PATH_SYSTEM & "config/member_skin_bottom.asp"
Dim MemberSkinBottom : MemberSkinBottom	= util.ReadFile(file)
Set util = Nothing
%>
              <textarea name="MemberSkinBottom" rows="8" id="MemberSkinBottom" style="width:100%"> 
</textarea></td>
          </tr>

          <tr>
            <th colspan="2" >회원가입시 축하 메일내용입력 </th>
          </tr>
          <tr>
            <td colspan="2" ><%
Set util = new utility			
file		= PATH_SYSTEM & "config/member_mail_info.asp"
Dim WELCOM_MESSAGE : WELCOM_MESSAGE	= util.ReadFile(file)
Set util = Nothing
%>
              <textarea name="WELCOM_MESSAGE" rows=8 style="width:100%">
                  </textarea></td>
          </tr>

          <tr>
            <td colspan="2" ><button name="save"  type="submit" title="적용">적용</button></td>
          </tr>
        </table>
      </form></td>
  </tr>
</table>