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

Dim uid,compsort,compid,comppass,comppersonalid,compname,compnum,compsortnum,compkind,comptype,compmain,compfoundday,compemployeenum,compzip1, zip1, zip1_1, zip1_2
Dim compaddress1,compaddress2,comptel,compfax,compprename,compprenum1,compprenum2,comppretel,compurl,compemail,compchaname,compchatel
Dim compchaemail,compchadep,compchalevel,compchabirthday,compchabirthtype,compchabirthgender,compcontents

Dim theme, menushow
Dim Loopcnt,selected,smode, qry
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

theme			= Request("theme")
menushow		= Request("menushow")
qry				= Request("qry")

uid					= Request("uid")
compsort			= Request("compsort")
compid				= Request("compid")
comppass			= Request("comppass")
comppersonalid		= Request("comppersonalid")
compname			= Request("compname")
compnum				= Request("compnum")
compsortnum			= Request("compsortnum")
compkind			= Request("compkind")
comptype			= Request("comptype")
compmain			= Request("compmain")
compfoundday		= Request("compfoundday")
compemployeenum		= Request("compemployeenum")
zip1_1				= Request("zip1_1")
zip1_2				= Request("zip1_2")
compzip1			= zip1_1 & "-" & zip1_2
compaddress1		= Request("compaddress1")
compaddress2		= Request("compaddress2")
comptel				= Request("comptel")
compfax				= Request("compfax")
compprename			= Request("compprename")
compprenum1			= Request("compprenum1")
compprenum2			= Request("compprenum2")
comppretel			= Request("comppretel")
compurl				= Request("compurl")
compemail			= Request("compemail")
compchaname			= Request("compchaname")
compchatel			= Request("compchatel")
compchaemail		= Request("compchaemail")
compchadep			= Request("compchadep")
compchalevel		= Request("compchalevel")
compchabirthday		= Request("compchabirthday")
compchabirthtype	= Request("compchabirthtype")
compchabirthgender	= Request("compchabirthgender")
compcontents		= Request("compcontents")



If qry = "qin" then
	strSQL = "insert into wizcom" 
	strSQL = strSQL & "(compsort,compid,comppass,comppersonalid,compname,compnum,compsortnum,compkind,comptype,compmain,compfoundday,compemployeenum"
	strSQL = strSQL & ",compzip1,compaddress1,compaddress2,comptel,compfax,compprename,compprenum1,compprenum2,comppretel,compurl,compemail"
	strSQL = strSQL & ",compchaname,compchatel,compchaemail,compchadep,compchalevel,compchabirthday,compchabirthtype,compchabirthgender,compcontents"
	strSQL = strSQL & ") "
	strSQL = strSQL & " values "
	strSQL = strSQL & " ('" & compsort & "','" & compid & "','" & comppass & "','" & comppersonalid & "','" & compname & "','" & compnum & "','" & compsortnum & "','" & compkind & "','" & comptype & "','" & compmain & "','" & compfoundday & "','" & compemployeenum & "','" & compzip1 & "','" & compaddress1 & "','" & compaddress2 & "','" & comptel & "','" & compfax & "','" & compprename & "','" & compprenum1 & "','" & compprenum2 & "','" & comppretel & "','" & compurl & "','" & compemail & "','" & compchaname & "','" & compchatel & "','" & compchaemail & "','" & compchadep & "','" & compchalevel & "','" & compchabirthday & "','" & compchabirthtype & "','" & compchabirthgender & "','" & compcontents & "') "
	Response.Write(strSQL)
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	Response.Redirect("./main.asp?menushow=menu6&theme=member/member_com")
	
ElseIf qry	= "qup" then
	strSQL = "update wizcom set" 
	strSQL = strSQL & " compsort='"& compsort &"',compid='"& compid &"',comppass='"& comppass &"',comppersonalid='"& comppersonalid &"',compname='"& compname &"',compnum='"& compnum &"',compsortnum='"& compsortnum &"',compkind='"& compkind &"',comptype='"& comptype &"',compmain='"& compmain &"',compfoundday='"& compfoundday &"',compemployeenum='"& compemployeenum &"',compzip1='"& compzip1 &"',compaddress1='"& compaddress1 &"',compaddress2='"& compaddress2 &"',comptel='"& comptel &"',compfax='"& compfax &"',compprename='"& compprename &"',compprenum1='"& compprenum1 &"',compprenum2='"& compprenum2 &"',comppretel='"& comppretel &"',compurl='"& compurl &"',compemail='"& compemail &"',compchaname='"& compchaname &"',compchatel='"& compchatel &"',compchaemail='"& compchaemail &"',compchadep='"& compchadep &"',compchalevel='"& compchalevel &"',compchabirthday='"& compchabirthday &"',compchabirthtype='"& compchabirthtype &"',compchabirthgender='"& compchabirthgender &"',compcontents='"& compcontents &"'"
	strSQL = strSQL & " where uid = " & uid
	''Response.Write(strSQL)
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	Response.Redirect("./main.asp?menushow=menu6&theme=member/member_com")
End If

if uid <> "" then 
	strSQL = "select * from wizcom where uid = " & uid 
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	uid					= objRs("uid")
	compsort			= objRs("compsort")
	compid				= objRs("compid")
	comppass			= objRs("comppass")
	comppersonalid		= objRs("comppersonalid")
	compname			= objRs("compname")
	compnum				= objRs("compnum")
	compsortnum			= objRs("compsortnum")
	compkind			= objRs("compkind")
	comptype			= objRs("comptype")
	compmain			= objRs("compmain")
	compfoundday		= objRs("compfoundday")
	compemployeenum		= objRs("compemployeenum")
	compzip1			= objRs("compzip1")
	zip1				= split(compzip1, "-") : zip1_1 = zip1(0) : zip1_2 = zip1(1)
	compaddress1		= objRs("compaddress1")
	compaddress2		= objRs("compaddress2")
	comptel				= objRs("comptel")
	compfax				= objRs("compfax")
	compprename			= objRs("compprename")
	compprenum1			= objRs("compprenum1")
	compprenum2			= objRs("compprenum2")
	comppretel			= objRs("comppretel")
	compurl				= objRs("compurl")
	compemail			= objRs("compemail")
	compchaname			= objRs("compchaname")
	compchatel			= objRs("compchatel")
	compchaemail		= objRs("compchaemail")
	compchadep			= objRs("compchadep")
	compchalevel		= objRs("compchalevel")
	compchabirthday		= objRs("compchabirthday")
	compchabirthtype	= objRs("compchabirthtype")
	compchabirthgender	= objRs("compchabirthgender")
	compcontents		= objRs("compcontents")

	smode		= "qup"
else
	smode		= "qin"
end if
%>
<script language="javascript" type="text/javascript">
<!--
$(function(){
	$("#btn_save").click(function(){
		$("#s_form").submit();
	});
});

//-->
</script>
<table class="table_outline">
  <tr>
    <td>
	
<fieldset class="desc">
        <legend>거래처 등록</legend>
        <div class="notice">[note]</div>
        <div class="comment">제품공급 거래처 및 판매처를 등록합니다.<br />
등록된 거래처는 제품등록시에 선택할 수 있으며 제품공급 거래처를 등록하면 공급 거래처별로 매출통계를 낼 수 있습니다.</div>
      </fieldset>
      <p></p>
	  

       <form action='./main.asp' method="post" name='s_form' id="s_form">
        <input type='hidden' name='menushow' value='<%=menushow%>'>
        <input type=hidden name="theme" value="<%=theme%>">
		<input type="hidden" name="qry" value="<%=smode%>">
		<input type="hidden" name="uid" value="<%=uid%>">
        <table class="table_main w_default">
          <tr>
            <td width="94" height="25" colspan=1 bgcolor="e0e4e8">* 
              상호</td>
            <td><input name="compname" type="text" value="<%=compname%>" size="25"></td>
            <!-- 
기업회원 구분(wizcom.compsort)은 크게 공급처( <50 ) 과 소매처(50 <=, <100) 로 분류된다. 
01 : 도매공급자, 02 : 소매공급자, 03 : 생산자), 50 : 쇼핑몰(온라인)기업고객고객, 51 : 도매판매처, 52, 소매판매처 .. 경우에따라 이곳은 자유롭게 프로그램가능)
-->
            <td width="117" colspan=-1 bgcolor="e0e4e8">* 
              거래처분류</td>
            <td><select name="compsort">
                <option value="01"<% If compsort = "01" then Response.Write(" selected='selected'")%>>도매공급자</option>
                <option value="02"<% If compsort = "02" then Response.Write(" selected='selected'")%>>소매공급자</option>
                <option value="03"<% If compsort = "03" then Response.Write(" selected='selected'")%>>생산자</option>
                <option value="51"<% If compsort = "51" then Response.Write(" selected='selected'")%>>도매판매처</option>
                <option value="52"<% If compsort = "52" then Response.Write(" selected='selected'")%>>소매판매처</option>
              </select></td>
          </tr>
		  <!--
          <tr>
            <td height="25" bgcolor="e0e4e8">* 
              거래처아이디</td>
            <td><input name="compid" type="text" id="compid" value="<%=compid%>" size="25"<% If smode = "qup" then Response.Write(" readonly='readonly'")%>></td>
            <td colspan=-1 bgcolor="e0e4e8">* 거래처패스워드</td>
            <td><input name="comppass" type="text" value="<%=comppass%>" size="15"></td>
          </tr>//-->
          <tr>
            <td height="25" colspan=1 bgcolor="e0e4e8">* 
              사업자등록번호</td>
            <td colspan="3"><input name="compnum" type="text" value="<%=compnum%>" size="25"></td>
          </tr>
          <tr>
            <td height="25" colspan=1 bgcolor="e0e4e8">* 
              업태</td>
            <td><input name="compkind" type="text" value="<%=compkind%>" size="15"></td>
            <td colspan=-1 bgcolor="e0e4e8">* 종목 </td>
            <td><input name="comptype" type="text" value="<%=comptype%>" size="25" /></td>
          </tr>
          <tr>
            <td height="25" colspan=1 bgcolor="e0e4e8">* 
              사업장 주소</td>
            <td colspan=3><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="25"><input name="zip1_1" type=text value="<%=zip1_1%>" size=4 maxlength=3>
                    -
                    <input name="zip1_2" type=text value="<%=zip1_2%>" size=4 maxlength=3>
                    <!--<img src="img/util_icon8.gif" width="86" height="20" onclick='openzipcode()'>//--></td>
                </tr>
                <tr>
                  <td height="25"><input name="compaddress1" type="text" value="<%=compaddress1%>" size="55">
                    <input name="compaddress2" type="text" value="<%=compaddress2%>" size="55">                  </td>
                </tr>
              </table></td>
          </tr>
          <tr>
            <td height="25" colspan=1 bgcolor="e0e4e8">* 
              전화</td>
            <td><input name="comptel" type="text" value="<%=comptel%>" size="15"></td>
            <td colspan=-1 bgcolor="e0e4e8">* 팩스</td>
            <td><input name="compfax" type="text" value="<%=compfax%>" size="15"></td>
          </tr>
          <tr>
            <td height="25" colspan=1 bgcolor="e0e4e8">* 
              대표자명</td>
            <td><input name="compprename" type="text" value="<%=compprename%>" size="15">            </td>
            <td colspan=-1 bgcolor="e0e4e8">* 대표자 연락처</td>
            <td><input name="comppretel" type="text" value="<%=comppretel%>" size="15"></td>
          </tr>
          <tr>
            <td height="25" colspan=1 bgcolor="e0e4e8">* 
              담당자명</td>
            <td><input name="compchaname" type="text" value="<%=compchaname%>" size="15">            </td>
            <td colspan=-1 bgcolor="e0e4e8">* 담당자 연락처</td>
            <td><input name="compchatel" type="text" value="<%=compchatel%>" size="15"></td>
          </tr>
          <tr>
            <td height="25" colspan=1 bgcolor="e0e4e8">* 
              담당자이메일</td>
            <td colspan=3><input name="compchaemail" type="text" value="<%=compchaemail%>" size="55"></td>
          </tr>
          <tr>
            <td height="25" colspan=1 bgcolor="e0e4e8">* 
              홈페이지</td>
            <td colspan=3><input name="compurl" type="text" size="55" value="<%=compurl%>"></td>
          </tr>
          <tr>
            <td height="25" colspan=1 bgcolor="e0e4e8">* 
              기타</td>
            <td colspan=3><textarea name="compcontents" cols="55" rows="6" id="compcontents"><%=compcontents%>
</textarea></td>
          </tr>
        </table>
        <br />
<div class="no_bound agn_c"><span class="button bull" id="btn_save"><a>확인</a></span></div>
      </form></td>
  </tr>
</table>
