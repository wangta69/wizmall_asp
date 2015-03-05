<%
if user_id <> "admin" or user_grade <> 0 then
	Response.Write "<script>window.alert('로그인해주시기 바랍니다.');location.href = './default.asp';</script>"
end if
%>
