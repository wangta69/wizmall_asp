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
Dim whereis, TotalCount, TotalPage, REALTOTAL, TOTAL, sorting, OptionList,Loopcnt
''category

qry					= Request("qry")
s_category			= Request("s_category")
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
if s_category <> "" then 
	Dim big_code,mid_code,small_code
	big_code	= right(s_category, 3)
	mid_code	= right(s_category, 6)
	small_code	= right(s_category, 9)
end if
'' end 

if qry = "qde" then    ''삭제옵션시 실행
	for Loopcnt=0 to ProductuidCount-1
		Call mall.DeleteProduct(Productuid(Loopcnt))
	next
end if '' qry = "qde" then  삭제옵션시 실행


if enable_multi = "1" Then 
	whereis = " where uid is not null"
Else 
	whereis = " where uid  = pid and pnone = 0"
End If

if s_category <> "" then 
		whereis = whereis & " and category like '%" & s_category &"'"
end if

if keyword <> "" then
	keyword = trim(keyword)
	whereis	= whereis & " and  ( pname LIKE '%" & keyword & "%' or description1 LIKE '%" & keyword & "%' OR model LIKE '%" & keyword & "%' )"
end if

strSQL = "SELECT COUNT(uid) FROM wizMall " & whereis
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	
TotalCount	= objRs(0)

''Response.Write(whereis)
strSQL = "select TOP " & setPageSize & " * from wizMall " & whereis & " and uid not in (SELECT TOP " & ((page - 1) * setPageSize) & " uid from wizMall " & whereis & " ORDER BY uid desc) ORDER by uid desc " 
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

%>
<script language="javascript" type="text/javascript">
<!--
$(function(){
	$(".btn_modify").click(function(){
		var uid = $(this).attr("uid");
		$("#uid").val(uid);
		$("#s_form").attr("action", "main.asp");
		$("#theme").val("product/product1");
		$("#s_form").submit();
	});
	
	$(".btn_excel").click(function(){
		$("#s_form").attr("action", "./product/product_excel.asp");
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
	$("#s_form").attr("action", "main.asp");
	$("#s_category").val(cat.value);
	$("#s_form").submit();
}
//-->
</script>
<table class="table_outline">
  <tr>
    <td>
	
<fieldset class="desc">
<legend>제품 수정</legend>
<div class="notice">[note]</div>
<div class="comment"> 제품을 수정 삭제 하실 수 있습니다.<br />
                  수정방법</b>은 수정을 원하시는 제품을 선택 후 우측 
                  &quot;Modify&quot;아이콘을 클릭하시면 수정 페이지로 화면이 전환됩니다.<br />
                  삭제방법</b>은 
                  삭제를 원하시는 제품의 좌측 실렉트박스를 책크 후 하단 상품삭제하기를 클릭하시면 상품이 삭제됩니다.</div>
</fieldset>
<div class="space20"></div>


      <table class="table_title">
        <!--<tr> 
          <td>총 등록상품</b> :  
            <%=REALTOTAL%>
            개 | 선택상품수 : 
            <%=TOTAL%>
            </b></td>
        </tr>-->
        <tr>
          <td height="53"><table cellSpacing=0 cellPadding=0 width="100%" 
border=0>
              <tr>
                <td vAlign=top>&nbsp; 
				<form action='./main.asp' method="post" name="s_form" id="s_form">
                      <input type="hidden" name="menushow" value=<%=menushow%>>
                      <input type="hidden" name="theme" id="theme" value=<%=theme%>>
                      <input type="hidden" name="page" value='<%=page%>'>
					  <input type="hidden" name="uid" id="uid" value="">
                      <!------------------------------- 검색 필드 ------------------------------>
                      <input type="hidden" name=qry value='search'>
                      <input type="hidden" name="s_category" id="s_category" value="<%=s_category%>">
					  
                  <table border="0">
                   
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
                   
                  </table> </form></td>
              </tr>
            </table></td>
        </tr>
      </table>
      <br /><form action='./main.asp' name='mall_list' onsubmit='return cmp()' method="post">
      <table class="table_blank">  

          <input type=hidden name="menushow" value='<%=menushow%>'>
          <input type=hidden name="theme" value='<%=theme%>'>
          <input type=hidden name="page" value='<%=page%>'>
          <input type=hidden name="qry" value='qde'>
           <tr>
            <td><table class="table_main w_default">    
			<col width="40px" />
			<col width="55px" />
			<col width="*" />
			<col width="100px" />
			<col width="90px" />
          <tr>
            <th class="agn_c">선택</th>
			<th class="agn_c">이미지</th>
            <th class="agn_c">제품명</th>
            <th class="agn_c">가격</th>
            <th>&nbsp;</th>
          </tr>
          <%
cnt = 0
Dim p_picture,p_picture_2, p_category,p_uid,p_pname,p_price,cnt
while not objRs.eof
	p_picture 	= split(objRs("picture"),"|")
	if Ubound(p_picture) > 1 Then p_picture_2 = p_picture(2)
	p_category	= objRs("category")
	p_uid		= objRs("uid")
	p_pname		= objRs("pname")
	p_price		= objRs("price")
	
%>
          <tr>
            <td align="center"><input type="checkbox" value='<%=p_uid%>' name="Productuid"></td>
			<td><a href='../wizmart.asp?code=<%=p_category%>&smode=view&no=<%=p_uid%>' TARGET=_blank><img src='../config/wizstock/<%=p_picture_2%>' width='50' height='50' border=0></a></td>
            <td> <%=p_pname%> </td>
            <td class="agn_r"><%=FormatNumber(p_price, 0)%> 원</td>
            <td class="agn_c"><div align="center"><!--<a HREF='./main.asp?menushow=<%=menushow%>&theme=product/product1&uid=<%=p_uid%>&page=<%=page%>'><IMG SRC='./img/mo.gif' border=0></A></div>//-->
			<span class="btn_modify button bull" uid="<%=p_uid%>"><a>수정</a></span>
			</td>
          </tr>
          <%
		  cnt = cnt + 1
		  objRs.movenext
		  wend
		  if cnt = 0 then
		  %>
          <tr>
            <td height="50" colspan="5" align="center">등록된 제품이 없습니다.</td>
            </tr>
       
          <%
		  end if
		  %>
        
      </table></td>
          </tr>
          <tr>
            <td height=25><table cellspacing=0 cellpadding=0 width="100%" border=0>
                <tr>
                  <td width=50><input type=image src="img/del.gif" border=0 name="image" width="68" height="20">
                  </td>
                  <td>
					<div class="agn_c w_default">
					<%
					Dim preimg : preimg = "img/pre.gif"
					Dim nextimg : nextimg = "img/next.gif"	
					Dim design
					Dim linkurl : linkurl = "main.asp?menushow="&menushow&"&theme="&theme&"&s_category="&s_category&"&sorting="&sorting&"&OptionList="&OptionList
					Call util.paging (page,setPageSize,setPageLink,TotalCount,linkurl,design)
					Set util = Nothing : Set db = Nothing : Set mall = Nothing
					%>
					</div>

                    </td>
                </tr>
              </table></td>
          </tr>
        
        </tbody>
        
      </table></form></td>
  </tr>
</table>
