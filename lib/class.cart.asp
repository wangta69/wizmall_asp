<% 
class wizcart '' 클래스 선언합니다..

	private Sub Class_Initialize()
	
	End Sub

	Private Sub Class_Terminate()
	
	End Sub

	function wizCartExe(oid,pid,qty,optionfield)
		Dim price, point,uid,oprice,ouid,oname, pnone
		Dim tprice			: tprice		= 0 ''전체상품금액
		Dim optionflag		: optionflag	= ""
		Dim op_price		: op_price		= 0 ''옵션가격		


		''기존 주문되지 않은 물품에 대해서는 삭제(30일전 데이타)
		strSQL = "delete from wizCart where ostatus = '0' and wdate < convert(char(8), dateadd(dd,-30,getdate()), 112)"
		Call db.ExecSQL(strSQL, Nothing, DbConnect)
	
		

		'' 실제 제품가격 및 제품 point를 구한다.
		strSQL		= "select m1.uid, m1.price, m1.point, m1.pnone from wizmall m1 left join wizmall m2 on m1.uid = m2.pid where m2.uid = '" & pid & "'"
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		price		= objRs("Price")
		point		= objRs("Point")
		pnone		= objRs("pnone")
		pid			= objRs("uid")''이곳에서 원본의  uid를 입력한다.
		
		if pnone <> 0 Then
			Response.Write("<script>alert('현재 상품은 품절이므로 구매하실 수 없습니다.'); history.go(-1)</script>")
		Else ''if pnone <> 0 Then
			if optionfield <> "" then 
				Dim optionfieldArr, value, tmp
				optionfieldArr = split(optionfield, ",")
	
				For Each value in optionfieldArr
					value = trim(value)
					if value <> "" then
						tmp = split(value,"|")
						''tmp = uid |oprice|ouid 
						uid		= tmp(0)
						oprice	= tmp(1)
						ouid	= tmp(2)
						
						Dim cfg_oflag, cfg_oname
						strSQL = "select oflag, oname from wizMalloptioncfg where uid = '" & ouid & "'"
						Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
						cfg_oflag = objRs("oflag")
						cfg_oname = objRs("oname")
						
						strSQL = "select oname from wizMalloption where uid = '" & uid &"'"
						Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
						
						oname = objRs("oname")
						
						optionflag = optionflag & cfg_oflag & "::" & cfg_oname & "::" & oname & "::" & oprice & "||"
						if cfg_oflag = 2 then ''기존 가격 변경
							price = oprice
						elseif cfg_oflag = 1 then ''옵션추가가격
							op_price = op_price + oprice
						end If
					End If
				next
			end if
			
			tprice = (price + op_price) * qty
		
		''	#데이타를 분석하여 (oid, pid, optionflag) 중복되면 qup를 그렇지 않으면 insert 를 실행한다.
			strSQL = "select count(*) from wizCart where oid='"&oid&"' and pid='"&pid&"' and optionflag='"&optionflag&"'"
			Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		
		
			if objRs(0) = 0 then
				strSQL = "insert into wizCart (oid,pid,user_id,qty,price,tprice,point,optionflag,ostatus,wdate)"
				strSQL = strSQL & " values "
				strSQL = strSQL & " ('"&oid&"','"&pid&"','"&user_id&"','"&qty&"','"&price&"','"&tprice&"','"&point&"','"&optionflag&"',0,getdate())"
				Call db.ExecSQL(strSQL, Nothing, DbConnect)
			end if
		End If''if pnone <> 0 Then
	end function

	
	Sub cart_view_pre(cartcode)
		''strSQL = "select sum(c.qty) from wizmall m left join wizcart c on m.UID = c.pid where c.oid = '"&cartcode&"'"
		strSQL = "select sum(c.qty) from wizcart c  where c.oid = '"&cartcode&"'"
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		TotalUnit = objRs(0)
		
		strSQL = "select m1.price as mprice, m1.pname, m1.uid, m1.picture, m1.category, m1.deliveryfee, c.uid as cuid, c.qty, c.price, c.tprice, c.point, c.optionflag "
		strSQL = strSQL & " from wizMall m1 left join wizMall m2 on m1.uid = m2.pid "
		strSQL = strSQL & " left join wizCart c on m2.uid = c.pid where c.oid = '" & cartcode & "' order by c.uid asc"
		''Response.Write( strSQL)
		Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
		summoney	= 0
		totalmoney	= 0
	End Sub
	
	Sub cart_view(objRs)
		
		Dim fnc_tprice
		''하기 변수들은 불러오기 전에 처리
    	p_picture			= split(objRs("picture"), "|")
		if Ubound(p_picture) > 1 Then p_picture_2 = p_picture(2)
		category		= objRs("category")
		uid				= objRs("uid")	
		cuid			= objRs("cuid")
		price			= objRs("price")
		fnc_tprice		= objRs("tprice")
		pname			= objRs("pname")	
		qty				= objRs("qty")
		deliveryfee		= objRs("deliveryfee")
		if isnull(deliveryfee) = true Then deliveryfee = 0
		
		opstr		= getOptionview(objRs("optionflag"))
		ordermoney	= objRs("price")

        summoney			= fnc_tprice * qty
		totalmoney			= totalmoney + summoney
		each_tackbae_money	= each_tackbae_money + deliveryfee
	End Sub
	
	''옵션필드에서 본 이름으로 분리해 낸다.
	function getOptionview(optionflag)
		dim i, j
		Dim fnc_op_field, fnc_op_field_sp, fnc_op_field_sp1, fnc_op_field_sp2, fnc_op_field_sp3
		Dim fnc_optionflag : fnc_optionflag	= optionflag
		Dim fnc_opstr
		''fnc_optionflag = cfg_oflag & "::" & cfg_oname & "::" & oname & "::" & oprice & "||"
		if isNull(fnc_optionflag) = FALSE and fnc_optionflag <> "" then
			fnc_op_field = split(fnc_optionflag, "||")
			For i = 0 To Ubound(fnc_op_field)
				fnc_op_field_sp = split(fnc_op_field(i), "::")
				if fnc_op_field(i) <> "" then
					For j=0 to Ubound(fnc_op_field_sp)
						if j = 1 then fnc_op_field_sp1 = fnc_op_field_sp(1)
						if j = 2 then fnc_op_field_sp2 = fnc_op_field_sp(2)
						if j = 3 then fnc_op_field_sp3 = fnc_op_field_sp(3)
					next
					fnc_opstr = fnc_opstr & "<br>" & fnc_op_field_sp1 & ":" & fnc_op_field_sp2 & "(" & fnc_op_field_sp3 & ")"
				end if
			next
		
		
		end if
		getOptionview = fnc_opstr
	end function
	
	
	'' 택배비용 구하기(택배관련 message)
	Function deliverfee_proc()
		Dim rtn_msg
		TACKBAE_CUTLINE	= util.convertnum(TACKBAE_CUTLINE)
		TACKBAE_MONEY	= util.convertnum(TACKBAE_MONEY)

		if totalmoney <> 0 then   ''장바구니가 담겼으면
			if totalmoney < TACKBAE_CUTLINE and TACKBAE_ALL = "ENABLE" then  ''택배비 적용
				rtn_msg = "<FONT COLOR='blue'>주문총액이 " & FormatNumber(totalmoney, 0) & "원 이하일 경우에는 " & FormatNumber(TACKBAE_MONEY, 0) & "원의 배송비가 합산되어집니다.</font>"
				totalmoney = totalmoney + TACKBAE_MONEY
			elseif TACKBAE_ALL = "PER" then ''제품당 택배비 적용
				rtn_msg = " 제품당 <FONT COLOR='#CE6500'>" & FormatNumber(TACKBAE_MONEY, 0) & "원의 배송비가 합산되어집니다.</font>"
				totalmoney = totalmoney + TACKBAE_MONEY
			elseif TACKBAE_ALL = "ALL" then ''금액에 상관없이 일괄적으로 배송비 적용
				rtn_msg = " <FONT COLOR='#CE6500'>" & FormatNumber(TACKBAE_MONEY, 0) & "원의 배송비가 합산되어집니다.</font><br>"
				totalmoney = totalmoney + TACKBAE_MONEY
			elseif TACKBAE_ALL = "each" then ''제품에 적용된 배송비 적용
				rtn_msg = " <FONT COLOR='#CE6500'>" & FormatNumber(each_tackbae_money, 0) & "원의 배송비가 합산되어집니다.</font><br>"
				totalmoney = totalmoney + each_tackbae_money				
			else 
				TACKBAE_MONEY = 0
			end if
		end if
		
		deliverfee_proc = rtn_msg
	End Function
	
	Sub update_cart_status(ostatus, oid)
			''기존 주문되지 않은 물품에 대해서는 삭제
		strSQL = "update wizCart set ostatus = '" & ostatus & "' where oid='"&oid&"'"
		''Response.Write(strSQL)
		Call db.ExecSQL(strSQL, Nothing, DbConnect)
	End Sub
	
End Class	
%>
