<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/admin_info.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/cfg.array.asp" -->
<%
Dim uid,flag1,ordernum,subject,url,target,attached,showflag,wdate
Dim strSQL,objRs
Dim db,util

Set util = new utility	
Set db = new database

Dim menushow, theme, smode
Dim LoopCount
menushow	= Request("menushow")
theme		= Request("theme")
smode		= Request("smode")

if smode = "qde" Then
	uid		= Request("uid")
	strSQL	= "delete from wizbanner where uid = " & uid
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	

End If

%>
<script language="javascript">
<!--
$(function(){
	$(".btn_write").click(function(){
		var flag1	= $(this).attr("flag1");
		var uid		= $(this).attr("uid");
		if(uid == undefined) uid = "";
		location.href="./main.asp?menushow=menu1&theme=basicinfo/basic_banner_w&flag1="+flag1+"&uid="+uid;
	});
	
	$(".btn_click").click(function(i){
		$(".submenu").hide();
		$(".submenu").eq($(".btn_click").index(this)).show(); //메서드
	});
	
	$(".btn_delete").click(function(){
		var uid		= $(this).attr("uid");
		location.href="./main.asp?menushow=<%=menushow%>&theme=<%=theme%>&smode=qde&uid="+uid;
	});
});

function deletefnc(){
        var f = document.forms.BrdList;
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
                alert('삭제하고자 하는 게시물을 하나 이상 선택해 주세요.');
                return false;
        }
        if (confirm('\n\n삭제하는 게시물은 복구가 불가능합니다!!! \n\n정말로 삭제하시겠습니까?\n\n')) return true;
        return false;
}
-->
</script>
<table class="table_outline">
  <tr>
    <td valign="top"><fieldset class="desc">
						<legend>메인베너관리</legend>
						<div class="notice">[note]</div>
						<div class="comment"> order가 작은 순서가 상위에 위치합니다.</div>
						</fieldset>
						<p></p>
      <table class="table_main w_default">
        <tr align="center">
          <td>베너위치</td>
        </tr>
<% 
For LoopCount = 1 to Ubound(bannerCat) 

''$whereis = " where flag1 = $key";
%>
        <tr>
          <td class="btn_click" flag="<%=LoopCount%>"><strong><font color="#FF9900">
            <%=bannerCat(LoopCount)%> (그룹코드 : <%=LoopCount%>)
          </strong></td>
        </tr>
        <tr align="center" class="submenu" flag="<%=LoopCount%>" style="display:none">
          <td><table class="table_main w_default">
				<col width="50px" />
				<col width="*" />
				<col width="150px" />
				<col width="150px" />
				<tr align="center">
				<th>순서</th>
				<th>이동경로</th>
				<th>이미지</th>
				<th>관리</th>
				</tr>
<%

strSQL = "select * from wizbanner where flag1 = " & LoopCount & " ORDER by ordernum asc " 
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
while not objRs.eof
	uid			= objRs("uid")
	flag1		= objRs("flag1")
	ordernum	= objRs("ordernum")
	subject		= objRs("subject")
	url			= objRs("url")
	target		= objRs("target")
	attached	= objRs("attached")
	showflag	= objRs("showflag")
	wdate		= objRs("wdate")
	
%>
                <tr>
                  <td align="center"><%=ordernum%></td>
                  <td><%=url%></td>
                  <td align="center"><img src="../config/banner/<%=attached%>" width=100> </td>
                  <td align="center"><span class="btn_write button bull" flag1="<%=LoopCount%>" uid="<%=uid%>"><a>수정</a></span> 
				  <span class="btn_delete button bull" uid="<%=uid%>"><a>삭제</a></span></td>
                </tr>
<%
objRs.movenext
wend
%>
                <tr class="agn_l">
                  <td colspan="4">
				  <span class="btn_write button bull" flag1="<%=LoopCount%>"><a>등록</a></span>
</td>
                </tr>
            </table>            </td>
        </tr>
<%
Next
%>
      </table>
</td>
  </tr>
</table>
