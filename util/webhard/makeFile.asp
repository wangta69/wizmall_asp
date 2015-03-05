<%@LANGUAGE="VBSCRIPT"%>
<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title> New Document </title>
<meta name="Generator" content="EditPlus">
<meta name="Author" content="">
<meta name="Keywords" content="">
<meta name="Description" content="">
</head>
<style>
<!--@IMPORT URL(./Css/Dir.css);-->
<!--@IMPORT URL(./Css/Margin.css);-->
<!--@IMPORT URL(./Css/Line.css);-->
<!--@IMPORT URL(./Css/Cusor.css);-->
<!--@IMPORT URL(./Css/Input_box.css);-->
</style>
<body>
<table align=center width=100 class=LINE_N>
<form name=createtext method=post action='CreateText.asp'>
<tr>
	<td colspan=2><p align=center class=oh><b>새로운 파일 만들기 [ TEXT ]</b></td>
</tr>
<tr>
	<td><p><b>File Name : </b></td>
	<td><p>
		<input type=hidden name=path value='<%=Request("path")%>'>
		<input type=text name=file_name class=IN_B_15> <b>.</b>
		<select name=file_ext>
			<option value='Txt'>Txt</option>
			<option value='Html'>Html</option>
			<option value='Css'>Css</option>
			<option value='Js'>Js</option>
			<option value='asp'>asp</option>
		</select>
	</td>
</tr>
<tr>
	<td valign=top><p><b>File Content : </b></td>
	<td valign=top><textarea name="content" rows="30" cols="80"></textarea>
</td>
</tr>
<tr>
	<td colspan=2><p align=center>
	<input type=reset name=btn1 value='모두 지움' class=IN_B_6><input type=text class=LINE_N>
	<input type=submit name=btn2 value='저장 하기' class=IN_B_6>
	</td>
</tr>
</form>
</table>
</body>
</html>
