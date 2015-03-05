<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/mall_config.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
''powered by 폰돌
''Reference URL : http://www.shop-wiz.com
''Contact Email : master@shop-wiz.com
''Free Distributer : 
''Copyright shop-wiz.com
''UPDATE HISTORY
''2006-12-10 : 시험판 인스톨형 제작

Dim tablename,theme,menushow,keyword,whereis,page,setPageSize,setSubjectCut,setPageLink
Dim TotalCount, TotalPage
Dim cnt,ListNum,sname,sid,sjumin1,sjumin2,semail,stel1,stel2,szip,saddress1,saddress2,rname
Dim remail,rtel1,rtel2,rzip,raddress1,raddress2,paytype,paymoney,totalmoney,bankinfo,inputer
Dim codevalue,processing,content,rdate,wdate,DeliveryStatus


Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

tablename		= "wizbuyer"
theme			= Request("theme")
menushow		= Request("menushow")
keyword			=  Request("keyword")
whereis			=  Request("whereis")
page			=  Request("page") : if page = "" then page = 1

setPageSize		= 10
setSubjectCut	= 20
setPageLink		= 10
whereis = "where uid <> 0 "
whereis = whereis & " and processing < 4"
	strSQL = "SELECT COUNT(b.uid) FROM wizbuyer b " & whereis 
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
'' // 전체 게시물 및 전체 페이지

	

	TotalCount = objRs(0)
	TotalPage = TotalCount / setPageSize
	IF (TotalPage - (TotalCount \ setPageSize)) > 0 then
		TotalPage = int(TotalPage) + 1
	Else
		TotalPage = int(TotalPage)
	End if

%>
<script language="javascript" type="text/javascript">
<!--
$(function(){
	$("#btn_downexcel").click(function(){
		$("#s_form").attr("action", "./order/order1_excel.asp");
		$("#s_form").submit();
		$("#s_form").attr("action", "");
	});

});

function gotoWindow(codevalue){
	wizwindow('./order/order1_1.asp?codevalue='+codevalue, 'cartform','width=620,height=700,statusbar=no,scrollbars=yes,toolbar=no')
}
//-->
</script>
<table class="table_outline">
  <tr>
    <td>
<fieldset class="desc">
<legend>주문상품보기</legend>
<div class="notice">[note]</div>
<div class="comment"> </div>
</fieldset>
<div class="space20"></div>



		<span class="button bull" id="btn_downexcel"><a>엑셀다운</a></span> 
		<form method="post" action="" id="s_form">
		</form>
      <table cellspacing=1 bordercolordark=white width="760" bgcolor=#c0c0c0 bordercolorlight=#dddddd border=0 cellpadding="1">
        <tr class="altern">
          <th>번호</th>
          <th>주문번호</th>
          <th>구매금액</th>
          <th>거래상태</th>
          <th>주문자</th>
          <th>전화</th>
          <th>주문일시</th>
        </tr>
        <%
		
strSQL = "select TOP " & setPageSize & " * from wizbuyer "& whereis &" and uid not in (SELECT TOP " & ((page - 1) * setPageSize) & " uid from wizbuyer "& whereis &"  ORDER BY uid desc) ORDER BY uid desc " 

'Response.Write(strSQL)
cnt = 0
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
while not objRs.eof
cnt = cnt+1

ListNum = INT(TotalCount)-(INT(setPageSize)*(INT(page)-1)) - cnt + 1
sname 			= objRs("sname")
sid				= user_id
sjumin1 		= objRs("sjumin1")
sjumin2 		= objRs("sjumin2")
semail 			= objRs("semail")
stel1 			= objRs("stel1")
stel2 			= objRs("stel2")
szip 			= objRs("szip")
saddress1 		= objRs("saddress1")
saddress2 		= objRs("saddress2")
rname 			= objRs("rname")
remail 			= objRs("remail")
rtel1 			= objRs("rtel1")
rtel2 			= objRs("rtel2")
rzip 			= objRs("rzip")
raddress1 		= objRs("raddress1")
raddress2 		= objRs("raddress2")
paytype 		= objRs("paytype")
paymoney 		= objRs("paymoney")
totalmoney 		= objRs("totalmoney")
bankinfo 		= objRs("bankinfo")
inputer 		= objRs("inputer")
codevalue 		= objRs("codevalue")
processing 		= objRs("processing")
content 		= objRs("content")
rdate 			= objRs("rdate")
wdate 			= objRs("wdate")
DeliveryStatus	= DeliveryStatusArr(processing)
%>
        <tr align=middle bgcolor=white height=25> 
          <td width=30 align="center" bgcolor=#f3f3f3><%=ListNum%></td>
          <td align="center" bgcolor="white"><font color="black"><a href="javascript:gotoWindow('<%=codevalue%>')"><%=codevalue%></a></td>
          <td align="center"><font color=red><%=FormatNumber(totalmoney, 0)%></b>원</td>
          <td align="center"><font color=red> <%=DeliveryStatus%>  </td>
          <td align="center"><font 
                        color=black> <%=sname%></td>
          <td align="center">&nbsp;<%=rtel1%></td>
          <td align="center"><font color=brown> <%=FormatDateTime(wdate,2)%> </a></td>
        </tr>
        <%
objRs.movenext
wend
%>
      </table>
                  <br />
       
      <table width="760" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center">

<%
Dim preimg : preimg = "img/pre.gif"
Dim nextimg : nextimg = "img/next.gif"	
Dim design
Dim linkurl : linkurl = "main.asp?theme="&theme&"&menushow=" & menushow
Call util.paging (page,setPageSize,setPageLink,TotalCount,linkurl,design)
Set util = Nothing
%> </td>
  </tr>
</table></td>
        </tr>
      </table></td>
              </tr>
            </table>
<%
SET objRs =NOTHING
%>			
