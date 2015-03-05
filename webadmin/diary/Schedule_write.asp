<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
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
</head>

<body>
<table width="800" border="1">
  <tr> 
    <td colspan="5" height="25"><font class="Add">▶ <a href="../../main.asp">업무</a> &gt;&gt; 
      일정관리</font></td>
  </tr>
  <tr> 
    <td colspan="5" height="25"><font size="2" color="#000000"><img src="../../images/title01_02.gif" width="307" height="25"></font></td>
  </tr>
  <tr> 
    <td><img src="../../images/submenu_01_02_03.gif" width="81" height="16"></td>
    <td><img src="../../images/submenu_01_02_02.gif" width="81" height="16"></td>
    <td height="25" width="83"><img src="../../images/submenu_01_02_01.gif" width="83" height="16"></td>
    <td height="25" width="355"><img src="../../images/submenu_01_02_04.gif" width="81" height="16"></td>
    <td width="174" height="25">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="5" height="25"><font size="2" color="#000000">2000년 11월 20일, 
      월요일 (음력 10월 25일) </font></td>
  </tr>
  <tr> 
    <td colspan="4"> 
      <table width="100%" border="1">
        <tr> 
          <td width="57" height="25" bgcolor="#B4CE82"> 
            <div align="center"><font size="2" color="#FFFFFF">제목</b></font></div>
          </td>
          <td height="25" bgcolor="#DBECC8" valign="middle" colspan="4"> 
            <input type="text" name="textfield">
          </td>
        </tr>
        <tr> 
          <td width="57" height="25" bgcolor="#B4CE82"> 
            <div align="center"><font size="2" color="#FFFFFF">장소</b></font></div>
          </td>
          <td height="25" bgcolor="#DBECC8" colspan="4"> 
            <input type="text" name="textfield2">
          </td>
        </tr>
        <tr> 
          <td width="57" height="25" bgcolor="#B4CE82"> 
            <div align="center"><font size="2" color="#FFFFFF">일정성격</b></font></div>
          </td>
          <td height="25" bgcolor="#DBECC8" colspan="4"> 
            <select name="select2">
              <option>회의</option>
            </select>
            <select name="select3">
              <option>공개일정</option>
            </select>
          </td>
        </tr>
        <tr> 
          <td width="57" height="25" bgcolor="#B4CE82"> 
            <div align="center"><font size="2" color="#FFFFFF">시간구분</b></font></div>
          </td>
          <td width="127" valign="middle" bgcolor="#DBECC8" height="25"> <font size="2"> 
            <input type="radio" name="radiobutton" value="radiobutton">
            시간단위 일정</font></td>
          <td width="126" valign="middle" bgcolor="#DBECC8" height="25"> <font size="2"> 
            <input type="radio" name="radiobutton" value="radiobutton">
            하루종일 </font></td>
          <td width="128" valign="middle" bgcolor="#DBECC8" height="25"><font size="2"> 
            <input type="radio" name="radiobutton" value="radiobutton">
            월중행사 </font></td>
          <td width="157" valign="middle" bgcolor="#DBECC8" height="25"> <font size="2"> 
            </font></td>
        </tr>
        <tr> 
          <td width="57" height="25" bgcolor="#B4CE82"> 
            <div align="center"><font size="2" color="#FFFFFF">일자</b></font></div>
          </td>
          <td height="25" bgcolor="#DBECC8" colspan="4"> 
            <select name="select4">
              <option>2000년</option>
            </select>
            <select name="select5">
              <option>11월</option>
            </select>
            <select name="select6">
              <option>7일</option>
            </select>
          </td>
        </tr>
        <tr> 
          <td width="57" height="25" bgcolor="#B6BA1B"> 
            <div align="center"><font size="2" color="#FFFFFF">시작시간</b></font></div>
          </td>
          <td height="25" bgcolor="#EFEFCF" width="127"> 
            <select name="select7">
              <option>2 PM</option>
            </select>
            <select name="select8">
              <option>00</option>
            </select>
          </td>
          <td height="25" bgcolor="#EFEFCF" colspan="2"><font size="2" color="#339933">▶기간 
            <select name="select9">
              <option>1</option>
            </select>
            시간 
            <select name="select10">
              <option>00</option>
            </select>
            분 동안</font></font></td>
          <td height="25" bgcolor="#EFEFCF" width="157">&nbsp;</td>
        </tr>
        <tr> 
          <td width="57" height="28" bgcolor="#B6BA1B"> 
            <div align="center"><font size="2" color="#FFFFFF">종료시간</b></font></div>
          </td>
          <td height="28" bgcolor="#EFEFCF" colspan="4"> 
            <select name="select11">
              <option>3 PM</option>
            </select>
            <select name="select12">
              <option>00</option>
            </select>
          </td>
        </tr>
        <tr> 
          <td width="57" height="25" bgcolor="#B6BA1B"> 
            <div align="center"><font size="2" color="#FFFFFF">내용</b></font></div>
          </td>
          <td height="25" bgcolor="#EFEFCF" colspan="4"> 
            <textarea name="textfield3" cols="55"></textarea>
          </td>
        </tr>
        <tr> 
          <td rowspan="2" height="25" bgcolor="#B6BA1B" width="57"> 
            <div align="center"><font size="2" color="#FFFFFF">반복옵션</b></font></div>
          </td>
          <td height="50" bgcolor="#EFEFCF" colspan="4"> 
            <div align="left"><font size="2">반복적인 일정의 기간을 선택합니다.</font><br />
              <select name="select13">
                <option>반복하지 않는다</option>
              </select>
              <select name="select14">
                <option>--</option>
              </select>
            </div>
          </td>
        </tr>
        <tr> 
          <td height="50" bgcolor="#EFEFCF" colspan="4"><font size="2">입력한 반복 
            일정의 종료기간을 선택합니다.</font><br />
            <select name="select15">
              <option>2000년</option>
            </select>
            <select name="select16">
              <option>12월</option>
            </select>
            <select name="select17">
              <option>7일</option>
            </select>
            <font size="2">까지 </font></td>
        </tr>
        <tr> 
          <td colspan="2" height="25">&nbsp;</td>
          <td width="126" height="25"> 
            <div align="center"><img src="../../images/icon01_02_save.gif" width="49" height="15"></div>
          </td>
          <td width="128" height="25"><img src="../../images/icon01_02_cancel.gif" width="51" height="15"></td>
          <td width="157" height="25">&nbsp;</td>
        </tr>
      </table>
      <br />
    </td>
    <td width="174" valign="top"> 
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
            <table width="150" border="1" cellpadding="0" cellspacing="0" bordercolor="#006633">
              <tr bgcolor="#006633"> 
                <td height="22"> 
                  <div align="center"><font size="2"> <font color="#FFFFFF">11월줄 
                    일정</font></b></font></div>
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
