<%@ codepage="65001" language="vbscript"%>
<%
function strip_tags(strHTML)

''Response.Write(strHTML)
    dim regEx
    Set regEx = New RegExp
    With regEx
        .Pattern = "<(.|\n)+?>"
        .IgnoreCase = true
        .Global = true
    End With
    strip_tags = regEx.replace(strHTML, "")
end function




''function strip_tags(strHTML, allowedTags)
     
''    dim objRegExp, strOutput
''    set objRegExp = new regexp
     
 ''   strOutput = strHTML
 ''   allowedTags = "," & lcase(replace(allowedTags, " ", "")) & ","
     
 ''   objRegExp.IgnoreCase = true
  '  objRegExp.Global = true
 '   objRegExp.MultiLine = true
 '   objRegExp.Pattern = "<(.|\n)+?>"
'    set matches = objRegExp.execute(strHTML)
'    objRegExp.Pattern = "<(/?)(\w+)[^>]*>"
'    for each match in matches
 '       tagName = objRegExp.Replace(match.value, "$2")
'        if instr(allowedTags, "," & lcase(tagName) & ",") = 0 then
'            strOutput = replace(strOutput, match.value, "")
'        end if
'    next
'    strip_tags = strOutput
'    set objRegExp = nothing
'end function

Dim str
str = "<p color='#2323232'>제목</p>"

%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>만화인 > 만화보기</title>
<meta charset="UTF-8">

</head>
<body>
<%
''Response.Write str
Response.Write strip_tags(str)
%>
</body>
</html>
