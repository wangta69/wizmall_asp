<% 
class malls '' 클래스 선언합니다..

	private Sub Class_Initialize()
	
	End Sub

	Private Sub Class_Terminate()
	
	End Sub


	Sub getSelectCategory(depth, category)
		Dim len_cat, len_depth, orderby, sel_cat, objRs, selected, strSQL
		len_cat		= len(category)
		len_depth	= depth*3
		
		orderby		= " ORDER BY cat_order ASC"
		strSQL		= ""
		select	case depth
			case 1
					strSQL = "SELECT cat_no, cat_name FROM wizCategory WHERE LEN(cat_no) = 3 "&orderby
					sel_cat = Right(category, 3)
			case 2
					strSQL = "SELECT cat_no, cat_name FROM wizCategory WHERE LEN(cat_no) = 6 and Right(cat_no, 3) = '"&Right(category,3)&"'" &orderby
					sel_cat = Right(category, 6)
			case 3
					strSQL = "SELECT cat_no, cat_name FROM wizCategory WHERE LEN(cat_no) = 9 and Right(cat_no, 6) = '"&Right(category,6)&"'" &orderby
					sel_cat = Right(category, 9)
		end select
		
		If len_depth <= len_cat+3 Then
			Set db = new database
			Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
			while not objRs.eof
				if sel_cat = objRs("cat_no") then selected = "selected" Else selected = ""
				Response.Write"<OPTION VALUE='"&objRs("cat_no")&"' "&selected&">"&objRs("cat_name")&"</OPTION>"&Chr(13)&Chr(10)
			objRs.movenext
			wend	
			Set objRs	= Nothing : db.Dispose : Set db	= Nothing
		End If
	
	End Sub	
	
	Function getPayType(paytype)
		select case paytype
			case "online"
				getPayType = "무통장입금"
			case "card"
				getPayType = "카드결제"
			case "hand"
				getPayType = "핸드폰결제"
			case "autobank"
				getPayType = "온라인결제"
			case "point"
				getPayType = "포인터결제"
			case "all"
				getPayType = "다중결제"												
		end select
	end Function

	''  첨부화일에 따른 이미지 출력
	Function getOptionICon(option_arg, iconskin, OptionIcon)
		''option_arg : wizmall 테이블의  option3값, 1|0|0|1, iconskin : ./cofig/skin_info.asp의 iconskin값, optionIconf mall_config의 iconf배열값
		Dim optionSp, i, j
		IF NOT ISNULL(option_arg) THEN
			optionSp = split(option_arg, "|")
			getOptionICon = ""
			for i = 0 to Ubound(optionSp)
				if optionSp(i) = "1" then
					j = i+1
					If IsArray(OptionIcon) Then 
						If Ubound(OptionIcon) > j then
							getOptionICon = getOptionICon & "<img src='./skinwiz/common_icon/"&iconskin&"/" & OptionIcon(j) &"'> "
						End If
					End If
				end if
			next
		END IF
	End Function

	Function stockStatus(pid, pnone, stock, stockouttype, input, output)
		Dim fstrSQL, fobjRs, ingcount
		stockStatus = true
			
		''현재 주문중인(결제전) 물품갯수 구하기
		fstrSQL = "select sum(qty) from wizcart where pid = '"&pid&"' and ostatus <> '0'"
		Set fobjRs	= db.ExecSQLReturnRS(fstrSQL, Nothing, DbConnect)
		ingcount = fobjRs(0)

		if pnone = 1 then 
			stockStatus = false
		else
			select case stockouttype
			''0 : 처리하지않음,  1 : 재고갯수수동처리, 2 : 재고갯수자동처리
				case "1"
					if stock = 0 then
						stockStatus = false
					elseif stock-ingcount = 0 then
						stockStatus = false
					end if
					
				case "2"
					if stock = 0 then 
						stockStatus = false
					elseif stock-ingcount = 0 then
						stockStatus = false					
					elseif input - output <= 0 then
						stockStatus = false
					end if			
			end select
		end if
	End Function


	Sub	MkViewPd(t_pname, t_price, t_category, t_uid, t_img)
	''오늘본 상품 쿠키저장(필요시 별도의 db저장을 하지만 db에서 값을 가져올경우 부하가 발생하므로 전체적인 쿠키시스템은 유지
		Dim cookiecnt, i
		cookiecnt = Request.Cookies("cookieKey")("cookiecnt")
		if cookiecnt = "" then cookiecnt = 0
		
		for i = 1 to cookiecnt - 1''기존 쿠키를 새로 저장
			if t_uid <> Cint(Request.Cookies("cookieKey" & (i + 1))("t_uid")) then ''중복 입력방지
				Response.Cookies("cookieKey" & i)("t_pname") = Request.Cookies("cookieKey" & (i + 1))("t_pname")
				Response.Cookies("cookieKey" & i)("t_price") = Request.Cookies("cookieKey" & (i + 1))("t_price")
				Response.Cookies("cookieKey" & i)("t_category") = Request.Cookies("cookieKey" & (i + 1))("t_category")
				Response.Cookies("cookieKey" & i)("t_uid") = Request.Cookies("cookieKey" & (i + 1))("t_uid")
				Response.Cookies("cookieKey" & i)("t_img") = Request.Cookies("cookieKey" & (i + 1))("t_img")	
			end if	
		next
		
		cookiecnt = cookiecnt + 1
		if 5 < cookiecnt then cookiecnt = 5 ''신규 쿠키 추가 저장
		
		Response.Cookies("cookieKey")("cookiecnt") = cookiecnt
		Response.Cookies("cookieKey" & cookiecnt)("t_pname")	= t_pname 
		Response.Cookies("cookieKey" & cookiecnt)("t_price")	= t_price 
		Response.Cookies("cookieKey" & cookiecnt)("t_category")	= t_category 
		Response.Cookies("cookieKey" & cookiecnt)("t_uid")		= t_uid 
		Response.Cookies("cookieKey" & cookiecnt)("t_img")		= t_img 
	End Sub	
	
	''@ deprecated
	'' getProductImage 로 대처
	Function getGoodsImg(filename, setImgWidth)
		Dim ImgDir, ImgFullPath, ImageSize, imgsize_width, imgsize_height,fileExt
		Set util = new utility
		ImgDir = "./config/wizstock/"
		ImgFullPath = PATH_SYSTEM & "config\wizstock\" & filename
		ImageSize=split(util.getImageSize(ImgFullPath), "|")
		imgsize_width = ImageSize(0)
		imgsize_height = ImageSize(1)
		''Response.Write(filename & ", " & setImgWidth  &", " & imgsize_width & ", " & imgsize_height)
		fileExt = Ucase(mid(filename, instrrev(filename, ".") + 1))
		SELECT CASE fileExt
			CASE "jpg", "JPG","jpeg", "JPEG", "gif", "GIF", "bmp", "BMP", "png", "PNG"
				IF imgsize_width <> "" AND imgsize_height <> "" THEN
					''IF INT(setImgWidth) > 100 THEN
						IF INT(imgsize_width) > INT(setImgWidth) THEN
							imgsize_height = INT(imgsize_height * setImgWidth / imgsize_width)
							imgsize_width = setImgWidth
						END IF
						imgsize_width = ROUND(imgsize_width - 0.5 + 1,0)
						imgsize_height = ROUND(imgsize_height - 0.5 + 1,0)
					''END IF
					imgsize_width = " width=" & imgsize_width
					imgsize_height = " height=" & imgsize_height
				ELSE
					imgsize_width = ""
					imgsize_height = ""
				END IF
				''Response.Write("<img name=previmg src=" & ImgDir & filename & imgsize_width & imgsize_height & " style='border-color:rgb(153,153,153)'>")
				getGoodsImg = "<img name=previmg src=" & ImgDir & filename & imgsize_width & imgsize_height & " style='border-color:rgb(153,153,153)'>"
		CASE ELSE
				getGoodsImg = ""''대폴트이미지가 있을 경우 그 이미지로 교체
		END Select
		Set util = Nothing
	End Function


	''flag : user : 사용자가 정해준 width와 height를 사용, default : getGoodsImg 와 동
	Function getProductImage(filename, flag, setImgWidth, setImagHeight)
		Dim ImgDir, ImgFullPath, ImageSize, imgsize_width, imgsize_height,fileExt
		Set util = new utility
		ImgDir = "./config/wizstock/"
		ImgFullPath = PATH_SYSTEM & "config\wizstock\" & filename
		ImageSize=split(util.getImageSize(ImgFullPath), "|")
		imgsize_width = ImageSize(0)
		imgsize_height = ImageSize(1)
		''Response.Write(filename & ", " & setImgWidth  &", " & imgsize_width & ", " & imgsize_height)
		fileExt = Ucase(mid(filename, instrrev(filename, ".") + 1))
		SELECT CASE fileExt
			CASE "jpg", "JPG","jpeg", "JPEG", "gif", "GIF", "bmp", "BMP", "png", "PNG"
				If flag = "user" Then
					imgsize_width = " width=" & setImgWidth
					imgsize_height = " height=" & setImagHeight
					getProductImage = "<img name=previmg src=""" & ImgDir & filename & """" & imgsize_width & imgsize_height & " style='border-color:rgb(255,255,255)'>"
				Else
					IF imgsize_width <> "" AND imgsize_height <> "" THEN
						''IF INT(setImgWidth) > 100 THEN
							IF INT(imgsize_width) > INT(setImgWidth) THEN
								imgsize_height = INT(imgsize_height * setImgWidth / imgsize_width)
								imgsize_width = setImgWidth
							END IF
							imgsize_width = ROUND(imgsize_width - 0.5 + 1,0)
							imgsize_height = ROUND(imgsize_height - 0.5 + 1,0)
						''END IF
						imgsize_width = " width=" & imgsize_width
						imgsize_height = " height=" & imgsize_height
					ELSE
						imgsize_width = ""
						imgsize_height = ""
					END IF
					''Response.Write("<img name=previmg src=" & ImgDir & filename & imgsize_width & imgsize_height & " style='border-color:rgb(153,153,153)'>")
					getProductImage = "<img name=previmg src=""" & ImgDir & filename & """" & imgsize_width & imgsize_height & """ style='border-color:rgb(255,255,255)'>"

				End if

		CASE ELSE
				getProductImage = "<img name=previmg src='/images/p_samp_s.gif'>"''대폴트이미지가 있을 경우 그 이미지로 교체
		END Select
		Set util = Nothing
	End Function



	Sub paging (page,setPageSize,setPageLink,TotalCount,linkurl,design)
		Dim TP, CB, SP, EP, TB, prev_page, next_page, I
		TP = Round(TotalCount / setPageSize + 0.49) ''총페이지수(Total Page) : 총게시물수 / 페이지당 리스트수  
		CB = Round(page / setPageLink + 0.49) ''현재블록(Current Block) : 현재페이지 / 표시되는 페이지 수
		SP = (CB - 1) * setPageLink + 1'' 블록의 처음 페이지(Start Page) 구하기
		EP = (CB * setPageLink) ''블록의 마지막 페이지(End Page) : 현재 블록 * 표시되는 페이지수
		TB = Round(TP / setPageLink + 0.49) '' 총블록수(Total Block) : 총페이지수 / 표시되는 페이지 수 

		Response.Write "<table id='paging'><tr><td align='center'>"
		IF INT(CB) > 1 THEN
			prev_page = SP - 1
			RESPONSE.WRITE "<a href='" & linkurl & "&page=" & prev_page & "'><img src='" & preimg & "' border=0></a>"
		END IF
		Response.Write "</td> <td align='center'>"


		FOR I = SP TO EP 
			IF I <= TP THEN
				IF INT(I) = INT(page) THEN
					RESPONSE.WRITE "&nbsp;<b>"&i&"</b>&nbsp;"
				ELSE
					RESPONSE.WRITE "<a href='" & linkurl & "&page=" & I & "'>&nbsp;"& I & "&nbsp;</a>"
				END IF
			END IF
		NEXT
		Response.Write "</td><td align='center'>"
		IF INT(CB) < INT(TB) THEN 
			next_page = EP + 1
			RESPONSE.WRITE "<a href='" & linkurl & "&page=" & next_page & "'><img src='" & nextimg & "' border=0></a>"
		END IF	

		Response.Write "</td> </tr></table>"
	End Sub

	Sub DeleteProduct(uid)
		dim i, pictureArr,productImgDir
		uid = util.convertnum(trim(uid))
		
		strSQL = "SELECT picture FROM wizmall WHERE uid=" & uid
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		while not objRs.eof
			pictureArr = split(objRs("picture"),"|")
			For i=0 to Ubound(pictureArr)
				productImgDir = PATH_SYSTEM&"config\wizstock\"
				IF pictureArr(i) <> "" THEN CALL util.FileDelete(productImgDir, pictureArr(1))
			Next
		objRs.movenext
		wend
		
		''strSQL = "DELETE FROM wizMall WHERE uid=" & uid
		''Call db.ExecSQL(strSQL, Nothing, DbConnect)
		
		strSQL = "DELETE FROM wizMall WHERE pid=" & uid
		Call db.ExecSQL(strSQL, Nothing, DbConnect)
		
		strSQL = "Select uid from wizmalloptioncfg WHERE opid = " & uid
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		while not objRs.eof
			strSQL = "Select uid from wizmalloption WHERE ouid = " & objRs("uid")
			Call db.ExecSQL(strSQL, Nothing, DbConnect)
		objRs.movenext
		wend
		
		strSQL = "DELETE FROM wizmalloptioncfg WHERE opid = " & uid
		Call db.ExecSQL(strSQL, Nothing, DbConnect)

	End Sub


	Sub UpdateProductPrice(uid, price,price1,wonga,point, pdisplay)
		uid		= util.convertnum(trim(uid))
		price	= util.convertnum(trim(price))
		point	= util.convertnum(trim(point))
		strSQL	= "UPDATE wizmall set price = " & price & ", price1 = " & price1 & ",wongaprice = " & wonga & ",point = " & point & ",pdisplay = " & pdisplay & " WHERE uid = " & uid
		Call db.ExecSQL(strSQL, Nothing, DbConnect)
	End Sub
	
	
	'' 이미지를 가져와 배열에 담기
	''Picture0 ~ Picture5는 상단에서 Dim 처리
	Sub splitPicture(picture)
		Dim i, PicArr
		PicArr = split(picture, "|")
		For i = 0 to Ubound(PicArr)
			Select Case i
				Case 0 : Picture0 = PicArr(i)
				Case 1 : Picture1 = PicArr(i)
				Case 2 : Picture2 = PicArr(i)
				Case 3 : Picture3 = PicArr(i)
				Case 4 : Picture4 = PicArr(i)
				Case 5 : Picture5 = PicArr(i)															
			End Select 
		Next
	End Sub
	
	
End Class	
%>
