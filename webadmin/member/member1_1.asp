<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/common_array.asp" -->
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

Dim mid
Dim nickname,jumin1,jumin2,zip1,address1,address2,email,birthtype,gender,tel1,tel2,birthdate
Dim companynum,contents,companyname,president,emailenable,mpwd,mname,mregdate,mgrantsta,mpoint
Dim mgrade,mloginnum,mlogindate


Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database




mid	= Request("mid")


'' 상세보기 페이지의 정보를 가지고 옮
strSQL = "select m.*, i.* from wizmembers m "
strSQL = strSQL & " left join wizmembers_ind i on m.mid = i.mid "
strSQL = strSQL & " where m.mid = '" & mid & "'"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
nickname		= objRs("nickname")
jumin1			= objRs("jumin1")
jumin2			= objRs("jumin2")
zip1			= objRs("zip1")
address1		= objRs("address1")
address2		= objRs("address2")
email			= objRs("email")
birthtype		= objRs("birthtype")
gender			= objRs("gender")
tel1			= objRs("tel1")
tel2			= objRs("tel2")
birthdate		= objRs("birthdate")
companynum		= objRs("companynum")
contents		= objRs("contents")
companyname		= objRs("companyname")
president		= objRs("president")
emailenable		= objRs("emailenable")

''mid			= objRs("mid") 
mpwd			= objRs("mpwd")
mname			= objRs("mname")
mregdate		= objRs("mregdate")
mgrantsta		= objRs("mgrantsta")
mpoint			= objRs("mpoint")
mgrade			= objRs("mgrade")
mloginnum		= objRs("mloginnum")
mlogindate		= objRs("mlogindate")
%>
<HTML>

<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<TITLE>회원정보수정</TITLE>
<link rel="stylesheet" href="../common/admin.css" type="text/css">

<script language=javascript src="../../js/wizmall.js"></script>
<script language="JavaScript">
<!--
function MemberCheckField(){
var f=document.FrmUserInfo;
return true;
}
//-->
</script>

</HEAD>
<BODY BGCOLOR='WHITE' LEFTMARGIN='0' TOPMARGIN='0' MARGINWIDTH='0' MARGINHEIGHT='0'>
<div align="center"> 
  <form action='./memberregis_qry.asp' method=post enctype="multipart/form-data" name="FrmUserInfo">

    <input type=hidden name="qry" value="qup">
	<input type=hidden name="old_id" value="<%=mid%>">
	<input type="hidden" name="ispopup" value="1">
	<table class="table_pop">
      <tr> 
        <td height="31" colspan="2" align="center">회원기본정보</td>
      </tr>
      <tr> 
        <td width="100" height="31" align="center">회원 
          ID</td>
        <td>&nbsp; 
        <input name="mid" type="text"  value="<%=mid%>" readonly></td>
      </tr>
      <tr> 
        <td height="31" align="center">비밀번호</td>
        <td>&nbsp;
        <input name="mpwd" type="text" id="mpwd" value="<%=mpwd%>"></td>
      </tr>
      <tr> 
        <td height="31" align="center">회원 
          이름</td>
        <td>&nbsp;
        <input name="mname" type="text" id="mname" value="<%=mname%>"></td>
      </tr>
      <tr> 
        <td height="31" align="center">닉네임</td>
        <td>&nbsp;
        
        <input name="nickname" type="text" id="nickname" value="<%=nickname%>"></td>
      </tr>
      <tr> 
        <td height="31" align="center">주민등록번호</td>
        <td>&nbsp;
        <input name="jumin1" type="text" id="jumin1" value="<%=jumin1%>" size="6" maxlength="6">
        -
        <input name="jumin2" type="text" id="jumin2" value="<%=jumin2%>" size="7" maxlength="7"></td>
      </tr>
      <tr> 
        <td height="31" align="center">생년월일</td>
        <td>&nbsp;<input name="birthdate" type="text" id="birthdate" value="<%=birthdate%>">
        </td>
      </tr>
      <tr> 
        <td height="31" align="center">우편번호</td>
        <td>&nbsp;
        <input name="zip1" type="text" id="zip1" value="<%=zip1%>" size="7" maxlength="7"></td>
      </tr>
      <tr> 
        <td height="31" align="center">주소</td>
        <td>&nbsp;
        <input name="address1" type="text" id="address1" value="<%=address1%>" size="50"></td>
      </tr>
      <tr> 
        <td height="31" align="center">&nbsp;</td>
        <td>&nbsp;
        <input name="address2" type="text" id="address2" value="<%=address2%>" size="50"></td>
      </tr>
	  <tr> 
        <td height="31" align="center">E-mail</td>
        <td>&nbsp; <input name="email" type="text" id="email" value="<%=email%>"> <input name="emailenable" type="radio" value="1" <% if emailenable= "1" then  Response.Write ("checked")%>>
                    수신 
                    <input type="radio" name="emailenable" value="0" <% if emailenable= "0" then Response.Write ("checked") %>>
                    수신하지 않음</td>
      </tr>

      <tr> 
        <td height="31" align="center">전화번호</td>
        <td>&nbsp; <input name="tel1" type="text" id="tel1" value="<%=tel1%>"></td>
      </tr>
      <tr> 
        <td height="31" align="center">휴대폰번호</td>
        <td>&nbsp; <input name="tel2" type="text" id="tel2" value="<%=tel2%>"></td>
      </tr>
      <tr> 
        <td height="31" colspan="2" align="center">기타정보</td>
      </tr>
      <tr> 
        <td height="31" align="center">회원가입일</td>
        <td>&nbsp;<%=mregdate%></td>
      </tr>
      <tr> 
        <td height="31" align="center">로그인수</td>
        <td><%=objRs("mloginnum")%>(최근 로그인 : <%=mlogindate%>)</td>
      </tr>
      <tr> 
        <td height="31" align="center">회원등급</td>
        <td><!--<input name="mgrade" type="text" id="mgrade">-->
          <select name="mgrade">
<%
Dim Loopcnt, selected
for Loopcnt=1 to Ubound(MemberGradeArr)
	if int(mgrade) = int(Loopcnt) then selected = "selected" else selected = ""
	if MemberGradeArr(Loopcnt) <> "" then 
		Response.Write("<option value='"&Loopcnt&"' "&selected&">"&MemberGradeArr(Loopcnt)&"</option>"&Chr(13)&Chr(10))
	end if
next 
%>			  
          </select>        </td>
      </tr>	  
    </table>
        
    <br />
    <table cellspacing=0  width="600" border=0 cellpadding="0">
      <tr> 
        <td colspan="2" align="center">
<table border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td><button name="" type="submit" title="수정">수정</button></td>
              <td width=10>&nbsp;</td>
              <td><button name="" onClick="top.close();" title="닫기">닫기</button></td>
            </tr>
          </table> </td>
      </tr>
    </table>
  </form>
</div>
</BODY>
</HTML>
