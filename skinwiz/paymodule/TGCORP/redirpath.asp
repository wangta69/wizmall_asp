<%@ Language = VBScript %>
<!-- #include file = "../../../lib/cfg.common.asp" -->
<%
    ''REDIRPATH 페이지는 결제가 완료되고, DBPATH 페이지의 결과 저장까지 완료된 후,
    ''결제 창을 종료하면 redirection 되는 구매자 결제정보 확인 페이지 입니다.

    ''아래와 같은 값이 GET 방식으로 전송됩니다. 자세한 설명은 매뉴얼을 참고바랍니다.
    
    MxIssueNO = Request("MxIssueNO")  '' 거래 번호 (결제 요청시 사용값)
    MxIssueDate = Request("MxIssueDate")  '' 거래 일시 (결제 요청시 사용값) 
    Amount = Request("Amount")  '' 거래 금액
    MSTR2 = Request("MSTR2")  '' 가맹점 return 값
    ReplyCode = Request("ReplyCode")  '' 결과 코드
    ReplyMessage = Request("ReplyMessage")  '' 결과 메시지
    Smode = Request("Smode")  '' 결제 수단 구분 코드
    CcCode = Request("CcCode")  '' 카드 코드 (신용카드인 경우)
    Installment = Request("Installment")  '' 할부 개월수 (신용카드인 경우)
    BkCode = Request("BkCode")  '' 은행코드 (뱅크타운 계좌이체인 경우)

    Sname = "신용카드" 
    if not isnull(Smode) then 
        if Smode="3001" or Smode="3005" or Smode="3007" then Sname = "신용카드"
        elseif Smode="2500" or Smode="2501" then Sname = "계좌이체"  ' 금결원
        elseif Smode="2201" or Smode="2401" then Sname = "계좌이체"  ' 핑거, 뱅크타운
        elseif Smode="6101" then Sname = "휴대폰결제"
        elseif Smode="8801" then Sname = "ARS전화결제"
        elseif Smode="2601" then Sname = "가상계좌"
        elseif Smode="5101" then Sname = "도서상품권"
        elseif Smode="5301" then Sname = "복합결제"
        elseif Smode="0001" then Sname = "현금영수증"
    end if 
	
	
%>
<%
'' db 처리는 이전단인 dbpath.asp에서 처리하고 이곳에서는 어느 페이지로 분기할지를 결정한다.
if not isnull(ReplyCode) and (ReplyCode="00003000" or (Smode="2601" and ReplyCode="00004000")) then 
'' ※ 가상계좌 발급성공 = "00004000"
		 Response.Write "<script>"
		 Response.Write "parent.location.replace('../../../wizbag.asp?smode=step4&codevalue='"&SESSION("CART_CODE")&"')"
		 Response.Write"</script>"
else
		 Response.Write "<script>"
		 Response.Write "parent.location.replace('../../../wizbag.asp?smode=step1')"
		 Response.Write "</script>"
end if
%>
<HTML>
<HEAD>
<TITLE>:::::TGCORP 결과 확인:::::</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=<%=cfg.Item("lan")%>"/>
<STYLE type="text/css">
    BODY { 
        scrollbar-3dlight-color:#888888;
        scrollbar-arrow-color:#888888;
        scrollbar-track-color:#FFFFFF;
        scrollbar-darkshadow-color:#888888;
        scrollbar-face-color:#FFFFFF;
        scrollbar-highlight-color:#FFFFFF;
        scrollbar-shadow-color:#FFFFFF
    }
    BODY { font-family:돋움; font-size:9pt;color:#000000; text-decoration:none;}
    TD { font-family:돋움; font-size:9pt;color:#000000; text-decoration:none;}
</STYLE>
</HEAD>
    
<BODY BGCOLOR="#FFFFFF" LEFTMARGIN="10" TOPMARGIN="10" MARGINWIDTH="0" MARGINHEIGHT="0">

<TABLE border="0" align="center" cellpadding="0" cellspacing="0">
<TR>
    <TD width=9 height=7 ><img src="http://npg.tgcorp.com/dlp/nondlp/cpguide/line_t_left.gif"></TD>
    <TD width="600" background="http://npg.tgcorp.com/dlp/nondlp/cpguide/line_t_center.gif"></TD>
    <TD><img src="http://npg.tgcorp.com/dlp/nondlp/cpguide/line_t_right.gif"></TD>
</TR>
<TR>
    <TD background="http://npg.tgcorp.com/dlp/nondlp/cpguide/line_m_left.gif"></TD>
    <TD bgcolor="#FFFFFF" align="center" width="600">
        <TABLE width="100%" align="center" border="0" cellspacing="0" cellpadding="0">
            <TR>
                <TD><img src="http://npg.tgcorp.com/dlp/nondlp/cpguide/top_banner.gif"></TD>
            </TR>
            <TR>
                <TD height="20">&nbsp;</TD>
            </TR>
            <TR>
                <TD bgcolor="#FFFFFF" align="center" valign="top">
                    <TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
                        <TR>
                            <TD align="right" height="30"><b>결제 요청 결과</b> (<%=Sname%>) : </TD>
                            <% if not isnull(ReplyCode) and (ReplyCode="00003000" or (Smode="2601" and ReplyCode="00004000")) then %>
                            <!-- ※ 가상계좌 발급성공 = "00004000" -->
                            <TD align="left" height="30">&nbsp;결제 성공했습니다.</TD>
                            <% else %>
                            <TD align="left" height="30">&nbsp;결제 실패했습니다.</TD>
                            <% end if %>
                        </TR>
                    </TABLE>
                </TD>
            </TR>
            <TR>
                <TD height="20">&nbsp;</TD>
            </TR>
            <TR>
                <TD width="100%" bgcolor="#FFFFFF" align="center" valign="top">
                    <TABLE align="center" border="0" cellspacing="0" cellpadding="0">
                        <TR>
                            <TD width="20"><TD>
                            <TD width="560">
                                <TABLE align="center" border="0" cellspacing="0" cellpadding="0">
                                    <TR>
                                        <TD width="7" height="7"><img src="http://npg.tgcorp.com/dlp/nondlp/cpguide/inline_t_left.gif"></TD>
                                        <TD width="546" background="http://npg.tgcorp.com/dlp/nondlp/cpguide/inline_t_center.gif"></TD>
                                        <TD width="7" height="7"><img src="http://npg.tgcorp.com/dlp/nondlp/cpguide/inline_t_right.gif"></TD>
                                    </TR>
                                    <TR>
                                        <TD background="http://npg.tgcorp.com/dlp/nondlp/cpguide/inline_m_left.gif"></TD>
                                        <TD width="546" align="center">
                                            <!--결제 내역-->
                                            <TABLE width="100%" align="center" border="0" cellspacing="0" cellpadding="0">
                                                <TR> 
                                                    <TD colspan="2" align="center" height="30" bgcolor="#F7D9FF">
                                                    <IMG ALIGN="absmiddle" SRC="http://npg.tgcorp.com/dlp/nondlp/cpguide/icon_member_02.gif">
                                                    <FONT style="color:black;">&nbsp;결제 정보 확인</FONT>
                                                    </TD>
                                                </TR>
                                                <TR>
                                                    <TD width="45%" align="right" height="20">거래번호 : </TD>
                                                    <TD width="55%" align="left" height="20">&nbsp;<% if not isnull(MxIssueNO) then response.write(MxIssueNO) end if %></TD>
                                                </TR>
                                                <TR><TD height="1" colspan="2" background="http://npg.tgcorp.com/dlp/nondlp/cpguide/bg_dot.gif"></TD></TR>
                                                <TR>
                                                    <TD width="45%" align="right" height="20">거래일자 : </TD>
                                                    <TD width="55%" align="left" height="20">&nbsp<% if not isnull(MxIssueDate) then response.write(MxIssueDate) end if %></TD>
                                                </TR>
                                                <TR><TD height="1" colspan="2" background="http://npg.tgcorp.com/dlp/nondlp/cpguide/bg_dot.gif"></TD></TR>
                                                <TR>
                                                    <TD width="45%" align="right" height="20">결제금액 : </TD>
                                                    <TD width="55%" align="left" height="20">&nbsp;<% if not isnull(Amount) then response.write(Amount) end if %> 원</TD>
                                                </TR>
                                                <TR><TD height="1" colspan="2" background="http://npg.tgcorp.com/dlp/nondlp/cpguide/bg_dot.gif"></TD></TR>
                                                <TR>
                                                    <TD width="45%" align="right" height="20">결과코드 : </TD>
                                                    <TD width="55%" align="left" height="20">&nbsp;<% if not isnull(ReplyCode) then response.write(ReplyCode) end if %></TD>
                                                </TR>
                                                <TR><TD height="1" colspan="2" background="http://npg.tgcorp.com/dlp/nondlp/cpguide/bg_dot.gif"></TD></TR>
                                                <TR>
                                                    <TD width="45%" align="right" height="20">결과메시지 : </TD>
                                                    <TD width="55%" align="left" height="20">&nbsp;<% if not isnull(ReplyMessage) then response.write(ReplyMessage) end if %></TD>
                                                </TR>
                                            </TABLE>
                                        </TD>
                                        <!--결제 내역 끝-->
                                        <TD background="http://npg.tgcorp.com/dlp/nondlp/cpguide/inline_m_right.gif"></TD>
                                    </TR>
                                    <TR>
                                        <TD width="7" height="7"><img src="http://npg.tgcorp.com/dlp/nondlp/cpguide/inline_b_left.gif"></TD>
                                        <TD background="http://npg.tgcorp.com/dlp/nondlp/cpguide/inline_b_center.gif"></TD>
                                        <TD width="7" height="7"><img src="http://npg.tgcorp.com/dlp/nondlp/cpguide/inline_b_right.gif"></TD>
                                    </TR>
                                </TABLE>
                            </TD>
                            <TD width="20">&nbsp;</TD>
                        </TR>
                    </TABLE>
                </TD>
            </TR>
            <TR><TD>&nbsp;</TD></TR>
            <TR>
                <TD height="46" align="center" valign="middle">
                <a href="index.html"><img src="http://npg.tgcorp.com/dlp/nondlp/cpguide/btn_payresult.gif" border="0"></a>
                </TD>
            </TR>
            <TR><TD>&nbsp;</TD></TR>
            <TR>
                <TD><img src="http://npg.tgcorp.com/dlp/nondlp/cpguide/allright.gif"></TD>
            </TR>
        </TABLE>
    </TD>
    <TD background="http://npg.tgcorp.com/dlp/nondlp/cpguide/line_m_right.gif"></TD>
</TR>
<TR>
    <TD width=9 height=10><img src="http://npg.tgcorp.com/dlp/nondlp/cpguide/line_b_left.gif"></TD>
    <TD background="http://npg.tgcorp.com/dlp/nondlp/cpguide/line_b_center.gif"></TD>
    <TD><img src="http://npg.tgcorp.com/dlp/nondlp/cpguide/line_b_right.gif"></TD>
</TR>
</TABLE>
</BODY>
</HTML>
