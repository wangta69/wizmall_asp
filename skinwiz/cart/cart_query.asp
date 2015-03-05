<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../../config/skin_info.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.cart.asp" -->
<%
Dim strSQL,objRs
Dim db,util,cart
Set util	= new utility	
Set db		= new database
Set cart	= new wizcart

Dim attached_file(20),file_del_status(20), imgsize(20), attached_filesize(20), thumnail(20)
Dim DefaultPath, UPLOAD, attached_count, old_filename

Dim smode,sub_query
Dim skinmode,code,mall_chk,no,buynum,goodsprice,goodspoint,optionfield
Dim fileinfo,filename
Dim cuid,gotourl
Dim addvalue

smode		= Request("smode")


if smode = "cart_save" then  
	DefaultPath = PATH_SYSTEM & "config\cartstock\"
	'' // 컴포넌트 지정
	attached_count = util.SetUploadComponent

	skinmode		= UPLOAD("skinmode")
	code			= UPLOAD("code")
	mall_chk		= UPLOAD("mall_chk")
	no				= UPLOAD("no")
	buynum			= UPLOAD("buynum")
	goodsprice		= UPLOAD("goodsprice")
	goodspoint		= UPLOAD("goodspoint")
	optionfield		= UPLOAD("optionfield")
	sub_query		= UPLOAD("sub_query")

	'' // 업로드 사이즈 체크 및 이미지 파일 너비 체크
	fileinfo	= util.FileUploadInfo(UPLOAD("attached"))
	'' // 체크가 모두 끝나면 파일 저장한다.
	filename	= util.FileUploadModule(UPLOAD("attached"), "", "", "gif,jpeg,jpg,png")

else
	cuid	= Request("cuid")
	gotourl	= Request("gotourl")
	buynum	= Request("buynum")
end if

''/*******************************************************************************
''장바구니 코드가 없을 경우 - 장바구니 코드 생성
''*******************************************************************************/
Dim CART_CODE
IF SESSION("CART_CODE") = "" THEN
	CART_CODE				= util.Linuxtime()
	SESSION("CART_CODE")    = CART_CODE ''장바구니고유코드
ELSE
	CART_CODE = SESSION("CART_CODE")
END IF


if smode = "cmp" then
''/*********************************************************************************
''다중선택 장바구니 담기일경우 
''*********************************************************************************/	
elseif smode = "cart_save" then
''/*********************************************************************************
''하나씩 선택하여 장바구니 담기일경우
''********************************************************************************/
	Call cart.wizCartExe(CART_CODE,no,buynum,optionfield) 
	if sub_query = "baro" then Call util.js_location("../../wizbag.asp?smode=step1","") else Call util.js_location("../../wizbag.asp","")

elseif smode = "update_qty" then
''/*********************************************************************************
''장바구니 택일수정
''*********************************************************************************/
	strSQL = "update wizCart set qty = "&buynum&" where uid = "&cuid
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	Call util.js_location("../../wizbag.asp","")
elseif smode = "qde" then 
''/*********************************************************************************
''장바구니 택일삭제
''*********************************************************************************/
	strSQL = "delete from wizCart where uid = "&cuid
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	Response.Redirect("../../wizbag.asp")
	Response.End()
elseif smode = "step5" then ''// 장바구니 쿠키삭제
	SESSION("CART_CODE") = ""
elseif smode = "trash" then ''// 장바구니 비우기
	strSQL = "delete from wizCart where oid = '"&SESSION("CART_CODE")&"'"
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
	SESSION("CART_CODE") = ""
	if gotourl <> "" then
		Response.Redirect("../../"&gotourl)	
	else
		Response.Redirect("../../wizbag.asp")
	end if
	Response.End()
end if
db.dispose : Set db = Nothing : Set util = Nothing : Set cart = Nothing
%>
