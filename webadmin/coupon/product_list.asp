<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util

Set util = new utility	
Set db = new database

Dim menushow, theme
Dim LoopCount
Dim category, page, keyword, smode
Dim whereis, TotalCount, TotalPage, REALTOTAL, TOTAL, sorting, OptionList,Loopcnt,setPageSize,setPageLink

menushow	= Request("menushow")
theme		= Request("theme")
category				= Request("category")
page					= Request("page") : if page = "" then page = 1

setPageSize		= 20
setPageLink		= 10

'' 카테고리별 정렬일 경우 카테고리를 다시 대/중/소 분류로 나눈단. 
if category <> "" then 
	Dim big_code,mid_code,small_code
	big_code	= right(category, 3)
	mid_code	= right(category, 6)
	small_code	= right(category, 9)
end if


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
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
%>
<html>
<head>
<title>[위즈몰] - 관리자 페이지</title>
<meta http-equiv="content-type" content="text/html; charset=<%=cfg.Item("lan")%>">
<link rel="stylesheet" href="../common/admin.css" type="text/css">
<script language="javascript" type="text/javascript" src="../../js/jquery-1.3.2.js"></script>
<script language="javascript">
<!--
$(function(){
	$(".sel_product").dblclick(function(){
	
		var rows = $("#tb_refer tr", parent.document);
		var index	= rows.length;
		$("#tb_refer", parent.document).append("<tr class='remove_product' id='remove_product"+index+"' indexval='"+index+"'>"+$(this).html()+"</tr>");
	});
});

/*function move(idx)
{
	alert(idx);

	var tb0 = document.getelementbyid('tb0');
	var tb = parent.document.getelementbyid('tb_refer');

	otr = tb.insertrow(0);
	otd = otr.insertcell(-1);
	otd.innerhtml = tb0.rows[idx].cells[0].innerhtml;
	otd = otr.insertcell(-1);
	otd.innerhtml = tb0.rows[idx].cells[1].innerhtml;

	tb.rows[0].classname = "hand";
	tb.rows[0].onclick = function(){ parent.spoit('refer',this); }
	tb.rows[0].ondblclick = function(){ parent.remove('refer',this); }
	parent.react_goods('refer');
	
}
*/
function gotopage(page){
	location.href = "main.asp?category=<%=category%>&cp="+page;
}
//-->
</script>
</head>

<body text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<div class=boxtitle>- 상품리스트 <font class=small color=#f2f2f2>(등록하려면 더블클릭)</div>
<table width="300" border="0">
  <tr> 
    <td valign="top">
      <table cellspacing=0 bordercolordark=white width="100%" bgcolor=#c0c0c0 bordercolorlight=#dddddd border=0 id=tb0>
        <form action='main.asp' name='mall_list'>
		 <input type=hidden name=query value='save'>
		<input type="hidden" name="keyword" value="<%=keyword%>">
		<input type="hidden" name="smode" value="<%=smode%>">
		<input type="hidden" name="cp" value=""> 	
  

          <tr> 
            <td colspan=2 height=1></td>
          </tr>
 <%
cnt = 0
Dim p_picture,p_picture_2, p_category,p_uid,p_pname,p_price,cnt
while not objRs.eof
	p_picture 	= split(objRs("picture"),"|")
	if Ubound(p_picture) > 1 Then p_picture_2 = p_picture(2)
	p_category	= objRs("category")
	p_uid			= objRs("uid")
	p_pname		= objRs("pname")
	p_price		= objRs("price")
	
%>
          <tr class="sel_product"> 
            <td width="50"><IMG SRC='../../config/wizstock/<%=p_picture_2%>' WIDTH='50' HEIGHT='50' BORDER=0></td>
            <td><div style="overflow:hidden;"><%=p_pname%></div>
	<%=p_price%></b>
	<input type="hidden" name="e_refer" value="<%=p_uid%>"></td>
          </tr>
          <%
		  cnt = cnt + 1
		  objRs.movenext
		  wend
		  if cnt = 0 then
		  %>
          <tr> 
            <td colspan="2"></td>
            </tr>       
          <%
		  end if
		  %>
          <tr> 
            <td colspan=2 height=25> <table cellspacing=0 cellpadding=0 width="100%" 
                        bgcolor=#ffffff border=0>
                <tr> 
                  <td align="center"> 
<%
Dim preimg : preimg = "img/pre.gif"
Dim nextimg : nextimg = "img/next.gif"	
Dim design
Dim linkurl : linkurl = "main.asp?menushow="&menushow&"&theme="&theme&"&category="&category&"&sorting="&sorting&"&OptionList="&OptionList
Call util.paging (page,setPageSize,setPageLink,TotalCount,linkurl,design)
Set util = Nothing : Set db = Nothing
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