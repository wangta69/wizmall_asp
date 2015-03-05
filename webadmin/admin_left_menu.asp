<%
Dim menu0, menu1, menu2, menu3, menu4, menu5, menu6, menu7, menu8, menu9, menu10, menu11, menu12, menu13
Dim marginleft, margintop, marginwidth, marginheight
menushow = Request("menushow")

if menushow <> "menu0"  then menu0 = "none" 
if menushow <> "menu1"  then menu1 = "none" 
if menushow <> "menu2"  then menu2 = "none" 
if menushow <> "menu3"  then menu3 = "none" 
if menushow <> "menu4"  then menu4 = "none" 
if menushow <> "menu5"  then menu5 = "none" 
if menushow <> "menu6"  then menu6 = "none" 
if menushow <> "menu7"  then menu7 = "none" 
if menushow <> "menu8"  then menu8 = "none" 
if menushow <> "menu9"  then menu9 = "none" 
if menushow <> "menu10"  then menu10 = "none" 
if menushow <> "menu11"  then menu11 = "none" 
if menushow <> "menu12"  then menu12 = "none" 
if menushow <> "menu13"  then menu13 = "none" 

marginleft = "0px"
margintop="0px"
marginwidth="120px"
marginheight="400px"
%>

<table width="188" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="188" height="75" align='center' background="img/img_bg.gif"><table width="94%" border="0" cellspacing="5" cellpadding="0">
        <tr>
          <td height="50" colspan="2" align="center" bgcolor="A8E5A8">관리자 님으로<br>
            접속중입니다.</td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="30" align="center" bgcolor="275903"><table width="100" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
          <td ><a href="../" target="_blank"><img src="img/adminsite_icon.gif" width="108" height="29" border="0"></a></td>
          <td ><a href="./admin_logout.asp"><img src="img/img_icon03.gif" width="70" height="29" border="0"></a></td>
        </tr>
      </table></td>
  </tr>
</table>
<table width="187" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="187"><img src="img/adminS_title01.gif" width="187" height="70"></td>
  </tr>
</table>
<DIV ID=menu0 style='display:<%=menu0%>;margin-left: <%=marginleft%> ; top:<%=margintop%>; width:<%=marginwidth%>; height:<%=marginheight%>'> </DIV>
<DIV ID=menu1 style='display:<%=menu1%>;margin-left: <%=marginleft%> ; top:<%=margintop%>; width:<%=marginwidth%>; height:<%=marginheight%>'>
  <table width="187" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td align="left" valign="top"></td>
    </tr>
    <tr>
      <td align="left" valign="top" bgcolor="f0f0f0" height="5"><table border="0" cellspacing="0" cellpadding="0" bgcolor="f0f0f0">
          <tr>
            <td align="left" valign="top"><table border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="38"><img src="img/ba_icon01.gif" width="38" height="33" align="absmiddle"></td>
                        <td height="43"><strong><font color="#666666" style="font-size:18px">기본환경</strong></td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td align="left" valign="top"><table border="0" cellspacing="0" cellpadding="0" class="notice">
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu1&theme=basicinfo/basic_info2" class="navigation">기본환경 
                                설정</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu1&theme=basicinfo/basic_info3" class="navigation">결제환경 
                                설정</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu1&theme=basicinfo/basic_info4" class="navigation">몰스킨 
                                설정</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu1&theme=basicinfo/basic_banner" class="navigation">베너관리</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>					  
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu1&theme=basicinfo/basic_info8" class="navigation">회원가입옵션 
                                설정</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                     <!-- <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./sysinfo/sysinfo.asp" class="navigation" target="_blank">시스템정보보기</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>-->
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./sysinfo/aspinfo.asp" class="navigation" target="_blank">ASP정보보기</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top">&nbsp;</td>
                      </tr>
                      <tr>
                        <td align="left" valign="top">&nbsp;</td>
                      </tr>
                    </table></td>
                </tr>
              </table></td>
          </tr>
        </table></td>
    </tr>
  </table>
</DIV>
<DIV ID=menu2 style='display:<%=menu2%>;margin-left: <%=marginleft%> ; top:<%=margintop%>; width:<%=marginwidth%>; height:<%=marginheight%>'>
  <table width="187" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td align="left" valign="top"></td>
    </tr>
    <tr>
      <td align="left" valign="top" bgcolor="f0f0f0" height="5"><table width="187" border="0" cellspacing="0" cellpadding="0" bgcolor="f0f0f0">
          <tr>
            <td align="left" valign="top"><table width="187" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="38"><img src="img/ba_icon01.gif" width="38" height="33" align="absmiddle"></td>
                        <td height="43"><strong><font color="#666666" style="font-size:18px">상품관리</strong></td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" class="notice">
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu2&theme=product/product1" class="navigation">상품신규등록</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu2&theme=product/product2" class="navigation">상품수정/삭제</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu2&theme=product/product_excel_file" class="navigation">엑셀상품업로드</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>					  
                      <tr> 
                        <td align="left" valign="top"> <table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left"> 
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu2&theme=product/product3" class="navigation">상품가격일괄수정</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr> 
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                     <tr> 
                        <td align="left" valign="top"> <table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left"> 
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu2&theme=product/product4" class="navigation">품절상품관리</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr> 
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <!--<tr> 
                        <td align="left" valign="top"> <table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left"> 
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu2&theme=product/product5" class="navigation">재고관리</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr> 
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>-->
                    <tr> 
                        <td align="left" valign="top"> <table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left"> 
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu2&theme=product/product6" class="navigation">상품평관리</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr> 
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
					  <tr> 
                        <td align="left" valign="top"> <table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left"> 
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu2&theme=product/product7" class="navigation">상품정렬순서</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr> 
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>	
                      <tr>
                        <td align="left" valign="top">&nbsp;</td>
                      </tr>
                      <tr>
                        <td align="left" valign="top">&nbsp;</td>
                      </tr>
                    </table></td>
                </tr>
              </table></td>
          </tr>
        </table></td>
    </tr>
  </table>
</DIV>
<DIV ID=menu3 style='display:<%=menu3%>;margin-left: <%=marginleft%> ; top:<%=margintop%>; width:<%=marginwidth%>; height:<%=marginheight%>'>
  <table width="187" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td align="left" valign="top"></td>
    </tr>
    <tr>
      <td align="left" valign="top" bgcolor="f0f0f0" height="5"><table width="187" border="0" cellspacing="0" cellpadding="0" bgcolor="f0f0f0">
          <tr>
            <td align="left" valign="top"><table width="187" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="38"><img src="img/ba_icon01.gif" width="38" height="33" align="absmiddle"></td>
                        <td height="43"><strong><font color="#666666" style="font-size:18px">매장관리</strong></td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" class="notice">
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu3&theme=category/shopmanager1" class="navigation">카테고리설정</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu3&theme=category/shopmanager2" class="navigation">카테고리 순서 설정</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>                      
                      <tr>
                        <td align="left" valign="top">&nbsp;</td>
                      </tr>
                      <tr>
                        <td align="left" valign="top">&nbsp;</td>
                      </tr>
                    </table></td>
                </tr>
              </table></td>
          </tr>
        </table></td>
    </tr>
  </table>
</DIV>
<DIV ID=menu4 style='display:<%=menu4%>;margin-left: <%=marginleft%> ; top:<%=margintop%>; width:<%=marginwidth%>; height:<%=marginheight%>'>
  <table width="187" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td align="left" valign="top"></td>
    </tr>
    <tr>
      <td align="left" valign="top" bgcolor="f0f0f0" height="5"><table width="187" border="0" cellspacing="0" cellpadding="0" bgcolor="f0f0f0">
          <tr>
            <td align="left" valign="top"><table width="187" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="38"><img src="img/ba_icon01.gif" width="38" height="33" align="absmiddle"></td>
                        <td height="43"><strong><font color="#666666" style="font-size:18px">주문/배송관리</strong></td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" class="notice">
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu4&theme=order/order1" class="navigation">주문상품보기</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu4&theme=order/order2" class="navigation">주문완료상품</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu4&theme=order/order3" class="navigation">반송상품</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <!--<tr> 
                        <td align="left" valign="top"> <table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left"> 
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu4&theme=order/order5" class="navigation">주문서입력</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr> 
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>-->
                      <!--<tr> 
                        <td align="left" valign="top"> <table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left"> 
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu4&theme=order/order4" class="navigation">온라인자동견적</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr> 
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>-->
                      <!--<tr> 
                        <td align="left" valign="top"> <table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left"> 
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu4&theme=inquire/inquire1&iid=INQ1" class="navigation">A/S신청문의</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr> 
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>-->
                      <tr>
                        <td align="left" valign="top">&nbsp;</td>
                      </tr>
                      <tr>
                        <td align="left" valign="top">&nbsp;</td>
                      </tr>
                    </table></td>
                </tr>
              </table></td>
          </tr>
        </table></td>
    </tr>
  </table>
</DIV>
<DIV ID=menu6 style='display:<%=menu6%>;margin-left: <%=marginleft%> ; top:<%=margintop%>; width:<%=marginwidth%>; height:<%=marginheight%>'>
  <table width="187" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td align="left" valign="top"></td>
    </tr>
    <tr>
      <td align="left" valign="top" bgcolor="f0f0f0" height="5"><table width="187" border="0" cellspacing="0" cellpadding="0" bgcolor="f0f0f0">
          <tr>
            <td align="left" valign="top"><table width="187" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="38"><img src="img/ba_icon01.gif" width="38" height="33" align="absmiddle"></td>
                        <td height="43"><strong><font color="#666666" style="font-size:18px">회원가입정보</strong></td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" class="notice">
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu6&theme=member/member1" class="navigation">총회원정보보기</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <!--<tr> 
                        <td align="left" valign="top"> <table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left"> 
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu6&theme=member6" class="navigation">일반회원</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr> 
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      -->
                      <!--<tr> 
                        <td align="left" valign="top"> <table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left"> 
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu6&theme=member5" class="navigation">기업회원</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr> 
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      -->
                      <!--<tr> 
                        <td align="left" valign="top"> <table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left"> 
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu6&theme=basic_info5" class="navigation">거래처정보보기</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr> 
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      -->
                      <!--<tr> 
                        <td align="left" valign="top"> <table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left"> 
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu6&theme=member3" class="navigation">가입지역분석</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr> 
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      -->
                      <!--<tr> 
                        <td align="left" valign="top"> <table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left"> 
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu6&theme=member4" class="navigation">탈퇴회원보기</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr> 
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      -->
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu6&theme=member/memberregis" class="navigation">회원등록</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu6&theme=member/member_stat" class="navigation">가입통계</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>			
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu6&theme=member/member_com" class="navigation">공급처/거래처관리</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>							  		  
                      <tr>
                        <td align="left" valign="top">&nbsp;</td>
                      </tr>
                      <tr>
                        <td align="left" valign="top">&nbsp;</td>
                      </tr>
                    </table></td>
                </tr>
              </table></td>
          </tr>
        </table></td>
    </tr>
  </table>
</DIV>
<DIV ID=menu7 style='display:<%=menu7%>;margin-left: <%=marginleft%> ; top:<%=margintop%>; width:<%=marginwidth%>; height:<%=marginheight%>'>
<table width="187" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td align="left" valign="top"></td>
    </tr>
    <tr>
      <td align="left" valign="top" bgcolor="f0f0f0" height="5"><table width="187" border="0" cellspacing="0" cellpadding="0" bgcolor="f0f0f0">
          <tr>
            <td align="left" valign="top"><table width="187" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="38"><img src="img/ba_icon01.gif" width="38" height="33" align="absmiddle"></td>
                        <td height="43"><strong><font color="#666666" style="font-size:18px">게시판관리</strong></td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" class="notice">
                      <tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <!--<tr> 
                        <td align="left" valign="top"> <table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left"> 
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a HREF="./main.asp?menushow=menu7&theme=channel1" class="navigation">채널관리</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr> 
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>-->
                      <tr>
                        <td align="left" valign="top">&nbsp;</td>
                      </tr>
                      <%
	Set db = new database					  					  
	strSQL = "SELECT * FROM wiztable_board_config ORDER BY gid asc, setorder asc, intnum asc "
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	IF objRs.EOF THEN	
%>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td align="center">등록된 게시판이 없습니다.</td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
<%
	ELSE
		gid_conf = ""
		WHILE NOT(objRs.EOF)
			tmp_gid_conf = objRs("gid")
			if tmp_gid_conf <> gid_conf then
				gid_conf = tmp_gid_conf
%>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td align="center"><span style="font-weight:bold; color:#FF6600"><%=gid_conf%></span></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
<%
			end if
%>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=<%=menushow%>&theme=<%=theme%>&AdminBID=<%=objRs("bid")%>&AdminGID=<%=objRs("gid")%>&page=1" class="navigation"><%=objRs("settitle")%></a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <%
		objRs.MOVENEXT
		WEND
	END IF
	Set objRs	= Nothing
	db.Dispose
    Set db		= Nothing
%>
                    </table></td>
                </tr>
              </table></td>
          </tr>
        </table></td>
    </tr>
  </table>
</DIV>
<DIV ID=menu8 style='display:<%=menu8%>;margin-left: <%=marginleft%> ; top:<%=margintop%>; width:<%=marginwidth%>; height:<%=marginheight%>'>
  <table width="187" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td align="left" valign="top"></td>
    </tr>
    <tr>
      <td align="left" valign="top" bgcolor="f0f0f0" height="5"><table width="187" border="0" cellspacing="0" cellpadding="0" bgcolor="f0f0f0">
          <tr>
            <td align="left" valign="top"><table width="187" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="38"><img src="img/ba_icon01.gif" width="38" height="33" align="absmiddle"></td>
                        <td height="43"><strong><font color="#666666" style="font-size:18px">방문자통계</strong></td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" class="notice">
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu8&theme=visit/visit_start" class="navigation">총방문자통계</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu8&theme=visit/visit_hour" class="navigation">시간별방문자통계</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu8&theme=visit/visit_day" class="navigation">일별방문자통계</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu8&theme=visit/visit_dayofweek" class="navigation">주별방문자통계</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu8&theme=visit/visit_month" class="navigation">월별방문자통계</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu8&theme=visit/visit_season" class="navigation">분기별방문자통계</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu8&theme=visit/visit_list" class="navigation">방문경로별통계</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu8&theme=visit/visit_os" class="navigation">OS별</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu8&theme=visit/visit_browser" class="navigation">브라우저별</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top">&nbsp;</td>
                      </tr>
                      <tr>
                        <td align="left" valign="top">&nbsp;</td>
                      </tr>
                    </table></td>
                </tr>
              </table></td>
          </tr>
        </table></td>
    </tr>
  </table>
</DIV>
<DIV ID=menu9 style='display:<%=menu9%>;margin-left: <%=marginleft%> ; top:<%=margintop%>; width:<%=marginwidth%>; height:<%=marginheight%>'>
<table width="187" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td align="left" valign="top"></td>
    </tr>
    <tr>
      <td align="left" valign="top" bgcolor="f0f0f0" height="5"><table width="187" border="0" cellspacing="0" cellpadding="0" bgcolor="f0f0f0">
          <tr>
            <td align="left" valign="top"><table width="187" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="38"><img src="img/ba_icon01.gif" width="38" height="33" align="absmiddle"></td>
                        <td height="43"><strong><font color="#666666" style="font-size:18px">매출/통계분석</strong></td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" class="notice">
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                     <!-- <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu9&theme=statistic/statistic2" class="navigation">제품별판매분석</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu9&theme=statistic/statistic8" class="navigation">고객별판매분석</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      --><tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu9&theme=statistic/statistic10" class="navigation">기간별판매분석</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <!--<tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu9&theme=statistic/statistic6" class="navigation">결제방법</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu9&theme=statistic/statistic4" class="navigation">구매지역</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu9&theme=statistic/statistic9" class="navigation">판매처별 
                                미수관리 </a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>-->
                      <tr>
                        <td align="left" valign="top">&nbsp;</td>
                      </tr>
                      <tr>
                        <td align="left" valign="top">&nbsp;</td>
                      </tr>
                    </table></td>
                </tr>
              </table></td>
          </tr>
        </table></td>
    </tr>
  </table>
</DIV>
<DIV ID=menu10 style='display:<%=menu10%>;margin-left: <%=marginleft%> ; top:<%=margintop%>; width:<%=marginwidth%>; height:<%=marginheight%>'>
  <table width="187" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td align="left" valign="top"></td>
    </tr>
    <tr>
      <td align="left" valign="top" bgcolor="f0f0f0" height="5"><table width="187" border="0" cellspacing="0" cellpadding="0" bgcolor="f0f0f0">
          <tr>
            <td align="left" valign="top"><table width="187" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="38"><img src="img/ba_icon01.gif" width="38" height="33" align="absmiddle"></td>
                        <td height="43"><strong><font color="#666666" style="font-size:18px">옵션메뉴</strong></td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" class="notice">
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                            </tr>
                            <tr>
                              <td height="25"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                                  <tr align="left">
                                    <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                                    <td>공동구매</td>
                                  </tr>
                                </table></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu10&theme=coorbuy1" class="navigation">제품등록</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu10&theme=coorbuy2" class="navigation">제품관리</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top">&nbsp;</td>
                      </tr>
                      <tr>
                        <td align="left" valign="top">&nbsp;</td>
                      </tr>
                    </table></td>
                </tr>
              </table></td>
          </tr>
        </table></td>
    </tr>
  </table>
</DIV>
<DIV ID=menu11 style='display:<%=menu11%>;margin-left: <%=marginleft%> ; top:<%=margintop%>; width:<%=marginwidth%>; height:<%=marginheight%>'>
  <table width="187" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td align="left" valign="top"></td>
    </tr>
    <tr>
      <td align="left" valign="top" bgcolor="f0f0f0" height="5"><table width="187" border="0" cellspacing="0" cellpadding="0" bgcolor="f0f0f0">
          <tr>
            <td align="left" valign="top"><table width="187" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="38"><img src="img/ba_icon01.gif" width="38" height="33" align="absmiddle"></td>
                        <td height="43"><strong><font color="#666666" style="font-size:18px">메일발송</strong></td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" class="notice">
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu11&theme=mail/mailer1" class="navigation">메일발송하기</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <!--<tr> 
                        <td align="left" valign="top"> <table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left"> 
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu11&theme=mail/email_send_list" class="navigation">발송된메일</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr> 
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>-->
                    <tr> 
                        <td align="left" valign="top"> <table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left"> 
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu11&theme=mail/mailer3" class="navigation">발송된메일</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr> 
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu11&theme=mail/address1" class="navigation">주소록관리</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top">&nbsp;</td>
                      </tr>
                      <tr>
                        <td align="left" valign="top">&nbsp;</td>
                      </tr>
                    </table></td>
                </tr>
              </table></td>
          </tr>
        </table></td>
    </tr>
  </table>
</DIV>
<DIV ID=menu13 style='display:<%=menu13%>;margin-left: <%=marginleft%> ; top:<%=margintop%>; width:<%=marginwidth%>; height:<%=marginheight%>'>
  <table width="187" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td align="left" valign="top"></td>
    </tr>
    <tr>
      <td align="left" valign="top" bgcolor="f0f0f0" height="5"><table width="187" border="0" cellspacing="0" cellpadding="0" bgcolor="f0f0f0">
          <tr>
            <td align="left" valign="top"><table width="187" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="38"><img src="img/ba_icon01.gif" width="38" height="33" align="absmiddle"></td>
                        <td height="43"><strong><font color="#666666" style="font-size:18px">기타관리</strong></td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" class="notice">
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu13&theme=inquire/inquire1&iid=inq1" class="navigation">문의관리</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu13&theme=poll/poll_list" class="navigation">투표창관리</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <!--
                      <tr> 
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr> 
                        <td align="left" valign="top"> <table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left"> 
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu13&theme=inquire2&iid=inq2" class="navigation">시험판다운로드</a></td>
                            </tr>
                          </table></td>
                      </tr>
                     <tr> 
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>					  
                      <tr> 
                        <td align="left" valign="top"> <table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left"> 
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu13&theme=apply1" class="navigation">입학신청</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      -->
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu13&theme=util/util2" class="navigation">일정관리</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <!--<tr> 
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr> 
                        <td align="left" valign="top"> <table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left"> 
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu13&theme=diary/Schedule_main" class="navigation">다이어리</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr> 
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      -->
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu13&theme=util/popup1" class="navigation">팝업창관리</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top"><table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left">
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu13&theme=coupon/coupon_list" class="navigation">쿠폰관리</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>					  
                      <!--<tr> 
                        <td align="left" valign="top"> <table width="190" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr align="left"> 
                              <td width="25" align="center"><img src="img/erpleft_icon.gif" width="9" height="9"></td>
                              <td><a href="./main.asp?menushow=menu13&theme=util1" class="navigation">투표창관리</a></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr> 
                        <td align="left" valign="top" height="2"><img src="img/admin_left_sub_bar.gif" width="180" height="2"></td>
                      </tr>-->
                      <tr>
                        <td align="left" valign="top">&nbsp;</td>
                      </tr>
                      <tr>
                        <td align="left" valign="top">&nbsp;</td>
                      </tr>
                    </table></td>
                </tr>
              </table></td>
          </tr>
        </table></td>
    </tr>
  </table>
</DIV>
