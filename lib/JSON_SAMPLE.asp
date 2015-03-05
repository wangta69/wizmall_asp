<!--#include file="JSON_2.0.4.asp"-->
<!--#include file="JSON_UTIL_0.1.1.asp"-->
<script language="JScript" runat="server" src='json2.js'></script>
<%
''https://code.google.com/p/aspjson/
Dim member,output
Set member = jsObject()

member("name") = "Tuğrul"
member("surname") = "Topuz"
member("message") = "Hello World"

''member.Flush


output = member.jsString
Response.Write(output)

''set oJson = new Json
''oJson.loadJson(output)
''Response.Write oJson.serialize("")
''Response.Write(oJson.getElement("surname") & "<br />" & vbNewLine)

''set d = server.createObject("scripting.dictionary")
''d.add "en", "sausage"
''d.add "de", array("egal", "wurst")
''response.write((new JSON).toJSON("rows", d))

Dim myJSON
''myJSON = Request.Form("myJSON") // "[ 1, 2, 3 ]"
Set myJSON = JSON.parse(output) '' [1,2,3]
Response.Write(myJSON)          '' 1,2,3
Response.Write(myJSON.name)      '' 1
Response.Write(myJSON.surname)     '' 2
Response.Write(myJSON.message) 
%>