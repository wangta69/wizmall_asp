<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.mall.asp" -->

<!-- #include file = "../../config/mall_config.asp" -->
<%
Dim strSQL,objRs
Dim db,util,mall
Set util = new utility	
Set db = new database
Set mall = new malls

dim picture,qry,category,menushow,theme,page,where,sort,keyword,setPageSize,setPageLink
Dim whereis, TotalCount, TotalPage, REALTOTAL, TOTAL, sorting, OptionList
Dim smode
''category

qry				= Request("qry")
category		= Request("category")
menushow		= Request("menushow")
theme			= Request("theme")
page			= Request("page") : if page = "" then page = 1
keyword			= Request("keyword")
smode			= Request("smode")


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

whereis = " where uid is not null and uid = pid "


if category <> "" then 
		whereis = whereis & " and category like '%" & category &"' AND pnone <> '1'"
end if

if keyword <> "" then
	keyword = trim(keyword)
	whereis = whereis & " and  ( pname LIKE '%" & keyword & "%' or description1 LIKE '%" & keyword & "%' OR model LIKE '%" & keyword & "%' )"
end if

strSQL = "SELECT COUNT(uid) FROM wizMall " & whereis
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	
TotalCount = objRs(0)
TotalPage = TotalCount / setPageSize
IF (TotalPage - (TotalCount \ setPageSize)) > 0 then
	TotalPage = int(TotalPage) + 1
Else
	TotalPage = int(TotalPage)
End if

strSQL = "select TOP " & setPageSize & " * from wizMall " & whereis & " and uid not in (SELECT TOP " & ((page - 1) * setPageSize) & " uid from wizMall " & whereis & " ORDER BY uid desc) ORDER by uid desc " 
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

%>
<html>
<head>
<title>[위즈몰] - 관리자 페이지</title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<link rel="stylesheet" href="../common/admin.css" type="text/css">
<script language="JavaScript">
<!--
function input_value(){
	var f=document.mall_list;
	var tarf = opener.writeForm.option5;
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
			alert('비교상품을 선택해 주세요');
			return false;
	}else{
	var newval = tarf.value;
	var strlen = newval.length;
	var is_split = newval.indexOf("|",[strlen-1]);
	//alert(strlen);
	//alert(newval.indexOf("|",[strlen-1]));
	if(strlen > 0 && is_split < 0){
	newval +="|";
	}
	
		for(i = 0; i < f.length; i++ ) {
				if(f[i].type == 'checkbox') {
						if(f[i].checked) {
								newval += eval(f[i].value);
								newval +="|";
						}
				}
		}
		tarf.value = newval
		document.mall_list.reset();	
	}
}

function SortbyCat(cat){
	var f = document.SortForm;
	f.category.value = cat.value;
	f.submit();
}
//-->
</script>
</head>

<body text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="600" border="0">
  <tr> 
    <td valign="top"> <table cellspacing=0 bordercolordark=white width="100%" bgcolor=#c0c0c0 bordercolorlight=#dddddd border=1>
        <tr> 
          <td><table cellspacing=0 cellpadding=0 width="100%" border=0>
              <tr> 
                <td width="70" align="center" valign="top"><font color=#ff6600>[note]</td>
                <td>제품을 선택후 확인 버튼을 눌러주세요</td>
              </tr>
            </table></td>
        </tr>
      </table>
      <br /> <table cellSpacing=0 borderColorDark=white width="100%" bgColor=#c0c0c0 borderColorLight=#dddddd 
border=1>
        <TBODY>
          <tr> 
            <td>총 등록상품</b> :  
              <%=REALTOTAL%>
              개 | 선택상품수 : 
              <%=TOTAL%>
              </b></td>
          </tr>
          <tr> 
            <td height="53"> <table cellSpacing=0 cellPadding=0 width="100%" 
border=0>
                <TBODY>
                  <tr> 
                    <td vAlign=top>&nbsp; <table width="100%" border="0">
                        <form action='' method="post" name="SortForm">
                          <input type="hidden" name=page value='<%=page%>'>
                          <!------------------------------- 검색 필드 ------------------------------>
                          <input type="hidden" name=qry value='search'>
						  <input type="hidden" name="smode" value="<%=smode%>">
						  <input type="hidden" name="category" value="<%=category%>">
                          <tr> 
                            <td width="89" height="23"> <div align="left"> 
                                <input name=keyword value="<%=keyword%>" size=12>
                              </div></td>
                            <td width="140"><input type="image" src="../img/gum.gif" width="44" height="20"> 
                              <input type="button" value="전체보기" onClick="location.href('product1_1search.asp')"></td>
                            <td align="right"> <select onChange="SortbyCat(this)">
                            <option value="">대분류</option>
                            <option value="">-----------</option>
 <% Call mall.getSelectCategory(1, category) %>
                          </select> <select  onChange="SortbyCat(this)">
                            <option value="">중분류</option>
                            <option value="">-----------</option>
 <% Call mall.getSelectCategory(2, category) %>                            
                          </select> <select  onChange="SortbyCat(this)">
                            <option value="">소분류</option>
                            <option value="">-----------</option>
 <% Call mall.getSelectCategory(3, category) %>                          
                          </select> </td>
                            <td width="6">&nbsp; </td>
                          </tr>
                        </form>
                      </table></td>
                  </tr>
                </TBODY>
              </table></td>
          </tr>
        </TBODY>
      </table>
      <br /> 
      <table cellspacing=0 bordercolordark=white width="100%" bgcolor=#c0c0c0 bordercolorlight=#dddddd border=0>
        <form action='' name='mall_list'>
		 <input type="hidden" name=qry value='save'>
		  <input type="hidden" name=keyword value='<%=keyword%>'>
		  <input type="hidden" name=smode value='<%=smode%>'>
          <tr height=22> 
            <td width="31">선택</td>
            <td width="322" align=left>제품명</td>
            <td width="136" align="center">모델명</td>
            <td width="97" align="center">브랜드</td>
          </tr>
          <tr> 
            <td colspan=4 height=1></td>
          </tr>
          <%
cnt = 0
Dim uid,pname,price,brand,model,cnt
while not objRs.eof
	''picture 	= split(objRs("picture"),"|")
	category	= objRs("category")
	uid			= objRs("uid")
	pname		= objRs("pname")
	price		= objRs("price")
	brand		= objRs("brand")
	model		= objRs("model")
	
%>
          <tr> 
            <td> <input type="checkbox" value='<%=uid%>'
                        name="multi"> </td>
            <td> <table width="100%">
                <tr> 
                  <td>
                    <%=pname%></td>
                </tr>
              </table></td>
            <td align="center"><%=model%></td>
            <td align="center"><%=brand%> </td>
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
            <td height="50" colspan="4" align="center">검색된 제품이 없습니다.</td>
          </tr>
          <tr> 
            <td colspan=4 
                      height=1></td>
          </tr>
<%
end if
%>          
          <tr> 
            <td colspan=4 height=25> <table cellspacing=0 cellpadding=0 width="100%" 
                        border=0>
                <tr> 
                  <td width=203> <input type="button" name="Button" value="비교상품담기" onClick="input_value()">
                    <input type="button" name="Button" value="닫기" onClick="window.close()"></td>
                  <td width="389" align="center"> <%
Dim preimg : preimg = "img/pre.gif"
Dim nextimg : nextimg = "img/next.gif"	
Dim design
Dim linkurl : linkurl = "product1_1search.asp?category="&category&"&sorting="&sorting&"&OptionList="&OptionList
Call util.paging (page,setPageSize,setPageLink,TotalCount,linkurl,design)
Set util = Nothing
%></td>
                </tr>
              </table></td>
          </tr>
        </form>
    </table></td>
  </tr>
</table>
</body>
</html>			
