<!-- #include file = "../../../lib/cfg.common.asp" -->
<!-- #include file = "../../../config/skin_info.asp" -->
<!-- #include file = "../../../lib/class.util.asp" -->
<!-- #include file = "../../../config/admin_info.asp" -->
<%
Dim util
Set util = new utility
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=SET_TITLE%></title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<script language="javascript" src="js/jquery-1.4.2.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/base.css" />
<link rel="stylesheet" type="text/css" href="/css/mall.css" />

</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a name="topAnchor"></a>
<!-- 따라 다니는 베너 시작 -->
<div style="left:905px; top:100px; visibility: visible; width: 150px; position: relative;"><div id="inside_box" style="position: absolute; top:0px">
<table border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="1" bgcolor="#F0F0F0"></td>
        </tr>
        <tr>
          <td align="center" bgcolor="#F2F2F2">오늘본상품1</td>
        </tr>
        <tr>
          <td height="1" bgcolor="#F0F0F0"></td>
        </tr>
        <tr>
          <td><% Call util.getClickedPd %></td>
        </tr>
      </table></td>
  </tr>
</table>
  </div>
</div>
		<script type="text/javascript">
			$(function() {	 //따라다니는 배너
				var currentPosition = parseInt($('#inside_box').css('top')); 
				$(window).scroll(function() { 
				   var position = $(window).scrollTop(); // 현재 스크롤바의 위치값을 반환
				   $('#inside_box').stop().animate({'top':position+currentPosition+'px'},500); //여기서 1000은 속도. 값이 작을수록 빨리.
				}); 
			});
		</script>
<!-- 따라 다니는 베너 끝 -->