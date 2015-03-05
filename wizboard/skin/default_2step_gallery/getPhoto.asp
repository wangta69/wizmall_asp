<!-- #include file = "../../../lib/cfg.common.asp" -->
<%
dim gid, bid, filename
gid			= Request("gid")
bid			= Request("bid")
filename	= Request("filename")
%>
<HTML>
<head>
<TITLE>이미지상세보기</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">

</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a href="javascript:window.close();"> 
                  <img name="GoodsBigPic" src='../../../wizboard_group/<%=gid%>/<%=bid%>/attached/<%=filename%>' style="filter:blendTrans(duration=0.5)" border="0"></a>
</body>
</html>
