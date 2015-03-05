<!-- #include file = "../../../config/db_connect.asp" -->
<!-- #include file = "../../../config/skin_info.asp" -->
<!-- #include file = "../../../lib/class.database.asp" -->
<!-- #include file = "../../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database
%>
<Script language=javascript>
<!--
function naturalcheck()
{
	if (document.natural.keyword.value.length < 1) {
	window.alert('\n다중검색에 필요한 단어들을 입력해 주세요.\n');
	document.natural.keyword.focus();
	return false;
	}

}
//-->
</script>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="100%" height="18" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
        <tr bgcolor="#F6F6F6">
          <td width="15" height="22" class="company">&nbsp;</td>
          <td width="18" height="22" valign="middle"><img src="./skinwiz/search/<%=SearchSkin%>/images/sn_arrow.gif" width="13" height="13"></td>
          <td height="22" class="company">Home &gt; <strong>상세검색</strong></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="15">&nbsp;</td>
          <td><img src="./skinwiz/search/<%=SearchSkin%>/images/title_detail.gif" width="579" height="65"></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td align="center"><table width="95%" border="0" cellspacing="0" cellpadding="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
        <tr>
          <td height="28" class="company"><img src="./skinwiz/search/<%=SearchSkin%>/images/icon_detail01.gif" width="9" height="9"> <font color="#006699">찾고 싶은 상품의 상품명이나 가격대, 제조사 등을 입력하셔도 검색됩니다.</font> </td>
        </tr>
        <form action="./wizsearch.asp" name="SearchForm">
          <input type=HIDDEN name="smode" value='search'>
          <tr>
            <td><table width="100%" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
                <tr bgcolor="#BEBEBE">
                  <td height="3" colspan="3"></td>
                </tr>
                <tr>
                  <td width="123" height="27" align="right" bgcolor="#f3f3f3"><font color="#144179">검 
                    색&nbsp; &nbsp; &nbsp; </font></td>
                  <td width="12" height="27"><img src="./skinwiz/search/<%=SearchSkin%>/images/img_a.gif" width="12" height="27"></td>
                  <td width="444" height="27"><table width="85%" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
                      <tr>
                        <td><input name="Target" type="radio" value="all" checked></td>
                        <td> 상품명(상품설명 포함)검색 </td>
                        <td><input type="radio" name="Target" value="pname"></td>
                        <td> 상품명 검색</td>
                        <td><input type="radio" name="Target" value="model"></td>
                        <td> 모델명 검색</td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td height="1" colspan="3" bgcolor="#cfcfcf"></td>
                </tr>
                <tr>
                  <td width="123" height="27" align="right" bgcolor="#f3f3f3"><font color="#144179">키 
                    워 드&nbsp; &nbsp; &nbsp; </font></td>
                  <td width="12" height="27"><img src="./skinwiz/search/<%=SearchSkin%>/images/img_a.gif" width="12" height="27"></td>
                  <td width="444" height="27"><input name="keyword" type="text" class="formline" id="keyword" size="40"></td>
                </tr>
                <tr>
                  <td height="1" colspan="3" bgcolor="#cfcfcf"></td>
                </tr>
                <tr>
                  <td width="123" height="27" align="right" bgcolor="#f3f3f3"><font color="#144179">가 
                    격 대&nbsp; &nbsp; &nbsp; </font></td>
                  <td width="12" height="27"><img src="./skinwiz/search/<%=SearchSkin%>/images/img_a.gif" width="12" height="27"></td>
                  <td width="444" height="27"><table width="62%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td><select name="price1" class="form">
                            <option value="">선택하세요
                            <option value="1000">1,000원 이상
                            <option value="10000">10,000원 이상
                            <option value="30000">30,000원 이상
                            <option value="50000">50,000원 이상
                            <option value="100000">100,000원 이상
                            <option value="200000">200,000원 이상
                            <option value="300000">300,000원 이상
                            <option value="500000">500,000원 이상
                            <option value="1000000">1,000,000원 이상
                            <option value="2000000">2,000,000원 이상
                            <option value="3000000">3,000,000원 이상
                            <option value="5000000">5,000,000원 이상
                            <option value="10000000">10,000,000원 이상
                          </select>
                          -
                          <select name="price2">
                            <option value="" >선택하세요
                            <option value="1000">1,000원 이하
                            <option value="10000">10,000원 이하
                            <option value="30000">30,000원 이하
                            <option value="50000" >50,000원 이하
                            <option value="100000">100,000원 이하
                            <option value="200000" >200,000원 이하
                            <option value="300000" >300,000원 이하
                            <option value="500000" >500,000원 이하
                            <option value="1000000">1,000,000원 이하
                            <option value="2000000">2,000,000원 이하
                            <option value="3000000">3,000,000원 이하
                            <option value="5000000">5,000,000원 이하
                            <option value="10000000">10,000,000원 이하
                          </select></td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td height="1" colspan="3" bgcolor="#cfcfcf"></td>
                </tr>
                <tr>
                  <td width="123" height="27" align="right" bgcolor="#f3f3f3"><font color="#144179">제 
                    조 사&nbsp; &nbsp; &nbsp; </font></td>
                  <td width="12" height="27"><img src="./skinwiz/search/<%=SearchSkin%>/images/img_a.gif" width="12" height="27"></td>
                  <td width="444" height="27"><input name="Brand" type="text" class="formline" id="Brand" size="30"></td>
                </tr>
                <tr>
                  <td height="1" colspan="3" bgcolor="#cfcfcf"></td>
                </tr>
                <tr>
                  <td width="123" height="27" align="right" bgcolor="#f3f3f3"><font color="#144179">정렬 
                    방식&nbsp; &nbsp; &nbsp; </font></td>
                  <td width="12" height="27"><img src="./skinwiz/search/<%=SearchSkin%>/images/img_a.gif" width="12" height="27"></td>
                  <td width="444" height="27"><table width="90%" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
                      <tr>
                        <td><input name="sort" type="radio" value="Price" checked></td>
                        <td>가격순으로 정렬</td>
                        <td><input type="radio" name="sort" value="Output"></td>
                        <td>상품인기순으로 정렬</td>
                        <td><input type="radio" name="sort" value="Point"></td>
                        <td>포인트순으로 정렬</td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                <tr>
                  <td height="1" colspan="3" bgcolor="#cfcfcf"></td>
                </tr>
                <tr>
                  <td height="3" colspan="3" bgcolor="#BEBEBE"></td>
                </tr>
              </table></td>
          </tr>
          <tr>
            <td height="40" align="right"><table width="32%" border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                  <td><img src="./skinwiz/search/<%=SearchSkin%>/images/but_cancle.gif" width="86" height="30" onClick="javascript:document.SearchForm.reset();" style="cursor:pointer"></td>
                  <td><input name="image" type="image" src="./skinwiz/search/<%=SearchSkin%>/images/but_ok.gif" width="86" height="30"></td>
                </tr>
              </table></td>
          </tr>
        </form>
        <tr>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="25" class="company"><img src="./skinwiz/search/<%=SearchSkin%>/images/icon_detail01.gif" width="9" height="9"> <font color="#006699">여러개의 검색어로 상세한 검색을 원하실때는 다중검색을 이용하세요.</font> </td>
        </tr>
        <FORM action="./wizsearch.php" onsubmit='return naturalcheck();' name=natural>
          <INPUT TYPE=HIDDEN NAME=query VALUE=natural>
          <tr>
            <td><table width="100%" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
                <tr bgcolor="#BEBEBE">
                  <td height="3" colspan="3"></td>
                </tr>
                <tr>
                  <td width="123" height="27" align="right" bgcolor="#f3f3f3"><font color="#144179">다중검색어 
                    입력&nbsp; &nbsp; &nbsp; </font></td>
                  <td width="12" height="27" valign="bottom"><img src="./skinwiz/search/<%=SearchSkin%>/images/img_a.gif" width="12" height="27"></td>
                  <td width="444" height="50"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td><table width="82%" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
                            <tr>
                              <td width="6%"><input name="Target" type="radio" value="Description1" checked></td>
                              <td width="44%"> 상품설명 검색 </td>
                              <td width="6%"><input type="radio" name="Target" value="Name"></td>
                              <td width="19%"> 상품명 검색</td>
                              <td width="6%"><input type="radio" name="Target" value="Model"></td>
                              <td width="19%"> 모델명 검색</td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr>
                        <td><table width="54%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td><input name="keyword" type="text" class="formline" id="keyword" size="30"></td>
                              <td><select name="andor" class="form" id="andor">
                                  <option>and</option>
                                  <option>or</option>
                                </select></td>
                            </tr>
                          </table></td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td height="1" colspan="3" bgcolor="#cfcfcf"></td>
                </tr>
                <tr>
                  <td height="3" colspan="3" bgcolor="#BEBEBE"></td>
                </tr>
              </table></td>
          </tr>
          <tr>
            <td height="40" align="right"><table width="32%" border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                  <td><img src="./skinwiz/search/<%=SearchSkin%>/images/but_cancle.gif" width="86" height="30" onClick="javascript:document.natural.reset();" style="cursor:pointer"></td>
                  <td><input name="image" type=image src="./skinwiz/search/<%=SearchSkin%>/images/but_ok.gif" width="86" height="30"></td>
                </tr>
              </table></td>
          </tr>
        </form>
        <tr>
          <td>&nbsp;</td>
        </tr>
      </table></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
