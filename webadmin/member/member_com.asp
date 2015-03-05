<% Option Explicit %>
<!-- #include file="../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file="../../lib/class.util.asp" -->
<!-- #include file="../../lib/class.database.asp" -->
<!-- #include file="../../lib/class.member.asp" -->
<!-- #include file = "../../config/common_array.asp" -->
<%
''powered by 폰돌
''Reference URL : http://www.shop-wiz.com
''Contact Email : master@shop-wiz.com
''Free Distributer : 
''Copyright shop-wiz.com
''UPDATE HISTORY

Dim compname,compaddress1,compprename,compchaname,compchatel,comptel,compfax, uid

Dim theme, menushow, qry
Dim Loopcnt
Dim strSQL, objRs, params, whereis, joinon, sqlcountstr, counting
Dim setPageSize, setPageLink, page, realtotal, TotalCount, TotalPage, LoopNum, ListNum
Dim db, util, member
Set db		= new database : Set util	= new utility : Set member	= new members

theme			= Request("theme")
menushow		= Request("menushow")
qry				= Request("qry")
uid				= Request("uid")
page			= Request("page") : if page = "" then page = 1
setPageSize		= 20
setPageLink		= 10

if qry = "qde" then
	strSQL = "delete from wizcom " 
	strSQL = strSQL & " where uid = " & uid
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
End If
%>
<script language="javascript" type="text/javascript">
<!--
$(function(){
	$(".btn_write").click(function(){
		var uid	= $(this).attr("uid");
		if(uid == undefined) uid = "";
		location.href="./main.asp?menushow=menu6&theme=member/member_com_write&uid="+uid;
	});
	
	
	$(".btn_delete").click(function(){
		var uid	= $(this).attr("uid");
		$("#uid").val(uid);
		$("#qry").val("qde");
		$("#s_form").submit();
	});
});


//-->		
</script>

<table class="table_outline">
	<tr>
		<td>
		
<fieldset class="desc w_desc">
			<legend>거래처관리</legend>
			<div class="notice">[note]</div>
			<div class="comment">본쇼핑몰의 제품공급 거래처 리스트입니다. 제품공급 거래처를 등록하면 공급 거래처별로 매출통계기능이 지원됩니다.<br />
									[수정]을 클릭하시면 선택한 거래처에 대한 자세한 정보를 확인 및 수정을 하실 수 있습니다.<br />
									[삭제]는 거래처 삭제시 [등록]은 신규 거래처 등록시 사용하시면 됩니다.</div>
			</fieldset>
			<div class="space20"></div>		
		

				<form action="./main.asp" name='s_form' id="s_form">
					<input type=hidden name="theme" value='<%=theme%>'>
					<input type=hidden name="menushow" value='<%=menushow%>'>
					<input type=hidden name="page" value='<%=page%>'>
					<input type=hidden name="qry" id="qry" value=''>
					<input type=hidden name="uid" id="uid" value=''>
					
					</form>			
			<br />
			<div class="no_bound agn_r"><span class="btn_write button bull"><a>등록</a></span></div>
			<table class="table_main w_default">
				<col width="60px" />
				<col width="90px" />
				<col width="*" />
				<col width="90px" />
				<col width="90px" />
				<col width="70px" />
				<col width="90px" />
				<col width="60px" />
				<col width="60px" />
					<tr>
						<th>번호</th>
						<th>거래처<br />
							시스템 코드</th>
						<th>거래처명</th>
						<th>지역</th>
						<th>대표자</th>
						<th>담당자(휴대폰)</th>
						<th>전화</th>
						<th>팩스</th>
						<th>관리</th>
					</tr>
					<%

''총회원수 구하기
Set db		= new database
strSQL = "select count(uid) from wizcom"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
realtotal = objRs(0)
	
whereis = " where uid is not null "	

strSQL = "select count(uid) from wizcom " & whereis 
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
TotalCount = objRs(0)


ListNum = INT(TotalCount)-(INT(setPageSize)*(INT(page)-1))

strSQL = "select TOP " & setPageSize & " uid, compname, compaddress1, compprename, compchaname, compchatel, comptel,compfax from wizcom " & whereis & " and uid not in (SELECT TOP " & ((page - 1) * setPageSize) & " uid from wizcom" & whereis & " ORDER BY uid desc) ORDER BY uid desc " 

Set objRs = db.ExecSQLReturnRS(strSQL, params, DbConnect)
If objRs.BOF or objRs.EOF Then %>
					<tr align="center">
						<td colspan="9">가입된 기업회원이 없습니다.</td>
					</tr>
					<%
      Else
        Do Until objRs.EOF
uid				= objRs("uid")
compname		= objRs("compname")
compaddress1	= objRs("compaddress1")
compprename		= objRs("compprename")
compchaname		= objRs("compchaname")
compchatel		= objRs("compchatel")
comptel			= objRs("comptel")
compfax			= objRs("compfax")
%>
					<tr align="center">
						<td width="60"><%=ListNum%></td>
						<td width="90"><%=uid%></td>
						<td width="90"><%=compname%></td>
						<td width="90"><%=compaddress1%></td>
						<td width="90"><%=compprename%></td>
						<td width="70"><%=compchaname%><br />(<%=compchatel%>)</td>
						<td width="90"><%=comptel%></td>
						<td width="60"><%=compfax%></td>
						<td width="60"><span class="btn_write button bull" uid="<%=uid%>"><a>수정</a></span> <span class="btn_delete button bull" uid="<%=uid%>"><a>삭제</a></span></td>
					</tr>
					<%
		  	ListNum = ListNum - 1
            objRs.MoveNext
        Loop
    End If

    Set objRs = Nothing : db.Dispose : Set db = nothing
%>
			</table>
			<br />
			<div class="agn_c w_default"><%
Dim preimg : preimg = "img/pre.gif"
Dim nextimg : nextimg = "img/next.gif"	
Dim design
Dim linkurl : linkurl = "main.asp?menushow="&menushow&"&theme="&theme
Call util.paging (page,setPageSize,setPageLink,TotalCount,linkurl,design)
Set util = Nothing
%></div>
			<br />
			</b> </td>
	</tr>
</table>
