<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<%@Language=vbscript%>


<%
d=Request("d")
If d="" Then
	d="m"
End if
m=Request("m")
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<script language="JavaScript">
<!--
function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}
//-->
</script>
<script LANGUAGE="JavaScript" src="cal_js.js" type="Text/JavaScript"></script>
</head>
<body>
<!-- #include file=cal_logic.asp-->
<!--#include file="lunartosol.asp"  -->

<div ID="overDiv" STYLE="position:absolute;top=50;left=100; visibility:hide; z-index:2;"></div>
<script LANGUAGE="JavaScript" src="cal_div.js" type="Text/JavaScript"></script>
<table width="750" border="1" cellspacing="0">
  <tr> 
    <td colspan="5" height="25"><font class="Add">▶ <a href="../../main.asp">업무</a> &gt;&gt; 
      일정관리</font></td>
  </tr>
  <!--<tr> 
    <td colspan="5" height="25"><font size="2" color="#000000"><img src="../../images/title01_02.gif" width="307" height="25"></font><font size="2"></font></td>
  </tr>-->
  <tr> 
    <td width="83" height="25"><img src="../../images/submenu_01_02_03.gif" width="81" height="16"></td>
    <td height="25" width="83"><img src="../../images/submenu_01_02_02.gif" width="81" height="16"></td>
    <td height="25" width="85"><img src="../../images/submenu_01_02_01.gif" width="83" height="16"></td>
    <td height="25" width="337"><img src="../../images/submenu_01_02_04.gif" width="81" height="16"></td>
    <td width="156" height="25">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="5" height="25"><font size="2" color="#000000">2000년 11월 20일, 
      월요일 (음력 10월 25일) </font></td>
  </tr>
  <tr> 
    <td valign="top" colspan="4"> 
      <table width="600" border="1" cellpadding="0" cellspacing="0" bordercolor="#336600">
      </table>
      <table width="600" border="0">
        <tr> 
          <td bgcolor="#C0DFAC" width="59"> 
            <div align="center"><font size="2">07:00</font></div>
          </td>
          <td bgcolor="#D2E8C4" width="531">1</td>
        </tr>
        <tr bgcolor="#EFEFCF"> 
          <td width="59" bgcolor="#E8E8BB"> 
            <div align="center"><font size="2">08:00</font></div>
          </td>
          <td width="531" bgcolor="#EFEFCF">1</td>
        </tr>
        <tr bgcolor="#D2E8C4"> 
          <td width="59" bgcolor="#C0DFAC"> 
            <div align="center"><font size="2">90:00</font></div>
          </td>
          <td bgcolor="#D2E8C4" width="531">1</td>
        </tr>
        <tr bgcolor="#EFEFCF"> 
          <td width="59" bgcolor="#E8E8BB"> 
            <div align="center"><font size="2">10:00</font></div>
          </td>
          <td width="531" bgcolor="#EFEFCF">1</td>
        </tr>
        <tr bgcolor="#D2E8C4"> 
          <td width="59" height="17" bgcolor="#C0DFAC"> 
            <div align="center"><font size="2">11:00</font></div>
          </td>
          <td height="17" bgcolor="#D2E8C4" width="531">1</td>
        </tr>
        <tr bgcolor="#EFEFCF"> 
          <td width="59" bgcolor="#E8E8BB"> 
            <div align="center"><font size="2">12:00</font></div>
          </td>
          <td width="531">1</td>
        </tr>
        <tr bgcolor="#D2E8C4"> 
          <td width="59" bgcolor="#C0DFAC"> 
            <div align="center"><font size="2">13:00</font></div>
          </td>
          <td width="531">1</td>
        </tr>
        <tr bgcolor="#EFEFCF"> 
          <td width="59" bgcolor="#E8E8BB"> 
            <div align="center"><font size="2">14:00</font></div>
          </td>
          <td width="531">1</td>
        </tr>
        <tr bgcolor="#D2E8C4"> 
          <td width="59" bgcolor="#C0DFAC"> 
            <div align="center"><font size="2">15:00</font></div>
          </td>
          <td width="531">1</td>
        </tr>
        <tr bgcolor="#EFEFCF"> 
          <td width="59" bgcolor="#E8E8BB"> 
            <div align="center"><font size="2">16:00</font></div>
          </td>
          <td width="531">1</td>
        </tr>
        <tr bgcolor="#D2E8C4"> 
          <td width="59" bgcolor="#C0DFAC"> 
            <div align="center"><font size="2">17:00</font></div>
          </td>
          <td width="531">1</td>
        </tr>
        <tr bgcolor="#EFEFCF"> 
          <td width="59" bgcolor="#E8E8BB"> 
            <div align="center"><font size="2">18:00</font></div>
          </td>
          <td width="531" bgcolor="#EFEFCF">1</td>
        </tr>
        <tr bgcolor="#D2E8C4"> 
          <td width="59" bgcolor="#C0DFAC"> 
            <div align="center"><font size="2">19:00</font></div>
          </td>
          <td width="531">1</td>
        </tr>
        <tr bgcolor="#EFEFCF"> 
          <td width="59" bgcolor="#E8E8BB"> 
            <div align="center"><font size="2">20:00</font></div>
          </td>
          <td width="531">1</td>
        </tr>
        <tr bgcolor="#D2E8C4"> 
          <td width="59" bgcolor="#C0DFAC"> 
            <div align="center"><font size="2">21:00</font></div>
          </td>
          <td width="531">1</td>
        </tr>
        <tr bgcolor="#EFEFCF"> 
          <td width="59" bgcolor="#E8E8BB"> 
            <div align="center"><font size="2">22:00</font></div>
          </td>
          <td width="531">1</td>
        </tr>
      </table>
      <table width="600" border="0">
        <tr> 
          <td width="92">&nbsp;</td>
          <td width="58"><img src="../../images/icon01_02_pre.gif" width="58" height="19"></td>
          <td width="148" valign="bottom"><font size="2">[11월16일]</font></td>
          <td width="70" valign="bottom">
            <div align="right"><font size="2">[11월18일]</font></div>
          </td>
          <td width="192"><img src="../../images/icon01_02_next.gif" width="58" height="19"></td>
          <td width="14">&nbsp;</td>
        </tr>
      </table>
      <br />
    </td>
    <td width="156" valign="top"> 
      <table width="150" border="0" cellspacing="10">
        <tr> 
          <td height="150">달력</td>
        </tr>
        <tr> 
          <td> 
            <select name="menu1" onChange="MM_jumpMenu('parent',this,0)">
              <option selected>2000</option>
              <option>2001</option>
              <option>2002</option>
              <option>2003</option>
              <option>2004</option>
              <option>2005</option>
            </select>
            <font size="2">년
            <select name="select" onChange="MM_jumpMenu('parent',this,0)">
              <option>01</option>
              <option>02</option>
              <option>03</option>
              <option>04</option>
              <option>05</option>
              <option>06</option>
              <option>07</option>
              <option>08</option>
              <option>09</option>
              <option>10</option>
              <option>11</option>
              <option>12</option>
            </select>
            월 </font></td>
        </tr>
        <tr> 
          <td height="80"> 
            <table width="150" border="1" cellpadding="0" cellspacing="0" bordercolor="#666666">
              <tr bgcolor="#006633" bordercolor="#006633"> 
                <td height="22"> 
                  <div align="center"><font size="2"> <font color="#FFFFFF">11월줄 
                    일정</b></font></font></div>
                </td>
              </tr>
              <tr> 
                <td height="40"><font size="2">등록된 일정이 없습니다</font></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<br />
<table width="600" border="0">
  <tr>
    <td>Copyright </td>
  </tr>
</table>
</body>
</html>
