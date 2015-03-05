<!-- #include file = "../../../lib/cfg.common.asp" -->
<%
제작자 : 폰돌
스킨 : wizboard list skin 
URL : http://www.shop-wiz.com
Email : master@shop-wiz.com
*** Updating List ***
*/
<%
RECNUM = 20;
LISTNUM = 10;
START_NUM = (PAGENUM-1)*RECNUM;

if (!sort) {sort = "UID";}

if (query == 'alpha') {
	WHEREIS = "WHERE UID";
	if (Category) { WHEREIS = "WHEREIS AND Category LIKE '%Category'";}
	if (Brand) {WHEREIS = "WHEREIS AND Brand LIKE '%compname%'";}
	if (keyword && Target) {
		if (Target == 'all') {
			WHEREIS = "WHEREIS AND Name LIKE '%keyword%' OR Description1 LIKE '%keyword%' OR Model LIKE '%keyword%'";
		}
		if (Target == 'Name') {
			WHEREIS = "WHEREIS AND Name LIKE 'keyword%'";
		}
		if (Target == 'Model') {
			WHEREIS = "WHEREIS AND Model LIKE '%keyword%'";
		}
	}
}

TOTAL_COUNT = mysql_fetch_array(mysql_query( "SELECT count(*) FROM wizMall", DB_CONNECT )); 

COUNT_DATA = mysql_query( "SELECT count(*) FROM wizMall WHEREIS", DB_CONNECT ); 
COUNT_ARRAY = mysql_fetch_array(COUNT_DATA);
DATA_NUM = COUNT_ARRAY[0];
TOTAL_PAGE = intval((DATA_NUM-1)/RECNUM)+1;

strSQL = "SELECT * FROM wizMall WHEREIS ORDER BY sort DESC LIMIT START_NUM,RECNUM";
TABLE_DATA = mysql_query(strSQL, DB_CONNECT);
%> 
<table border="0" cellpadding="0" cellspacing="0">
              <tr> 
                <td colspan="2"> 
                  <table width="689" border="0" cellpadding="0" cellspacing="0" height="80">
                    <tr> 
                      <td colspan="2" class="tex1" style="padding: 0 30 0 30"><font color="#999999">::Home 
                        &gt; 검색</font></td>
                      <td rowspan="2"><img src="img/rightwoman.gif" width="73" height="94"></td>
                    </tr>
                    <tr> 
                      <td height="60" valign="top" width="396"><img src="img/alpatitle.gif" width="396" height="60"></td>
                      <td width="221" height="67" valign="top">
                        <table width="221" border="0" cellpadding="0" height="67" cellspacing="0">
                          <tr>
                            <td background="img/last.gif" height="60">
                              <div align="center"><br>
                                <br>
<%include "./skinwiz/subtop/select.php";%>
                              </div>
                            </td>
                          </tr>
                          <tr>
                            <td>&nbsp;</td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
<%
while( list = mysql_fetch_array( TABLE_DATA ) ) :

link_url = "'./wizmart.php?query=view&code=list[Category]&no=list[UID]'";
Picture = split("\|", list[Picture]);
Multi_Disabled = "";
if ((Stock && Stock <= Output) || None == 'checked' ) {
	link_url = "'#' onclick=\"javascript:alert('제품이 품절되었습니다. 관리자에게 문의하세요.')\"";
	Multi_Disabled = " disabled";
}
%>			  
              <tr> 
                <td colspan="2">
                  <table width="680" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="20">&nbsp;</td>
                      <td width="182" background="img/alpa.gif" height="176"> 
                        <table width="88" border="0" cellpadding="0" align="center" cellspacing="0">
                          <tr>
                            <td><A HREF=<%=link_url%>><IMG SRC='./wizstock/<%=Picture[0]%>' WIDTH='88' BORDER=0></A></td>
                          </tr>
                        </table>
                      </td>
                      <td width="414" valign="top"> <br><br>
                        <table width="400" border="0" cellpadding="1" cellspacing="1" class="tex1" height="101" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
                          <tr bgcolor="#FCFCFC"> 
                            <td width="125"> 
                              <div align="center"><b><font face="Arial, Helvetica, sans-serif" color="#FF6600"><font face="Geneva, Arial, Helvetica, san-serif">도서명</font> 
                                </font></b></div>
                            </td>
                            <td width="137"> 
                              <div align="center"><b><font color="#FF6600">발행국 
                                </font></b></div>
                            </td>
                            <td width="138"> 
                              <div align="center"><b><font color="#FF6600">판매가격</font></b></div>
                            </td>
                          </tr>
                          <tr bgcolor="#EFEFEF"> 
                            <td width="125"> 
                              <div align="center"><font color="#333333"><%=list[Name]%></font></div>
                            </td>
                            <td width="137"> 
                              <div align="center"><font color="#333333"><%=list[Brand]%></font></div>
                            </td>
                            <td width="138"> 
                              <div align="center"><font color="#333333"><%=number_format(list[Price])%></font></div>
                            </td>
                          </tr>
                          <tr bgcolor="#FFFFFF"> 
                            <td colspan="3">
                              <div align="right"><A HREF=<%=link_url%>><img src="img/seebutton.gif" width="87" height="26" border="0"></a></div>
                            </td>
                          </tr>
                        </table>
                      </td>
                      <td width="64">&nbsp;</td>
                    </tr>
                  </table>
                </td>
              </tr>
<%endwhile;%>			  
              <tr> 
                <td colspan="2" valign="top"> 
                  <table width="690" border="0" cellpadding="0" cellspacing="0">
                    <tr> 
                      
          <td width="18" height="48"> 
            <div align="center"></div>
                      </td>
                      <td width="672" class="tex1"> 

                        <div align="center"><br>
                          <br>
                          <%
	if (p == 1) {
		ECHO "◁";
	}
	else {
		PrevPage = p-1;
		ECHO "<A HREF='PHP_SELF?query=query&cat=cat&Target=Target&keyword=keyword&price1=price1&price2=price2&compname=compname&sort=sort&andor=andor&p=PrevPage'>◀</A>";
	}
	ECHO "&nbsp;";
/*****************************************************************************/
	term = LISTNUM;
	f = 1;
	l = term;

	while (f <= TOTAL_PAGE) {
		if ((f <= p) && (p <= l)) {
			if (l <= TOTAL_PAGE) {
				for (page = f; page <= l; page++) {
					if (page == p) {
						echo "<FONT COLOR=RED>page</FONT>&nbsp;";
					}
					else {
						echo "<A HREF='PHP_SELF?query=query&cat=cat&Target=Target&keyword=keyword&price1=price1&price2=price2&compname=compname&sort=sort&andor=andor&p=page'>page</A>&nbsp;";
					}
				}
			}
			else {
				for (page = f; page <= TOTAL_PAGE; page++) {
					if (page == p) {
						echo "<FONT COLOR=RED>page</FONT>&nbsp;";
					}
					else {
						echo "<A HREF='PHP_SELF?query=query&cat=cat&Target=Target&keyword=keyword&price1=price1&price2=price2&compname=compname&sort=sort&andor=andor&p=page'>page</A>&nbsp;";
					}
				}
			}
		}
		
		f = f + term;
		l = l + term;
	}
/*****************************************************************************/

	if(p == TOTAL_PAGE) {
		ECHO "▷";
	}
	else {
		NextPage = p+1;
		ECHO "<A HREF='PHP_SELF?query=query&cat=cat&Target=Target&keyword=keyword&price1=price1&price2=price2&compname=compname&sort=sort&andor=andor&p=NextPage'>▶</A>";
	}
%></div>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr> 
                
    <td colspan="2">&nbsp; </td>
              </tr>
            </table>
