<%@LANGUAGE="VBScript"%>
<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<%
Dim filename, path
path		= request("path")
filename	= request("filename")
%>
<html>

<head>
<meta http-equiv="content-type" content="text/html; charset=<%=cfg.Item("lan")%>">
<SCRIPT LANGUAGE="JavaScript">
<!--
function CheckSpaces(strValue) {
	var flag=true;

	if (strValue!="") {
		for (var i=0; i < strValue.length; i++) {
			if (strValue.charAt(i) != " ") {
				flag=false;
				break;
			}
		}
	}
	return flag;
}

function CheckForm(theForm)
{
	   if (CheckSpaces(write_form.New_filename.value)) {
                alert("파일 이름을 입력하세요.");
				write_form.New_filename.value = "";
                write_form.New_filename.focus();
                return false;
        }
document.write_form.action = "Edit_file_ok.asp";
document.write_form.submit();
}

//-->
</SCRIPT>
<title>파일 이름 수정</title>
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
<Form name="write_form" method="post">
<input type="hidden" name="path" value="<%=path%>">
<input type="hidden" name="filename" value="<%=filename%>">
<table border="1" width="100%">
    <tr>
        <td width="100%" colspan="2">
            <p align="center">파일 이름 변경</p>
        </td>
    </tr>
    <tr>
        <td width="50%">
            <p>현재 파일명</p>
        </td>
        <td width="50%">
            <p><%=filename%></p>
        </td>
    </tr>
    <tr>
        <td width="50%">
            <p>교체 파일명</p>
        </td>
        <td width="50%">
            <p><input type="text" name="New_filename"></p>
        </td>
    </tr>
    <tr>
        <td width="100%" colspan="2">
            <p align="center"><input type="button" name="formbutton1" value="변경" onClick="return CheckForm(this)"> 
            <input type="button" name="formbutton2" value="취소" onClick="javascript:self.close();"></p>
        </td>
    </tr>
</table>
</form>
</body>

</html>
