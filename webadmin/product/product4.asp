<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.mall.asp" -->
<%
Dim strSQL,objRs
Dim db,util,mall
Set util	= new utility	
Set db	= new database
Set mall	= new malls

dim picture,qry,category,s_category,menushow,theme,page,where,sort,keyword,Productuid_tmp,Productuid,ProductuidCount,setPageSize,setPageLink, enable_multi
Dim whereis, TotalCount, TotalPage, REALTOTAL, TOTAL, sorting, OptionList,Loopcnt, pid


qry					= Request("qry")
pid					= Request("pid")
category				= Request("category")
menushow			= Request("menushow")
theme					= Request("theme")
page					= Request("page") : if page = "" then page = 1
keyword				= Request("keyword")
Productuid_tmp	= Request("Productuid")
enable_multi	= Request("enable_multi")
Productuid		= split( Productuid_tmp,",")
if isarray(Productuid) then 
	ProductuidCount = Ubound(Productuid)+1
else 
	ProductuidCount = 1
end if

setPageSize		= 20
setPageLink		= 10

'' 카테고리별 정렬일 경우 카테고리를 다시 대/중/소 분류로 나눈단. 
if category <> "" then 
	Dim big_code,mid_code,small_code
	big_code	= right(category, 3)
	mid_code	= right(category, 6)
	small_code	= right(category, 9)
end if
'' end 

if qry = "qde" then    ''삭제옵션시 실행
	for Loopcnt=0 to ProductuidCount-1
		Call mall.DeleteProduct(Productuid(Loopcnt))
	next
ElseIf qry = "qup" then    ''품절해제에서 원상태로 변경
	strSQL	= "update wizMall set pnone = 0 where pid = " & pid
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
end if '' qry = "qde" then  삭제옵션시 실행


if enable_multi = "1" Then 
	whereis = " where uid is not null"
Else 
	whereis = " where uid is not null and (pnone = 1 or pnone = 2)"
End If

if category <> "" then 
		whereis = whereis & " and category like '%" & category &"' AND pnone <> '1'"
end if

if keyword <> "" then
	keyword = trim(keyword)
	whereis	= whereis & " and  ( pname LIKE '%" & keyword & "%' or description1 LIKE '%" & keyword & "%' OR model LIKE '%" & keyword & "%' )"
end if

strSQL = "SELECT COUNT(uid) FROM wizMall " & whereis
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	
TotalCount	= objRs(0)

strSQL = "select TOP " & setPageSize & " * from wizMall " & whereis & " and uid not in (SELECT TOP " & ((page - 1) * setPageSize) & " uid from wizMall " & whereis & " ORDER BY uid desc) ORDER by uid desc " 
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

%>
<script language="javascript" type="text/javascript">
<!--
$(function(){
	$(".btn_unlock").click(function(){
		var pid		= $(this).attr("pid");
		$("#qry").val("qup")
		alert($("#qry").val());
		$("#pid").val(pid)
		$("#s_form").attr("action", "main.asp");
		$("#s_form").submit();
	});
	
	$("#btn_search").click(function(){
		$("#qry").val("search")
		$("#s_form").attr("action", "main.asp");
		$("#s_form").submit();
	});
	
	$(".btn_excel").click(function(){
		$("#s_form").attr("action", "./product/product_excel.asp?smode=pnone");
		$("#s_form").submit();
	});		
});
function cmp(){
        var f = document.forms.mall_list;
        var i = 0;
        var chked = 0;
        for(i = 0; i < f.length; i++ ) {
                if(f[i].type == 'checkbox') {
                        if(f[i].checked) {
                                chked++;
                        }
                }
        }
        if( chked < 1 ) {
                alert('삭제하고자 하는 상품에 체크해주시기 바랍니다.');
                return false;
        }
        if (confirm('\n\n삭제하는 제품은 DB에서 삭제되어 복구가 불가능합니다.\n\n정말로 삭제하시겠습니까?\n\n')) return true;
        return false;
}

function SortbyCat(cat){
	var f = document.s_form;
	f.category.value = cat.value;
	f.submit();
}
//-->
</script>

<table class="table_outline">
	<tr>
		<td>
		
<fieldset class="desc">
<legend>제품 수정</legend>
<div class="notice">[note]</div>
<div class="comment">품절상태 상품만 디스플레이 합니다.<br />
									수정방법</b>은 수정을 원하시는 제품을 선택 후 우측 
									&quot;Modify&quot;아이콘을 클릭하시면 수정 페이지로 화면이 전환됩니다.<br />
									삭제방법</b>은 
									삭제를 원하시는 제품의 좌측 실렉트박스를 책크 후 하단 상품삭제하기를 클릭하시면 상품이 삭제됩니다.</div>
</fieldset>
<div class="space20"></div>


<form action='./main.asp' method="post" name="s_form" id="s_form">
                      <input type="hidden" name="menushow" value=<%=menushow%>>
                      <input type="hidden" name="theme" id="theme" value=<%=theme%>>
                      <input type="hidden" name="page" value='<%=page%>'>
					  <input type="hidden" name="uid" id="uid" value="">
                      <!------------------------------- 검색 필드 ------------------------------>
                      <input type="hidden" name=qry value='search'>
                      <input type="hidden" name="s_category" id="s_category" value="<%=s_category%>">
					  
                  <table cellSpacing=0 cellPadding=0 width="100%" border=0>
                   
                      <tr>
                        <td height="23">
                            <input name=keyword value="<%=keyword%>" size=12>
                        </td>
                        <td><input type="image" src="img/gum.gif" width="44" height="20"></td>
                        <td><!--<select onChange=this.form.submit() name=OptionList>
                            <option value=''>옵션별</option>
                            <option value=''>-----------</option>

                          </select> --></td>
                        <td><select onChange="SortbyCat(this)">
                            <option value="">대분류</option>
                            <option value="">-----------</option>
 <% Call mall.getSelectCategory(1, s_category) %>
                          </select>
                        </td>
                                              <td> 
                          <select  onChange="SortbyCat(this)">
                            <option value="">중분류</option>
                            <option value="">-----------</option>
 <% Call mall.getSelectCategory(2, s_category) %>                            
                          </select></td>
                                                <td><select  onChange="SortbyCat(this)">
                            <option value="">소분류</option>
                            <option value="">-----------</option>
 <% Call mall.getSelectCategory(3, s_category) %>                          
                          </select>
                                               	<!--<input name="enable_multi" type="checkbox" id="enable_multi" value="1"<% if enable_multi = "1" Then Response.Write("checked='checked'") %>/>
                                               	다중등록보기//--></td>
                        <td><!--<select onChange=this.form.submit() name=sorting>
                            <option value=''>상품정렬하기</option>
                            <option value='uid'<% if sorting = "uid" then Response.Write(" selected")%>>등록순</option>
                            <option value='wdate'<% if sorting = "wDate" then Response.Write(" selected")%>>수정순 
                            정렬</option>
                            <option value='price'<% if sorting ="Price" then Response.Write(" selected")%>>가격순 
                            정렬</option>
                            <option value='hit'<% if sorting = "Hit" then Response.Write(" selected")%>>조회순 
                            정렬</option>
                            <option value='pOutPut'<% if sorting ="pOutPut" then Response.Write(" selected")%>>판매순 
                            정렬</option>
                            <option value='Point'<% if sorting = "Point" then Response.Write(" selected")%>>포인트순 
                            정렬</option>
                          </select>-->
                         </td>

                        <td><span class="btn_excel button bull"><a>엑셀출력</a></span></td>
                      </tr>
                   
                  </table> </form>


			<br />
			<table class="table_blank">
				<form action='./main.asp' name='mall_list' onsubmit='return cmp()' method="post">
					<input type=hidden name=menushow value='<%=menushow%>'>
					<input type=hidden name="theme" value='<%=theme%>'>
					<input type=hidden name=page value='<%=page%>'>
					<input type=hidden name=qry value='qde'>
					<tr>
						<td><table class="table_main w_default">
							<col width="40px" />
							<col width="*" />
							<col width="100px" />
							<col width="90px" />
							<col width="90px" />
								<tr>
									<th>선택</th>
									<th>제품명</th>
									<th>가격</th>
									<th>상태</th>
									<th>&nbsp;</th>
								</tr>
								<%
cnt = 0
Dim p_picture,p_category,p_uid,p_pid, p_pname,p_price,cnt, p_none
while not objRs.eof
	p_picture 	= split(objRs("picture"),"|")
	p_category	= objRs("category")
	p_uid			= objRs("uid")
	p_pid			= objRs("pid")
	p_pname		= objRs("pname")
	p_price		= objRs("price")
	if objRs("pnone") = 1 then p_none = "일시품절" else if objRs("pnone") = 2 then p_none = "생산중단" end if

	
	
%>
								<tr>
									<td align="center"><input type="checkbox" value='<%=p_uid%>'
                        name="Productuid">
									</td>
									<td><a href='../wizmart.asp?code=<%=p_category%>&smode=view&no=<%=p_uid%>' target="_blank"><img src='../config/wizstock/<%=p_Picture(0)%>' width='50' height='50' border=0></a><br /><%=p_pname%></td>
									<td class="agn_r"><%=p_price%></td>
									<td class="agn_c"><%=p_none%></td>
									<td class="agn_c"><span class="btn_unlock button bull" pid=<%=p_pid%>><a>품절해제</a></span></td>
								</tr>
								<%
		  cnt = cnt + 1
		  objRs.movenext
		  wend
		  if cnt = 0 then
		  %>
								<tr>
									<td height="50" colspan="5" class="agn_c">등록된 제품이 없습니다.</td>
								</tr>
								<%
		  end if
		  %>
							</table></td>
					</tr>
					<tr>
						<td 
                      height=25><table cellspacing=0 cellpadding=0 width="100%" 
                        border=0>
								<tr>
									<td width=50><input type="image" 
                              src="img/del.gif" border=0 name="image" width="68" height="20">
									</td>
									<td align="center"><%
Dim preimg : preimg = "img/pre.gif"
Dim nextimg : nextimg = "img/next.gif"	
Dim design
Dim linkurl : linkurl = "main.asp?menushow="&menushow&"&theme="&theme&"&category="&category&"&sorting="&sorting&"&OptionList="&OptionList
Call util.paging (page,setPageSize,setPageLink,TotalCount,linkurl,design)
Set util = Nothing : Set db = Nothing : Set mall = Nothing
%>
									</td>
								</tr>
							</table></td>
					</tr>
				</form>
				</tbody>
				
			</table></td>
	</tr>
</table>
