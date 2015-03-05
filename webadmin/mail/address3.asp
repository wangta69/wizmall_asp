<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
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

Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database
%>
<table cellspacing=0 bordercolordark=white width="100%" bgcolor=#c0c0c0 bordercolorlight=#dddddd border=1>
  <tr> 
    <td colspan='2'>

	  <table cellpadding='0' cellspacing='0' border='0' width='100%'>
        <tr height='20'><td colspan='3'></td></tr>
        <tr height='30'> 
          <td width='5%'>&nbsp;</td>
          <td width='75%'>
주소록 가져오기</b></td>
          <td width='20%'></td>
        </tr>
      </table>
	</td>
  </tr>
  <tr valign='top'>
    <td>

<%

addrfn = HTTP_COOKIE_VARS[WIZMAIL_USER_ID] . ".csv";

/* CSV -> DB */
if((dbupdate == "Y") and (file_exists("./maildata/addrfn")) and (md5(key) == key2))
{
	file = fopen("./maildata/addrfn", "r");
	temp = fgets(file, 10000);

	sql_delete = "delete from wizMailAddressBook where userid='IUID'";
	mysql_query(sql_delete);

	date = time();
	count = 0;
	while(temp = fgets(file, 10000))
	{
		dat_temp = split(",", temp, 14);

		if(strlen(trim(dat_temp[0])) > 1)
		{
			if(strlen(trim(dat_temp[10])) > 1)
				phone = trim(dat_temp[10]);
			else
				phone = "1";

			/* 최대값 구하기 */
			SQL = "select max(idx) as cnt from wizMailAddressBook where userid='HTTP_COOKIE_VARS[WIZMAIL_USER_ID]'";
			Rs = mysql_query(SQL);
			idx = mysql_result(Rs,0,"cnt");
			idx = idx + 1;

			/* 쿼리문 조합 */
			SQL = "insert into wizMailAddressBook values ";
			SQL .= "(idx, ";
			SQL .= "'HTTP_COOKIE_VARS[WIZMAIL_USER_ID]', ";
			SQL .= "'". strtoupper(trim(dat_temp[0])) ."', ";
			SQL .= "'". strtoupper(trim(dat_temp[1])) ."', ";
			SQL .= "'". trim(dat_temp[2]) ."', ";
			SQL .= "'". trim(dat_temp[3]) ."', ";
			SQL .= "'". trim(dat_temp[4]) ."', ";
			SQL .= "'". trim(dat_temp[5]) ."', ";
			SQL .= "'". trim(dat_temp[6]) ."', ";
			SQL .= "'". trim(dat_temp[7]) ."', ";
			SQL .= "'". trim(dat_temp[8]) ."', ";
			SQL .= "'". trim(dat_temp[9]) ."', ";
			SQL .= "'". trim(dat_temp[11]) ."', ";
			SQL .= "'". trim(dat_temp[12]) ."', ";
			SQL .= "'". trim(dat_temp[13]) ."', ";
			SQL .= "'', ";
			SQL .= "'date', ";
			SQL .= "'0', ";
			SQL .= "'". phone ."')";
			mysql_query(SQL);
		}

		count++;
	}

	fclose(file);
	unlink("./maildata/addrfn");
}

/* CSV 파일 업로드 */
if(strlen(csvfn_name) > 3) 
{
	datafolder = "./maildata/" . addrfn;
	copy(csvfn, datafolder);
	unlink(csvfn);

	csv_upload = "Y";
}
%>
<table width='98%' border='0' align='center' cellpadding='0' cellspacing='0'>
  <tr valign='top'>
    <td colspan='2'>
<table width='100%' border='0' align='center' cellpadding='0' cellspacing='0'>
  <tr> 
    <td colspan='2'>
	  <table cellpadding='0' cellspacing='0' border='0'>
        <tr height='20'> 
                      <td width='13'>&nbsp;</td>
<%

if(csv_upload == "Y")
	echo("<td>CSV --> DB</td>");
else
	echo("<td>PC --> SERVER</td>");

%>
        </tr>
      </table>
	</td>
  </tr>
  <tr> 
    <td colspan='2'> 
	  <table cellpadding='0' cellspacing='0' border='0' width='100%'>
        <tr height='2'><td></td></tr>
<%		

if(csv_upload != "Y"):
%>
        <tr height='23'> 
                      <td width='150' bgcolor='#f2f2f2'>&nbsp;&nbsp; CSV 파일</td>
<Form method='POST' action='<%=PHP_SELF%>' name='addrbook' ENCTYPE='MULTIPART/FORM-DATA'>
<input type="hidden" name="menu2" value="show">
<input type="hidden" name="theme" value="<%=theme%>">
          <td>&nbsp;<input type='file' name='csvfn' maxlength='10' class='input' onblur="this.style.backgroundColor='#F7F7F7'" onfocus="this.style.backgroundColor='#E2F5FF'"></td>
</form>
        </tr>
<% endif; %>		
        <tr height='2'><td></td></tr>
	  </table>
<%

if((csv_upload == "Y") and (file_exists("./maildata/addrfn")))
{
	file = fopen("./maildata/addrfn", "r");
	temp = fgets(file, 10000);

%>
	  <table cellpadding='0' cellspacing='0' border='0' width='100%'>
        <tr height='23' bgcolor='#f2f2f2' align='center'> 
          <td>이름</td>
          <td>그룹</td>
		  <td>전자우편</td>
		  <td>회사</td>
		  <td>부서</td>
		  <td>집전화</td>
		  <td>사무실전화</td>
		  <td>핸드폰</td>
        </tr>
<%		

count = 0;
while(temp = fgets(file, 10000))
{
	dat_temp = split(",", temp, 14);

%>
        <tr height='22' align='center'> 
          <td><%=dat_temp[0]%></td>
          <td><%=dat_temp[1]%></td>
		  <td><%=dat_temp[2]%></td>
		  <td><%=dat_temp[3]%></td>
		  <td><%=dat_temp[4]%></td>
		  <td><%=dat_temp[6]%></td>
		  <td><%=dat_temp[7]%></td>
		  <td><%=dat_temp[8]%></td>
        </tr>
<%		
	count++;
}
fclose(file);
%>
      </table>
<%
}
%>
	</td>
  </tr>
  <tr><td colspan='2' height='1'></td></tr>
  <tr> 
    <td colspan='2'>
<%

key = time();
key2 = md5(key);

if(csv_upload == "Y"):
%>
<a href="javascript:if(confirm('\n주소록을 업데이트합니다.\n\n업데이트 작업을 계속 진행하실려면 확인을 누르세요\n\n')){location.href='<%=PHP_SELF%>?menu2=show&theme=<%=theme%>&dbupdate=Y&key=<%=key%>&key2=<%=key2%>';}"><img src='img/button12.gif' width="46" height="20" border='0'></a>
<%
else:
%>
<a href='javascript:document.addrbook.submit();'><img src='img/button12.gif' width="46" height="20" border='0'></a>
<%
endif;
%>
	</td>
  </tr>
</table>
	</td>
  </tr>
</table>
<%
mysql_close(DB_CONNECT);
%>
	</td>
  </tr>
</table>
