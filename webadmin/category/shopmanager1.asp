<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%

Dim cat_flag,qry,ccode,tccode,cat_no,theme,menushow,new_category_name,cat_depth
Dim lv,cat_order,width,loopcnt, loopcnt1,bgcolor,c_len,p_len,ccode_len
Dim orderby, whereis,strlen, comlen, max_no, tmpcode
Dim strSQL,objRs,strSQL1,objRs1
Dim db,util
Set util = new utility	
Set db = new database

cat_flag	= "wizmall"
qry			= Request("qry")
ccode 		= Request("ccode")
tccode 		= Request("tccode")
cat_no		= Request("cat_no")
theme		= Request("theme")
menushow	= Request("menushow")
new_category_name = Request("new_category_name")
cat_depth	= 3


''관련 Function 정의

Function getcatorder(lv, ccode) '' ##레벨에 따른 카테고리 순서 뽑아오기
	strlen = lv * 3''카테고리당 3자리씩 자른다.(뒤부터 1차, 2차...  카테고리
	comlen = strlen - 3

	strSQL = "select max(cat_order) from wizCategory where LEN(cat_no) = "&strlen&" and RIGHT(cat_no, "&comlen&") = '"&ccode&"'"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	getcatorder =objRs(0)+1
End Function

Function getcatno(lv, ccode) '' ##레벨에 따른 카테고리 순서 뽑아오기
	strlen = lv * 3''카테고리당 3자리씩 자른다.(뒤부터 1차, 2차...  카테고리
	comlen = strlen - 3

	strSQL = "select max(cat_no)  from wizCategory where LEN(cat_no) = "&strlen&" and RIGHT(cat_no, "&comlen&") = '"&ccode&"'"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	max_no	= objRs(0)
	if IsNull(max_no) then max_no = "000"
	tmpcode = "000" & Cstr(Cint(Left(max_no, 3))+1)
	getcatno = Right(tmpcode, 3)&ccode
End Function

''attached_dir = PATH_SYSTEM & "config\wizstock\"

If qry = "in" and new_category_name <> "" then

	lv			= Len(ccode)/3 + 1''//현재 카테고리의 레벨을 구한다.
	cat_no		= getcatno(lv, ccode)
	cat_order	= getcatorder(lv, ccode)
	
	strSQL = "INSERT INTO wizCategory (cat_order,cat_no,cat_name,cat_flag) "
	strSQL = strSQL & "VALUES "
	strSQL = strSQL & "('" & cat_order & "','" & cat_no & "','" & new_category_name & "','" & cat_flag & "')"
    Call db.ExecSQL(strSQL, Nothing, DbConnect)

ElseIf qry = "up" then 
	''## 현재 카테고리 정보를 변경한다.
	strSQL = "update wizCategory set cat_name = '"&new_category_name&"' WHERE cat_no = '"&ccode&"' and cat_flag='"&cat_flag&"'"
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	
       Response.Write "<HTML><META http-equiv='refresh' content ='0;url=main.asp?menushow="&menushow&"&theme="&theme&"&ccode="&ccode&"'></HTML>"
       Response.End()		
ElseIf qry = "de" then 

	''## 하위 카테고리 존재시 삭제를 cancel
	strSQL = "select count(1) from wizCategory where cat_no like '%"&ccode&"' and cat_flag='"&cat_flag&"'"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	If objRs(0) > 1 then ''## 자신을 폼함하여 1개 이상 존재시
		Response.Write "<script>alert('하위 카테고리가 존재 합니다.\n\n먼저 하위 카테고리를 삭제해 주시기 바랍니다.');history.go(-1);</script>"
		Response.End()
	End If
	
	''## 현카테고리에 상품이 존재하면 삭제를 cancel
	strSQL = "select count(1) from wizMall where Category = '"&ccode&"'"
	Response.Write(strSQL)
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	If objRs(0) > 0 then ''## 제품이 한개 이상 존재시
		Response.Write "<script>alert('현재 카테고리에 제품(다중혹은 단일)이 등록되어있습니다..\n\n먼저 해당카테고리의 상품을 삭제하거나 변경해 주시기 바랍니다.');history.go(-1);</script>"
		Response.End()
	End If	
	
'' 카테고리 DB에서 지우기 START
	strSQL = "DELETE FROM wizCategory WHERE cat_no LIKE '" & ccode & "' and cat_flag='" & cat_flag & "'"
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
						
	
        Response.Write "<HTML><META http-equiv='refresh' content ='0;url=main.asp?menushow="&menushow&"&theme="&theme&"&ccode="&ccode&"'></HTML>"
        Response.End()
elseif qry = "in_desc" then
	Dim cat_top : cat_top = Request("cat_top")
	Dim cat_bottom : cat_bottom = Request("cat_bottom")
	Dim cat_disable : cat_disable = Request("cat_disable")
	if cat_disable = "" then cat_disable = "0"
	Dim where : where = Request("where")
	''Response.Write(cat_top)
	
	strSQL = "update wizCategory set cat_top = '" & cat_top & "', cat_bottom = '" & cat_bottom & "', cat_disable = '" & cat_disable & "' where cat_no = '" & cat_no & "' and cat_flag='" & cat_flag & "'"
	''Response.Write(strSQL)
	''Response.End()
	Set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
    Response.Write "<HTML><META http-equiv='refresh' content ='0;url=main.asp?menushow="&menushow&"&theme="&theme&"&qry=" & where & "&ccode="&ccode&"'></HTML>"
    Response.End()

end if
%>
<script language="javascript">
<!--
function actionqry(f,val){
	f.qry.value = val;
	f.submit();
}

function cat_manage(code,flag){
	switch(flag){
		case "de":
			location.href = "main.asp?menushow=<%=menushow%>&theme=<%=theme%>&cat_flag=<%=cat_flag%>&ccode="+code+"&qry="+flag;
		break;
		case "coding":
			location.href = "main.asp?menushow=<%=menushow%>&theme=<%=theme%>&cat_flag=<%=cat_flag%>&ccode="+code+"&qry="+flag;
			location.href = "main.asp?menushow=<%=menushow%>&theme=<%=theme%>&cat_flag=<%=cat_flag%>&ccode="+code+"&qry="+flag;
		break;		
		default:
			location.href = "main.asp?menushow=<%=menushow%>&theme=<%=theme%>&cat_flag=<%=cat_flag%>&ccode="+code;
		break;
	}
	
}
//-->
</script>
<link href="../js/Smart/css/default.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/Smart/js/HuskyEZCreator.js" charset="utf-8"></script>
<!-- body start -->
<table class="table_outline">
	<tr>
		<td>
		
<fieldset class="desc">
        <legend>카테고리 메니저</legend>
        <div class="notice">[note]</div>
        <div class="comment">상품카테고리를 등록, 수정, 변경 삭제 하는 곳입니다. 또한 카테고리별로 별도의 코딩을 하실 수 도 있습니다. <br />
									( <img src="img/cat_view.gif" width="16" height="16"> 매장보기 <img src="img/cat_modify.gif" width="16" height="16"> 카테고리등록 및 수정 <img src="img/cat_text.gif" width="16" height="16"> 카테고리별 상,하단 코딩 <img src="img/cat_delete.gif" width="14" height="16"> 카테고리 삭제 )</div>
      </fieldset>
      <p></p>

			<table class="table_main w_default">
				<tr>
					<td> 
						<table width="100%" border="0">
							<form action='./main.asp' method=post>
								<input type="hidden" name=menushow value='<%=menushow%>'>
								<input type="hidden" name="theme" value='<%=theme%>'>
								<input type="hidden" name=qry value='in'>
								<input type="hidden" name="cat_flag" value='<%=cat_flag%>'>
								<tr>
									<td width="170">
										<input size=26 name="new_category_name">
										</td>
									<td width="236"><input type="image" src="img/da.gif" width="84" height="20">
									</td>
									<td align="right"><!--//<button name="" onClick="location.href('./category/shopmanager1_1.asp?DownForExel=yes')" title="전체리스트출력">전체리스트출력</button>//--></td>
								</tr>
							</form>
						</table></td>
				</tr>
			</table>
			<br />
			<table class="table_main w_default">
				<tr>
					<td width="253"  colspan="3"><!-- 대분류 리스트 표시 시작 -->
						<table>
							<tr>
								<%
width = 100/cat_depth
For loopcnt=0 to cat_depth-1	
	loopcnt1 = loopcnt+1
	
    if loopcnt Mod 2 = 0 then
    	bgcolor = "bgcolor='#E0E4E8'"
    Else
   		bgcolor = "bgcolor='#B9C2CC'"
    End If

	c_len = loopcnt1*3
	p_len = c_len-3
	ccode_len = Len(ccode)
%>
								<td valign="top" width="<%=width%>%"><!-- 분류 테이블 시작 -->
									<table width=100% cellspacing=0 cellpadding=0 border=0>
										<tr>
											<th> <%=loopcnt1%> 차카테고리</th>
										</tr>
										<%
if ccode_len >= loopcnt*3 then
	orderby = " order by cat_order asc "
	If loopcnt > 0 then
		whereis = " WHERE LEN(cat_no) = "&c_len&" and RIGHT(cat_no, "&p_len&") = '"&Right(ccode, p_len)&"' and cat_flag='"&cat_flag&"'"
	Else
		whereis = " WHERE LEN(cat_no) = "&c_len&" and cat_flag='"&cat_flag&"'"
	End If
	strSQL1 = "SELECT * FROM wizCategory "&whereis & orderby
	set objRs1 = db.ExecSQLReturnRS(strSQL1, Nothing, DbConnect)
	WHILE NOT objRs1.EOF
		tccode = objRs1("cat_no")
%>
										<tr>
											<td><table width=100% cellspacing=0 cellpadding=0 border=0>
													<tr>
														<td align="left" onClick="cat_manage('<%=tccode%>');"><%
							
		if Right(ccode, c_len) = tccode then
			Response.Write ""&objRs1("cat_name")&""
		else 
			Response.Write objRs1("cat_name")
		end if
%>
														</td>
														<td align=RIGHT><a HREF='../wizmart.asp?code=<%=tccode%>' TARGET='_blank'><IMG SRC='./img/cat_view.gif' border='0' alt='보기'></A> <a HREF="javascript:cat_manage('<%=tccode%>');"><IMG SRC='./img/cat_modify.gif' border='0' alt='등록/수정'></A> <a HREF="javascript:cat_manage('<%=tccode%>', 'coding');"><IMG SRC='./img/cat_text.gif' border='0' alt='코딩'></A> <a HREF="javascript:cat_manage('<%=tccode%>', 'de');"><IMG SRC='./img/cat_delete.gif' border='0' alt='삭제'></A></td>
													</tr>
												</table></td>
										</tr>

										<%
	objRs1.MOVENEXT
	WEND
End If ''if ccode_len >= i*3 then
%>
									</table>
									<!-- 분류 테이블 끝 -->
								</td>
								<%
Next 
%>
							</tr>
						</table></td>
				</tr>
				<tr>
					<td height="50" colspan="3" ><% 

	if ccode <> "" then
%>
						<form action='./main.asp' method=post name="catfrm">
							<input type="hidden" name="menushow" value="<%=menushow%>">
							<input type="hidden" name="theme" value="<%=theme%>">
							<input type="hidden" name="qry" value="">
							<input type="hidden" name="ccode" value="<%=ccode%>">
							<input type="hidden" name="cat_flag" value="<%=cat_flag%>">
							<input type=TEXT name="new_category_name" size=13 >
							<img src="img/dung.gif" width="55" height="20" onclick=actionqry(document.catfrm,'in');> <img src="img/byun.gif" width="55" height="20" onclick=actionqry(document.catfrm,'up');>
						</form>
						<% 
	end if'if where = "sub_regis1" or where = "sub_regis2" or where = "sub_regis3" then
%></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td width="253">&nbsp;</td>
					<td width="253"></td>
				</tr>
				<%
if qry = "coding" and  ccode <> "" then
	strSQL = "SELECT cat_top,cat_bottom, cat_disable FROM wizCategory WHERE  cat_no = '"&ccode&"' and cat_flag='"&cat_flag&"'"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
%>
				<form name = "SaveCatCoding" action="./main.asp" method="post">
					<input type="hidden" name="cat_no" value = "<%=ccode%>">
					<input type="hidden" name="theme" value = "<%=theme%>">
					<input type="hidden" name="menushow" value = "<%=menushow%>">
					<input type="hidden" name="qry" value = "in_desc">
					<input type="hidden" name="where" value = "<%=qry%>">
					<input type="hidden" name="ccode" value="<%=ccode%>">
					<tr>
						<td colspan="3"><table cellspacing=0 cellpadding=0 width="100%" border=0>
								<tr>
									<td bgcolor="#E0E4E8">카테고리숨김
									<input name="cat_disable" type="checkbox" id="cat_disable" value="1"<% If objRs("cat_disable") = "1" Then Response.Write(" checked='checked'")%> /></td>
								</tr>
								<!--매장카테고리 코딩 시작 -->
								<tr>
									<td bgcolor="#E0E4E8" class="s1 agn_l">몰 페이지 
										html 삽입</td>
								</tr>
							</table>
							<br />
							<span class="agn_l s1">상단코딩</b></span><br />

							<textarea name="cat_top" id="ir1" style="width:650px; height:100px; display:none;"><%=objRs("cat_top")%></textarea>
														<span><br />
							하단코딩</b></span><br />
							<textarea name="cat_bottom" style="width:650px; height:100px; display:none;" id="ir2"><%=objRs("cat_bottom")%></textarea>



						</td>
					</tr>
					<!--매장 카테고리 코딩 끝 -->
					<br />
					<tr>
						<td  colspan=3><div align="center">
								<input type="button" onclick="_onSubmit(this)" value="설정완료"></input>
							</div></td>
					</tr>
				</form>
<script>
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "ir1",
	sSkinURI: "../js/Smart/SEditorSkin.html",
	fCreator: "createSEditorInIFrame"
});

nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "ir2",
	sSkinURI: "../js/Smart/SEditorSkin.html",
	fCreator: "createSEditorInIFrame"
});

function insertIMG(irid,fileame)
{
 
    var sHTML = "<img src='" + fileame + "' border='0'>";
    oEditors.getById[irid].exec("PASTE_HTML", [sHTML]);
 
}

// 복수개의 에디터를 생성하고자 할 경우, 아래와 같은 방식으로 호출하고 oEditors.getById["ir2"]이나 oEditors[1]을 이용해 접근하면 됩니다.
/*

*/

function _onSubmit(elClicked){
	// 에디터의 내용을 에디터 생성시에 사용했던 textarea에 넣어 줍니다.
	oEditors.getById["ir1"].exec("UPDATE_IR_FIELD", []);
	oEditors.getById["ir2"].exec("UPDATE_IR_FIELD", []);
	
	// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("ir1").value를 이용해서 처리하면 됩니다.

	try{
		elClicked.form.submit();
	}catch(e){}
}
</script>				
				<%
end if ''if qry = "coding" and  ccode <> "" then
%>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td></td>
				</tr>
			</table></td>
	</tr>
</table>
<!-- body end --------->
<%
Set util = Nothing : db.Dispose : Set objRs = Nothing : Set db = Nothing
%>
