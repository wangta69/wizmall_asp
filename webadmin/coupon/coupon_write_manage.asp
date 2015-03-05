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
Dim uid, qry
menushow	= Request("menushow")
theme		= Request("theme")

uid		= Request("uid")
qry		= Request("qry")

if qry = "qin" then
	''기존 모든 정보 삭제
	sqlStr = "delete from wizusercoupon where couponid=" & uid &" and useflag=0"
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	
	''현재 정보를 입력한다.
	''if(is_array(m_ids)){
	''	foreach(m_ids as key => value){
	''		sqlstr = "insert into wizusercoupon (userid,couponid,gdate) values ('value','uid',".time().")";
	''		dbcon->_query(sqlstr);
	''	}
	''}
ElseIf qry = "qde" then
	sqlStr = "delete from wizusercoupon where uid='cuid'";
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	Response.Write( "<script>location.href='main.asp?menushow=" & menushow & "&theme=coupon/coupon_list'</script>")
End If
%>
<script language="javascript">
<!--
function del_cp(uid){
	if(confirm('삭제된 데이타는 복구되지 않습니다.\n\n정말로 삭제하시겠습니까?')){
		location.href = "main.asp?menushow=<%=menushow%>&theme=<%=theme%>&query=delete&cuid="+uid;
	}else return;
}

function gotolist(){
	location.href = "main.asp?menushow=<%=menushow%>&theme=coupon/coupon_list";
}

function del_options(el)
{
	idx = el.rowindex;
	var obj = document.getelementbyid('m_ids');
	obj.deleterow(idx);
}

function checkform1(f){

	calsmscnt();

	if(f.membertype[1].checked == true){
		if(!document.getelementsbyname('m_ids[]').length){
			alert('회원을 선택해주세요!!');
			return false;
		}
	}
	return true;
}


var sgrp = new array();
sgrp[1] = 0;
sgrp[2] = 1;
var tot_mem = 1;
function calsmscnt(){
	var f = document.memberselectform;
	if(f.membertype[0].checked)	var tt = tot_mem;

	if(f.membertype[1].checked) var tt = document.getelementsbyname('m_ids[]').length;
}

function delapply(sno){
	var f = document.hiddenform;
	f.mode.value = "delapply";
	f.action = "indb.coupon.php?couponcd=3&sno="+sno;
	f.submit();
}
//-->
</script>

<table class="table_outline">
  <tr>
    <td valign="top"><fieldset class="desc">
						<legend>회원발급하기</legend>
						<div class="notice">[note]</div>
						<div class="comment">삭제버튼을 클릭하면 해당 회원에게 발급된쿠폰이 취소됩니다.<br />
                  '쿠폰사용완료'란 해당 회원이 이미 쿠폰을 사용하여 완료됨을 의미합니다. </div>
						</fieldset>
						<p></p>	
      쿠폰발급/조회<span>쿠폰을 직접 발급하고 관리할 수 있습니다.<br />
      <div style="padding:3 0 5 8"><font color=0074ba>쿠폰발급내용</b></div>
<%
Dim whereis, orderby
Dim cname,cpubtype,ctype,csaleprice,csaletype,ctermtype,cterm,ctermf,cterme,wdate
whereis = "where uid = " & uid
orderby = " order by uid desc"

sqlStr = "select uid,cname,cpubtype,ctype,csaleprice,csaletype,ctermtype,cterm,ctermf,cterme,wdate from wizcoupon " & whereis
Set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)  

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

Select Case ctermtype
    Case "1"''시작일, 종료일
		''ctermstr = date("y.m.d h:i", ctermf)."<br />~".date("y.m.d h:i", cterme);
	Case "2"''기간설정
		''ctermstr = "발급 후 ".cterm."일";
End Select
%>
      <table class="table_main w_default">
        <tr class=cellc align="center" height=25>
          <td align="center" bgcolor="#b9c2cc">쿠폰명</td>
          <td align="center" bgcolor="#e0e4e8">쿠폰발급방식</td>
          <td width=120 align="center" bgcolor="#b9c2cc">생성일</td>
          <td width=100 align="center" bgcolor="#e0e4e8">할인금액(율)</td>
          <td width=150 align="center" bgcolor="#b9c2cc">사용기간</td>
          <td width=70 align="center" bgcolor="#e0e4e8">기능</td>
        </tr>
        <tr height=25>
          <td align="center" class=celll><a href="main.asp?menushow=<%=menushow%>&theme=coupon/coupon_write&uid=<%=uid%>">
            <%=cname%>
            </a> </td>
          <td align="center"><%=cpubtypearr[cpubtype]%></td>
          <td align="center"><%''=date("y.m.d h:i:s", wdate)%></td>
          <td align="center"><%=csaleprice%>
            <%''=csaletypearr[csaletype]%></td>
          <td align="center"><%''=ctermstr%></td>
          <td align="center"><%''=ctypearr[ctype]%></td>
        </tr>
      </table>
      <p> <font color=0074ba>이 쿠폰을 발급받은 회원리스트</b> <font class=extext>(삭제버튼을 클릭하면 해당 회원에게 발급된 쿠폰이 취소됩니다)<br />
      <table cellspacing=0 bordercolordark=white width="760" bgcolor=#c0c0c0 bordercolorlight=#dddddd border=1>
        <tr class=cellc align="center" height=25>
          <td width=50 align="center" bgcolor="#e0e4e8">순번</td>
          <td align="center" bgcolor="#b9c2cc">발급 상품</td>
          <td align="center" bgcolor="#e0e4e8">발급받은 회원</td>
          <td align="center" bgcolor="#b9c2cc">발급일/사용일</td>
          <td align="center" bgcolor="#e0e4e8">삭제</td>
        </tr>
<%
sqlStr = "select uid as cuid, user_id, gdate,  from wizusercoupon where couponid = " & uid
Set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)  
LoopCnt = 1
If objRs.BOF or objRs.EOF Then		
%>
        <tr class=cellc align="center" height=25>
          <td align="center"><%=cnt%></td>
          <td align="center"><%=cname%></td>
          <td align="center"><%=list["userid"]%></td>
          <td align="center"><? if(list["gdate"]) echo date("y.m.d h:i", list["gdate"])%>
            /
            <? if(list["udate"]) echo date("y.m.d h:i", list["udate"])%></td>
          <td align="center"><input type="button" name="button" id="button" value="삭제" onclick="del_cp(<%=list["uid"]%>)"></td>
        </tr>
<%
      Else
        Do Until objRs.EOF
cuid				= objRs("cuid")
userid			= objRs("userid")
gdate			= objRs("gdate")
udate			= objRs("udate")


%>		
        <tr class=cellc align="center" height=25>
          <td align="center"><%=LoopCnt%></td>
          <td align="center"><%=cname%></td>
          <td align="center"><%=user_id%></td>
          <td align="center"><%=gdate%>
            /
            <%=udate%></td>
          <td align="center"><input type="button" name="button" id="button" value="삭제" onclick="del_cp(<%=cuid%>)"></td>
        </tr>		
<%
		  	LoopCnt = LoopCnt + 1
            objRs.MoveNext
        Loop
    End If

    Set objRs = Nothing : db.Dispose : Set db = nothing
%>
      </table>
      <p> <font color=0074ba>이 쿠폰을 제공할 회원선택</b> <font class=extext>(쿠폰을 지급할 회원을 추가하려면 아래에서 회원을 선택하세요)<br />
      <table class="table_main w_default">
        <form name="memberselectform">
          <input type="hidden" name="uid" value="<%=uid%>" />
          <input type="hidden" name="menushow" value="<%=menushow%>" />
          <input type="hidden" name="theme" value="<%=theme%>" />
          <input type="hidden" name="qry" value="qin" />
          <tr>
            <td align=left bgcolor="#e0e4e8"><input type=radio name=membertype value=0 checked onclick='calsmscnt();' class=null>
              전체회원발급</td>
            <td>전체회원에게 쿠폰을 발급합니다.</td>
          </tr>
          <tr>
            <td height=170  align=left valign=top bgcolor="#e0e4e8"><input type=radio name=membertype value=2 onclick='calsmscnt();'  class=null>
              회원개별발급</td>
            <td valign=top><div style="padding-top:4"><a href="javascript:membersearch()">[회원검색]</b></a></div>
              <div class="box" style="padding:10 0 0 10">
                <table  cellpadding=8 cellspacing=0 id=m_ids bgcolor=f3f3f3 border=0 bordercolor=#cccccc style="border-collapse:collapse">
                </table>
              </div></td>
          </tr>
          <tr>
            <td height=25 colspan="2"  align="center" valign=top><input type="submit" name="button2" id="button2" value="등록" />
              <input type="button" name="button" id="button3" value="이전" onclick="gotolist()" /></td>
          </tr>
        </form>
      </table></td>
  </tr>
</table>
