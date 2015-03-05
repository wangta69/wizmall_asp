<!-- #include file = "../../../config/skin_info.asp" -->
<!-- #include file = "../../../config/admin_info.asp" -->
<script language="JavaScript">
<!--
function checkForm(f){
	if(autoCheckForm(f)){
		return true;
	}else return false;

}
//-->
</script>	

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td colspan="3"><table width="100%" height="18" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
        <tr bgcolor="#F6F6F6">
          <td width="15" height="22" class="company">&nbsp;</td>
          <td width="18" height="22" valign="middle"><img src="skinwiz/html/<%=HtmlSkin%>/images/top_arrow.gif" width="18" height="11"></td>
          <td height="22" class="company">Home ＞<strong>고객센터</strong></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td width="19">&nbsp;</td>
    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="15" valign="middle">&nbsp;</td>
        </tr>
        <tr>
          <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><div align="left"><img src="skinwiz/html/<%=HtmlSkin%>/images/title_01.gif" width="567" height="30"></div></td>
              </tr>
              <tr>
                <td height="30">&nbsp;</td>
              </tr>
              <tr>
                <td valign="top" class="agn_c"><table class="table_blank agn_l">
                    <tr>
                      <td valign="top" widtth="555"></td>
                    </tr>
                    <tr>
                      <td valign="top"><div align="left"> </div>
                        <span class="text2">
                        <%=mall_name%>
                        을 이용해 주셔서 감사합니다. </span>
                        <p class="text2">저희
                          <%=mall_name%>
                          에서는 무엇보다도 완벽한 품질의 제품과 최고의 서비스를 
                          
                          제공하기<br>
                          위하여 끊임없이 노력하고 있습니다.</p>
                        <p class="text2">저희 제품에 대하여 궁금하신 사항이나 사용상의 문제점 등 제반 문의사항이 
                          있으시면<br>
                          전화(
                          <%=mall_tel%>
                          ) 또는 이메일을 주십시오.</p>
                        <p class="text2">☞ 회사 연락처<br>
                          주 소 :
                          <%=mall_address%>
                          <br>
                          전 화 :
                          <%=mall_tel%>
                          <br>
                          팩 스 :
                          <%=mall_fax%>
                          <br>
                          <span class="text2">E-mail :
                          <%=mall_email%>
                          </span></p></td>
                    </tr>
                    <tr>
                      <td valign="top">&nbsp;</td>
                    </tr>
                    <tr>
                      <td><table width="100%" border="0" cellspacing="0" cellpadding="2">
                          <tr>
                            <td class="products3"><font color="#FF6600">문의메일</font></td>
                          </tr>
                          <tr>
                            <td> <form name="InquireForm" method="POST" action="./skinwiz/html/wizinquire_qry.asp" onsubmit='return checkForm(this);' enctype="multipart/form-data">
                                      <input type="hidden" name="qry" value="qin">
    <input type="hidden" name="iid" value="inq1"><table border="0" cellpadding="0" cellspacing="0">
                               
                                  <tr>
                                    <td height="11"><img src="skinwiz/html/<%=HtmlSkin%>/images/list_bgc_01.gif" width="11" height="11"></td>
                                    <td height="11"><img src="skinwiz/html/<%=HtmlSkin%>/images/list_bg_02.gif" width="514" height="11"></td>
                                    <td height="11"><img src="skinwiz/html/<%=HtmlSkin%>/images/list_bgc_02.gif" width="11" height="11"></td>
                                  </tr>
                                  <tr>
                                    <td background="skinwiz/html/<%=HtmlSkin%>/images/list_bg_01.gif">&nbsp;</td>
                                    <td><table border="0" cellpadding="0" cellspacing="0">
                                        <td valign="top"><table class="table_blank agn_l">
                                              <tr>
                                                <td height="15"></td>
                                              </tr>
                                              <tr>
                                                <td class="text1"><table class="table_blank agn_l">
                                                    <tr>
                                                      <td class="text" width="98"><img src="../images/list_icon_1.gif" width="4" height="4" hspace="2" align="absmiddle"> 제 목</td>
                                                      <td class="text" valign="middle"><input name="subject" type="text" class="border" id="subject" size="50">
                                                      </td>
                                                    </tr>
                                                  </table></td>
                                              </tr>
                                              <tr>
                                                <td><table class="table_blank agn_l">
                                                    <tr>
                                                      <td class="text" width="98"><img src="../images/list_icon_1.gif" width="4" height="4" hspace="2" align="absmiddle"> 성 명</td>
                                                      <td class="text" valign="middle"><input name="name" type="text" class="border" id="name" size="8">
                                                      </td>
                                                    </tr>
                                                  </table></td>
                                              </tr>
                                              <tr>
                                                <td height="5"></td>
                                              </tr>
                                              <tr>
                                                <td><img src="skinwiz/html/<%=HtmlSkin%>/images/dot.gif"></td>
                                              </tr>
                                              <tr>
                                                <td height="5"></td>
                                              </tr>
                                              <tr>
                                                <td><table class="table_blank agn_l">
                                                    <tr>
                                                      <td class="text" width="98"><img src="../images/list_icon_1.gif" width="4" height="4" hspace="2" align="absmiddle"> 연락처</td>
                                                      <td class="text" valign="middle"><img src="../images/list_icon.gif" width="4" height="6" hspace="7">전<font color="#FFFFFF">..</font> 화
                                                        <input name="tel1" type="text" class="border" id="tel1" size="3">
                                                        -
                                                        <input name="hand1" type="text" class="border" id="hand1" size="4">
                                                        -
                                                        <input name="fax1" type="text" class="border" id="fax1" size="5">
                                                      </td>
                                                    </tr>
                                                  </table></td>
                                              </tr>
                                              <tr>
                                                <td><table class="table_blank agn_l">
                                                    <tr>
                                                      <td class="text" width="98">&nbsp;</td>
                                                      <td class="text" valign="middle"><img src="../images/list_icon.gif" width="4" height="6" hspace="7">핸드폰
                                                        <input name="Tel2_1" type="text" class="border" id="Tel1" size="3">
                                                        -
                                                        <input name="Tel2_2" type="text" class="border" id="Tel2" size="4">
                                                        -
                                                        <input name="Tel2_3" type="text" class="border" id="Tel3" size="5">
                                                      </td>
                                                    </tr>
                                                  </table></td>
                                              </tr>
                                              <tr>
                                                <td><table class="table_blank agn_l">
                                                    <tr>
                                                      <td class="text" width="98">&nbsp;</td>
                                                      <td class="text" valign="middle"><img src="../images/list_icon.gif" width="4" height="6" hspace="7">팩<font color="#FFFFFF">..</font> 스
                                                        <input name="Tel3_1" type="text" class="border" id="Tel1" size="3">
                                                        -
                                                        <input name="Tel3_2" type="text" class="border" id="Tel2" size="4">
                                                        -
                                                        <input name="Tel3_3" type="text" class="border" id="Tel3" size="5">
                                                      </td>
                                                    </tr>
                                                  </table></td>
                                              </tr>
                                              <tr>
                                                <td  height="11" valign="middle"><img src="skinwiz/html/<%=HtmlSkin%>/images/dot.gif" width="484" height="1"></td>
                                              </tr>
                                              <tr>
                                                <td><table class="table_blank agn_l">
                                                    <tr>
                                                      <td class="text" width="98"><img src="../images/list_icon_1.gif" width="4" height="4" hspace="2" align="absmiddle"> E-mail</td>
                                                      <td class="text" valign="middle"><input name="email_1" type="text" class="border" id="email_1" size="9">
                                                        @
                                                        <input name="email_2" type="text" class="border" id="email_2" size="12">
                                                      </td>
                                                    </tr>
                                                  </table></td>
                                              </tr>
                                              <tr>
                                                <td height="5"></td>
                                              </tr>
                                              <tr>
                                                <td><img src="skinwiz/html/<%=HtmlSkin%>/images/dot.gif"></td>
                                              </tr>
                                              <tr>
                                                <td height="5"></td>
                                              </tr>
                                              <tr>
                                                <td><table class="table_blank agn_l">
                                                    <tr>
                                                      <td class="text" width="98"><img src="../images/list_icon_1.gif" width="4" height="4" hspace="2" align="absmiddle"> 문의항목</td>
                                                      <td class="text" valign="middle"><select name="Item" class="border" id="Item">
                                                          <option selected>==항목을 
                                                          
                                                          선택하세요==</option>
                                                          <option>---------------------</option>
                                                          <option value="제품 구입에 관한 문의">제품 
                                                          
                                                          구입에 관한 문의</option>
                                                          <option value="제품 사용법에 관한 문의">제품 
                                                          
                                                          사용법에 관한 문의</option>
                                                          <option value="제품 서비스에 관한 문의">제품 
                                                          
                                                          서비스에 관한 문의</option>
                                                          <option value="기타">기타</option>
                                                        </select>
                                                      </td>
                                                    </tr>
                                                  </table></td>
                                              </tr>
                                              <tr>
                                                <td><table class="table_blank agn_l">
                                                    <tr>
                                                      <td class="text" width="98" valign="top"><img src="../images/list_icon_1.gif" width="4" height="4" hspace="2" align="absmiddle"> 문의사항</td>
                                                      <td class="text" valign="middle"><textarea name="contents" cols="52" rows="5" wrap="VIRTUAL" class="border" id="contents"></textarea>
                                                      </td>
                                                    </tr>
                                                  </table></td>
                                              </tr>
                                              <tr>
                                                <td height="15"></td>
                                              </tr>
                                            </table></td>
                                        </tr>
                                      </table></td>
                                    <td background="skinwiz/html/<%=HtmlSkin%>/images/list_bg_03.gif">&nbsp;</td>
                                  </tr>
                                  <tr>
                                    <td><img src="skinwiz/html/<%=HtmlSkin%>/images/list_bgc_03.gif" width="11" height="11"></td>
                                    <td><img src="skinwiz/html/<%=HtmlSkin%>/images/list_bg_04.gif" width="514" height="11"></td>
                                    <td><img src="skinwiz/html/<%=HtmlSkin%>/images/list_bgc_04.gif" width="11" height="11"></td>
                                  </tr>
                                  <tr>
                                    <td height="10" colspan="3"></td>
                                  </tr>
                                  <tr>
                                    <td colspan="3" class="agn_c"><input name="image" type="image" src="skinwiz/html/<%=HtmlSkin%>/images/enter_img.gif" width="70" height="29">
                                      &nbsp;&nbsp;<img src="skinwiz/html/<%=HtmlSkin%>/images/cancle_btn.gif" width="70" height="29" hspace="5" onclick="history.go(-1)"; style="cursor:pointer"> </td>
                                  </tr>
                                
                              </table></form></td>
                          </tr>
                        </table></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
    <td width="18">&nbsp;</td>
  </tr>
</table>
