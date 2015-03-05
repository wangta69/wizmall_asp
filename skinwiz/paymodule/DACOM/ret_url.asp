<%@ Language = VBScript %>
<%
'' db 처리는 이전단인 dbpath.asp에서 처리하고 이곳에서는 어느 페이지로 분기할지를 결정한다.
response_code = Request("response_code")
if response_code = "0000" then 
		 Response.Write "<script>"
		 Response.Write "parent.location.replace('../../../wizbag.asp?smode=step4&codevalue='"&SESSION("CART_CODE")&"')"
		 Response.Write"</script>"
else
		 Response.Write "<script>"
		 Response.Write "parent.location.replace('../../../wizbag.asp?smode=step1')"
		 Response.Write "</script>"
end if
%>
