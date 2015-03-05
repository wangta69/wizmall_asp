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
menushow	= Request("menushow")
theme		= Request("theme")
%>

if(query == "delete"){
	sqlstr = "delete from wizusercoupon where uid='cuid'";
	dbcon->_query(sqlstr);
	echo "<script>location.href='php_self?menushow=menushow&theme=coupon/coupon_list'</script>";
}
%>
<script language=javascript>
<!--
function del_cp(uid){
	if(confirm('삭제된 데이타는 복구되지 않습니다.\n\n정말로 삭제하시겠습니까?')){
		location.href = "main.asp?menushow=<%=menushow%>&theme=<%=theme%>&query=delete&cuid="+uid;
	}else return;
}
//-->	
</script>
<table class="table_outline">
  <tr>
    <td valign="top"><fieldset class="desc">
						<legend>발급내용보기 </legend>
						<div class="notice">[note]</div>
						<div class="comment">삭제버튼을 클릭하면 해당 회원에게 발급된쿠폰이 취소됩니다.<br />
                  '쿠폰사용완료'란 해당 회원이 이미 쿠폰을 사용하여 완료됨을 의미합니다.</div>
						</fieldset>
						<p></p>	
      쿠폰발급/조회 쿠폰을 직접 발급하고 관리할 수 있습니다.<br />
      쿠폰발급내용
      <?      
whereis = "where uid = uid";
orderby = " order by uid desc";

sqlstr = "select * from wizcoupon whereis";
dbcon->_query(sqlstr);      

list = dbcon->_fetch_array( );
uid				= list["uid"];
cname				= list["cname"];
cpubtype			= list["cpubtype"];
ctype				= list["ctype"];
csaleprice			= list["csaleprice"];
csaletype			= list["csaletype"];
ctermtype			= list["ctermtype"];
cterm				= list["cterm"];
ctermf				= list["ctermf"];
cterme				= list["cterme"];
crestric			= list[""];
wdate				= list["wdate"];

switch(ctermtype){
	case "1"://시작일, 종료일
		ctermstr = date("y.m.d h:i", ctermf)."<br />~".date("y.m.d h:i", cterme);
	break;
	case "2"://기간설정
		ctermstr = "발급 후 ".cterm."일";
	break;
}
%>
      <table class="table_main w_default">
        <tr class=cellc align=center height=25>
          <td align=center bgcolor="#b9c2cc">쿠폰명</td>
          <td align=center bgcolor="#e0e4e8">쿠폰발급방식</td>
          <td width=120 align=center bgcolor="#b9c2cc">생성일</td>
          <td width=100 align=center bgcolor="#e0e4e8">할인금액(율)</td>
          <td width=150 align=center bgcolor="#b9c2cc">사용기간</td>
          <td width=70 align=center bgcolor="#e0e4e8">기능</td>
        </tr>
        <tr height=25>
          <td align=center bgcolor="#ffffff" class=celll><a href="main.asp?menushow=<%=menushow%>&theme=coupon/coupon_write&uid=<%=uid%>">
            <%=cname%>
            </a> </td>
          <td align=center bgcolor="#ffffff"><%=cpubtypearr[cpubtype]%></td>
          <td align=center bgcolor="#ffffff"><?=date("y.m.d h:i:s", wdate)%></td>
          <td align=center bgcolor="#ffffff"><%=csaleprice%>
            <%=csaletypearr[csaletype]%></td>
          <td align=center bgcolor="#ffffff"><%=ctermstr%></td>
          <td align=center bgcolor="#ffffff"><%=ctypearr[ctype]%></td>
        </tr>
      </table>
      <p> 이 쿠폰을 발급받은 회원리스트 (삭제버튼을 클릭하면 해당 회원에게 발급된 쿠폰이 취소됩니다)<br /><table class="table_main w_default">
        <tr class=cellc align=center height=25>
          <td width=50 align=center bgcolor="#e0e4e8">순번</td>
          <td align=center bgcolor="#b9c2cc">발급 상품</td>
          <td align=center bgcolor="#e0e4e8">발급받은 회원</td>
          <td align=center bgcolor="#b9c2cc">발급일/사용일</td>
          <td align=center bgcolor="#e0e4e8">삭제</td>
        </tr>
        <?
sqlstr = "select * from wizusercoupon where couponid = 'uid'";
dbcon->_query(sqlstr);
cnt = 1;
while(list = dbcon->_fetch_array()):		
		%>
        <tr class=cellc align=center height=25>
          <td align=center bgcolor="#ffffff"><%=cnt%></td>
          <td align=center bgcolor="#ffffff"><%=cname%></td>
          <td align=center bgcolor="#ffffff"><%=list["userid"]%></td>
          <td align=center bgcolor="#ffffff"><? if(list["gdate"]) echo date("y.m.d h:i", list["gdate"])%>
            /
            <? if(list["udate"]) echo date("y.m.d h:i", list["udate"])%></td>
          <td align=center bgcolor="#ffffff"><input type="button" name="button" id="button" value="삭제" onclick="del_cp(<%=list["uid"]%>)"></td>
        </tr>
        <?
cnt++;		
endwhile;		
		%>
      </table></td>
  </tr>
</table>
