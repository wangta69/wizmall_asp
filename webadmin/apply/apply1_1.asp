<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

Dim uid
uid = Request("uid")
%>
<!--
powered by 폰돌
Reference URL : http://www.shop-wiz.com
Contact Email : master@shop-wiz.com
Free Distributer : 
Copyright shop-wiz.com
*** Updating list ***
-->
<%
' 상세보기 페이지의 정보를 가지고 옮
strSQL = "select * from wizapply where uid = '" & uid & "'"
'Response.Write(strSQL)
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
birthday = split(objRs("birthday"), "/")
body = split(objRs("body"), "|")
family = split(objRs("family"), "|")

'if objRs("zip") then zipcode = split(objRs("zip"), "-")
'tel1 = split(objRs("tel1"), "-")
'tel2 = split(objRs("tel2"), "-")
'email = split(objRs("email"), "@")
%>
<HTML>

<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<TITLE>회원정보수정</TITLE>
<link rel="stylesheet" href="style.css" type="text/css">
<link href="../main.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
<!--
function MemberCheckField(){
var f=document.FrmUserInfo;
return true;
}
//-->
</script>

</HEAD>
<BODY BGCOLOR='WHITE' LEFTMARGIN='0' TOPMARGIN='0' MARGINWIDTH='0' MARGINHEIGHT='0'>
<div ALIGN=CENTER> 
  <FORM ACTION='./member1_1.asp' method=post name="FrmUserInfo">
    <input type=hidden name="query" value="qup">
    <table width="670" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><img src="../img/t_01.gif" width="670" height="30"></td>
              </tr>
              <tr> 
                <td background="../img/t_02.gif"> 
			
				<table width="610" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td><div align="justify"> </div></td>
                    </tr>
                  </table>
                  <table width="610" border="0" align="center" cellpadding="0" cellspacing="0" background="../member/image/t01.gif">
                    <tr> 
                      <td width="100" height="31"><div align="center"><font color="#FFFFFF">지원반명</div></td>
                      <td width="10">&nbsp;</td>
                      <td><div align="left"> 
                            <%=objRs("flag1")%>
                          </div></td>
                    </tr>
                  </table>
                  <table width="610" border="0" align="center" cellpadding="0" cellspacing="0" background="../member/image/t01.gif">
                    <tr> 
                      <td width="100" height="31"><div align="center"><font color="#FFFFFF">이름</div></td>
                      <td width="10">&nbsp;</td>
                      <td><div align="left"> 
                          <%=objRs("name")%>
                        </div></td>
                    </tr>
                  </table>
                  <table width="610" border="0" align="center" cellpadding="0" cellspacing="0" background="../member/image/t01.gif">
                    <tr> 
                      <td width="100" height="31"><div align="center"><font color="#FFFFFF">주민등록번호</div></td>
                      <td width="10">&nbsp;</td>
                      <td><div align="left"> 
                          <%=objRs("jumin1")%>
                          - 
                          <%=objRs("jumin2")%> <br />
                        </div></td>
                    </tr>
                  </table>
                  <table width="610" border="0" align="center" cellpadding="0" cellspacing="0" background="../member/image/t01.gif">
                    <tr> 
                      <td width="100" height="31"><div align="center"><font color="#FFFFFF">성별</div></td>
                      <td width="10">&nbsp;</td>
                      <td><div align="left"> 
<%
if objRs("gender") = 1 then
	Response.Write("남")
else 
	Response.Write("여")
end if
%></div></td>
                    </tr>
                  </table>
                  <table width="610" border="0" align="center" cellpadding="0" cellspacing="0" background="../member/image/t01.gif">
                    <tr> 
                      <td width="100" height="31"><div align="center"><font color="#FFFFFF">생년월일</div></td>
                      <td width="12">&nbsp;</td>
                      <td width="498"><div align="left"> 
                         <%=birthday(0)%>
                          년 
                          <%=birthday(1)%>
                          월 
                         <%=birthday(2)%>
                          일
<%
if objRs("birthtype") = 0 then
	Response.Write("양")
else 
	Response.Write("음")
end if
%>						   
</div></td>
                    </tr>
                  </table>
                  <table width="610" border="0" align="center" cellpadding="0" cellspacing="0" background="../member/image/t01.gif">
                    <tr> 
                      <td width="100" height="31"><div align="center"><font color="#FFFFFF">우편번호</div></td>
                      <td width="10">&nbsp;</td>
                      <td><div align="left"> 
<%=objRs("zip")%></div></td>
                    </tr>
                  </table>
                  <table width="610" border="0" align="center" cellpadding="0" cellspacing="0" background="../member/image/t01.gif">
                    <tr> 
                      <td width="100" height="31"><div align="center"><font color="#FFFFFF">주소</div></td>
                      <td width="10">&nbsp;</td>
                      <td><div align="left"> <%=objRs("address1")%> <br />
                        </div></td>
                    </tr>
                  </table>
                  <table width="610" border="0" align="center" cellpadding="0" cellspacing="0" background="../member/image/t02.gif">
                    <tr> 
                      <td width="100" height="25"><div align="center"></div></td>
                      <td width="10">&nbsp;</td>
                      <td valign="top"><div align="left"> <%=objRs("address2")%> <br />
                        </div></td>
                    </tr>
                  </table>
                  <table width="610" border="0" align="center" cellpadding="0" cellspacing="0" background="../member/image/t01.gif">
                    <tr> 
                      <td width="100" height="31"><div align="center"><font color="#FFFFFF">전화번호</div></td>
                      <td width="10">&nbsp;</td>
                      <td><div align="left"> 
                          <%=objRs("tel1")%></div></td>
                    </tr>
                  </table>
                  <table width="610" border="0" align="center" cellpadding="0" cellspacing="0" background="../member/image/t01.gif">
                    <tr> 
                      <td width="100" height="31"><div align="center"><font color="#FFFFFF">핸드폰번호</div></td>
                      <td width="10">&nbsp;</td>
                      <td><div align="left"> 
                          <%=objRs("tel2")%></div></td>
                    </tr>
                  </table>
                  <table width="610" border="0" align="center" cellpadding="0" cellspacing="0" background="../member/image/t01.gif">
                    <tr> 
                      <td width="100" height="31"><div align="center"><font color="#FFFFFF">이메일</div></td>
                      <td width="10">&nbsp;</td>
                      <td><div align="left"> 
<%=objRs("email")%>
                          - 관련메일 수신여부&nbsp; 
<%
if objRs("mailreceive") = 1 then
	Response.Write("수신")
else 
	Response.Write("수신거부")
end if
%>
                </div></td>
                    </tr>
                  </table>
                  <table width="610" height="1" border="0" align="center" cellpadding="0" cellspacing="0" background="../member/image/t01.gif">
                    <tr> 
                      <td width="90"></td>
                      <td></td>
                    </tr>
                  </table>
                  <table width="610" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td><div align="justify"><img src="../img/line.gif" width="610" height="40"> 
                          </div></td>
                    </tr>
                  </table>
                  <table width="610" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td><div align="justify"><img src="../member/image/t08.gif" width="274" height="14"> 
                          <table width="50" height="10" border="0" cellpadding="0" cellspacing="0">
                            <tr> 
                              <td></td>
                            </tr>
                          </table>
                        </div></td>
                    </tr>
                  </table>
                  <table width="610" border="0" align="center" cellpadding="0" cellspacing="0" background="../member/image/t01.gif">
                    <tr> 
                      <td width="100" height="31"><div align="center"><font color="#FFFFFF">학년</div></td>
                      <td width="10">&nbsp;</td>
                      <td><div align="left"> 
<%=objRs("school_level")%>					  
                        </div></td>
                    </tr>
                  </table>
                  <table width="610" border="0" align="center" cellpadding="0" cellspacing="0" background="../member/image/t01.gif">
                    <tr> 
                      <td width="100" height="31"><div align="center"><font color="#FFFFFF">학교명</div></td>
                      <td width="10">&nbsp;</td>
                      <td><div align="left"> 
<%=objRs("school_name")%>
                        </div></td>
                    </tr>
                  </table>
                  <table width="610" border="0" align="center" cellpadding="0" cellspacing="0" background="../member/image/t01.gif">
                    <tr> 
                      <td width="100" height="31"><div align="center"><font color="#FFFFFF">신체</div></td>
                      <td width="10">&nbsp;</td>
                      <td><div align="left"> 
                          <%=body(0)%>
                            <font color="#666666">c<font color="#666666">m 
                            <%=body(1)%>
                          kg</div></td>
                    </tr>
                  </table>
                  <table width="610" border="0" align="center" cellpadding="0" cellspacing="0" background="../member/image/t01.gif">
                    <tr> 
                      <td width="100" height="31"><div align="center"><font color="#FFFFFF">가족상</div></td>
                      <td width="10">&nbsp;</td>
                      <td><div align="left"> 
                          <%=family(0)%>
                            <font color="#666666">남
                            <%=family(1)%>
                            녀중 
                           <%=family(2)%>
                            째</div></td>
                    </tr>
                  </table>
                  <table width="610" border="0" align="center" cellpadding="0" cellspacing="0" background="../member/image/t01.gif">
                    <tr> 
                      <td width="100" height="31"><div align="center"><font color="#FFFFFF">보호자 
                          성명 </div></td>
                      <td width="10">&nbsp;</td>
                      <td><div align="left"> 
                         <%=objRs("parents")%>
                        </div></td>
                    </tr>
                  </table>
                  <table width="610" height="1" border="0" align="center" cellpadding="0" cellspacing="0" background="../member/image/t01.gif">
                    <tr> 
                      <td width="90"></td>
                      <td></td>
                    </tr>
                  </table>
                  <table width="610" border="0" align="center" cellpadding="0" cellspacing="0" background="../member/image/t10.gif">
                    <tr> 
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr> 
                      <td width="100"><div align="center"><font color="#FFFFFF">특기(자세히기록)</div></td>
                      <td width="10">&nbsp;</td>
                      <td><div align="left"><font color="#666666"> 
                          <%=objRs("goodspoints")%>
                          </div></td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                  </table>
                  <table width="610" border="0" align="center" cellpadding="0" cellspacing="0" background="../member/image/t01.gif">
                    <tr> 
                      <td width="100" height="31"><div align="center"><font color="#FFFFFF">연기경험유뮤</div></td>
                      <td width="10">&nbsp;</td>
                      <td><div align="left"> 
<%
if objRs("actor_exp") = 1 then
	Response.Write("유")
else 
	Response.Write("무")
end if
%>
                </div></td>
                    </tr>
                  </table>
                  <table width="610" height="1" border="0" align="center" cellpadding="0" cellspacing="0" background="../member/image/t01.gif">
                    <tr> 
                      <td width="90"></td>
                      <td></td>
                    </tr>
                  </table>
                  <table width="610" border="0" align="center" cellpadding="0" cellspacing="0" background="../member/image/t10.gif">
                    <tr> 
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr> 
                      <td width="100"><div align="center"><font color="#FFFFFF">자기소개</div></td>
                      <td width="10">&nbsp;</td>
                      <td><div align="left"><font color="#666666"> 
                          <%=objRs("biology")%>
                          </div></td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                  </table>
                  <table width="610" height="1" border="0" align="center" cellpadding="0" cellspacing="0" background="../member/image/t01.gif">
                    <tr> 
                      <td width="90"></td>
                      <td></td>
                    </tr>
                  </table>
                  
        </td>
              </tr>
              <tr> 
                <td><img src="../img/t_03.gif" width="670" height="30"></td>
              </tr>
            </table>
    <br /><!--
    <table cellspacing=0  width="600" border=0 class="s1" cellpadding="0">
      <tr> 
        <td colspan="2" align="center"><input type="image" src="img/su.gif" width="53" height="20" border="0" > 
          &nbsp; <img src="img/order_icon3.gif" width="66" height="20" border="0" onclick="window.print()"> 
          &nbsp; <img src="img/order_icon4.gif" width="66" height="20" border="0"  onclick='javascript:top.close();'> 
        </td>
      </tr>
    </table> -->
  </FORM>
</DIV>
</BODY>
</HTML>
