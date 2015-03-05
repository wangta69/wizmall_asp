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
Dim qry, uid
Dim whereis, orderby, searchenable, sword, s_ctype, skey
Dim setPageSize, setPageLink, page, realtotal, TotalCount, TotalPage, LoopNum, ListNum''페이징관련 변수정의

menushow	= Request("menushow")
theme		= Request("theme")
qry			= Request("qry")
uid			= Request("uid")

searchenable	= Request("searchenable")
sword			= Request("sword")
s_ctype			= Request("s_ctype")
skey			= Request("skey")
page			= Request("page") : if page = "" then page = 1
setPageSize		= 20
setPageLink		= 10

If qry = "qde" then
	''이미 발급된 쿠폰에 대해 삭제하기를 할 경우 문제가 발생 
	'' 발급수 조회후 절차에 따라서 해야 한다.
	''따라서 이후는 업데이트 형식으로 해야 한다.
	'' 현재는 걍 ...
	strSQL = "delete from wizcoupon where uid = " & uid
    Call db.ExecSQL(strSQL, Nothing, DbConnect)
	
	strSQL = "delete from wizcouponapply where couponid = " & uid 
    Call db.ExecSQL(strSQL, Nothing, DbConnect)
	''db.Dispose : Set db = Nothing
End If


whereis = " where uid is not null"
orderby = " order by uid desc"


If searchenable <> "" then ''검색절 시작
	if sword <> "" Then
		if skey <> "" then
			whereis = whereis  & " and skey like '%sword%'"
		Else
			whereis = whereis  &  " and cname like '%sword%' or cdesc like '%sword%' "
		End If
	End If
	
	''if (is_array(s_ctype)){
	''	whereis .= " and (";
	''	cnt=0;
	''	foreach(s_ctype as key => value){
	''		if(cnt) whereis.= " or ";
	''		whereis .= " ctype = 'value'";
	''		cnt++;
	''	}
	''	whereis .= ")";
	''End If
	
	''if(is_array(s_cpubtype)){
	''	whereis .= " and (";
	''	cnt=0;	
	''	foreach(s_cpubtype as key => value){
	''		if(cnt) whereis.= " or ";
	''		whereis .= " cpubtype = 'value'";
	''		cnt++;
	''	}
	''	whereis .= ")";
	''End If	
End If
%>
<script language=javascript>
<!--
$(function(){
	$(".btn_write").click(function(){
		var uid = $(this).attr("uid");
		if(uid == undefined) uid = "";
		location.href = "main.asp?menushow=<%=menushow%>&theme=coupon/coupon_write&uid="+uid;
	});
	
	$(".btn_delete").click(function(){
		var uid = $(this).attr("uid");
		if(confirm('삭제된 데이타타는 복구되지 않습니다.\n정말로 삭제하시겠습니까?')){
			location.href = "main.asp?query=delete&menushow=<%=menushow%>&theme=<%=theme%>&uid="+uid;
		}
	});
	

});


function gotocoponmanage(uid){
	if(uid == undefined){
		var uid = "";
	}
	location.href = "main.asp?menushow=<%=menushow%>&theme=coupon/coupon_write_manage&uid="+uid;
}

function gotocoponview(uid){
	if(uid == undefined){
		var uid = "";
	}
	location.href = "main.asp?menushow=<%=menushow%>&theme=coupon/coupon_view&uid="+uid;
}



function searchthis(f){
	f.searchenable.value = "1";
	f.submit();
}

function gotolist(){
	location.href = "main.asp?menushow=<%=menushow%>&theme=<%=theme%>";
}

//-->	
</script>

<table class="table_outline">
  <tr>
    <td valign="top"><fieldset class="desc">
						<legend>쿠폰리스트</legend>
						<div class="notice">[note]</div>
						<div class="comment">즉시발급쿠폰의 경우는 '발급하기'를 클릭하여 직접 회원에게 발급해야 합니다.<br />
                  자동으로 발급되는 쿠폰들은 '조회하기'를 누르면 쿠폰발급내용과 발급받은 회원을 조회할 수 있습니다.</div>
						</fieldset>
						<p></p>	
      <table width="100%" cellpadding="0" cellspacing="0" bgcolor="white" border="0">
        <tr>
          <td valign="top" style="padding-left:12px"> 쿠폰리스트<span>고객에게 발급된 쿠폰을 관리하거나 쿠폰을 발급합니다.  
		        <form method="post" action="main.asp" name="searchform">
                <input type="hidden" name="menushow" value="<%=menushow%>" />
                <input type="hidden" name="theme" value="<%=theme%>" />
                <input type="hidden" name="page" value="<%=page%>" />
                <input type="hidden" name="searchenable" value="" />
            <table class="table_main w_default">

                <tr>
                  <td bgcolor="e0e4e8">쿠폰검색</td>
                  <td><select name=skey>
                      <option value="">전체검색</option>
                      > 쿠폰명<option value="cname"<? if(skey == "cname") echo " selected"%>> 쿠폰명</option>
                      > 쿠폰설명<option value="cdesc"<? if(cdesc == "cname") echo " selected"%>> 쿠폰설명</option>
                    </select>
                    <input type=text name=sword value="<%=sword%>">
                  </td>
                  <td bgcolor="e0e4e8">쿠폰기능</td>
                  <td><input type="checkbox" name='s_ctype[]' value='1'>
                    할인
                    <input type="checkbox" name='s_ctype[]' value='2'>
                    적립 </td>
                </tr>
                <tr>
                  <td bgcolor="e0e4e8">쿠폰발급방식</td>
                  <td colspan=3><input type="checkbox" name='s_cpubtype[]' value='1'>
                    운영자발급
                    <input type="checkbox" name='s_cpubtype[]' value='2'>
                    회원직접다운로드
                    <input type="checkbox" name='s_cpubtype[]' value='3'>
                    회원가입자동발급
                    <input type="checkbox" name='s_cpubtype[]' value='4'>
                    구매후 자동발급 </td>
                </tr>
                <tr>
                  <td colspan="4" align="center"><input type="button" name="button2" id="button2" value="검색" onclick="searchthis(document.searchform)">
                   &nbsp; 
                  <input type="button" name="button4" id="button4" value="리스트" onclick="gotolist()" /></td>
                </tr>
              
            </table></form>
            <br />
            <table width="760" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td align="right"><span class="btn_write button bull"><a>쿠폰생성</a></span></td>
              </tr>
            </table>
            <table class="table_main w_default">
              <tr>
                <td align="center" bgcolor="e0e4e8">번호</td>
                <td align="center" bgcolor="#b9c2cc">쿠폰명</td>
                <td align="center" bgcolor="e0e4e8">쿠폰종류</td>
                <td align="center" bgcolor="#b9c2cc">쿠폰생성일</td>
                <td align="center" bgcolor="e0e4e8">기능</td>
                <td align="center" bgcolor="#b9c2cc">할인금액(율)</td>
                <td align="center" bgcolor="e0e4e8">적용기간</td>
                <td align="center" bgcolor="#b9c2cc" style="padding-left:3">발급/조회(발급수)</td>
                <td align="center" bgcolor="e0e4e8">수정/삭제</td>
              </tr>
<%
Dim  cname,cpubtype,ctype,csaleprice,csaletype,ctermtype,cterm,ctermf,cterme,wdate,ctermstr

Set db		= new database
''strSQL = "select count(uid) from wizcoupon"
''Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
''realtotal = objRs(0)



strSQL = "select count(uid) from wizcoupon" & whereis 
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
TotalCount = objRs(0)


ListNum = INT(TotalCount)-(INT(setPageSize)*(INT(page)-1))

strSQL = "select TOP " & setPageSize & " uid,cname,cpubtype,ctype,csaleprice,csaletype,ctermtype,cterm,ctermf,cterme,wdate	 from wizcoupon " & whereis & " ORDER BY uid desc " 


Set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
If objRs.BOF or objRs.EOF Then
%>
              <tr>
                <td colspan="9" align="center">등록된 쿠폰이 없습니다.</td>
                </tr>
<%
      Else
        Do Until objRs.EOF

uid					= objRs("uid")
cname				= objRs("cname")
cpubtype			= objRs("cpubtype")
ctype				= objRs("ctype")
csaleprice			= objRs("csaleprice")
csaletype			= objRs("csaletype")
ctermtype			= objRs("ctermtype")
cterm				= objRs("cterm")
ctermf				= objRs("ctermf")
cterme				= objRs("cterme")
wdate				= objRs("wdate")

Select Case cpubtype
    Case "1"''운영자발급
		''btn_str = "<input type='button' name='button' id='button' value='회원발급하기' onclick='gotocoponmanage(".uid.")'>"
	Case Else
		''btn_str = "<input type='button' name='button' id='button' value='발급내용보기' onclick='gotocoponview(".uid.")'>"
End Select 


Select Case ctermtype
    Case "1"''시작일, 종료일
		''ctermstr = date("y.m.d h:i", ctermf)."<br />~".date("y.m.d h:i", cterme);
	Case "2"''기간설정
		''ctermstr = "발급 후 ".cterm."일";
End Select 
%>
              <tr>
                <td align="center"><%=ListNum%></td>
                <td align="center"><%=cname%></td>
                <td align="center"><%''=cpubtypearr[cpubtype]%></td>
                <td align="center"></td>
                <td align="center"><%''=ctypearr[ctype]%></td>
                <td align="center"><%=csaleprice%>
                <%''=csaletypearr[csaletype]%></td>
                <td align="center" style="word-break:break-all;"><%=ctermstr%></td>
                <td align=left><%''=btn_str%>
                  <font color=ea0095>(
                  <%''=mall->getcouponcnt(uid)%>
                  )</b></td>
                <td align="center">
				<span class="btn_write button bull" uid="<%=uid%>"><a>수정</a></span>
				<span class="btn_delete button bull" uid="<%=uid%>"><a>삭제</a></span>  </td>
              </tr>
<%
		  	ListNum = ListNum - 1
            objRs.MoveNext
        Loop
    End If

    Set objRs = Nothing : db.Dispose : Set db = nothing
%>
            </table>
            <table cellspacing=0 cellpadding=0 width="760" 
border=0>
              <tr>
                <td align="center"><%
Dim preimg : preimg = "img/pre.gif"
Dim nextimg : nextimg = "img/next.gif"	
Dim design
Dim linkurl : linkurl = "main.asp?menushow="&menushow&"&theme="&theme
Call util.paging (page,setPageSize,setPageLink,TotalCount,linkurl,design)
Set util = Nothing : Set db = Nothing 
%></td>
              </tr>
            </table>
            </form></td>
        </tr>
      </table>
      <br />
      </b> </td>
  </tr>
</table>
