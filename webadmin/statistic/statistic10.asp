<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<%
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

dim picture,query,menushow,theme,syear,smonth,sday,eyear,emonth,eday,page
Dim setPageSize,setPageLink,whereis,orderby,TotalCount,ListNum,searchField,searchKeyword

query		= Request("query")
menushow	= Request("menushow")
theme		= Request("theme")
syear		= Request("syear")	: If syear	= "" then syear		= Year(date)
smonth		= Request("smonth")	: If smonth	= "" then smonth	= Month(date)
sday		= Request("sday")	: If sday	= "" then sday		= Day(date)
eyear		= Request("eyear")	: If eyear	= "" then eyear		= Year(date)
emonth		= Request("emonth")	: If emonth	= "" then emonth	= Month(date)
eday		= Request("eday")	: If eday	= "" then eday		= Day(date)
page		= Request("page")	: If page	= "" then page = 1
%>
<script>
function gotoInfo(mid){
	if(mid) window.open('./member/member1_1.asp?mid='+mid, 'regisform','width=650,height=650,statusbar=no,scrollbars=yes,toolbar=no')
}

function gotoWindow(codevalue){
	window.open('./order/order1_1.asp?codevalue='+codevalue, 'cartform','width=620,height=700,statusbar=no,scrollbars=yes,toolbar=no')
}
</script>
<table class="table_outline">
  <tr>
    <td>
	
<fieldset class="desc">
<legend>기간별 판매 분석</legend>
<div class="notice">[note]</div>
<div class="comment"> * 주의 : 카드결제 성공시 "<span class="orange">입금확인됨</span>" 단계, 실패시는 
            "<span class="red">결제실패</span>"단계. 카드결제시는 카드사 관리자 모드에서 한 번더 확인 바람 </div>
</fieldset>
<div class="space20"></div>


      <table class="table_blank">
        <form action='main.asp' method=post>
          <input type="hidden"  name="menushow" value='<%=menushow%>' >
          <input type="hidden"  name="theme" value='<%=theme%>' >
          <tr>
            <td height="24" colspan="4"> Year 
              :
              <select name="syear">
                <%=util.getSelectdate("year",syear)%>
              </select>
              &nbsp;&nbsp; Month :
              <select name="smonth">
                <%=util.getSelectdate("month",smonth)%>
              </select>
              &nbsp; Day :
              <select name="sday">
                <%=util.getSelectdate("day",sday)%>
              </select>
              ~
              Year:
              <select name="eyear">
                <%=util.getSelectdate("year",eyear)%>
              </select>
              &nbsp;&nbsp; Month :
              <select name="emonth">
                <%=util.getSelectdate("month",emonth)%>
              </select>
              &nbsp; Day :
              <select name="eday">
                <%=util.getSelectdate("day",eday)%>
                <% Set util = Nothing %>
              </select>
              <input type=image height=20 width=51 src="img/move.gif" align=absMiddle border=0 name="image"></td>
            <!-- <td width="166"> <div align="right"> 
                <select onChange=this.form.submit() name=where>
                  <option>전체회원</option>
                  <option value="general">일반회원</option>
                  <option value="company">기업회원</option>
                </select> 
              </div></td>-->
          </tr>
        </form>
      </table>

      <br />
      <table class="table_main w_default">
        <tr>
          <th>&nbsp; </th>
          <th class="agn_c">주문번호</th>
          <th class="agn_c">구매금액</th>
          <th class="agn_c">주문자</th>
          <th class="agn_c">주문일시</th>
        </tr>
<%
setPageSize = 10
setPageLink = 10
if page		= "" then page = 1
whereis	= " WHERE CONVERT(VARCHAR(10),wdate,112) >= '"&syear&right("0"&smonth, 2)&right("0"&sday, 2)&"' and CONVERT(VARCHAR(10), wdate,112) <= '"&eyear&right("0"&emonth, 2)&right("0"&eday, 2)&"'"
orderby 	= " order by uid desc"
'' // 토탈
strSQL = "SELECT COUNT(uid) FROM wizbuyer " & whereis
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
TotalCount = objRs(0)


Dim uid,sname,sid,paytype,paymoney,totalmoney,summoney,codevalue,processing,wdate,total,sidstr
	

strSQL = "select TOP " & setPageSize
strSQL = strSQL & " b.uid, b.sname, b.sid, b.paytype, b.paymoney, b.totalmoney, b.codevalue, b.processing, b.wdate, "
strSQL = strSQL & " (select sum(totalmoney) from wizbuyer " & whereis & ") as total "
strSQL = strSQL & " from wizbuyer b" & whereis
strSQL = strSQL & " and uid not in (SELECT TOP " & ((page - 1) * setPageSize) & " uid from wizbuyer b" & whereis & orderby & ") " & orderby 
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
ListNum = INT(TotalCount)-(INT(setPageSize)*(INT(page)-1)) 

summoney = 0
if objRs.EOF then
%>
        <tr>
          <td colspan="5" align="center">주문내역이 없습니다. </td>
        </tr>
<%
else WHILE NOT objRs.EOF
	uid			= objRs("uid")
	sname		= objRs("sname")
	sid			= objRs("sid")
	paytype		= objRs("paytype")
	paymoney	= objRs("paymoney")
	totalmoney	= objRs("totalmoney")
	summoney	= summoney + totalmoney
	codevalue	= objRs("codevalue")
	processing	= objRs("processing")
	wdate		= objRs("wdate")
	total		= objRs("total")
	if sid = "" then 
		sidstr = "(비회원)"
	else
		sidstr = "("&sid&")"
	end if
%>		
        <tr>
          <td width=30 align="center" bgcolor=#f3f3f3><% Response.Write ListNum %></td>
          <td align="center" bgcolor="white">
             <a href="javascript:gotoWindow('<%=codevalue%>')"><%=codevalue%></a>
</td>
          <td align="center"><font color=red>
           <%=FormatNumber(totalmoney, 0)%>
            </b>원</td>
          <td align="center"><a HREF="javascript:gotoInfo('<%=sid%>')">
            <%=sname%><%=sidstr%></a></td>
          <td align="center"><font color=brown> <%=wdate%> </td>
        </tr>
<%
	ListNum = ListNum -1
	objRs.MOVENEXT
	WEND
end if	
%>			
        <tr>
          <td colspan="5">기간별 총 판매금액 : 
           <span class="blue"><%=FormatNumber(total, 0)%></span>원</td>
        </tr>
        <tr>
                <td colspan="5">현재페이지 합계금액 : <span class="blue"><%=FormatNumber(summoney, 0)%> 원</span></td>
        </tr>
            
      </table>
      <br />
      
      <div class="agn_c w_default">
<%
Set util = new utility
Dim preimg : preimg = "img/pre.gif"
Dim nextimg : nextimg = "img/next.gif"	
Dim design
Dim linkurl : linkurl = "main.asp?menushow="&menushow&"&theme="&theme&"&searchField="&searchField&"&searchKeyword="&searchKeyword & "&syear=" & syear & "&smonth=" & smonth & "&sday=" & sday & "&eyear=" & eyear & "&emonth=" & emonth & "&eday=" & eday
Call util.paging (page,setPageSize,setPageLink,TotalCount,linkurl,design)
Set util = Nothing
%>
</div></td>
  </tr>
</table>
