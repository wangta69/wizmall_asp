<%@LANGUAGE="VBScript"%>
<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<html>
<head><title>웹하드</title>
<meta http-equiv='content-type' content='text/html; charset=<%=cfg.Item("lan")%>'>
<link rel=stylesheet href='http://mail.hyperasp.net/mail/skin/skin9/style_sky.css'>
<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript' src='http://mail.hyperasp.net/mail/javascript/hermes21.js'></script>
<title>폴더 만들기</title>
<script language=JavaScript>
function chkfolder() {
    if( document.folderName.folderName.value.length < 1 ) {
        alert('새로 만들 폴더 이름이 입력되지 않았습니다. 다시 입력해 주세요.');
        document.folderName.folderName.focus();
        return;
    }
    document.folderName.submit();
	}

</script>
</head>

<body leftmargin=0 marginwidth=0 topmargin=0 marginheight=0 onload='javascript:document.folderName.folderName.focus();' class=bodybg1>
<form name=folderName action="CreateFolder.asp" method=POST>
<input type="hidden" name="path" value="<%=Request("now_folder")%>">
<center>
<table cellspacing=0 width=100% cellpadding=0 border=0>
  <tr class=boardbg>
      <td height=> 
        <div align="center">새로 만들 폴더의 이름을 넣어주세요.</div>
      </td>
                <td></td>
  </tr>
  <tr height=2>
    <td height=2 background=../mail/imgs/horizon.dot.gif></td>
                <td></td>
  </tr>
  <tr class=bodybg1><td height=20 colspan=2></td></tr>
  <tr class=bodybg1>
    <td align=center><input type=text name="folderName" maxlength=20 size=20 class=input>
        <a href="javascript:chkfolder()"> <img src=image/btn_write.gif width=63 height=21  border=0 align=absmiddle></a> 
      </td>
                <td></td>
  </tr>
</table>
</form></center>

</body>
</html>