<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/mall_config.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<%
Server.ScriptTimeout=10000
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database


Dim qry,htmleditimgfolder,uid,pid,pname,brand,compname,price,price1,wongaprice,point,unit,model,porigin, deliveryfee
Dim psize,color,option1,option2,option4,option5,pnone,pdisplay,pinput,poutput,stock,stockouttype
Dim description1_tmp,description1,description2,description3,category,ptexttype1,ptexttype2
Dim ptexttype3,texttype,getcomp,theme,menushow,page,smode,tmpvalue,option3
Dim picture
Dim none
Dim Loopcnt,Loopcnt1, maxuid
		
Dim attached_file(20),delete_file,file_del_status(20), imgsize(20), attached_filesize(20), thumnail(20)
Dim DefaultPath, UPLOAD, attached_count, old_filename
Dim fileinfo, filename

Dim con, constr, fullpath, tmppath, rs, sql, query''엑셀관련


DefaultPath			= PATH_SYSTEM & "config\tmp\"

'' // 컴포넌트 지정
attached_count = util.SetUploadComponent
qry					= UPLOAD("qry")

if qry = "excel_up" then
	'' // 업로드 사이즈 체크 및 이미지 파일 너비 체크
	fileinfo	= util.FileUploadInfo(UPLOAD("attached"))
		
	'' // 체크가 모두 끝나면 파일 저장한다.
	filename	= util.FileUploadModule(UPLOAD("attached"), smode, delete_file, "xls,xlsx")
	
	''업로드가 끝나면 이파일을 불러들여 mssql에 입력한다.
	tmppath		= Split(DefaultPath&filename, "|")
	fullpath	= tmppath(0)
	Set con		= Server.CreateObject("ADODB.Connection")
	constr		= "Provider=Microsoft.Jet.OLEDB.4.0;" & _
				   "Data Source=" & fullpath& ";" & _    
				   "Extended Properties=Excel 8.0;"
	con.Open constr
	 
	
	
	Set rs = Server.CreateObject("ADODB.RecordSet")
	sql = "select * From [Sheet1$]"
	 
	rs.Open sql, con
	 
	IF Not rs.eof Then
		Do Until rs.eof
			category			= rs("소분류")&rs("중분류")&rs("대분류")
			pname			= rs("상품명")
			''brand			= rs("브랜드")
			compname		= rs("제조사")
			getcomp			= rs("공급사")
			price			= rs("판매가")
			price1			= rs("시중가")
			wongaprice		= rs("구매가")
			deliveryfee		= rs("택배비")
			''point			= rs("포인트")
			model			= rs("모델명")
			porigin			= rs("원산지")
			if rs("상품노출") = "Y" THEN pdisplay = 0 ELSE pdisplay=1 end if
			pnone			= rs("판매상태")
			picture			= rs("이미지대") & "|" & rs("이미지중") & "|" & rs("이미지소")
			''Response.Write(picture)
			''Response.End()
			description1	= util.getReplaceInput(rs("제품설명"), "")
			''description1	= replace(description1,chr(13)&chr(10),"<br />") 
			description1	= replace(description1,chr(10),"<br />") 
			if rs("상세설명이미지")  <> "" then 
			description1	= "<img src=""/config/wizstock/descimg/" & rs("상세설명이미지") & """ />" & description1
			end if
			description2	= rs("간단한설명")
			description3	= rs("배송정보")
			''category		= rs("카테고리")


			if texttype = "checked" then description1 = description1 else description1 = description1''text type에 따른 폼 변환예정
				
		
			//description1 = util.htmleditorImg(description1, htmleditimgfolder, maxuid)
			'' 쿼리문 시작 '
			strSQL = "insert into wizmall ( "
			strSQL = strSQL & " pname,brand,compname,price,price1,wongaprice,point,deliveryfee,unit,model,porigin,psize,color,option1,option2,option3,option4,option5,"
			strSQL = strSQL & " picture,pnone,pdisplay,pinput,poutput,stock,stockouttype,wdate,description1,description2,description3,category,texttype,getcomp)"
			strSQL = strSQL & " values("
			strSQL = strSQL & "'"&pname&"','"&brand&"','"&compname&"','"&price&"','"&price1&"','"&wongaprice&"','"&point&"','"&deliveryfee&"','"&unit&"',"
			strSQL = strSQL & "'"&model&"','"&porigin&"','"&psize&"','"&color&"','"&option1&"','"&option2&"','"&option3&"','"&option4&"','"&option5&"','"&picture&"','"&pnone&"','"&pdisplay&"',"
			strSQL = strSQL & "'"&pinput&"','"&poutput&"','"&stock&"','"&stockouttype&"',getdate(),'" & description1 & "','" & description2 & "','"&description3&"','"&category&"','"&texttype&"',"
			strSQL = strSQL & "'"&getcomp&"')"
			''Response.Write(strSQL)
			''Response.Write("<br />---------------------------<br />")
			Call db.ExecSQL(strSQL, Nothing, DbConnect)
			
			''pid를 구한다.
			strSQL		= "select max(uid) from wizmall"
			Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
			uid			= objRs(0)
			strSQL		= "update wizmall set pid = '" & uid & "' where uid = '" & uid & "'"
			Call db.ExecSQL(strSQL, Nothing, DbConnect)
			
			''옵션값 등록하기
			''Call insertOp(uid)

			rs.MoveNext
		Loop
	End if
	 
	rs.Close
	con.Close
	 
	Set rs = Nothing
	Set con = Nothing
	
	Set objRs	= Nothing : db.Dispose : Set db	= Nothing : Set upload = Nothing

	
	


end if 'if qry = "qin" then 
''db.dispose : Set db = Nothing : Set objRs = Nothing : Set util = Nothing
Response.Write("<script>alert(""정상적으로 처리 되었습니다."");location.href=""/webadmin/main.asp?menushow=menu2&theme=product/product_excel_file""</script>")
%>
