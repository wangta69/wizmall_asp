<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../../config/skin_info.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/mall_config.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<%
''제작자 : 폰돌
''제작자 URL : http://www.shop-wiz.com
''제작자 Email : master@shop-wiz.com
''Free Distributer 

''*** Updating List ***
Dim strSQL,objRs
Dim db,util
Set util = new utility	
Set db = new database

if session("user_info") = "" then Call util.js_alert("먼저 로그인해 주세요.","")

keyword			=  Request("keyword")
where			=  Request("where")
page			=  Request("page") : If page = "" then page = 1
setPageSize		= 10
setSubjectCut	= 20
setPageLink		= 10

whereis = " where id = '"&user_id&"'"

	strSQL = "SELECT COUNT(uid) FROM wizpoint b "& whereis & " "
	Set objRs = db.ExecSQLReturnRs(strSQL, Nothing, DbConnect)
'' 전체 게시물 및 전체 페이지

	

	TotalCount = objRs(0)
	TotalPage = TotalCount / setPageSize
	IF (TotalPage - (TotalCount \ setPageSize)) > 0 then
		TotalPage = int(TotalPage) + 1
	Else
		TotalPage = int(TotalPage)
	End if

'' 루프 기본 변수
	Dim LoopCount, intNotice, intIndexSize
	LoopCount = 0
	read_uid = uid
%>
<!--
CREATE TABLE [yeon].[wizPoint](
	[uid] [int] IDENTITY(1,1) NOT NULL,
	[id] [varchar](20) COLLATE Korean_Wansung_CI_AS NULL,
	[content] [varchar](100) COLLATE Korean_Wansung_CI_AS NULL,
	[point] [int] NULL,
	[flag] [int] NULL,
	[wdate] [datetime] NULL,
) 
-->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="100%" height="18" border="0" cellpasdding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
        <tr bgcolor="#F6F6F6">
          <td width="15" height="22">&nbsp;</td>
          <td width="18" height="22" valign="middle"><img src="wizmember/<%=MemberSkin%>/images/sn_arrow.gif" width="13" height="13"></td>
          <td height="22">Home &gt; <strong>적립금 보기</strong></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td align="center"><br>
    </td>
  </tr>
  <tr>
    <td><TABLE WIDTH='95%' CELLSPACING=0 CELLPADDING=0 BORDER=0 style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
        <TR>
          <TD HEIGHT='71' ALIGN=RIGHT valign="bottom"><B><%=user_name%>(<%=user_id%>)</B>님의 
            포인트내역입니다.</TD>
        </TR>
      </TABLE></td>
  </tr>
  <tr>
    <td align="center"><table width="95%" border="0" cellpadding="0" cellspacing="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
        <tr align=center bgcolor="#F5F5F5">
          <td width="30" height="25">번호</td>
          <td>적립내역</td>
          <td>지급량</td>
          <td width="90">지급일</td>
        </tr>
        <%
strSQL = "EXEC getPointList  """&page&""", """&setPageSize&""", ""uid, id, content, point,flag,wdate"",""uid"", ""id='" & user_id & "'"", ""uid desc"""
set objRs = db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
cnt = 0
while not objRs.eof
cnt = cnt+1
ListNum = INT(TotalCount)-(INT(setPageSize)*(INT(page)-1)) - cnt + 1

uid 	= objRs("uid")
id 		= objRs("id")
content = objRs("content")
point 	= objRs("point")
flag 	= objRs("flag")
wdate 	= objRs("wdate")
%>
        <TR ALIGN=CENTER HEIGHT=25>
          <TD WIDTH=30 height="25"><B> <%=BOARD_NO%> </B></TD>
          <TD height="25" bgcolor="WHITE"><FONT COLOR=BROWN>&nbsp; <%=content%> </FONT></TD>
          <TD height="25" bgcolor="WHITE"><%=point%> </TD>
          <TD width="90" ALIGN=center><font color=BROWN> <%=wdate%> </font><font color=RED><b> </b></font></TD>
        </TR>
        <%

objRs.movenext
wend
if cnt = 0 then
%>
        <TR ALIGN=CENTER HEIGHT=25>
          <TD height="25" colspan="4">지급된 포인트가 없습니다.&nbsp; </TD>
        </TR>
<%
end if
%>
       <!-- <TR ALIGN=CENTER HEIGHT=40>
          <TD height="40" colspan=5 bgcolor="WHITE"><B>현재페이지 포인트 : <FONT COLOR=BLUE>
            <%''=FormatNumber(SUB_SMONEY, 0)%>
            </FONT> 포인트 | 총 획득 포인트 : <FONT COLOR=RED>
            <%''=FormatNumber(totalpoint,0)%>
            </FONT> 포인트</B> </TD>
        </TR>-->
      </TABLE>
      <table width="95%" border="0" cellpadding="0" cellspacing="0">
        <TR>
          <TD WIDTH=50></TD>
          <TD ALIGN=CENTER><%
Dim TransDate
TransData = "&theme="&theme&"&menushow=" & menushow & "&WHERE=" & WHERE & "&keyword=" & keyword
%>
            <table width="155" height="30" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td align="center"><%
	IntStart = INT((((page - 1) \ setPageLink)) * setPageLink + 1)
	IntEnd = INT(((((page - 1) + setPageLink) \ setPageLink)) * setPageLink)
	
	
	
	IF INT(TotalPage) < intEnd THEN IntEnd = TotalPage
		IF INT(page) > INT(setPageLink) THEN
			RESPONSE.WRITE "<a href='main.asp?page=" & int(page - setPageLink) & TransData & "'><img src='wizmember/"&MemberSkin&"/img_order/pre.gif' width='17' height='19'>"
			RESPONSE.WRITE "<a href='main.asp?page=1" & TransData & "'></a>.. &nbsp;"
		END IF
%>
                </td>
                <td align="center"><%


		FOR I = IntStart TO IntEnd 
			IF I = IntStart THEN
				'TMPSPLIT = ""
			ELSE 
				'TMPSPLIT = "/"
			END IF 
			
			IF INT(I) = INT(page) THEN
				RESPONSE.WRITE "&nbsp;<b>"&i&"</b>&nbsp;"
			ELSE
				RESPONSE.WRITE "<a href='main.asp?page=" & I & TransData & "'>&nbsp;"& I & "&nbsp;</a>"
			END IF
		NEXT
%></td>
                <td align="center"><%
		IF INT(TotalPage - IntStart + 1) > INT(setPageLink) THEN RESPONSE.WRITE "<a href='main.asp?page=" & TotalPage & TransData & "'></a>"

		IF INT(page) + setPageLink > TotalPage + 1 THEN
		ELSEIF INT(page) + setPageLink < TotalPage + 1 THEN
			RESPONSE.WRITE "<a href='main.asp?page=" & INT(page + setPageLink) & TransData & "'><img src='wizmember/"&MemberSkin&"/img_order/next.gif' width='17' height='19' border='0'>"
		END IF
%>
                </td>
              </tr>
            </table>
            </TD>
          <TD WIDTH=50 align=right></TD>
        </TR>
      </TABLE></td>
  </tr>
</table>
