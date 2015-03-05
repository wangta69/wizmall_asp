<!-- #include file = "md5.asp" -->
<!-- #include file = "../../../config/db_connect.asp" -->
<!-- #include file = "../../../config/cart_info.asp" -->
<!-- #include file = "../../../lib/class.database.asp" -->
<!-- #include file = "../../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database
%>
<%
    ''DBPATH 페이지는 결제가 완료되면, 결과를 전송 받아서 주문 DB에 저장 합니다.
    ''결제 완료와 동시에 DBPATH로 결과를 전송하고, DBPATH로 부터 return 메시지가
    ''확인이 되면, 결제 진행 중이던 결제 창은 최종 결제 완료 페이지를 출력합니다.
    ''따라서, DBPATH가 비 정상적인 경우에는 결제 지연의 원인이 될 수 있습니다.

    ''아래와 같은 값이 POST 방식으로 전송됩니다. 자세한 설명은 매뉴얼을 참고바랍니다.

    MxIssueNO = Request("MxIssueNO")  '' 거래 번호 (결제 요청시 사용값)
    MxIssueDate = Request("MxIssueDate")  '' 거래 일시 (결제 요청시 사용값) 
    Amount = Request("Amount")  '' 거래 금액
    MSTR = Request("MSTR")  '' 가맹점 return 값
    ReplyCode = Request("ReplyCode")  '' 결과 코드
    ReplyMessage = Request("ReplyMessage")  '' 결과 메시지
    Smode = Request("Smode")  '' 결제 수단 구분 코드
    CcCode = Request("CcCode")  '' 카드 코드 (신용카드인 경우)
    Installment = Request("Installment")  '' 할부 개월수 (신용카드인 경우)
    BkCode = Request("BkCode")  '' 은행코드 (뱅크타운 계좌이체인 경우)
    MxHASH = Request("MxHASH")  '' 결과 검증값(데이터 조작 여부 확인)

    Sname = "신용카드" 
    if not isnull(Smode) then 
        if Smode="3001" or Smode="3005" or Smode="3007" then Sname = "신용카드"
        elseif Smode="2500" or Smode="2501" then Sname = "계좌이체"  '' 금결원
        elseif Smode="2201" or Smode="2401" then Sname = "계좌이체"  '' 핑거, 뱅크타운
        elseif Smode="6101" then Sname = "휴대폰결제"
        elseif Smode="8801" then Sname = "ARS전화결제"
        elseif Smode="2601" then Sname = "가상계좌"
        elseif Smode="5101" then Sname = "도서상품권"
        elseif Smode="5301" then Sname = "복합결제"
        elseif Smode="0001" then Sname = "현금영수증"
    end if   

    ''결제 정보의 위/변조 여부를 확인하기 위해,
    ''주요 결제 정보를 MD5 암호화 알고리즘으로 HASH 처리한 MxHASH 값을 받아
    ''동일한 규칙으로 DBPATH에서 생성한 값(output)과 비교합니다.

   '' mxid1 = "testcorp"  '' 가맹점 ID (고정 값)  
   mxid1 = CARD_ID
    ''mxotp1 = "wr7yZ2OayGjj3eDo2XbA1jipf6S45ubp"  '' 접근키 (고정 값)
	mxotp1 = CARD_PASS
    currency1 = "KRW"  '' 화폐코드 (고정 값) 
    mxissueno1 = MxIssueNO  '' 거래 번호 (결과로 전송받은 값)
    mxissuedate1 = MxIssueDate  '' 거래 일시 (결과로 전송받은 값)
    amount1 = ""   '' 가맹점 주문 DB에 기록되어 있는 거래금액

    ''반드시 가맹점 주문 DB에서 거래금액(amount) 값을 가져와야 합니다.
    ''예) query = "select amount01 from 주문테이블 where 거래번호='"+MxIssueNO+"', and 거래일시='"+MxIssueDate
	strSQL = "select paymoney from wizbuyer where codevalue='"&SESSION("CART_CODE")&"'"
	Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
	amount1 = objRs("paymoney")
    ''    amount = amount01

    ''MD5 알고리즘을 이용한 HASH 값 생성

    output = md5(mxid1 & mxotp1 & mxissueno1 & mxissuedate1 & amount1 & currency1)

    isOK = "0"
    returnMsg = "ACK=400FAIL"

    ''MxHASH 값과 output 생성 값을 비교해서 일치하는 경우에만 결과 저장
    
    if not isnull(MxHASH) and MxHASH=output then  '' 일치하는 경우
		if ReplyCode = "00003000" or (Smode="2601" and ReplyCode="00004000") then  
            ''결제 성공이거나, 가상계좌("2601") 발급성공 = "00004000"
            ''이 부분에서 주문 DB에 결과를 저장하는 소스 코딩 필요
            ''예) isOK = (DB 업데이트 결과)
			strSQL = "update wizbuyer set processing = '2', pay_date=getdate() where codevalue='"&SESSION("CART_CODE")&"'"
			Call db.ExecSQL(strSQL, Nothing, DbConnect)
            ''returnMsg = "ACK=400FAIL"					'' DB 저장 실패이면
            ''if isOK="1" then returnMsg = "ACK=200OKOK"	'' DB 저장 성공이면
			returnMsg = "ACK=200OKOK"	'' DB 저장 성공이면
        else  
            '' 결제 실패인 경우
            ''이 부분에서 주문 DB에 결과를 저장하는 소스 코딩 필요
            ''예) isOK = (DB 업데이트 결과)

            ''returnMsg = "ACK=400FAIL"					'' DB 저장 실패이면
           ''if isOK="1" then returnMsg = "ACK=200OKOK"	'' DB 저장 성공이면
		   returnMsg = "ACK=200OKOK"	'' DB 저장 성공이면
        end if
    else
        returnMsg = "ACK=400FAIL"  '' 결제 정보가 일치하지 않는 경우 : 데이타 조작의 가능성이 있으므로, 결제 취소
    end if
%>

<%=returnMsg%> <% //return 메시지('ACK=200OKOK' or 'ACK=400FAIL')를 출력해야 정상 처리됩니다. %>
