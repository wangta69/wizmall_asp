<%@LANGUAGE="VBScript"%>
<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">

<%
''Set objMon = Server.CreateObject("SiteGalaxyUpload.FormMonitor") 
''objMon.UseMonitor(True) 
''Set objMon = Nothing 
%>

<SCRIPT LANGUAGE="JavaScript"> 
<!-- 
function ShowProgress() 
{ 
   strAppVersion = navigator.appVersion; 
   if (document.write_form.Library_file.value != "") {
      if (strAppVersion.indexOf('MSIE')!=-1 && 
          strAppVersion.substr(strAppVersion.indexOf('MSIE')+5,1) > 4) { 

          winstyle = "dialogWidth=385px; dialogHeight:150px; center:yes"; 
          window.showModelessDialog("show_progress.asp?nav=ie", null, winstyle); 
      } 
      else { 
          winpos = "left=" + ((window.screen.width-380)/2)+",top=" +
               ((window.screen.height-110)/2); winstyle="width=380,height=110,status=no,toolbar=no,menubar=no," + 
               "location=no, resizable=no,scrollbars=no,copyhistory=no," + winpos; 
          window.open("show_progress.asp",null,winstyle); 
      } 
   }

   return true; 
} 

//--> 
</SCRIPT> 
<!-- Form을 Submit하기 직전에 ShowProgress()라는 함수를 호출하여 Progress Indicator를 시각적으 로 보여주기 위해 새 창(또는 대화상자)을 띄워 주어야한다.
이문서는 파일을 올리는 페이지 상단에 포함시켜야 한다. 자바스크립에서 폼이름과 파일객체의 이름을 정확히.
 -->