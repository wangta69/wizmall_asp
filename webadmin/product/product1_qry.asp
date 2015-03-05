<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/mall_config.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<%
Dim strSQL,objRs
Dim db,util
Set util	= new utility	
Set db		= new database


Dim qry,htmleditimgfolder,uid,pid,pname,brand,deliveryfee,compname,price,price1,wongaprice,point,unit,model,porigin
Dim psize,color,option1,option2,option4,option5,pnone,pdisplay,pinput,poutput,stock,stockouttype
Dim description1_tmp,description1,description2,description3,category,ptexttype1,ptexttype2
Dim ptexttype3,texttype,getcomp,theme,menushow,smode,tmpvalue,option3, tmp_multi,copyenable
Dim page, s_category''수정에서 넘어온경우
Dim none
Dim Loopcnt,Loopcnt1, maxuid
		
Dim attached_file(20),delete_file,file_del_status(20), imgsize(20), attached_filesize(20), thumnail(20)
Dim DefaultPath, UPLOAD, attached_count, old_filename
Dim fileinfo, filename

DefaultPath			= PATH_SYSTEM & "config\wizstock\"
'' // 컴포넌트 지정
attached_count = util.SetUploadComponent
		
		qry					= upload("qry")
        uid					= upload("uid")
		pid					= upload("pid")
		pname				= upload("pname")
		brand				= upload("brand")
		deliveryfee			= upload("deliveryfee")
		compname			= upload("compname")
		price				= upload("price")
		price1				= upload("price1")
		wongaprice			= upload("wongaprice")
		point				= upload("point")
		unit				= upload("unit")
		model				= upload("model")
		porigin				= upload("porigin")
		psize				= upload("psize")
		color				= upload("color")
		option1				= upload("option1")
		option2				= upload("option2")
		option4				= upload("option4")
		option5				= upload("option5")
		pnone				= upload("pnone")
		pdisplay			= upload("pdisplay")
		copyenable			= upload("copyenable")
		
		
		pinput				= upload("input")
		poutput				= upload("output")
		stock				= upload("stock")
		stockouttype		= upload("stockouttype")
		''wdate				= upload("wdate")
		description1_tmp	= upload("description1")
		description1		= util.getReplaceInput(description1_tmp, "")	
		description2		= upload("description2")
		description3		= upload("description3")
		category			= upload("category") : If category = ""  then Call util.js_alert("카테고리가 설정되지 않았습니다.","")
		''category3			= upload("category3")
		''category2			= upload("category2")
		''category1			= upload("category1")
		ptexttype1			= upload("ptexttype1")
		ptexttype2			= upload("ptexttype2")
		ptexttype3			= upload("ptexttype3")
		texttype			= ptexttype1&"|"&ptexttype2&"|"&ptexttype3
		getcomp				= upload("getcomp")
		tmp_multi			= upload("tmp_multi")
		menushow			= upload("menushow")
		theme				= upload("theme")
		page				= upload("page")
		s_category			= upload("s_category")
		if qry = "qup" then smode = "edit"

        ''if category3 <> "" then
		''	category = category3
		''elseif category2 <> "" then
		''	category = category2
		''elseif category1 <> "" then 
		''	category = category1
		''else 
			''Call util.js_alert("카테고리가 설정되지 않았습니다.","")
		''end if
		
		for Loopcnt=1 to Ubound(DisplayOptionArr)
			tmpvalue =  upload("option3_"&Loopcnt)
			If tmpvalue = "" Then tmpvalue = 0
			option3 = option3 & tmpvalue & "|"
		next

	if qry = "qup" then
		strSQL = "select picture from wizmall where uid = '" & uid & "'"
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
			if objRs("picture") <> "" then  old_filename = split(objRs("picture"), "|")
			ReDim Preserve old_filename (attached_count)			
	end if
	


	'' 옵션관련 변수 Request
	Dim optioncnt,opname,opnameArr,opcnt,opflag,opflagArr,optioneachname_0,optioneachnameArr_0,optioneachprice_0,optioneachpriceArr_0
	Dim optioneachqty_0,optioneachqtyArr_0,optioneachname_1,optioneachnameArr_1,optioneachprice_1,optioneachpriceArr_1,optioneachqty_1
	Dim optioneachqtyArr_1,optioneachname_2,optioneachnameArr_2,optioneachprice_2,optioneachpriceArr_2,optioneachqty_2,optioneachqtyArr_2
	Dim optioneachname_3,optioneachnameArr_3,optioneachprice_3,optioneachpriceArr_3,optioneachqty_3,optioneachqtyArr_3,optioneachname_4
	Dim optioneachnameArr_4,optioneachprice_4,optioneachpriceArr_4,optioneachqty_4,optioneachqtyArr_4

	optioncnt			= upload("optioncnt")        
	opname				= upload("opname")				: opnameArr = split(opname, ",")
	opcnt				= upload("opcnt")
	opflag				= upload("opflag")				: opflagArr = split(opflag, ",")
	optioneachname_0	= upload("optioneachname_0")	: optioneachnameArr_0 = split(optioneachname_0, ",")
	optioneachprice_0	= upload("optioneachprice_0")	: optioneachpriceArr_0 = split(optioneachprice_0, ",")	
	optioneachqty_0		= upload("optioneachqty_0")		: optioneachqtyArr_0 = split(optioneachqty_0, ",")
	optioneachname_1	= upload("optioneachname_1")	: optioneachnameArr_1 = split(optioneachname_1, ",")
	optioneachprice_1	= upload("optioneachprice_1")	: optioneachpriceArr_1 = split(optioneachprice_1, ",")	
	optioneachqty_1		= upload("optioneachqty_1")		: optioneachqtyArr_1 = split(optioneachqty_1, ",")
	optioneachname_2	= upload("optioneachname_2")	: optioneachnameArr_2 = split(optioneachname_2, ",")
	optioneachprice_2	= upload("optioneachprice_2")	: optioneachpriceArr_2 = split(optioneachprice_2, ",")	
	optioneachqty_2		= upload("optioneachqty_2")		: optioneachqtyArr_2 = split(optioneachqty_2, ",")
	optioneachname_3	= upload("optioneachname_3")	: optioneachnameArr_3 = split(optioneachname_3, ",")
	optioneachprice_3	= upload("optioneachprice_3")	: optioneachpriceArr_3 = split(optioneachprice_3, ",")	
	optioneachqty_3		= upload("optioneachqty_3")		: optioneachqtyArr_3 = split(optioneachqty_3, ",")
	optioneachname_4	= upload("optioneachname_4")	: optioneachnameArr_4 = split(optioneachname_4, ",")
	optioneachprice_4	= upload("optioneachprice_4")	: optioneachpriceArr_4 = split(optioneachprice_4, ",")	
	optioneachqty_4		= upload("optioneachqty_4")		: optioneachqtyArr_4 = split(optioneachqty_4, ",")
''Response.write(tmp_multi)
''Response.End()	
		
'' // 업로드 사이즈 체크 및 이미지 파일 너비 체크
fileinfo	= util.FileUploadInfo(UPLOAD("attached"))
	
'' // 체크가 모두 끝나면 파일 저장한다.
filename	= util.FileUploadModule(UPLOAD("attached"), smode, delete_file, "gif,jpeg,jpg,png")

'' thumbnail 이미지를 만든다.
filename	= util.ThumnailForMall(filename)

''## 등록 옵션 입력하기
''##삭제되는 값의 존재 여부 확인이 어려우므로 모두 삭제하고 새로 입력한다.
Sub insertOp(uid)
	Dim oorder,ropflag,ouid
    strSQL		= "select uid from wizMalloptioncfg where opid = '" & uid & "'"
    Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
    WHILE NOT objRs.EOF
        strSQL = "delete from wizMalloption where ouid = '" & objRs("uid") & "'"
        Call db.ExecSQL(strSQL, Nothing, DbConnect)
    objRs.MOVENEXT
    WEND
    
    strSQL = "delete from wizMalloptioncfg where opid = '" & uid & "'"
    Call db.ExecSQL(strSQL, Nothing, DbConnect)
    
    if isArray(opnameArr) then 
        oorder=0
        for Loopcnt = 0 to Ubound(opnameArr) 
            ropflag = trim(opflagArr(Loopcnt))
            strSQL = "insert into wizMalloptioncfg (opid, oname, oorder, oflag) values ('" & uid & "', '" & trim(opnameArr(Loopcnt)) & "', '" & oorder & "', '" & ropflag & "')"
            Call db.ExecSQL(strSQL, Nothing, DbConnect)
            
            ''select @@IDENTITY
            strSQL = "select max(uid) from wizMalloptioncfg"
            Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
            ouid	= objRs(0)
            oorder	= oorder + 1
            
        Select Case Loopcnt
            Case "0"
                Call insertOpSpec(ouid, optioneachnameArr_0, optioneachpriceArr_0, optioneachqtyArr_0)
            Case "1"
                Call insertOpSpec(ouid, optioneachnameArr_1, optioneachpriceArr_1, optioneachqtyArr_1)
            Case 2
                Call insertOpSpec(ouid, optioneachnameArr_2, optioneachpriceArr_2, optioneachqtyArr_2)
            Case 3
                Call insertOpSpec(ouid, optioneachnameArr_3, optioneachpriceArr_3, optioneachqtyArr_3)
            Case 4
                Call insertOpSpec(ouid, optioneachnameArr_4, optioneachpriceArr_4, optioneachqtyArr_4)							
        End Select    
       next
    End If
End Sub        


''## 다중카테고리 입력하기
''##삭제되는 값의 존재 여부 확인이 어려우므로 모두 삭제하고 새로 입력한다.
Sub insertmulti(uid, tmp_multi)
   Dim insert_cat, subloop
	strSQL = "delete from wizMall where pid = " & uid & " and pid <> uid"
	Call db.ExecSQL(strSQL, Nothing, DbConnect)

	Dim multiArr : multiArr = split(tmp_multi, ",")

	for subloop=0 to Ubound(multiArr)
		insert_cat = trim(multiArr(subloop))
		if insert_cat <> "" then 
			strSQL = "insert into  wizMall (pid, category) values (" & uid & ", '" & insert_cat & "')"
			''Response.Write(strSQL)
			Call db.ExecSQL(strSQL, Nothing, DbConnect)
		end if
	NEXT	     
End Sub   


Sub insertOpSpec(ouid, oname,oprice,oqty)
	if isArray(oname) then 
        	for Loopcnt1 = 0 to Ubound(oname) 
                strSQL = "insert into wizMalloption (ouid,oname,oprice,oqty) values ('" & ouid& "', '" & trim(oname(Loopcnt1)) & "', '" & trim(oprice(Loopcnt1)) & "', '" & trim(oqty(Loopcnt1)) & "')"
''                Response.Write(strSQL & "<br />")
                Call db.ExecSQL(strSQL, Nothing, DbConnect)
            Next			
       End If
End Sub     
''## 등록 옵션 입력하기 끝



if qry = "qin" then 
		
        if texttype = "checked" then description1 = description1 else description1 = description1''text type에 따른 폼 변환예정

' 쿼리문 시작 '
        strSQL = "insert into wizmall ( "
        strSQL = strSQL & " pname,brand,deliveryfee,compname,price,price1,wongaprice,point,unit,model,porigin,psize,color,option1,option2,option3,option4,option5,"
        strSQL = strSQL & " picture,pnone,pdisplay,pinput,poutput,stock,stockouttype,wdate,description1,description2,description3,category,texttype,getcomp)"
        strSQL = strSQL & " values("
		strSQL = strSQL & "'"&pname&"','"&brand&"','"&deliveryfee&"','"&compname&"','"&price&"','"&price1&"','"&wongaprice&"','"&point&"','"&unit&"',"
		strSQL = strSQL & "'"&model&"','"&porigin&"','"&psize&"','"&color&"','"&option1&"','"&option2&"','"&option3&"','"&option4&"','"&option5&"','"&filename&"','"&pnone&"','"&pdisplay&"',"
		strSQL = strSQL & "'"&pinput&"','"&poutput&"','"&stock&"','"&stockouttype&"',getdate(),'"&description1&"','"&description2&"','"&description3&"','"&category&"','"&texttype&"',"
		strSQL = strSQL & "'"&getcomp&"')"

        Call db.ExecSQL(strSQL, Nothing, DbConnect)
		
		''pid를 구한다.
		strSQL		= "select max(uid) from wizmall"
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		uid			= objRs(0)
		
		''편집기에 올라온 임시 파일 이동
		description1 = util.htmleditorImg(description1, uid)
		
		strSQL		= "update wizmall set pid = '" & uid & "', description1 = '" & description1 & "' where uid = '" & uid & "'"
		Call db.ExecSQL(strSQL, Nothing, DbConnect)
		
        ''옵션값 등록하기
        Call insertOp(uid)
		
		''다중카테고리 등록
		Call insertmulti(uid, tmp_multi)
		
		
		Set objRs	= Nothing : db.Dispose : Set db	= Nothing : Set upload = Nothing
        response.write "<script>con = confirm(""동종 상품 추가등록을 하시겠습니까?"");if (con==true) { history.go(-1)} else {location.href ='../main.asp?menushow="&menushow&"&theme=product/product1'}</script>"
        response.end()
elseif qry = "qup" then 

	description1 = util.htmleditorImg(description1, uid)
	
	' omit 된 내용 : input = 'input', output = 'output', ''' 다시 추가 : stock = 'stock', stockouttype
	strSQL = "update wizmall set "
	strSQL = strSQL & " pid = '"&uid&"', "
	strSQL = strSQL & " pname = '"&pname&"', "
	strSQL = strSQL & " brand = '"&brand&"', "
	strSQL = strSQL & " deliveryfee = '"&deliveryfee&"', "
	strSQL = strSQL & " compname = '"&compname&"', "
	strSQL = strSQL & " price = '"&price&"', "
	strSQL = strSQL & " price1 = '"&price1&"', "
	strSQL = strSQL & " wongaprice = '"&wongaprice&"', "
	strSQL = strSQL & " point = '"&point&"', "
	strSQL = strSQL & " unit = '"&unit&"', "
	strSQL = strSQL & " model = '"&model&"', "
	strSQL = strSQL & " porigin = '"&porigin&"', "
	strSQL = strSQL & " psize = '"&psize&"', "
	strSQL = strSQL & " color = '"&color&"', "
	strSQL = strSQL & " option1 = '"&option1&"', "
	strSQL = strSQL & " option2 = '"&option2&"', "
	strSQL = strSQL & " option3 = '"&option3&"', "
	strSQL = strSQL & " option4 = '"&option4&"', "
	strSQL = strSQL & " option5 = '"&option5&"', "
	strSQL = strSQL & " picture = '"&filename&"', "
	strSQL = strSQL & " pnone = '"&pnone&"', "
	strSQL = strSQL & " pdisplay = '"&pdisplay&"', "
	strSQL = strSQL & " stock = '"&stock&"', "
	strSQL = strSQL & " stockouttype = '"&stockouttype&"', "
	'strSQL = strSQL & " wdate = '"&wdate&"', "
	strSQL = strSQL & " description1 = '"&description1&"', "
	strSQL = strSQL & " description2 = '"&description2&"', "
	strSQL = strSQL & " description3 = '"&description3&"', "
	strSQL = strSQL & " category = '"&category&"', "
	strSQL = strSQL & " texttype = '"&texttype&"', "
	strSQL = strSQL & " getcomp = '"&getcomp&"' where uid="&uid
	Call db.ExecSQL(strSQL, Nothing, DbConnect)
    
    ''옵션값 등록하기
	Call insertOp(uid)
    
	''다중카테고리 등록
	Call insertmulti(uid, tmp_multi)
			
    Set objRs	= Nothing : db.Dispose : Set db	= Nothing : Set upload = Nothing
	response.write "<script>location.href ='../main.asp?menushow="&menushow&"&theme=product/product2&page=" & page & "&s_category=" & s_category & "'</script>"
	response.end()
	
end if 'if qry = "qin" then 
db.dispose : Set db = Nothing : Set objRs = Nothing : Set util = Nothing
%>