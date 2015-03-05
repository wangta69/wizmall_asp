<SCRIPT LANGUAGE=javascript>


function num_plus(num){


	gnum = parseInt(num.BUYNUM.value);


	num.BUYNUM.value = gnum + 1;


	return;


}


function num_minus(num){





	gnum = parseInt(num.BUYNUM.value);


	if( gnum > 1 ){


		num.BUYNUM.value = gnum - 1;


	}	


	return;


}


function is_number(){


 	if ((event.keyCode<48)||(event.keyCode>57)){


  		alert("\n\n수량은 숫자만 입력하셔야 합니다.\n\n");


  		event.returnValue=false;


 	}


}


</SCRIPT>


<DIV ALIGN=CENTER>


<TABLE WIDTH='95%' CELLSPACING=0 CELLPADDING=0 BORDER=0>


<TR>


<TD HEIGHT='71' BACKGROUND='./mall_skin/shop/<%ECHO"SKIN";%>/image/cmp_ttbg.gif'><IMG SRC='./mall_skin/shop/<%ECHO"SKIN";%>/image/cmp_tt.gif'></TD>


<TD HEIGHT='71' BACKGROUND='./mall_skin/shop/<%ECHO"SKIN";%>/image/cmp_ttbg.gif' ALIGN=RIGHT>


<FONT COLOR='#081E8A'>다음은 고객님께서 선택하신 제품리스트입니다.</FONT>


</TD>


</TR>


</TABLE>


<%





while (list(key,no) = each(HTTP_GET_VARS)) :


	if(ereg("multi", key)) :


		VIEW_QUERY = "SELECT * FROM wizMall WHERE UID='no'";


		VIEW_DATA = mysql_fetch_array(mysql_query(VIEW_QUERY, DB_CONNECT));





		UID = VIEW_DATA[UID];


		PID = VIEW_DATA[PID];


		NAME = stripslashes(VIEW_DATA[NAME]);


		COMPNAME = stripslashes(VIEW_DATA[COMPNAME]);


		CHECK = number_format(VIEW_DATA[CHECK]);


		//SAIL = number_format(VIEW_DATA[SAIL]);


		SIZE = VIEW_DATA[SIZE];


		COLOR = VIEW_DATA[COLOR];


		SMALLPIC = VIEW_DATA[SMALLPIC];


		BIGPIC = VIEW_DATA[BIGPIC];


		MOVIE = VIEW_DATA[MOVIE];


		POINT = number_format(VIEW_DATA[POINT]);


		OPTI = VIEW_DATA[OPTI];


		NONE = VIEW_DATA[NONE];


		GET = VIEW_DATA[GET];


		PUT = VIEW_DATA[PUT];


		DATE = VIEW_DATA[DATE];


		//SHORTCON = stripslashes(VIEW_DATA[SHORTCON]);


		//LONGCON = stripslashes(VIEW_DATA[LONGCON]);


		CATEGORY = VIEW_DATA[CATEGORY];


		MODEL = stripslashes(VIEW_DATA[MODEL]);


		//HIT = VIEW_DATA[HIT];


		CAT_SPL = split(">", CATEGORY);


		if (file_exists("./upload/BIGPIC")) {


			Vpic_size = GetImageSize("./upload/BIGPIC");


			VPIC_FILE = "../../../upload/BIGPIC";


		}


%>





		<TABLE WIDTH='95%' HEIGHT='200' CELLSPACING=0 CELLPADDING=0 BORDER=0>


		<FORM NAME='view_form<%ECHO"no";%>' ACTION='./wizbag.php'>


		<INPUT TYPE=HIDDEN NAME='query' VALUE='cart_save'>


		<INPUT TYPE=HIDDEN NAME='no' VALUE='<%ECHO"no";%>'>


		<TR>


		<TD WIDTH='35%' ALIGN=CENTER>


		<A HREF='./wizmart.php?sort=<%ECHO"CATEGORY";%>&query=view&no=<%ECHO"UID";%>'><IMG SRC='./upload/<%ECHO"SMALLPIC";%>' BORDER=0></A>


		<P>





		<A HREF='#' onclick="javascript:window.open('./mall_skin/shop/<%ECHO"SKIN";%>/picview.php?file=<%ECHO"VPIC_FILE";%>&subject=<%ECHO"NAME";%>', 'kimsmall','width=<%ECHO"Vpic_size[0]";%>,height=<%ECHO"Vpic_size[1]";%>,statusbar=no,scrollbars=no,toolbar=no,resizable=no')"><IMG SRC='./mall_skin/shop/<%ECHO"SKIN";%>/image/co_zoom.gif' BORDER=0></A>


		<%


		if (MOVIE) {


			ECHO "<A HREF='./upload/MOVIE'><IMG SRC='./mall_skin/shop/SKIN/image/co_movie.gif' BORDER=0></A>";


		}


		%>





		</TD>


		<TD WIDTH='1' BACKGROUND='./mall_skin/shop/<%ECHO"SKIN";%>/image/vline1.gif'><IMG SRC='./mall_image/blank.gif' WIDTH=1></TD>


		<TD WIDTH='15'><IMG SRC='./mall_image/blank.gif' WIDTH=15></TD>


		<TD WIDTH='65%' VALIGN=TOP>





		<TABLE WIDTH='100%' CELLSPACING=0 CELLPADDING=0 BORDER=0>


		<TR HEIGHT=22>


		<TD COLSPAN=2><FONT COLOR='#CE6500' SIZE=3 FACE=돋움><B><%ECHO"NAME MODEL";%></B></FONT></TD>


		</TR>





		<TR>


		<TD COLSPAN=2 HEIGHT=30>판매가격 : <FONT COLOR='#CE6500'><B><%ECHO"CHECK";%>원</B></FONT></TD>


		</TR>





		<TR>


		<TD COLSPAN=2 HEIGHT=20><FONT COLOR='GRAY'>제품위치 : 


		<%


		for(i = 0; i < sizeof(CAT_SPL); i++) {





			if (i == 0) {CAT_STR = CAT_SPL[0];} else {CAT_STR = CAT_STR.">".CAT_SPL[i];}


			ECHO "<A HREF='./wizmart.php?sort=CAT_STR'><FONT COLOR='GRAY'>CAT_SPL[i]</FONT></A>";


			if (i < sizeof(CAT_SPL)-1) {


				ECHO " > ";


			}


		}


		%>


		</FONT></TD>


		</TR>





		<TR><TD COLSPAN=2 HEIGHT=25>


		<%


		if (OPTI) {


			if (OPTI == '신규') {


				ECHO "<IMG SRC='./mall_skin/shop/SKIN/image/new.gif'><BR>";


			}


			elseif (OPTI == '추천') {


				ECHO "<IMG SRC='./mall_skin/shop/SKIN/image/req.gif'><BR>";


			}


			elseif (OPTI == '기획') {


				ECHO "<IMG SRC='./mall_skin/shop/SKIN/image/plan.gif'><BR>";


			}


			elseif (OPTI == '히트') {


				ECHO "<IMG SRC='./mall_skin/shop/SKIN/image/hit.gif'><BR>";


			}


			else {


				ECHO "<IMG SRC='./mall_skin/shop/SKIN/image/special.gif'><BR>";


			}


		}


		%>


		</TD></TR>


		<TR>


		<TD COLSPAN=2 BACKGROUND='./mall_skin/shop/<%ECHO"SKIN";%>/image/list_line.gif' HEIGHT=1> </TD>


		</TR>


		<TR>


		<TD COLSPAN=2 HEIGHT=5> </TD>


		</TR>





		<TR HEIGHT=22>


		<TD WIDTH=130>제조사</TD><TD>: <%ECHO"COMPNAME";%></TD>


		</TR>


		<TR HEIGHT=22>


		<TD WIDTH=130>적립금</TD><TD>: <%ECHO"POINT";%>포인트</TD>


		</TR>





		<%if (SIZE) :%>


		<%SIZE_DATA = split("\n", SIZE);%>


		<TR HEIGHT=22>


		<TD WIDTH=130>옵션</TD><TD>: <SELECT NAME=SIZE STYLE='font-family:돋움;'>


		<%


		if (eregi("=", SIZE)) {





			ECHO "<OPTION VALUE=''>기본옵션 적용</OPTION>


			<OPTION VALUE=''>--------------</OPTION>";





			for(i = 0; i < sizeof(SIZE_DATA) && chop(SIZE_DATA[i]); i++) {


				SIZE_DATA_SPL = split("=", chop(SIZE_DATA[i]));


				ECHO "<OPTION VALUE='".chop(SIZE_DATA[i])."'>".SIZE_DATA_SPL[0]." (".number_format(SIZE_DATA_SPL[1])."원추가)</OPTION>";


			}


		}


		else {


			for(i = 0; i < sizeof(SIZE_DATA) && chop(SIZE_DATA[i]); i++) {


				ECHO "<OPTION VALUE='".chop(SIZE_DATA[i])."'>".chop(SIZE_DATA[i])."</OPTION>";


			}


		}


		%>


		</SELECT>


		</TD>


		</TR>


		<%endif;%>





		<%if (COLOR) :%>


		<%COLOR_DATA = split("\n", COLOR);%>


		<TR HEIGHT=22>


		<TD WIDTH=130>색상</TD><TD>: <SELECT NAME=COLOR STYLE='font-family:돋움;'>


		<%


		for(i = 0; i < sizeof(COLOR_DATA) && chop(COLOR_DATA[i]); i++) {


			ECHO "<OPTION VALUE='".chop(COLOR_DATA[i])."'>".chop(COLOR_DATA[i])."</OPTION>";


		}


		%>


		</SELECT>


		</TD>


		</TR>


		<%endif;%>





		<TR HEIGHT=22>


		<TD WIDTH=130>주문수량</TD><TD>





		<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0>


		<TR>


		<TD ROWSPAN=2>: <INPUT TYPE=TEXT SIZE=5 NAME="BUYNUM" MAXLENGTH=5 VALUE="1" onkeypress="is_number()"></TD>


		<TD><A href="javascript:num_plus(document.view_form<%ECHO"no";%>);"><IMG src="./mall_image/num_plus.gif" border=0></A></TD>


		<TD ROWSPAN=2>&nbsp;&nbsp;EA</TD>


		</TR>


		<TR>


		<TD><A href="javascript:num_minus(document.view_form<%ECHO"no";%>);"><IMG src="./mall_image/num_minus.gif" border=0></A></TD>


		</TR>


		</TABLE>





		</TD>


		</TR>





		<TR>


		<TD COLSPAN=2 HEIGHT=5> </TD>


		</TR>


		<TR>


		<TD COLSPAN=2 BACKGROUND='./mall_skin/shop/<%ECHO"SKIN";%>/image/list_line.gif' HEIGHT=1> </TD>


		</TR>


		<TR>


		<TD COLSPAN=2 HEIGHT=5> </TD>


		</TR>





		<TR>


		<TD COLSPAN=2>


		<INPUT TYPE=IMAGE SRC='./mall_skin/shop/<%ECHO"SKIN";%>/image/cart.gif' BORDER=0> 


		<A HREF='./mall_include/WISH_objRs.php?uid=<%ECHOUID;%>'><IMG SRC='./mall_skin/shop/<%ECHO"SKIN";%>/image/wish.gif' BORDER=0></A>


		<A HREF=''><IMG SRC='./mall_skin/shop/<%ECHO"SKIN";%>/image/que.gif' BORDER=0></A>


		</TD>


		</TR>


		</FORM>


		</TABLE>


		


		</TD>


		</TR>


		</TABLE>





		<TABLE WIDTH='95%' CELLSPACING=0 CELLPADDING=0 BORDER=0>


		<TR>


		<TD COLSPAN=2 HEIGHT=10> </TD>


		</TR>


		<TR>


		<TD COLSPAN=2 BACKGROUND='./mall_skin/shop/<%ECHO"SKIN";%>/image/list_line.gif' HEIGHT=1> </TD>


		</TR>


		<TR>


		<TD COLSPAN=2 HEIGHT=10> </TD>


		</TR>


		</TABLE>


<%


	endif;


endwhile;


%>


</DIV>
