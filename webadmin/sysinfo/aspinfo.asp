<!-- #include file = "../../lib/cfg.common.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta name="VI60_defaultClientScript" content="JavaScript">
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<style type="text/css">
<!--
a {
	text-decoration: none;
}
a:hover {
	text-decoration: underline;
}
h1 {
	font-family: arial, helvetica, sans-serif;
	font-size: 18pt;
	font-weight: bold;
}
h2 {
	font-family: arial, helvetica, sans-serif;
	font-size: 14pt;
	font-weight: bold;
}
body, td {
	font-family: arial, helvetica, sans-serif;
	font-size: 10pt;
}
th {
	font-family: arial, helvetica, sans-serif;
	font-size: 11pt;
	font-weight: bold;
}
//
-->
</style>
<title>ASPINFO v1.0.0.0</title>
</head>
<body>
<table align="center" border="1" cellpadding="5" cellspacing="0" width="600" bgcolor="#000000" style="border-collapse: collapse" bordercolor="#111111">
  <tr valign="middle" bgcolor="#9999cc">
    <td align="left" nowrap><font size="5"> ASPINFO</b>&nbsp;<br />
      Server Name: <font color="#000080"><%=request.ServerVariables("SERVER_NAME")%>:<%=request.ServerVariables("SERVER_PORT")%></b> Local Addr: <font color="#000080"><%=request.ServerVariables("LOCAL_ADDR")%></b> Remote Addr: <font color="#000080"><%=request.ServerVariables("REMOTE_ADDR")%>:<%=request.ServerVariables("REMOTE_PORT")%></b></td>
  </tr>
</table>
<h2 align="center">Application Object</h2>
<table border="0" cellpadding="3" cellspacing="1" width="600" bgcolor="#000000" align="center">
  <tr valign="middle" bgcolor="#9999cc">
    <th width="30%">Contents</th>
    <th>Value</th>
  </tr>
  <%	for each strkey in Application.Contents %>
  <tr valign="baseline" bgcolor="#cccccc">
    <td bgcolor="#ccccff" nowrap >Contents("<%= strkey %>")</b></td>
    <%	 	if isObject(Application.Contents(strkey)) then %>
    <td align="left">[Object]</td>
  </tr>
  <%		else %>
  <td align="left"><%= Application.Contents(strkey) %>　</td>
  </tr>
  <%		end if %>
  <%	next %>
</table>
<%	response.Flush %>
<h2 align="center">Request Object</h2>
<!-- Attribute -->
<table border="0" cellpadding="3" cellspacing="1" width="600" bgcolor="#000000" align="center">
  <tr valign="middle" bgcolor="#9999cc">
    <th width="30%">Attribute</th>
    <th>Value</th>
  </tr>
  <tr valign="baseline" bgcolor="#cccccc">
    <td bgcolor="#ccccff" nowrap >TotalBytes</b></td>
    <td align="left"><%= Request.TotalBytes %></td>
  </tr>
</table>
<br />
<%	response.Flush %>
<!-- ClientCertificate -->
<table border="0" cellpadding="3" cellspacing="1" width="600" bgcolor="#000000" align="center">
  <tr valign="middle" bgcolor="#9999cc">
    <th width="30%">ClientCertificate</th>
    <th>Value</th>
  </tr>
  <% For Each strKey in Request.ClientCertificate %>
  <tr valign="baseline" bgcolor="#cccccc">
    <td bgcolor="#ccccff" nowrap >ClientCertificate("<%= strkey %>")</b></td>
    <td align="left"><%= Request.ClientCertificate(strkey) %></td>
  </tr>
  <% next %>
</table>
<br />
<%	response.Flush %>
<!-- Cookies -->
<table border="0" cellpadding="3" cellspacing="1" width="600" bgcolor="#000000" align="center">
  <tr valign="middle" bgcolor="#9999cc">
    <th width="30%">Cookies</th>
    <th>Value</th>
  </tr>
  <% for each cookie in request.Cookies
		if request.Cookies(cookie).HasKeys then
			for each subcookie in request.Cookies(cookie) %>
  <tr valign="baseline" bgcolor="#cccccc">
    <td bgcolor="#ccccff" nowrap >Cookies("<%= cookie %>")("<%= subcookie %>")</b></td>
    <td align="left"><%= request.Cookies(cookie)(subCookie) %></td>
  </tr>
  <%			next %>
  <%		else %>
  <tr valign="baseline" bgcolor="#cccccc">
    <td bgcolor="#ccccff" nowrap >Cookies("<%= cookie %>")</b></td>
    <td align="left"><%= request.Cookies(cookie) %><br /></td>
  </tr>
  <%		end if %>
  <% next %>
</table>
<br />
<%	response.Flush %>
<!-- Form -->
<table border="0" cellpadding="3" cellspacing="1" width="600" bgcolor="#000000" align="center">
  <tr valign="middle" bgcolor="#9999cc">
    <th width="30%">Form</th>
    <th>Value</th>
  </tr>
  <% For Each strKey in Request.Form %>
  <tr valign="baseline" bgcolor="#cccccc">
    <td bgcolor="#ccccff" nowrap >Form("<%= strkey %>")</b></td>
    <td align="left"><%= Request.Form(strkey) %></td>
  </tr>
  <% next %>
</table>
<br />
<%	response.Flush %>
<!-- QueryString -->
<table border="0" cellpadding="3" cellspacing="1" width="600" bgcolor="#000000" align="center">
  <tr valign="middle" bgcolor="#9999cc">
    <th width="30%">QueryString</th>
    <th>Value</th>
  </tr>
  <% For Each strKey in Request.QueryString %>
  <tr valign="baseline" bgcolor="#cccccc">
    <td bgcolor="#ccccff" nowrap >QueryString("<%= strkey %>")</b></td>
    <td align="left"><%= Request.QueryString(strkey) %></td>
  </tr>
  <% next %>
</table>
<br />
<%	response.Flush %>
<!-- ServerVaribles -->
<table border="0" cellpadding="3" cellspacing="1" width="600" bgcolor="#000000" align="center">
  <tr valign="middle" bgcolor="#9999cc">
    <th width="30%">ServerVariables</th>
    <th>Value</th>
  </tr>
  <% for each strkey in request.servervariables %>
  <tr valign="baseline" bgcolor="#cccccc">
    <td bgcolor="#ccccff" nowrap >ServerVariables("<%= strkey %>")</b></td>
    <td align="left"><%= request.servervariables(strkey) %></td>
  </tr>
  <% next %>
</table>
<br />
<%	response.Flush %>
<h2 align="center">Response Object</h2>
<table border="0" cellpadding="3" cellspacing="1" width="600" bgcolor="#000000" align="center">
  <tr valign="middle" bgcolor="#9999cc">
    <th width="30%">Attribute</th>
    <th>Value</th>
  </tr>
  <tr valign="baseline" bgcolor="#cccccc">
    <td bgcolor="#ccccff" nowrap >Buffer</b></td>
    <td align="left"><%= Response.Buffer %></td>
  </tr>
  <tr valign="baseline" bgcolor="#cccccc">
    <td bgcolor="#ccccff" nowrap >CacheControl</b></td>
    <td align="left"><%= Response.CacheControl %></td>
  </tr>
  <tr valign="baseline" bgcolor="#cccccc">
    <td bgcolor="#ccccff" nowrap >Charset</b></td>
    <td align="left"><%= Response.Charset %></td>
  </tr>
  <tr valign="baseline" bgcolor="#cccccc">
    <td bgcolor="#ccccff" nowrap >ContentType</b></td>
    <td align="left"><%= Response.ContentType %></td>
  </tr>
  <tr valign="baseline" bgcolor="#cccccc">
    <td bgcolor="#ccccff" nowrap >Expires</b></td>
    <td align="left"><%= Response.Expires %></td>
  </tr>
  <tr valign="baseline" bgcolor="#cccccc">
    <td bgcolor="#ccccff" nowrap >ExpiresAbsolute</b></td>
    <td align="left"><%= Response.ExpiresAbsolute %></td>
  </tr>
  <tr valign="baseline" bgcolor="#cccccc">
    <td bgcolor="#ccccff" nowrap >isClientConnected</b></td>
    <td align="left"><%= Response.isClientConnected %></td>
  </tr>
  <tr valign="baseline" bgcolor="#cccccc">
    <td bgcolor="#ccccff" nowrap >Status</b></td>
    <td align="left"><%= Response.Status %></td>
  </tr>
</table>
<%	response.Flush %>
<h2 align="center">Server Object</h2>
<table border="0" cellpadding="3" cellspacing="1" width="600" bgcolor="#000000" align="center">
  <tr valign="middle" bgcolor="#9999cc">
    <th width="30%">Attribute</th>
    <th>Value</th>
  </tr>
  <tr valign="baseline" bgcolor="#cccccc">
    <td bgcolor="#ccccff" nowrap >ScriptTimeout</b></td>
    <td align="left"><%= Server.ScriptTimeout %></td>
  </tr>
</table>
<%	response.Flush %>
<h2 align="center">Session Object</h2>
<table border="0" cellpadding="3" cellspacing="1" width="600" bgcolor="#000000" align="center">
  <tr valign="middle" bgcolor="#9999cc">
    <th width="30%">Attribute</th>
    <th>Value</th>
  </tr>
  <tr valign="baseline" bgcolor="#cccccc">
    <td bgcolor="#ccccff" nowrap >Session.CodePage</b></td>
    <td align="left"><%= Session.CodePage %></td>
  </tr>
  <tr valign="baseline" bgcolor="#cccccc">
    <td bgcolor="#ccccff" nowrap >Session.LCID</b></td>
    <td align="left"><%= Session.LCID %></td>
  </tr>
  <tr valign="baseline" bgcolor="#cccccc">
    <td bgcolor="#ccccff" nowrap >Session.SessionID</b></td>
    <td align="left"><%= Session.SessionID %></td>
  </tr>
  <tr valign="baseline" bgcolor="#cccccc">
    <td bgcolor="#ccccff" nowrap >Session.Timeout</b></td>
    <td align="left"><%= Session.Timeout %></td>
  </tr>
</table>
<br />
<table border="0" cellpadding="3" cellspacing="1" width="600" bgcolor="#000000" align="center">
  <tr valign="middle" bgcolor="#9999cc">
    <th width="30%">Contents</th>
    <th>Value</th>
  </tr>
  <% for each Content in Session.Contents
		if isObject(Session.Contents(Content)) then %>
  <tr valign="baseline" bgcolor="#cccccc">
    <td bgcolor="#ccccff" nowrap >Contents("<%= Content %>")</b></td>
    <td align="left">[Object]</td>
  </tr>
  <%		else %>
  <tr valign="baseline" bgcolor="#cccccc">
    <td bgcolor="#ccccff" nowrap >Contents("<%= Content %>")</b></td>
    <td align="left"><%= Session.Contents(Content) %>　</td>
  </tr>
  <%		end if %>
  <% next %>
</table>
<br />
<table border="0" cellpadding="3" cellspacing="1" width="600" bgcolor="#000000" align="center">
  <tr valign="middle" bgcolor="#9999cc">
    <th width="30%">StaticObjects</th>
    <th>Value</th>
  </tr>
  <% for each Content in Session.StaticObjects
		if isObject(Session.StaticObjects(Content)) then %>
  <tr valign="baseline" bgcolor="#cccccc">
    <td bgcolor="#ccccff" nowrap >StaticObjects("<%= Content %>")</b></td>
    <td align="left">[Object]</td>
  </tr>
  <%		else %>
  <tr valign="baseline" bgcolor="#cccccc">
    <td bgcolor="#ccccff" nowrap >StaticObjects("<%= Content %>")</b></td>
    <td align="left"><%= Session.StaticObjects(Content) %>　</td>
  </tr>
  <%		end if %>
  <% next %>
</table>
<%	response.Flush %>
<br />
</body>
</html>
