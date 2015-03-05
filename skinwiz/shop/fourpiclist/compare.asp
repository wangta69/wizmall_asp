<script language="JavaScript">
<!--
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
function wishconfirm(){
if (confirm('\n\n정말로 본 제품을 위시리스트에 담으시겠습니까?\n\n')) return true;
return false;
}
function baropay(f,val){
f.sub_query.value = val;
f.submit();
}
//-->
</script> 
<table border="0" width=856 cellspacing=0 cellpadding=0>
  <tr> 
    <td colspan="3" height=10></td>
  </tr>
  <tr> 
    <td colspan="3"> <table border="0" cellspacing=0 cellpadding=0>
        <tr> 
          <td with=7></td>
          <td background=images/bg_sub01.gif  height=5 colspan="3" width=849></td>
        </tr>
        <tr> 
          <td with=7></td>
          <td> <table width="849" border="0" cellspacing="0" cellpadding="0">
              <tr> 
<%
if (file_exists("./wizmember_tmp/goods_compare/_COOKIE[MEMBER_COMPARE].cgi")):
	WISH_ARRAY = file("./wizmember_tmp/goods_compare/_COOKIE[MEMBER_COMPARE].cgi");
	NO=0;
	while (list(key,value) = each(WISH_ARRAY)) :
			value_arr = split("\|", value);
			strSQL = "SELECT * FROM wizMall WHERE UID='value_arr[0]'";
			sqlqry = mysql_query(strSQL, DB_CONNECT) or die(mysql_error());
			list = mysql_fetch_array(sqlqry);
			Picture = split("\|", list[Picture]);
			if(!strcmp(LIST[None],"checked")) orderenable ="주문불가";
			else orderenable ="주문가능";
%>
                <td width="422"><table border="0" width=100% cellspacing=0 cellpadding=0 >
                    <tr> 
                      <td align=center>&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr> 
                      <td width=210 align=center valign="top"> <table border="0" cellspacing=0 cellpadding=0>
                          <tr> 
                            <td>&nbsp;</td>
                            <td><A HREF='#' onclick="javascript:window.open('./skinwiz/viewer/<%=ViewerSkin%>/picview.php?no=<%=list[UID]%>', 'BICIMAGEWINDOW','width=750,height=592,statusbar=no,scrollbars=no,toolbar=no,resizable=no')"><img 
                        src="./wizstock/<%=Picture[0]%>" border=0 width=200 height=200></a></td>
                          </tr>
                          <tr> 
                            <td>&nbsp;</td>
                            <td align=center height=30><A HREF='#' onclick="javascript:window.open('./skinwiz/viewer/<%=ViewerSkin%>/picview.php?no=<%=list[UID]%>', 'BICIMAGEWINDOW','width=750,height=592,statusbar=no,scrollbars=no,toolbar=no,resizable=no')"><img src=/images/btn_zoom.gif width="90" height="20" border=0></a></td>
                          </tr>
                          <tr> 
                            <td>&nbsp;</td>
                            <td align=right><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td align="center"> </td>
                                </tr>
                              </table></td>
                          </tr>
                        </table></td>
                      <td> <table border="0" cellspacing=0 cellpadding=0>
                          <FORM NAME='view_form_<%=value_arr[0]%>' ACTION='./wizbag.php' metbod="post">
                            <INPUT TYPE=HIDDEN NAME='query' VALUE='cart_save'>
                            <INPUT TYPE=HIDDEN NAME='no' VALUE='<%=value_arr[0]%>'>
                            <INPUT TYPE=HIDDEN NAME='sub_query' VALUE= ''>
                            <tr> 
                              <td width=10>&nbsp;</td>
                              <td width="201" height=30><font size="3"><b> 
                                <%=list[Name]%>
                                </b></font></td>
                              <td width="2">&nbsp;</td>
                            </tr>
                            <tr bgcolor="0D92C2"> 
                              <td colspan="3"  height=2></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td height=30>- 가격 : <font size="3" color="F26522"><b> 
                                <%=number_format(list[Price])%>
                                원 </b> </font> <input type='hidden' name='GoodsPrice' value='<%=list[Price]%>'></td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td colspan="3" background=images/dot_04.gif height=1></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td height=30>- 마일리지 : 
                                <%=number_format(list[Point])%>
                                pts<br> </td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td colspan="3" background=images/dot_04.gif height=1></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td height=30>- 원산지 / 제조사 : 
                                <%=list[Brand]%>
                              </td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td colspan="3" background=images/dot_04.gif height=1></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td height=29>- 상품코드 : 
                                <%=list[Model]%>
                                <br> </td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td colspan="3" background=images/dot_04.gif height=1></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td height=30>- 색상 및 종류 : </td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td colspan="3" background=images/dot_04.gif height=1></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td height=30> <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <tr> 
                                    <td> <table cellpadding=0 cellspacing=0 border=0>
                                        <tr> 
                                          <td rowspan=2>- 구매수량 : </td>
                                          <td rowspan=2> <input type=TEXT size=3 name="BUYNUM" maxlength=5 value="1" onKeyPress="is_number()"> 
                                          </td>
                                          <td><a href="javascript:num_plus(document.view_form_<%=value_arr[0]%>);"><img src="./skinwiz/viewer/<%=ViewerSkin%>/images/num_plus.gif" border=0></a></td>
                                          <td rowspan=2>&nbsp;&nbsp;EA</td>
                                        </tr>
                                        <tr> 
                                          <td><a href="javascript:num_minus(document.view_form_<%=value_arr[0]%>);"><img src="./skinwiz/viewer/<%=ViewerSkin%>/images/num_minus.gif" border=0></a></td>
                                        </tr>
                                      </table></td>
                                    <td align="center" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td colspan="3" bgcolor="B7B7B7" height=2></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td></td>
                              <td> <input type="image" src=/images/btn_cart.gif align="middle" width="90" height="42" border=0>
                                <A HREF='./wizmart.php?query=compare_del&uid=<%=value_arr[0]%>'><img src=/images/btn_delete02.gif width="90" border=0 align="absmiddle"></a>
                              </td>
                              <td></td>
                            </tr>
                            <tr> 
                              <td></td>
                              <td>&nbsp; </td>
                              <td>&nbsp;</td>
                            </tr>
                          </form>
                        </table></td>
                    </tr>
                  </table></td>
                <%
NO++;
// && NO != Total
if(!(NO%2)) ECHO"</tr>
              <tr> 
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>			  
              <tr background=images/bg_prodetail.gif> 
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr> ";
else echo "<td width=10></td>";			  
endwhile;
else :
%>
                <td width="422" align="center">제품 비교품목이 없습니다.</td>
                <%
endif;
%>
              </tr>
              <tr> 
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td width=7 height=10></td>
          <td></td>
        </tr>
        <tr> 
          <td></td>
          <td valign=top>&nbsp;</td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td></td>
  </tr>
</table>
