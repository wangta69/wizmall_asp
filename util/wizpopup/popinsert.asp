<script language="javascript">
<!--
function getCookie( name ) {        
var nameOfCookie = name + "=";
var x = 0;
while ( x <= document.cookie.length )
{
var y = (x+nameOfCookie.length);
if ( document.cookie.substring( x, y ) == nameOfCookie ) {
if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) 
endOfCookie = document.cookie.length; 
return unescape( document.cookie.substring( y, endOfCookie ) ); 
}
x = document.cookie.indexOf( " ", x ) + 1;
if ( x == 0 )
break;
}
return "";
}


function setCookie( name, value, expiredays ) 
{
var todayDate = new Date();
todayDate.setDate( todayDate.getDate() + expiredays );
document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + "; domain=" + ".lgeshop.com"+";";
}

var cookieval = new Date();
cookieval = cookieval.getTime();
var rStr_1 = "" + Math.random();
var rStr_2 = "" + Math.random();
var rStr_3 = "" + Math.random();
var rStr_4 = "" + Math.random();
var rStr_5 = "" + Math.random();
rStr_1 = rStr_1.charAt(2);
rStr_2 = rStr_2.charAt(2);
rStr_3 = rStr_3.charAt(2);
rStr_4 = rStr_4.charAt(2);
rStr_5 = rStr_5.charAt(2);
cookieval = cookieval + rStr_1 + rStr_2 + rStr_3 + rStr_4 + rStr_5;

<%
Dim popup_uid, popup_pwidth,popup_pheight, popup_ptop, popup_pleft
Set db		= new database
strSQL	= "select uid, pwidth, pheight, ptop, pleft from wizpopup where popupenable = 1"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)

WHILE NOT objRs.EOF
popup_uid		= objRs("uid")
popup_pwidth		= objRs("pwidth")
popup_pheight	= objRs("pheight")
popup_ptop		= objRs("ptop")
popup_pleft		= objRs("pleft")
%>
if ( getCookie( "Notice_<%=popup_uid%>" ) != "done" ) 
{ 
noticeWindow  =  window.open('./util/wizpopup/index.asp?uid=<%=popup_uid%>','PopUpWindow_<%=popup_uid%>','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,left=<%=popup_pleft%>,top=<%=popup_ptop%>,width=<%=popup_pwidth%>,height=<%=popup_pheight%>');
noticeWindow.opener = self; 
}
<%
	objRs.MOVENEXT
	WEND
	%>
//-->
</script>
