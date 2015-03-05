<%@LANGUAGE="VBSCRIPT" %>
<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->

<% 
Response.Buffer = False 
Dim util
Set util = new utility
Dim filename, URL, filepath

filename  = Request.QueryString("filename")
URL = Request.QueryString("URL")
filepath = PATH_SYSTEM & URL & "\" 
''filepath = Server.MapPath(URL) & "\" 

Call util.fileDown(filename, filepath)
Set util = Nothing	


Set objDownload = Nothing 

%> 