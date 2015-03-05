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
''Set util = new utility	
Set db = new database

ctrn = "\n";

SQL = "select * from wizMailAddressBook where userid='HTTP_COOKIE_VARS[WIZMAIL_USER_ID]' order by binary name";
Rs = mysql_query(SQL);
Total = mysql_num_rows(Rs);

'' 다운로드 해더 출력 */
if(strstr(HTTP_USER_AGENT, "MSIE 5.5")) 
{ 
	header("Content-Type: doesn/matter"); 
	header("Content-Disposition: filename=addrbook.csv"); 
	header("Content-Transfer-Encoding: binary"); 
	header("Pragma: no-cache"); 
	header("Expires: 0"); 
} 
else 
{ 
	Header("Content-type: file/unknown"); 
	Header("Content-Disposition: attachment; filename=addrbook.csv"); 
	Header("Content-Description: PHP4 Generated Data"); 
	header("Pragma: no-cache"); 
	header("Expires: 0"); 
} 

echo("이름, 그룹, 전자우편, 회사, 부서, 직책, 집전화번호, 사무실전화번호, 핸드폰번호, 팩스번호, 대표번호, 우편번호, 주소, 나머지주소ctrn");

if(Total)
{
	cnts = 0;
	while(cnts < Total)
	{
		name = mysql_result(Rs,cnts,"name");
		grp = mysql_result(Rs,cnts,"grp");
		email = mysql_result(Rs,cnts,"email");
		company = mysql_result(Rs,cnts,"company");
		buseo = mysql_result(Rs,cnts,"buseo");
		work = mysql_result(Rs,cnts,"work");
		hphone = mysql_result(Rs,cnts,"hphone");
		cphone = mysql_result(Rs,cnts,"cphone");
		hand = mysql_result(Rs,cnts,"hand");
		fax = mysql_result(Rs,cnts,"fax");
		post = mysql_result(Rs,cnts,"post");
		addr1 = mysql_result(Rs,cnts,"addr1");
		addr2 = mysql_result(Rs,cnts,"addr2");
		phone = mysql_result(Rs,cnts,"phone");
		
		echo("name, grp, email, company, buseo, work, hphone, cphone, hand, fax, phone, ppost, addr1, addr2 ctrn");
		
		cnts = cnts + 1;
	}
}
%>
