<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/skin_info.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
Dim menushow, theme
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

menushow	= Request("menushow")
theme		= Request("theme")
%>

<table class="table_outline">
  <tr>
    <td>
	  <fieldset class="desc">
			<legend>몰스킨 설정</legend>
			<div class="notice">[note]</div>
			<div class="comment"> 위즈몰의 각종 몰스킨을 설정하실 수 있습니다. <br />
                  숍디스프레이에서는 상품 출력 갯수를 설정하실 수 있습니다.<br />
                  카테고리별 스킨설정이 가능하므로 상품특성에 맞는 다양한 스킨설정이 가능합니다.</div>
			</fieldset>
			<p></p>


              <form action='./basicinfo/basic_info4_1.asp' method=post>
                <input type="hidden" name="menushow" value="<%=menushow%>">
                <input type="hidden" name="theme" value="<%=theme%>">
                <input type="hidden" name="qry" value='qup'>      

				<table class="table_main w_default">
				<col width="200px" />
				<col width="*" />
                <tr>
                  <td colspan=2>사용하고자 
                    하시는 스킨을 지정하여 주십시오. </td>
                </tr>
                <!-------------- 메인화면 스킨 시작 ----------------------------------------------------------------------------------->
                <tr>
                  <th>레이아웃스킨
                    <input id=GoodsNoShow  type="checkbox" value=checked name=GoodsNoShow <%'=GoodsNoShow%>>
                    메뉴상품수표시여부 </th>
                  <td>
                    <select name="LayoutSkin">
                      <%=util.ShowFolderList(PATH_SYSTEM & "skinwiz\layout",LayoutSkin)%>
                    </select>
                    쇼핑몰 전체 레이아웃 </td>
                </tr>
                <tr>
                  <th> 메인화면스킨 
                    <input id=box type="checkbox" value=checked name=MainSkin_Inc <%'=MainSkin_Inc%>>
                    스킨사용</th>
                  <td>
                    <select name=MainSkin>
                      <%=util.ShowFolderList(PATH_SYSTEM & "skinwiz\index",MainSkin)%>
                    </select>
                    쇼핑몰 첫화면</td>
                </tr>
                <!-------------- 메뉴화면 스킨 끝 ----------------------------------------------------------------------------------->
                <!-------------- 기본매장화면 스킨 시작 ----------------------------------------------------------------------------------->
                <tr>
                  <th> 숍스킨(리스트스킨) </th>
                  <td>
                    <select name=ShopSkin>
                      <%=util.ShowFolderList(PATH_SYSTEM & "skinwiz\shop",ShopSkin)%>
                    </select>
                    쇼핑몰의상품 디스플레이 스킨<br />
                     페이지당상품 리스수 :
                    <input  size=4 name="ListNo" value="<%=ListNo%>">
                    개, 페이지별 이동번호 수 :
                    <input  size=4 name="PageNo" value="<%=PageNo%>">
                    개<br />
                     기본정렬방식
                    <select  size="1" name="DefaultOrder">
                      <%
Call DefaultOrderList()

Sub DefaultOrderList()	
	Dim DefaultOrderArr, selected, eachitem
	Set DefaultOrderArr = CreateObject("Scripting.Dictionary")
	DefaultOrderArr.Add "m2.uid/desc", "등록순"
	DefaultOrderArr.Add "userorder/asc", "사용자정의"
	For Each eachitem In DefaultOrderArr
		if DefaultOrder = eachitem then selected = " selected" else selected = ""
		response.write "<option value='"&eachitem&"'"&selected&">" & DefaultOrderArr.item(eachitem) & "</option>"&chr(13)&chr(10)
	Next
	Set DefaultOrderArr = Nothing
End Sub
%>
                    </select>
                    <br />
                     1차카테고리 첫화면 모양
                    <select  size=1 name="SubListSubject">
                    </select>
                    을
                    <input  size=4 name="SubListNo" value="<%=SubListNo%>">
                    개 출력</td>
                </tr>
                <!-------------- 기본배장화면 스킨 끝 ----------------------------------------------------------------------------------->
                <!-------------- 기본매장화면 스킨 시작 ----------------------------------------------------------------------------------->
                <tr>
                  <th> 숍스킨(상세보기스킨)</th>
                  <td><p>
                      <select name="ViewerSkin">
                        <%=util.ShowFolderList(PATH_SYSTEM & "skinwiz\viewer",ViewerSkin)%>
                      </select>
                      쇼핑몰의상품 디스플레이 스킨 <br />
                       
                      <input type="checkbox" name="GoodsDisplayEstim" value="checked" <%=GoodsDisplayEstim%>>
                      상세보기페이지에 상품평표시하기<br />
                      
                      <input type="checkbox" name="GoodsDisplayPid" value="checked" <%=GoodsDisplayPid%>>
                      상세보기페이지에 관련상품 표시하기</p></td>
                </tr>
                <tr>
                  <th>옵션아이콘설정</th>
                  <td>
                    <select name="IconSkin">
                      <%=util.ShowFolderList(PATH_SYSTEM & "skinwiz\common_icon",IconSkin)%>
                    </select>
                    상품등록시의 옵션 아이콘 폴더</td>
                </tr>
                <!-------------- 기본배장화면 스킨 끝 ----------------------------------------------------------------------------------->
                <!--------------상품결제화면 스킨 시작 ----------------------------------------------------------------------------------->
                <tr>
                  <th> 장바구니스킨
                    <input id="NoneDouble" type="checkbox" value="checked" name="NoneDouble" <%'=NoneDouble%>>중복담기금지 </th>
                  <td>
                    <select name="CartSkin">
                      <%=util.ShowFolderList(PATH_SYSTEM & "skinwiz\cart",CartSkin)%>
                    </select>
                    일련의 장바구니 스킨</td>
                </tr>
                <!-------------- 상품결제화면 스킨 끝 ----------------------------------------------------------------------------------->
                <!--------------공동구매 스킨 시작 ----------------------------------------------------------------------------------->
                <tr>
                  <th> 공동구매스킨</th>
                  <td>
                    <select name=CoorBuySkin>
                    </select>
                    일련의 장바구니 스킨</td>
                </tr>
                <!-------------- 공동구매 스킨 끝 ----------------------------------------------------------------------------------->
                <!--------------회원가입관련스킨 시작 ----------------------------------------------------------------------------------->
                <tr>
                  <th>회원관련스킨
                    <input id=box 

                         type="checkbox" 
                        value=checked name=NoneMemOnly <%'=NoneMemOnly%>>
                    비회원전용 </th>
                  <td>
                    <select name="MemberSkin">
                      <%=util.ShowFolderList(PATH_SYSTEM & "wizmember",MemberSkin)%>
                    </select>
                    회원가입,수정,탈퇴에 관한 스킨</td>
                </tr>
                <!-------------- 회원가입관련 스킨 끝----------------------------------------------------------------------------------->
                <tr>
                  <th> 검색스킨</th>
                  <td>
                    <select name=SearchSkin>
                      <%=util.ShowFolderList(PATH_SYSTEM & "skinwiz\search",SearchSkin)%>
                    </select>
                    검색 디스플레이 스킨</td>
                </tr>
                <!-------------- [위시리스트 스킨]----------------------------------------------------------------------------------->
                <tr>
                  <th> 위시리스트스킨</th>
                  <td>
                    <select name="WishSkin">
                      <%=util.ShowFolderList(PATH_SYSTEM & "skinwiz\wizwish",WishSkin)%>
                    </select>
                    위시리스트 디스플레이 스킨</td>
                </tr>
                <tr>
                  <th> 일반문서스킨</th>
                  <td>
                    <select name=HtmlSkin>
                      <%=util.ShowFolderList(PATH_SYSTEM & "skinwiz\html",HtmlSkin)%>
                    </select>
                    일반문서 디스플레이 스킨</td>
                </tr>
                <!-------------- [zipcode pop skin 선택 start] ----------------------------------------------------------------------------------->
                <tr>
                  <th> 우편번호찾기스킨</th>
                  <td>
                    <select name="ZipCodeSkin">
                      <%=util.ShowFolderList(PATH_SYSTEM & "util\zipcode",ZipCodeSkin)%>
                    </select>
                    우편번호찾기 디스플레이 스킨</td>
                </tr>
                <tr>
                  <td colspan=2 align="center"><input type="image" src="img/sul.gif" width="68" height="20">
                  </td>
                </tr>
              
            </table></form>
            <p></p>
            <table class="table_title">
              <tr>
                <td width=100><div align="center">매장스킨 
                    확장</div></td>
                <td colspan=3><br />
                  매장스킨 확장기능은 매장별로 스킨을 구분하여 지정할 수 있는 기능입니다..<br />
                  성격이 다른 매장인 관계로, 스킨을 다르게 지정하고자 할 경우 해당매장만 스킨을 변경하여 주시면 됩니다.<br />
                  매장 확장스킨을 지정하지 않으시면 기본매장스킨으로 적용됩니다.<br />
                  <br />
                  <table cellspacing=0 cellpadding=0 width="100%" border=0>
                    <tr>
                      <td align="right">| 적 용 스 킨 |</b></td>
                    </tr>
                    <%
Dim displayID				
displayID = 1
strSQL = "select * from wizcategory where len(cat_no) = 3 order by cat_no asc"		
'strSQL = "select * from wizcategory where len(cat_no) = 3 < '1000' order by cat_no asc"	
'where LEN(cat_no) = "&strlen&" and RIGHT(cat_no, "&comlen&") = '"&ccode&"'"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
while not objRs.eof
	'cat_no = list("cat_no")
	'bigcode = Right(cat_no, 3);
	'big_code = substr(code, -2); /* wizmart에서 넘어온 코드값의 대분류 코드값을 구한다 */
	' 하위 카테고리 유무 책크 */
	'sqlsubcountstr = "select count(UID) from wizCategory where cat_no LIKE '%bigcode'";
	'sqlsubcountqry = mysql_query(sqlsubcountstr);
	'sqlsubcount = mysql_result(sqlsubcountqry, 0, 0);
	
	
	
	' 카테고리별 등록 상품수를 구한다. */
	'                if (GoodsNoShow  == 'checked') {
	 '               sqlcountstr = mysql_query( "select count(UID) from wizMall where Category LIKE '%bigcode'", DB_CONNECT );
	'                TotalGoodsNo = "(".mysql_result(sqlcountstr, 0, 0).")";
	'                }
	'                if (ereg(bigcode,big_code)) {show_hidden = "show";}else{show_hidden = "none";}/* wizmart에서 넘어온 대분류 코드값과 현대 wizCategory의 대분류 코드값을 비교해 토글 display 유무를 결정한다.*/
	'* 하위 카테고리 유무 책크 및 토글을 입력한다 */
	
	'if(sqlsubcount > 1) ahref = "HREF='javascript:;' onClick=\"return DisplayToggle('catlistmenudisplayID')\"";
	'                else ahref = "HREF='javascript:;' onClick=\"alert('하위메뉴가 없습니다.');\"";
%>
                    <tr>
                      <td height='1' bgcolor='cccccc'></td>
                    </tr>
                    <tr>
                      <td>
					  <form action='main.asp' method=post>
                            <input type="hidden" name='menushow' value='menu1'>
                            <input type="hidden" name='theme' value='basicinfo/basic_info4_qry2'>
                            <input type="hidden" name='query' value='qup'>
                            <input type="hidden" name='uid' value='<%=objRs("uid")%>'>
					  <table width='100%' height='22' border='0' cellpadding='0' cellspacing='0'>
                          
                            <tr>
                              <td width='10' align='center'></td>
                              <td width="128" height='20'><a <%'=ahref%>> <%=objRs("cat_name")%> </a></b></td>
                              <td width="506"><select name="CAT_SKIN" style='width:200;'>
                                  <option value="" selected>기본 리스트 스킨 적용</option>
                                  <%=util.ShowFolderList(PATH_SYSTEM & "skinwiz\shop",objRs("cat_skin"))%>
                                </select>
                                <select name="CAT_SKIN_VIEWER" style='width:200;'>
                                  <option value="" selected>기본 상세보기 스킨 적용</option>
                                  <%=util.ShowFolderList(PATH_SYSTEM & "skinwiz\viewer",objRs("cat_skin_viewer"))%>
                                </select>
                                <input type="image" src="img/juk.gif" align="middle" width="53" height="20"></td>
                            </tr>
                          
                        </table>
						</form></td>
                    </tr>
                    <!--
                     <%
' 중분류 카테고리를 리스트 한다.
'if(sqlsubcount > 1):
%> 
                     <tr> 
                      <td valign='top'> <div id='catlistmenu<%'=displayID%>' style='display:<%'=show_hidden%>;margin-left:15px'> 
                          <table width='100%' border='0' cellpadding='0' cellspacing='0'> 

                            <%		  
                               ' sqlsubstr = "select * from wizCategory where cat_no >= 100 and cat_no <10000 and cat_no LIKE '%bigcode' order by cat_no asc";
								'sqlsubqry = mysql_query(sqlsubstr) or die(mysql_error());
								'while(sublist = mysql_fetch_array(sqlsubqry)):
%> 
                            <form action='<%'={PHP_SELF}%>' method=post> 
                              <input type="hidden" name='menu1' value='show'> 
                              <input type="hidden" name='theme' value='basic_info4'> 
                              <input type="hidden" name='qry' value='cat_write'> 
                              <input type="hidden" name='UID' value='<%'=sublist[UID]%>'> 
                              <tr> 
                                <td width="14"></td> 
                                <td width="108" height="18"> <%'=sublist[cat_name]%> </td> 
                                <td width="507"> <select name=CAT_SKIN style='width:200;'> 
                                    <option value="" selected>기본 리스트 스킨 적용</option> 
                                    <%

            '  open_dir = opendir("../skinwiz/shop");
                        'while(opendir = readdir(open_dir)) {
                            '   if((opendir != ".") && (opendir != "..")) {
                                 '       if (sublist[cat_skin]) CAT_SKIN=sublist[cat_skin];
								'		else CAT_SKIN = SKIN;
                                  '      if(CAT_SKIN == opendir) {
                                   '             echo "<option value=\"opendir\" selected>opendir 리스트 스킨</option>\n";
                                   '     }
                                     '   else {
                                     '           echo "<option value=\"opendir\">opendir 리스트스킨</option>\n";
                                     '   }
                              ' }
                      '  }
               ' closedir(open_dir);
%> 
                                  </select> 
                                  <select name=CAT_SKIN_VIEWER style='width:200;'> 
                                    <option value="" selected>기본 상세보기 스킨 적용</option> 
                                    <%
            '  open_dir = opendir("../skinwiz/viewer");
                       ' while(opendir = readdir(open_dir)) {
                              '  if((opendir != ".") && (opendir != "..")) {
                                   '     if (sublist[cat_skin_viewer]) CAT_SKIN_VIEWER=sublist[cat_skin_viewer];
                                   '     if(CAT_SKIN_VIEWER == opendir) {
                                   '             echo "<option value=\"opendir\" selected>opendir 상세보기스킨</option>\n";
                                  '      }
                                  '      else {
                                  '              echo "<option value=\"opendir\">opendir 상세보기스킨</option>\n";
                                  '      }
                              '  }
                       ' }
               ' closedir(open_dir);
%> 
                                  </select> 
                                  <input name="image" type="image" src="img/juk.gif" align="middle" width="53" height="20"> 
</td> 
                              </tr> 
                            </form> 
                            <%	
'unset(CAT_SKIN);
'unset(CAT_SKIN_VIEWER);		  
'endwhile;
%> 
                          </table> 
                        </div></td> 
                    </tr> -->
                    <%
displayID = displayID + 1
'end if
objRs.MOVENEXT
wend
%>
                  </table>
                  <div ID=catlistmenu<%=displayID%> style='display:none;margin-left:5px'> </div>
                  <script language="javascript">
<!--
function DisplayToggle(currMenu) {
		if (document.all) {
				thisMenu = eval("document.all." + currMenu + ".style")
				if (thisMenu.display != "none") {
						thisMenu.display = "none"
				}
				else {
						for (i = 1; i < <%=displayID+1 %>; i++ ){
								if (eval("document.all.catlistmenu" + i + ".style").display != "none") {
										eval("document.all.catlistmenu" + i + ".style").display = "none"
								}
								else {
										thisMenu.display = "block"
								}
						}
				}
				return false
		}
		else {
				return false
		}
}
//-->
</script>
                </td>
              </tr>
            </table></td>
        </tr>
      </table>

<%
SET objRs =Nothing : Set db	= Nothing : Set util = Nothing
%>
