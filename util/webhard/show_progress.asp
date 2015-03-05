<%@ EnableSessionState=False%> 
<% 
'Case of Netscape Navigator 
If Request("nav") = "ns" Then 
%>
    <frameset rows="80,1*" border="0" framespacing="0" frameborder="no">
   <frame src="show_prog_body.asp" noresize scrolling="NO" frameborder="NO" 
      name="sp_body">
   <frame src="show_prog_bottom.asp" noresize scrolling="NO" frameborder="NO"
      name="sp_bottom">

<%
'Case of Internet Explorer
Else
%>
   <HTML>
   <HEAD>
   <TITLE>Uploading Files...</TITLE>
   <STYLE type="text/css">
       td {font-size: 9pt}
   </STYLE>
   </HEAD>

   <BODY bgcolor="#d4d0c8" leftmargin="8" topmargin="0" scroll="no">
   <IFRAME src="show_prog_body.asp" title="Progress Step1" frameborder=0 
       marginheight=0 marginwidth=0 noresize scrolling=no width=365 height=65>
   </IFRAME><BR><BR>

   <TABLE border="0" width="365" cellpadding="2" cellspacing="0" bgcolor="#d4d0c8">
   <TR><TD>Click the <B>STOP</B> button on your browser to abort uploading.
   </TD></TR>
   </TABLE>

   </BODY>
   </HTML>
<%
End If
%>
