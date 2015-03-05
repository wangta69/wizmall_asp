<%
if (!_COOKIE[MEMBER_ID]) {
	ECHO "<script language=javascript>
	window.alert('로그인 후 이용해 주세요. ');
	location.href='./wizmember.php?query=login&file=wizhtml&goto=wish';
	</script>";
	exit;
}
%>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="40" valign="top"> 
	  <table width="100%" height="18" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
	    <tr bgcolor="#F6F6F6"> 
		  <td width="15" height="22">&nbsp;</td>
		  <td width="18" height="22" valign="middle"><img src="./skinwiz/wizwish/<%=WishSkin%>/images/sn_arrow.gif" width="13" height="13"></td>
		  <td height="22">Home > WISH LIST</td>
		</tr>
	  </table>
	</td>
  </tr>
  <tr>
    <td align="center"><%
if (file_exists("./wizmember_tmp/wiz_wish/_COOKIE[MEMBER_ID]")){
	WISH_ARRAY = file("./wizmember_tmp/wiz_wish/_COOKIE[MEMBER_ID]");
	while (list(key,value) = each(WISH_ARRAY)) :
			value_arr = split("\|", value);
			strSQL = "SELECT * FROM wizMall WHERE UID='value_arr[0]'";
			sqlqry = mysql_query(strSQL, DB_CONNECT) or die(mysql_error());
			list = mysql_fetch_array(sqlqry);
			Picture = split("\|", list[Picture])
%>

		<table width="630" border="0" cellspacing="0" cellpadding="0">
			  <tr> 
				<td width="270" valign="top"> <table width="270" border="0" cellspacing="0" cellpadding="0">
					<tr> 
					  <td><table width="270" border="0" cellpadding="1" cellspacing="5" bgcolor="#f9f9f9">
						  <tr> 
							<td bgcolor="#dddddd"><table width="258" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
								<tr> 
								  <td align=center height=100><A HREF='#' onclick="javascript:window.open('./skinwiz/viewer/<%=ViewerSkin%>/picview.php?no=<%=list[UID]%>', 'BICIMAGEWINDOW','width=750,height=592,statusbar=no,scrollbars=no,toolbar=no,resizable=no')"><IMG SRC='./wizstock/<%=Picture[0]%>' BORDER=0></A></td>
								</tr>
							  </table></td>
						  </tr>
						</table></td>
					</tr>
					<tr> 
					  <td height="30"><div align="center"><A HREF='#' onclick="javascript:window.open('./skinwiz/viewer/<%=ViewerSkin%>/picview.php?no=<%=list[UID]%>', 'BICIMAGEWINDOW','width=750,height=592,statusbar=no,scrollbars=no,toolbar=no,resizable=no')"><img src="./skinwiz/wizwish/<%=WishSkin%>/images/but_zoom.gif" border="0"></a></div></td>
					</tr>
				  </table></td>
				<td width="30">&nbsp;</td>
				<td width="330" valign="top"> <table width="330" border="0" cellspacing="0" cellpadding="0">
					<tr> 
					  <td height="30" bgcolor="#E3ECF2"> <div align="center"><span style="font-size:12px; color:#135C91;"><strong><%=list[Name]%> <%if(list[Model]):%>(<%=list[Model]%>)<%endif;%></strong></span></div></td>
					</tr>
					<tr> 
					  <td height="1px" bgcolor="#B3CDDF"></td>
					</tr>
					<tr> 
					  <td>


              <table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
                            <tr style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%"> 
                              <td width="90" height="24">&nbsp; 가격</td>
                              <td width="9" height="24">:</td>
                              <td width="226" height="24"><font color="#2266BB"><strong><SPAN class=item_price>
                                <%=number_format(list[Price])%>
                                원 </SPAN></strong></font></td>
                            </tr>
                            <tr> 
                              <td height="1px" colspan="3" bgcolor="#dddddd"></td>
                            </tr>
                            <% if(list[Price1]):%>
                            <tr style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%"> 
                              <td width="90" height="24"> &nbsp; 시중가격</td>
                              <td width="9" height="24">:</td>
                              <td width="226" height="24"><font color="#2266BB"><s>
                                <%=number_format(list[Price1])%>
                                원</s><strong><s> </s></strong></font></td>
                            </tr>
                            <tr> 
                              <td height="1px" colspan="3" bgcolor="#dddddd"></td>
                            </tr>
                            <% endif;%>
                            <%if(list[Brand]):%>
                            <tr style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%"> 
                              <td width="90" height="24"> &nbsp; 제조사</td>
                              <td width="9" height="24">:</td>
                              <td width="226" height="24">
                                <%=list[Brand]%>
                              </td>
                            </tr>
                            <tr> 
                              <td height="1px" colspan="3" bgcolor="#dddddd"></td>
                            </tr>
                            <% endif;%>
                            <%if(list[Point]):%>
                            <tr style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%"> 
                              <td height="24">&nbsp; 적립포인트</td>
                              <td height="24">:</td>
                              <td height="24">
                                <%=number_format(list[Point])%>
                              </td>
                            </tr>
                            <tr> 
                              <td height="1px" colspan="3" bgcolor="#dddddd"></td>
                            </tr>
                            <% endif;%>
                            <%if (list[Size]) :%>
                            <%Option4 = split("\n", list[Option4]);%>
                            <tr style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%"> 
                              <td height="24"> &nbsp; 규격(크기)</td>
                              <td height="24">:</td>
                              <td height="24">
                                <%=list[Size]%>
                              </td>
                            </tr>
                            <tr> 
                              <td height="1px" colspan="3" bgcolor="#dddddd"></td>
                            </tr>
                            <% endif;%>
                            <%if (list[Option2]) :%>
                            <%Option4 = split("\n", list[Option4]);%>
                            <tr style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%"> 
                              <td height="24"> &nbsp; 용량</td>
                              <td height="24">:</td>
                              <td height="24">
                                <%=list[Option2]%>
                              </td>
                            </tr>
                            <tr> 
                              <td height="1px" colspan="3" bgcolor="#dddddd"></td>
                            </tr>
                            <% endif;%>
                            <tr> 
                              <td height="1px" colspan="3" bgcolor="#dddddd"></td>
                            </tr>
                          </table>
					  
					  </td>
					</tr>
					<tr> 
					  <td height="40" align=center>
					    <table width="300" border="0" cellspacing="0" cellpadding="0">
						  <tr>                    
							  
                      <td> <A HREF='./wizbag.php?query=cart_save&no=<%=list[UID]%>&BUYNUM=1&GoodsPrice=<% echo list[Price]; %>'><IMG SRC='./skinwiz/wizwish/<%=WishSkin%>/images/but_jbgn.gif' width="90" height="20" BORDER=0></A> 
                        <A HREF='./skinwiz/wizwish/index.php?action=wish_delete&uid=<%=list[UID]%>'><IMG SRC='./skinwiz/wizwish/<%=WishSkin%>/images/but_cancle.gif' width="35" height="20" BORDER=0></A></td>
						  </tr>
						</table>
					  </td>
					</tr>
					<tr> 
					  <td>&nbsp;</td>
					</tr>
				  </table></td>
			  </tr>
			</table>

		
      <TABLE WIDTH='100%' CELLSPACING=0 CELLPADDING=0 BORDER=0>
        <TR>
		<TD COLSPAN=2 HEIGHT=10> </TD>
		</TR>
		<TR>
		<TD COLSPAN=2 HEIGHT=1 bgcolor="#666666"> </TD>
		</TR>
		<TR>
		<TD COLSPAN=2 HEIGHT=10> </TD>
		</TR>
		</TABLE>
<%
	endwhile;
}	
if (!WISH_ARRAY) :
%>

      <TABLE WIDTH=100% CELLSPACING=0 CELLPADDING=0 BORDER=0>
        <TR>
    <TD width=100>&nbsp;</TD>    
          <TD> WISH LIST 에 담긴 제품이 없습니다. </TD>
</TR>
</TABLE>
      <TABLE WIDTH='100%' CELLSPACING=0 CELLPADDING=0 BORDER=0>
        <TR>
<TD COLSPAN=2 HEIGHT=10> </TD>
</TR>
<TR>
<TD COLSPAN=2  HEIGHT=1  bgcolor="#666666"> </TD>
</TR>
<TR>
<TD COLSPAN=2 HEIGHT=10> </TD>
</TR>
</TABLE>
<%
endif;
%></td>
  </tr>
  <tr>
    <td align="center">&nbsp;</td>
  </tr>
</table>

