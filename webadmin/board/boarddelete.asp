<% Option Explicit %>
<%
include ("../wizboard/func/register_globals_on.php");
include "../config/mall_info.php";
include "../config/db_connect.php";
BOARD_NAME="wizTable_{AdminBID}";
%>

<%php

if(smode==ok) {

	if(UID=='') {

ECHO "<script>window.alert('잘못된 경로의 접근입니다.');	

	self.close();

	</script>";

	exit;

	}



/******** 업로딩된 파일 삭제 **************/



	SQL_STR="SELECT UPDIR1, UPDIR2 FROM BOARD_NAME WHERE UID='UID'";

	SQLDEL_QRY=mysql_query(SQL_STR);

	LIST1=mysql_fetch_array(SQLDEL_QRY) or die(mysql_error());

	if(LIST1[UPDIR1] && file_exists("./table/AdminBID/updir/LIST1[UPDIR1]")) {

		unlink("./table/AdminBID/updir/LIST1[UPDIR1]");

	}

	if(LIST1[UPDIR2] && file_exists("./table/<br />AdminBID/updir/LIST1[UPDIR2]")) {

		unlink("./table/AdminBID/updir/LIST1[UPDIR2]");

	}

	

/******* 리플 테이블로 부터 정보 삭제 *********/	

	SQL_STR="DELETE FROM {BOARD_NAME}_reply WHERE MID='UID'";

	mysql_query(SQL_STR) or die(mysql_error());

/******* 테이블로 부터 정보 삭제 *********/

	SQL_STR="DELETE FROM BOARD_NAME WHERE UID='UID'";

	mysql_query(SQL_STR) or die(mysql_error());

	echo "<script>alert('게시물을 삭제했습니다.');

		opener.location.replace('./main.php?AdminBID=AdminBID&page=page&menu7=show&theme=boardadmin');

		self.close();

		</script>";

	exit();

}

%>

<script>

con =  confirm("정말로 삭제하시겠습니까?")

if (con==true) location.href ='<%=PHP_SELF%>?UID=<%=UID%>&page=<%=page%>&AdminBID=<%=AdminBID%>&smode=ok&menu7=show&theme=boardadmin';

            else self.close();

</script>
