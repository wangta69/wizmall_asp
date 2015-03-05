<% Option Explicit %>
<!-- #include file = "../../../lib/cfg.common.asp" -->
<!-- #include file = "../../../config/skin_info.asp" -->
<!-- #include file = "../../../config/db_connect.asp" -->
<!-- #include file = "../../../lib/class.database.asp" -->
<!-- #include file = "../../../lib/class.util.asp" -->
<%
Dim code,displayID,cat_no,cat_name,bigcode,big_code,GoodsNoShow,show_hidden,ahref
Dim FMENU_NUM, sub_cat_no, sub_cat_name
Dim db, strSQL, strSQL1,objRs,objRs1, cmd, params, result, sqlsubcount
Dim util, LoopCnt
Set util = new utility
Set db = new database
code = Request("code")
%>
<script language="javascript" type="text/javascript">
<!--
$(function(){
	$(".menu_click").click(function(i){
		$(".submenu").hide();
		$(".submenu").eq($(".menu_click").index(this)).show(); //메서드
	});	
});
//-->
</script>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><%
if session("user_info") <> "" then
%>
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td>&nbsp;</td>
          <td><%=user_id%>
            님이 로그인 중입니다.</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>포인트 :<%=user_point%></td>
        </tr>
        <tr align="right">
          <td colspan="2"><a href="wizmember/log_out.asp">로그아웃</a></td>
        </tr>
        <tr align="right">
          <td colspan="2"><a href="wizmember.asp?smode=info">정보변경</a><img src="./skinwiz/layout/<%=LayoutSkin%>/images/idpasssearch_btn.gif" width="85" height="18" vspace="3" align="absmiddle"></td>
        </tr>
      </table>
      <%
else
%>
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <script language="JavaScript">
<!--
function LoginCheckForm(){

var f=document.LoginCheck;

  if(f.wizmemberID.value == ''){
	  alert('ID를 입력해주세요');
	  f.wizmemberID.focus();
  return false;
  } else if(f.wizmemberPWD.value == ''){
	  alert('패스워드를 입력하세요');
	  f.wizmemberPWD.focus();
  return false;
  }
 }
//-->
</script>
        <form action='./wizmember/log_check.asp' method="POST" name="LoginCheck" onsubmit='return LoginCheckForm();'>
          <input type="hidden" name="action" value="login_check">
          <tr>
            <td><img src="./skinwiz/layout/<%=LayoutSkin%>/images/id_txt.gif" width="32" height="22"></td>
            <td><input name="login_id" type="text"  class="input" id="wizmemberID" size="21" tabindex="1"></td>
          </tr>
          <tr>
            <td><img src="./skinwiz/layout/<%=LayoutSkin%>/images/pwd_txt.gif" width="32" height="22"></td>
            <td><input name="login_pwd" type="password" class="input" id="wizmemberPWD" size="21" tabindex="2"></td>
          </tr>
          <tr align="right">
            <td colspan="2"><input type="image" src="./skinwiz/layout/<%=LayoutSkin%>/images/login_btn.gif" width="137" height="18"></td>
          </tr>
          <tr align="right">
            <td colspan="2"><a href="wizmember.asp?smode=regis_step1"><img src="./skinwiz/layout/<%=LayoutSkin%>/images/member_reg_btn.gif" width="69" height="18" hspace="3" border="0" align="absmiddle"></a><a href="wizmember.asp?smode=idpasssearch"><img src="./skinwiz/layout/<%=LayoutSkin%>/images/idpasssearch_btn.gif" width="85" height="18" vspace="3" border="0" align="absmiddle"></a></td>
          </tr>
        </form>
      </table>
<%
end if
%>
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="right"><img src="./skinwiz/layout/<%=LayoutSkin%>/images/product_cat_btn.gif" width="160" height="33"></td>
        </tr>
        <tr>
          <td align="right"><table width="160" border="0" cellspacing="0" cellpadding="0">
<%
displayID = 1
strSQL		= "select cat_no, cat_name from wizcategory where len(cat_no) = 3 and cat_flag = 'wizmall' and  (cat_disable is null or cat_disable <> 1) order by cat_order asc"
Set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
while not objRs.eof
	cat_no		= objRs("cat_no")
	cat_name	= objRs("cat_name")
	bigcode		= cat_no
	big_code	= right(code, 3) '' wizmart에서 넘어온 코드값의 대분류 코드값을 구한다 
	
	'' 하위 카테고리 유무 책크
	strSQL1 = "select count(*) from wizcategory where Right(cat_no, 3) = '"&bigcode&"'"
	Set objRs1 = db.ExecSQLReturnRS(strSQL1, Nothing, DbConnect)
	sqlsubcount = objRs1(0)
	
	'' 카테고리별 등록 상품수를 구한다. 
	if GoodsNoShow  = "checked" then
		strSQL1 =  "select count(*) from wizmall where Right(category, 3) = '"&bigcode&"'"
		Set objRs1 = db.ExecSQLReturnRS(strSQL1, Nothing, DbConnect)
		TotalGoodsNo = "("&objRs1(0)&")"
	end if


	if bigcode = big_code then
		show_hidden = "show"
	else
		show_hidden = "none" ''wizmart에서 넘어온 대분류 코드값과 현대 wizCategory의 대분류 코드값을 비교해 토글 display 유무를 결정한다.
	end if

'' 하위 카테고리 유무 책크 및 토글을 입력한다 
	if sqlsubcount > 1 then 
		ahref = "<A class='menu_click'>"
	else 
		ahref = "<A HREF='./wizmart.asp?code="&cat_no&"'>"
	end if
'' 대분류 리스트
	Response.Write "<tr><td width='167' height='25' background='./skinwiz/layout/"&LayoutSkin&"/images/product_cat_bg.gif' style='text-align:left'><img src='./skinwiz/layout/"&LayoutSkin&"/images/product_cat_icon.gif' width='19' height='7' align='absmiddle'>"& ahref & cat_name&"</a><FONT COLOR='GRAY'>"&FMENU_NUM&"</FONT></td><tr>"&Chr(13)&Chr(10)
						  
'' 중분류 카테고리를 리스트 한다.
	if sqlsubcount > 1 then
			
			Response.Write "<tr><td><DIV class='submenu' style='display:"&show_hidden&";margin-left:15px'><TABLE border=0 VALIGN=TOP cellpadding=0 cellspacing=1  WIDTH=140>"&Chr(13)&Chr(10)
			strSQL1 = "select cat_no, cat_name from wizCategory where len(cat_no) = 6 and right(cat_no, 3) = '"&bigcode&"' and cat_flag='wizmall' and  (cat_disable is null or cat_disable <> 1) order by cat_order asc"
			Set objRs1 = db.ExecSQLReturnRS(strSQL1, Nothing, DbConnect)
			while not objRs1.eof
				sub_cat_no		= objRs1("cat_no")
				sub_cat_name	= objRs1("cat_name")
				Response.Write "<TR><TD HEIGHT=21>&nbsp;.<A HREF='./wizmart.asp?code="&sub_cat_no&"'><FONT COLOR=#263000>"&sub_cat_name&"</FONT></A></TD></TR>"&Chr(13)&Chr(10)
			objRs1.MOVENEXT
			WEND
			Response.Write "</table></DIV></td></tr>"&Chr(13)&Chr(10)
	displayID = displayID + 1
	end if

objRs.MOVENEXT
Wend
Set objRs	= Nothing : Set objRs1	= Nothing
%>
            </table></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
<%
Dim bannerList(10)
Call util.getBanners(5, 160, 68)
For LoopCnt=0 to Ubound(bannerList) 
If bannerList(LoopCnt) <> "" then
%>  
  <tr>
    <td align="right"><%=bannerList(LoopCnt)%></td>
  </tr>
  <tr>
    <td align="right">&nbsp;</td>
  </tr>
<%
End If
Next
%>  
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
