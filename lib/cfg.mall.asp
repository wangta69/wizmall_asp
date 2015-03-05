<!-- #include file = "./cfg.common.asp" -->
<!-- #include file = "../config/db_connect.asp" -->
<!-- #include file = "../config/skin_info.asp" -->
<!-- #include file = "../config/mall_config.asp" -->
<!-- #include file = "./class.database.asp" -->
<!-- #include file = "./class.util.asp" -->
<!-- #include file = "./class.mall.asp" -->
<%

Dim code, codelen, page, no, order, qry, smode, searchmode, stext, opval
Dim big_code, mid_code, small_code, title, route
Dim setPageSize, setPageLink
Dim strSQL, objRs
Dim db, util,mall
Set util	= new utility	
Set db		= new database
Set mall	= new malls

code		= Request("code")
codelen		= Len(code)
no			= Request("no")
order		= Request("order")
qry			= Request("qry")
smode		= Request("smode")
opval		= Request("opval")
searchmode	= Request("searchmode")''내부검색용
stext		= Request("stext")''내부검색용
page		= Request("page") : if page	= "" then page = 1
setPageSize	= ListNo
setPageLink	= PageNo
'' 대분류일경우 

if codelen >= 3 then 
	big_code	= right(code, 3)
	strSQL		= "SELECT cat_no, cat_name FROM wizCategory WHERE cat_no='"&big_code&"'"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	title		= objRs("cat_name")
	route		= " &gt; <a href='wizmart.asp?code="&big_code&"'>"&title&"</a>"
	Set objRs	= Nothing
end if

if codelen >= 6 then 
	mid_code	= right(code, 6)
	strSQL		= "SELECT cat_no, cat_name FROM wizCategory WHERE cat_no='"&mid_code&"'"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	title		= objRs("cat_name")
	route		= route & " &gt; <a href='wizmart.asp?code="&mid_code&"'>"&title&"</a>"
	Set objRs	= Nothing
end if

if codelen >= 9 then 
	small_code	= right(code, 9)
	strSQL		= "SELECT cat_no, cat_name FROM wizCategory WHERE cat_no='"&small_code&"'"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	if NOT objRs.EOF Then
		title		= objRs("cat_name")
		route		= route & " &gt; "&title
		Set objRs	= Nothing
	End If
end if

if smode = "view" then 
	''카테고리 매장 분류에서 사용자 정의가 되어있어면 아래와 같이 실행된다.

	''strSQL = "select * from wizCategory where cat_no < 100 AND cat_no LIKE '%big_code'"
	''set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	
	Dim pname,uid,brand,price,price1,point,model,psize,porigin,compname,color,option1,option2,option3,option4,option5
	Dim picture,pnone,pnonestr,pinput,poutput,stock,stockouttype,wdate,description1,description2,description3,category,texttype
	Dim PictureArr, Picture0, Picture1, Picture2, Picture3, Picture4, Picture5
	Dim dpIcon, stockstate, catwhere,preuid,prepname,nextuid,nextpname,preatag,nextatag

	'' 상품조회, 카운트 올리기, 이전/다음 제품 구하기 프로시저
	Dim paramInfo(5)
	paramInfo(0) = db.MakeParam("@no", adInteger, adParamInput,11, no)
	paramInfo(1) = db.MakeParam("@code", adInteger, adParamInput,5, code)
	paramInfo(2) = db.MakeParam("@rtn_puid", adInteger, adParamOutput,11, 0)
	paramInfo(3) = db.MakeParam("@rtn_nuid", adInteger, adParamOutput,11, 0)
	paramInfo(4) = db.MakeParam("@rtn_ppname", adVarChar, adParamOutput,150, "")
	paramInfo(5) = db.MakeParam("@rtn_npname", adVarChar, adParamOutput,150, "")

	Set objRs = db.ExecSPReturnRS("usp_product_view", paramInfo, DbConnect)
	
	preuid		= db.GetValue(paramInfo, "@rtn_puid")
	prepname	= db.GetValue(paramInfo, "@rtn_ppname")
	nextuid		= db.GetValue(paramInfo, "@rtn_nuid")
	nextpname	= db.GetValue(paramInfo, "@rtn_npname")


	''strSQL = "SELECT * FROM wizmall WHERE uid='"&no&"' and pid = uid"
	''set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

	pname			= objRs("pname")
	uid				= objRs("uid")
	brand			= objRs("brand")
	price			= objRs("price")
	price1			= objRs("price1")
	point			= objRs("point")
	model			= objRs("model")
	porigin			= objRs("porigin")
	psize			= objRs("psize")
	compname		= objRs("compname")
	color			= objRs("color")
	option1			= objRs("option1")
	option2			= objRs("option2")
	option3			= objRs("option3")
	option4			= objRs("option4")
	option5			= objRs("option5")
	picture			= objRs("picture")
	pnone			= objRs("pnone") : if pnone = 1 then pnonestr = "checked"
	pinput			= objRs("pinput")
	poutput			= objRs("poutput")
	stock			= objRs("stock")
	stockouttype	= objRs("stockouttype")
	wdate			= objRs("wdate")
	description1	= objRs("description1")
	description2	= objRs("description2")
	description3	= objRs("description3")
	category		= objRs("category")
	texttype		= objRs("texttype")
	
	''이미지를 배열로 담아 다시 변수Picture0~5까지 분리하여 담기
	Call mall.splitPicture(picture)

	dpIcon			= mall.getOptionICon(option3,IconSkin,DisplayOptionIconArr)''option_arg, iconskin, OptionIcon
	
	stockstate		= mall.stockStatus(uid, pnone, stock, stockouttype, pinput, poutput)

	
	''오늘본 상품 저장
	Call mall.MkViewPd(pname, price, category, uid, Picture0)
	
	
	
	if Not IsNull(preuid) then
		preatag = "wizmart.asp?smode=view&code="&code&"&no="&preuid
	else
		preatag = "javascript:alert('이전상품이 없습니다.');"
	end if	
	
	if Not IsNull(nextuid) then
		nextatag = "wizmart.asp?smode=view&code="&code&"&no="&nextuid
	else
		nextatag = "javascript:alert('다음상품이 없습니다.');"
	end if	
end if''if smode = "view" then 

db.Dispose : Set db		= Nothing : Set util	= Nothing : Set mall = Nothing
%>
