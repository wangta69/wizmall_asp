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

dim picture,qry,category,menushow,theme,page,where,sort,keyword,Productuid_tmp,Productuid,ProductuidCount,setPageSize,setPageLink
Dim whereis, TotalCount, TotalPage, REALTOTAL, TOTAL, sorting, OptionList,Loopcnt
''category

qry					= Request("qry")
category			= Request("category")
menushow			= Request("menushow")
theme				= Request("theme")
page				= Request("page") : if page = "" then page = 1
keyword				= Request("keyword")
Productuid_tmp	= Request("Productuid")
''Response.Write(Productuid_tmp)
Productuid		= split( Productuid_tmp,",")
if isarray(Productuid) then 
	''Response.Write("배열")
	ProductuidCount = Ubound(Productuid)
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



if qry = "qup" then    ''상품가격 일괄 수정 시작
	Dim input_price, input_price1,input_wonga, input_point, sel_pdisplay, hidden_uid, SubLoopCnt, price, point

	input_price = split( Request("input_price"),",")
	input_price1 = split( Request("input_price1"),",")
	input_wonga = split( Request("input_wonga"),",")
	input_point	= split( Request("input_point"),",")
	sel_pdisplay	= split( Request("sel_pdisplay"),",")
	hidden_uid	= split( Request("hidden_uid"),",")
	
	
	
	for Loopcnt=0 to ProductuidCount
		for SubLoopCnt = 0 to Ubound(hidden_uid)
			if Trim(hidden_uid(SubLoopCnt))	= Trim(Productuid(Loopcnt)) then
				Call mall.UpdateProductPrice(hidden_uid(SubLoopCnt), input_price(SubLoopCnt), input_price1(SubLoopCnt), input_wonga(SubLoopCnt), input_point(SubLoopCnt), sel_pdisplay(SubLoopCnt))
			end if
		next
	next
end if '' qry = "qup" then  삭제옵션시 실행



whereis = " where uid  = pid and pnone = 0"


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
''Response.Write(strSQL)
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

%>
<script language="javascript" type="text/javascript">
<!--
$(function(){
	$("#btn_submit").click(function(){
		$("#mall_list").submit();
	});
});
/*
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
*/
function SortbyCat(cat){
	var f = document.SortForm;
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
<div class="comment">제품가격 및 포인트를 일괄 변경하실 수 있습니다. </div>
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
				<form action='./main.asp' method="post" name="SortForm">
                      <input type="hidden" name= menushow value=<%=menushow%>>
                      <input type="hidden" name="theme" value=<%=theme%>>
                      <input type="hidden" name=page value='<%=page%>'>
                      <!------------------------------- 검색 필드 ------------------------------>
                      <input type="hidden" name=qry value='search'>
                      <input type="hidden" name="category" value="<%=category%>">
                  <table border="0">
                   
                      <tr>
                        <td height="23">
                            <input name=keyword value="<%=keyword%>" size=12>
                        </td>
                        <td><input type="image" src="img/gum.gif" width="44" height="20"></td>
                        <td><!-- <select onChange=this.form.submit() name=OptionList>
                            <option value=''>  </option>

                          </select> --></td>
                        <td><select onChange="SortbyCat(this)">
                            <option value="">대분류</option>
                            <option value="">-----------</option>
 <% Call mall.getSelectCategory(1, category) %>
                          </select>
                        </td>
                                              <td> 
                          <select  onChange="SortbyCat(this)">
                            <option value="">중분류</option>
                            <option value="">-----------</option>
 <% Call mall.getSelectCategory(2, category) %>                            
                          </select></td>
                                                <td><select  onChange="SortbyCat(this)">
                            <option value="">소분류</option>
                            <option value="">-----------</option>
 <% Call mall.getSelectCategory(3, category) %>                          
                          </select></td>
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

                        <td>&nbsp;</td>
                      </tr>
                   
                  </table> </form></td>
              </tr>
            </table></td>
        </tr>
      </table>
      <br /><form action='./main.asp' name='mall_list' id="mall_list" method="post">
          <input type=hidden name=menushow value='<%=menushow%>'>
          <input type=hidden name="theme" value='<%=theme%>'>
          <input type=hidden name=page value='<%=page%>'>
          <input type=hidden name=qry value='qup'>
      <table class="table_blank">  

           <tr>
            <td><table class="table_main w_default">        
          <tr align="center" height=22>
            <th width="40">선택</th>
            <th align=left>제품명</th>
            <th align=left></th>
            <th ></th>
          </tr>
          <tr>
            <td colspan=4 height=1></td>
          </tr>
          <%
cnt = 0
Dim p_picture,p_category,p_uid,p_pname,p_price,p_price1,wongaprice, p_point,pdisplay,cnt, picture2
while not objRs.eof
	//If isnull(objRs("picture")) then 

	//Else 
		''Response.Write(objRs("picture"))
		If objRs("picture") <> "" then
		p_picture 	= split(objRs("picture"),"|")
		''Response.Write(p_picture)
		If Ubound(p_picture) >= 2 then picture2	= p_picture(2)	
		End If
//	End If
	p_category	= objRs("category")
	p_uid		= objRs("uid")
	p_pname		= objRs("pname")
	p_price		= objRs("price")''판매가
	p_price1	= objRs("price1")''시중가
	wongaprice	= objRs("wongaprice")''구매가
	p_point		= objRs("point")
	pdisplay	= objRs("pdisplay")
	
%>
          <tr>
            <td align="center"><input type="checkbox" value="<%=p_uid%>" name="Productuid"> <input type="hidden" name="hidden_uid" value="<%=p_uid%>" />           </td>
            <td><table width="100%">
                <tr>
                  <td width=50><a HREF='../wizmart.asp?code=<%=p_category%>&smode=view&no=<%=p_uid%>' TARGET=_blank><IMG SRC='../config/wizstock/<%=picture2%>' width='50' height='50' border=0></A></td>
                  <td> <%=p_pname%> </td>
                </tr>
              </table></td>
               <td align=left>&nbsp;</td>
            <td align=right>판매가: 
            	<input name="input_price" type="text" value="<%=p_price%>"/>
            	/
            	시중가:
            	<input name="input_price1" type="text" value="<%=p_price1%>"/>
            	 /구매가:
            	<input name="input_wonga" type="text" value="<%=wongaprice%>"/>
            / 포인트 :
            	<input type="text" name="input_point" value="<%=p_point%>" />/ <select name="sel_pdisplay" id="sel_pdisplay">
								<option value="0"<% if pdisplay = "0" then Response.Write(" selected='selected'") %>>상품진열</option>
								<option value="1"<% if pdisplay = "1" then Response.Write(" selected='selected'") %>>상품감춤</option>
							</select></td>
          </tr>
          <tr>
            <td colspan=4 height=1></td>
          </tr>
          <%
		  cnt = cnt + 1
		  objRs.movenext
		  wend
		  if cnt = 0 then
		  %>
          <tr>
            <td height="50" colspan="4" align="center">등록된 제품이 없습니다.</td>
            </tr>
          <tr>
            <td colspan=4 height=1></td>
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
                  <td width=50><span class='button bull' id="btn_submit"><a>상품가격일괄수정</a></span>
                  </td>
                  <td align="center">

<%
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
       
        </tbody>
        
      </table> </form></td>
  </tr>
</table>
