<%@LANGUAGE="VBSCRIPT"%>
<% Option Explicit %>
<!-- #include file = "../lib/cfg.common.asp" -->
<!-- #include file = "../config/db_connect.asp" -->
<!-- #include file = "../lib/class.database.asp" -->
<!-- #include file="./admin_access.asp" -->
<%
Dim exe_file, theme, menushow
Dim whereis, objRs, strSQL, gid_conf, tmp_gid_conf ''left menu용
Dim db,util
''Set util = new utility	
theme			= Request("theme")
menushow	= Request("menushow")
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>WizMall_Admin Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<script language="javascript" type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
<script language="javascript" type="text/javascript" src="../js/jquery.plugins/jquery-ui-1.7.2/js/jquery-ui-1.7.2.custom.min.js"></script>
<script language="javascript" type="text/javascript" src="../js/editor.js"></script>
<script language="javascript" type="text/javascript" src="../js/GoodWord.js"> </script>
<script language="javascript" type="text/javascript" src="../js/wizmall.js"></script>
<script language="javascript" type="text/javascript" src="./common/admin.js"></script>
<link rel="stylesheet" href="../css/base.css" type="text/css">
<link rel="stylesheet" href="../css/admin.css" type="text/css">

<link rel="stylesheet" type="text/css" href="../js/jquery.plugins/jquery-ui-1.7.2/css/ui-lightness/jquery-ui-1.7.2.custom.css"  />
<script language="javascript" type="text/javascript">
<!--
$(function(){
	$(".altern th:odd").addClass("bg3"); //basic이라는 클래스네임을 가진 요소의 tr 요소 중 홀수번째에 bg1클래스 부여
	$(".altern th:even").addClass("bg4");
	$(".list tr:odd").addClass("bg1");
	$(".list tr:even").addClass("bg2");

});
//-->
</script>
</head>
<body text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"> 
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0"> 
  <tr> 
    <td valign="top" width="100%"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="200" height="5" bgcolor="#669933"><table width="200" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="200" height="5"> </td>
              </tr>
            </table> </td>
        <td width="14"> </td>
        <td width="879" bgcolor="#003300"><table width="879" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="879" height="5"></td>
              </tr>
            </table> </td>
        <td bgcolor="f2f2f2"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="5"> </td>
              </tr>
            </table> </td>
      </tr>
    </table></td> 
  </tr>
  <tr>
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="200" height="50" align="center"><a href="main.asp?menushow=menu0&theme=front"><strong><font color="#336600" style="font-size:20px">위즈몰<br>
            관리자페이지</strong></a></td>
          <td><SCRIPT LANGUAGE='JavaScript'>document.write(quote);</SCRIPT></td>
        </tr>
      </table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="30" bgcolor="5A9D28"> 
      <table border="0" cellspacing="0" cellpadding="0" height="30" align="left">
              <tr> 
                <td width="100" align="center" onMouseOver="this.style.background='#70AF41'" onMouseOut="this.style.background='#5A9D28'"> 
                  <a href="./main.asp?menushow=menu1&theme=basicinfo/basic_info2" class="topnavigation"><b>기본환경</b></a></td>
                <td width="1" align="center"> </td>
               <td width="100" align="center" onMouseOver="this.style.background='#70AF41'" onMouseOut="this.style.background='#5A9D28'"> 
                  <a href="./main.asp?menushow=menu2&theme=product/product1" class="topnavigation"><b>상품관리</b></a></td>
                <td width="1" align="center"> </td>
               <td width="100" align="center" onMouseOver="this.style.background='#70AF41'" onMouseOut="this.style.background='#5A9D28'"> 
                  <a href="./main.asp?menushow=menu3&theme=category/shopmanager1" class="topnavigation"><b>매장관리</b></a></td>
                <td width="1"> </td>
               <td width="100" align="center" onMouseOver="this.style.background='#70AF41'" onMouseOut="this.style.background='#5A9D28'"> 
                  <a href="./main.asp?menushow=menu4&theme=order/order1" class="topnavigation"><b>주문배송관리</b></a></td>
                <td width="1"> </td>
               <td width="100" align="center" onMouseOver="this.style.background='#70AF41'" onMouseOut="this.style.background='#5A9D28'"> 
                  <a href="./main.asp?menushow=menu6&theme=member/member1" class="topnavigation"><b>회원관리</b></a></td>
                <td width="1"> </td>
                <td width="100" align="center" onMouseOver="this.style.background='#70AF41'" onMouseOut="this.style.background='#5A9D28'"> 
                  <a href="./main.asp?menushow=menu11&theme=mail/mailer1" class="topnavigation"><b>메일링</b></a></td>
                <td width="1"> </td>
               <td width="100" align="center" onMouseOver="this.style.background='#70AF41'" onMouseOut="this.style.background='#5A9D28'"> 
                  <a href="./main.asp?menushow=menu7&theme=board/boardadmin" class="topnavigation"><b>게시판관리</b></a></td>
                <td width="1"> </td>
                <td width="100" align="center" onMouseOver="this.style.background='#70AF41'" onMouseOut="this.style.background='#5A9D28'"> 
                  <a href="main.asp?menushow=menu8&theme=visit/visit_start" class="topnavigation"><b>방문자통계</b></a></td>
                <td width="1"> </td>
               <td width="100" align="center" onMouseOver="this.style.background='#70AF41'" onMouseOut="this.style.background='#5A9D28'"> 
                  <a href="./main.asp?menushow=menu9&theme=statistic/statistic10" class="topnavigation"><b>매출통계</b></a></td>
                <td width="1"> </td>
                <!--<td width="100" align="center" onMouseOver="this.style.background='#70AF41'" onMouseOut="this.style.background='#5A9D28'"> 
                  <a href="./main.asp?menushow=menu10&theme=coorbuy1" class="topnavigation"><b>옵션</b></a></td>
                <td width="1"> </td>
                --><!--<td width="100" align="center" onMouseOver="this.style.background='#70AF41'" onMouseOut="this.style.background='#5A9D28'"> 
                  <a href="./main.asp?menushow=menu13&theme=inquire/inquire1&iid=inq1" class="topnavigation"><b>문의관리</b></a></td>
                <td width="1"> </td>-->
<td width="100" align="center" onMouseOver="this.style.background='#70AF41'" onMouseOut="this.style.background='#5A9D28'"> 
                  <a href="./main.asp?menushow=menu13&theme=poll/poll_list" class="topnavigation"><b>기타관리</b></a></td>
                <td width="1"> </td>	
<td width="100" align="center" onMouseOver="this.style.background='#70AF41'" onMouseOut="this.style.background='#5A9D28'"> 
                  <a href="javascript:wizwindow('./about/about.asp','about_wizmall', 'width=300, height=300')" class="topnavigation"><b>ABOUT</b></a></td>
                <td width="1"> </td>	                
              </tr>
            </table>
    </td>
  </tr>
  <tr> 
    <td height="1"></td>
  </tr>
</table></td>
  </tr>
  <tr>
    <td height="100%" valign="top"><table width="100%" height="100%"  border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="186" height="100%" valign="top" bgcolor="f0f0f0">
<!-- #include file = "./admin_left_menu.asp" --></td>
          <td valign="top"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td bgcolor="5A9D28"><img src="img/admintop_img01.gif" width="762" height="75"></td>
              </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="2%">&nbsp;</td>
                <td width="98%"><br> 
<%
if theme <> "" then
	exe_file = "./" & theme & ".asp"
	if exe_file <> "" THEN SERVER.EXECUTE(exe_file)
else
	Response.Write("theme 값이 존재 하지 않습니다.")
end if
%>
                  <br></td>
              </tr>
            </table>
            
          </td>
        <td>&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td bgcolor="C8C8C8" height="1"></td>
  </tr>
  <tr> 
          <td><table width="879" border="0" cellspacing="0" cellpadding="0" class="font_1">
              <tr> 
                <td width="879" height="50" align="center">Copyright ⓒ 2006 shopwiz 
                  . All rights reserved. Powered by <a href="http://www.shop-wiz.com" target="_blank">shop-wiz.com</a>
                </td>
              </tr>
            </table></td>
  </tr>
  <tr> 
    <td bgcolor="C8C8C8" height="1"></td>
  </tr>
</table>
    </td>
  </tr>
</table> 
</body>
</html>
