<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file="../admin_access.asp" -->
<%
include ("./ROOT_CHECK.php");
if (action == 'qde') {
        mysql_query("DELETE FROM wizCom WHERE CompID='mid'", DB_CONNECT) or die(mysql_error());  //wizCom 삭제

      if(CompSort >= 50){		/* 만약 CompSort >= 50 (판매처) 일경우 wizMembers 에저장된 정보를 삭제 */
		mysql_query("DELETE FROM wizMembers WHERE ID='mid'", DB_CONNECT) or die(mysql_error());  //wizMembers 삭제
		mysql_query("DELETE FROM wizMembersMore WHERE MID='mid'", DB_CONNECT) or die(mysql_error());  //wizMembers 삭제
		}
}
ListNo = "15";
PageNo = "20";
if(empty(page) || page <= 0) page = 1;
START_NO = (page - 1) * ListNo;

if (!sort) {sort = "UID";}
if(!WHERE) WHERE = "WHERE CompSort < '50'";
/* 
기업회원 구분(wizCom.CompSort)은 크게 공급처( <50 ) 과 소매처(50 <=, <100) 로 분류된다. 
01 : 도매공급자, 02 : 소매공급자, 03 : 생산자), 50 : 쇼핑몰(온라인)기업고객고객, 51 : 도매판매처, 52, 소매판매처 .. 경우에따라 이곳은 자유롭게 프로그램가능)
*/
TOTAL_STR = "SELECT count(*) FROM wizCom WHERE";
TOTAL_QRY = mysql_query(TOTAL_STR, DB_CONNECT);
TOTAL = @mysql_result(TOTAL_QRY, 0, 0);

//--페이지 나타내기--
TP = ceil(TOTAL / ListNo) ; /* 페이지 하단의 총 페이지수 */
CB = ceil(page / PageNo);
SP = (CB - 1) * PageNo + 1;
EP = (CB * PageNo);
TB = ceil(TP / PageNo);
//echo "\TP = TP, \CB = CB, \SP = SP, \EP = EP, \TB = TB <br />";
//--페이지링크를 작성하기--

LIST_QUERY = "SELECT * FROM wizCom WHERE ORDER BY sort DESC LIMIT START_NO,ListNo";
//echo "\LIST_QUERY = LIST_QUERY <br />";
TABLE_DATA = mysql_query(LIST_QUERY, DB_CONNECT) or die(mysql_error());
%>
<script language="javascript">
function really(){
if (confirm('\n\n삭제된 데이터는 복구가 불가능합니다.\n\n정말로 삭제하시겠습니까?\n\n')) return true;
return false;
}
</script>

<table class="table_outline">
  <tr>
    <td>
	
	<fieldset class="desc">
			<legend>거래처관리 </legend>
			<div class="notice">[note]</div>
			<div class="comment"> 본쇼핑몰의 제품공급 거래처 리스트입니다. 제품공급 거래처를 등록하면 공급 거래처별로 매출통계기능이 지원됩니다.<br />
                  [수정]을 클릭하시면 선택한 거래처에 대한 자세한 정보를 확인 및 수정을 하실 수 있습니다.<br />
                  [삭제]는 거래처 삭제시 [등록]은 신규 거래처 등록시 사용하시면 됩니다.</div>
			</fieldset>
			<p></p>
      <table class="table_main w_default">
        <tr>
          <th>거래처명</th>
          <th>지역</th>
          <th>대표자</th>
          <th>담당자 (휴대폰)</th>
          <th>전화</th>
          <th>팩스</th>
          <th>&nbsp;</th>
        </tr>
        <%
while( LIST = mysql_fetch_array( TABLE_DATA ) ) :
AREA = split(" ",LIST[CompAddress1]);
%>
        <tr align="center" height=22>
          <td align=LEFT><div align="CENTER"><font color=#C85602> <%=LIST[CompName]%> </b></div></td>
          <td><%=AREA[0]%> </td>
          <td><%=LIST[CompPreName]%> </td>
          <td><A HREF='mailto:<%=LIST[CompChaEmail]%>'><font color='#0000FF'><%=LIST[CompChaName]%>(<%=LIST[CompChaTel]%>)</A> </td>
          <td> <%=LIST[CompTel]%> </td>
          <td><font color=BLUE> <%=LIST[CompFax]%> </td>
          <td><a href='<%=PHP_SELF%>?menu6=show&theme=basic_info5_1&uid=<%=LIST[UID]%>&smode=modify&page=<%=page%>'><font color="#0000FF"><img src="img/mo.gif" width="44" height="20" hspace="1" border="0"></a> <a href='<%=PHP_SELF%>?menu6=show&theme=<%=theme%>&action=qde&mid=<%=LIST[CompID]%>&page=<%=page%>&CompSort=<%=LIST[CompSort]%>' onClick='return really()'><font color="#0000FF"><img src="img/util_icon5.gif" width="44" height="20" hspace="0" border="0"></a></td>
        </tr>
        <%
endwhile;
%>
      </table>
      <table class="table_main w_default">
        <tr>
          <td align="center"><%
/* 페이지 번호 리스트 부분 */
/* PREVIOUS or First 부분 */
PostValue = "WHERE=WHERE&menu6=show&theme=member1&keyword=keyword&sorting=sorting&add=add&Sex=Sex&Dsort=Dsort&SYear=SYear&SMonth=SMonth&SDay=SDay";	  
if ( CB > 1 ) {
PREV_PAGE = SP - 1;
echo "<a href='PHP_SELF?page=PREV_PAGE&PostValue'><img src='./img/pre.gif' hspace='5' border='0'></a>";
} else {
echo "<img src='./img/pre.gif' hspace='5' border='0'>";
 }

/* LISTING NUMBER PART */
for (i = SP; i <= EP && i <= TP ; i++) {
if(page == i){NUMBER_SHAPE= "<font color = 'gray'>{i}";}
else NUMBER_SHAPE="<font color = 'gray'>".{i}."";
ECHO"&nbsp;<A HREF='PHP_SELF?page=i&PostValue'>NUMBER_SHAPE</a>";
}

/* NEXT or END PART */
if (CB < TB) {
NEXT_PAGE = EP + 1;
ECHO "&nbsp;<a href='PHP_SELF?page=NEXT_PAGE&PostValue'><img src='./img/next.gif' hspace='5' border='0'></a>";
} else {
ECHO"&nbsp;<img src='./img/next.gif' hspace='5' border='0'>";
}
%>
          </td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" align="CENTER" height="38">
        <tr>
          <td><a href='<%=PHP_SELF%>?menu6=show&theme=basic_info5_1'><font color="#0000FF"><img src="img/util_icon7.gif" width="67" height="20" border="0"></a></td>
        </tr>
      </table></td>
  </tr>
</table>
