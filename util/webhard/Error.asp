<%@ Language="VBScript" EnableSessionState="True"%>
<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=<%=cfg.Item("lan")%>">
<title>잘못된 접근 / 로그인한 후 다시 이용해 주세요</title>
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
<p style='padding-left:30px;font-size:9pt;'><font color=blue>다음은 사용자 님께서 요청하신 정보와 사용자의 정보입니다.
<br>로그인이 되지 않았거나 시간이 오래동안지나서 서버에서 인증된 사용자로 판단할 수 없습니다.
<br>다시 로긴하셔야 합니다.</font>
<br>
<p>
<span style="font-size:9pt;"><br><b>쿠키</b><font color="gray">(Cookies 객체)</font></span><br>
<table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#CCCCCC">
    <tr>
        <td width="30%" bgcolor="#EBEBEB">
            <p align="center"><span style="font-size:9pt;">Key</span></p>
        </td>
        <td width="70%" bgcolor="#EBEBEB">
            <p align="center"><span style="font-size:9pt;">Value</span></p>
        </td>
    </tr>
<% For Each key in Request.Cookies %>
    <tr>
        <td width="30%" bgcolor="black">
            <p align="center"><span style="font-size:9pt;"><font color="white"><%=key%></font></span></p>
        </td>
        <td width="70%" bgcolor="white">
            <p><span style="font-size:9pt;">&nbsp;<% if Request.cookies(key) = "" Then %>&nbsp;<% else %><%=Request.cookies(key)%><% end if %></span></p>
        </td>
    </tr>
<% Next %>
</table>
<span style="font-size:9pt;"><br><b>세션</b><font color="gray">(Session 객체, EnableSessionState="True")</font></span><br>
<table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#CCCCCC">
    <tr>
        <td width="30%" bgcolor="#EBEBEB">
            <p align="center"><span style="font-size:9pt;">Key</span></p>
        </td>
        <td width="70%" bgcolor="#EBEBEB">
            <p align="center"><span style="font-size:9pt;">Value</span></p>
        </td>
    </tr>
    <tr>
        <td width="30%" bgcolor="black">
            <p align="center"><span style="font-size:9pt;"><font color="white">Session.SessionID</font></span></p>
        </td>
        <td width="70%" bgcolor="white">
            <p><span style="font-size:9pt;">&nbsp;<%=Session.SessionID%></span></p>
        </td>
    </tr>
    <tr>
        <td width="30%" bgcolor="black">
            <p align="center"><span style="font-size:9pt;"><font color="white">Session.CodePage</font></span></p>
        </td>
        <td width="70%" bgcolor="white">
            <p><span style="font-size:9pt;">&nbsp;<%=Session.CodePage%>&nbsp;<font color="gray">(949가 한글페이지)</font></span></p>
        </td>
    </tr>
    <tr>
        <td width="30%" bgcolor="black">
            <p align="center"><span style="font-size:9pt;"><font color="white">Session.Timeout</font></span></p>
        </td>
        <td width="70%" bgcolor="white">
            <p><span style="font-size:9pt;">&nbsp;<%=Session.Timeout%>&nbsp;<font color="gray">(단위:분)</font></span></p>
        </td>
    </tr>
<% For Each key in Session.Contents %>
    <tr>
        <td width="30%" bgcolor="black">
            <p align="center"><span style="font-size:9pt;"><font color="white"><%=key%></font></span></p>
        </td>
        <td width="70%" bgcolor="white">
            <p><span style="font-size:9pt;">&nbsp;<% if Session(key) = "" Then %>&nbsp;<% else %><%=Session(key)%><% end if %></span></p>
        </td>
    </tr>
<% Next %>
</table>
<span style="font-size:9pt;"><br><b>폼</b><font color="gray">(Request.Form() : FORM방식으로 받은 값)</font></span><br>
<table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#CCCCCC">
    <tr>
        <td width="30%" bgcolor="#EBEBEB">
            <p align="center"><span style="font-size:9pt;">Key</span></p>
        </td>
        <td width="70%" bgcolor="#EBEBEB">
            <p align="center"><span style="font-size:9pt;">Value</span></p>
        </td>
    </tr>
<% For Each key in Request.Form %>
    <tr>
        <td width="30%" bgcolor="black">
            <p align="center"><span style="font-size:9pt;"><font color="white"><%=key%></font></span></p>
        </td>
        <td width="70%" bgcolor="white">
            <p><span style="font-size:9pt;">&nbsp;<% if Request.Form(key) = "" Then %>&nbsp;<% else %><%=Request.Form(key)%><% end if %></span></p>
        </td>
    </tr>
<% Next %>
</table>
<span style="font-size:9pt;"><br><b>쿼리</b><font color="gray">(Request.QueryString() : GET방식으로 받은 값)</font></span><br>
<table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#CCCCCC">
    <tr>
        <td width="30%" bgcolor="#EBEBEB">
            <p align="center"><span style="font-size:9pt;">Key</span></p>
        </td>
        <td width="70%" bgcolor="#EBEBEB">
            <p align="center"><span style="font-size:9pt;">Value</span></p>
        </td>
    </tr>
<% For Each key in Request.QueryString %>
    <tr>
        <td width="30%" bgcolor="black">
            <p align="center"><span style="font-size:9pt;"><font color="white"><%=key%></font></span></p>
        </td>
        <td width="70%" bgcolor="white">
            <p><span style="font-size:9pt;">&nbsp;<% if Request.QueryString(key) = "" Then %>&nbsp;<% else %><%=Request.QueryString(key)%><% end if %></span></p>
        </td>
    </tr>
<% Next %>
</table>
<span style="font-size:9pt;"><br><b>서버</b><font color="gray">(Server 객체)</font></span><br>
<table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#CCCCCC">
    <tr>
        <td width="30%" bgcolor="#EBEBEB">
            <p align="center"><span style="font-size:9pt;">Key</span></p>
        </td>
        <td width="70%" bgcolor="#EBEBEB">
            <p align="center"><span style="font-size:9pt;">Value</span></p>
        </td>
    </tr>
    <tr>
        <td width="30%" bgcolor="black">
            <p align="center"><span style="font-size:9pt;"><font color="white">Server.ScriptTimeout</font></span></p>
        </td>
        <td width="70%" bgcolor="white">
            <p><span style="font-size:9pt;">&nbsp;<%=Server.ScriptTimeout%>&nbsp;<font color="gray">(단위:초)</font></span></p>
        </td>
    </tr>
</table>
<span style="font-size:9pt;"><br><b>서버변수</b><font color="gray">(ServerVariables 객체)</font></span><br>
<table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#CCCCCC">
    <tr>
        <td width="30%" bgcolor="#EBEBEB">
            <p align="center"><span style="font-size:9pt;">Key</span></p>
        </td>
        <td width="70%" bgcolor="#EBEBEB">
            <p align="center"><span style="font-size:9pt;">Value</span></p>
        </td>
    </tr>
<% For Each key in Request.ServerVariables %>
    <tr>
        <td width="30%" bgcolor="black">
            <p align="center"><span style="font-size:9pt;"><font color="white"><%=key%></font></span></p>
        </td>
        <td width="70%" bgcolor="white">
            <p><span style="font-size:9pt;">&nbsp;<% if Request.ServerVariables(key) = "" Then %>&nbsp;<% else %><%=Request.ServerVariables(key)%><% end if %></span></p>
        </td>
    </tr>
<% Next %>
</table>
</body>

</html>