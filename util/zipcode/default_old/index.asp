<% Option Explicit %>
<!-- #include file = "../../../lib/cfg.common.asp" -->
<!-- #include file = "../../../config/db_connect.asp" -->
<!-- #include file = "../../../lib/class.database.asp" -->
<!-- #include file = "../../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database
%>
<%
Dim flag, form, zip1, zip2, firstaddress, secondaddress, searchmode, smode, keyword
Dim zipcode, zipArr, sido, gugun, dong, address1, address2
form			= Request("form")
zip1			= Request("zip1")
zip2			= Request("zip2")
firstaddress	= Request("firstaddress")
secondaddress	= Request("secondaddress")
searchmode		= Request("searchmode")
smode			= Request("smode")
keyword			= util.secFilter(Request("keyword"))
''Response.Write(keyword)
%>
<html>
<head>
<title>우편번호검색</title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<link href="../zipcode.css" rel="stylesheet" type="text/css">
<SCRIPT language=JavaScript>
<!--
function Copy(zip1,zip2,address1) {
	opener.document.<%=form%>.<%=zip1%>.value = zip1;
	opener.document.<%=form%>.<%=zip2%>.value = zip2;
	opener.document.<%=form%>.<%=firstaddress%>.value = address1;
	opener.document.<%=form%>.<%=secondaddress%>.focus();
	top.window.close();	
}

function check_field(){
 var f= document.zipform
 	if(f.keyword.value == ""){
		alert('동(읍,면) 이름을 입력해 주세요');
		f.keyword.focus();
		return false;	
	}else return true;

}
//-->
</SCRIPT>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0">
<table width="350" border="0" cellspacing="0" cellpadding="0" class="maintxt">
  <tr> 
    <td><img src="image/t06.gif" width="350" height="40"></td>
  </tr>
  <tr> 
    <td> <table width="350" border="0" cellspacing="0" cellpadding="5" class="stage_txt">
        <tr> 
          <td height="1" width="100" bgcolor="#DFDFDF"></td>
        </tr>
        <tr> 
          <td height="24" class="maintxt"><img src="./image/icon03.gif" width="11" height="11" hspace="4" vspace="4" align="absmiddle">주소 
            검색하기</td>
        </tr>
        <tr bgcolor="E7E7E7"> 
          <td height="1" class="maintxt"></td>
        </tr>
        <tr> 
          <td height="24" class="maintxt"><span class="text"><img src="./image/icon04.gif" width="11" height="11" hspace="6" vspace="4" align="absmiddle">거주하고 
            계신 동(읍, 면) 이름을 입력해 주세요.<br>
            <img src="./image/icon04.gif" width="11" height="11" hspace="6" vspace="4" align="absmiddle">번지는 
            따로 입력해야 합니다.</span></td>
        </tr>
        <FORM action="./index.asp" method=post name=zipform onSubmit="return check_field()">
          <input type=hidden name=smode value=search>
          <input type=hidden name=form value=<%=form%>>
          <input type=hidden name=zip1 value=<%=zip1%>>
          <input type=hidden name=zip2 value=<%=zip2%>>
          <input type=hidden name=firstaddress value=<%=firstaddress%>>
          <input type=hidden name=secondaddress value=<%=secondaddress%>>
          <input type=hidden name="searchmode" value="2">
          <tr> 
            <td height="24" class="txt"> <div align="center"> 
                <input class=maintxt style="BORDER-RIGHT: rgb(214,214,214) 1px solid; BORDER-TOP: rgb(214,214,214) 1px solid; BORDER-LEFT: rgb(214,214,214) 1px solid; BORDER-BOTTOM: rgb(214,214,214) 1px solid" 
                  maxlength=214 size=15 name="keyword">
               
                <input type="image" src="./image/bt_search.gif" width="48" height="18" align="absmiddle" vspace="0" hspace="5" border="0"></td>
          </tr>
        </form>
        <%
if smode = "search"  then
keyword = trim(keyword)
	strSQL = "select * from zipcode where dong like '%" & keyword & "%' order by sido asc, gugun asc"
	'response.write(strSQL)
	'response.end()
%>
        <tr bgcolor="E7E7E7"> 
          <td height="1" width="100" class="maintxt"></td>
        </tr>
        <tr> 
          <td height="24" class="maintxt"><img src="./image/icon03.gif" width="11" height="11" hspace="4" vspace="4" align="absmiddle">주소 
            검색하기 결과</td>
        </tr>
        <tr bgcolor="E7E7E7"> 
          <td height="1" class="maintxt"></td>
        </tr>
        <tr> 
          <td height="100" class="txt"> <%
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	while not objRs.eof
	zipcode = objRs("zipcode")
	zipArr = split(zipcode, "-")
	sido = trim(objRs("sido"))
	gugun = trim(objRs("gugun"))
	dong = trim(objRs("dong"))
	address1 = sido & " " & gugun & " " & dong

%> <a href="#" onClick="javascript: Copy('<%=trim(zipArr("0"))%>','<%=trim(zipArr("1"))%>','<%=address1%>')"> 
            <% Response.Write(zipcode & sido & gugun & dong) %>
            </a><br> <%		 
flag = 1
objRs.MOVENEXT
WEND
SET objRs =NOTHING
if flag <> 1 then
%> <a href="#">적절한 데이타를 찾을 수 없습니다.</a><%
end if
%></td>
        </tr>
        <%
end if
%>
        <tr bgcolor="E7E7E7"> 
          <td height="1" width="100"></td>
        </tr>
      </table></td>
  </tr>
</table>
<table width="50" height="5" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td></td>
  </tr>
</table>
<!--
<table width="350" height="40" border="0" cellpadding="0" cellspacing="0" background="image/t05.gif">
  <tr> 
    <td class="maintxt"><div align="right"><a href="#"onFocus='this.blur()'><img src="./image/icon_ok.gif" width="55" height="25" border="0"></a></div></td>
    <td width="20" class="maintxt">&nbsp;</td>
    <td class="maintxt"><a href="#"onFocus='this.blur()'><img src="./image/icon_cancel.gif" width="55" height="25" border="0"></a></td>
  </tr>
</table> -->
</body>
</html>
