<% Option Explicit %>
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<%
Dim util
Set util = new utility	

Dim filename, pds_dir
filename	= REQUEST("filename")
pds_dir		= PATH_SYSTEM & "config\wizinquire\"
Call util.fileDown(filename, pds_dir)
Set util = Nothing	
%>
