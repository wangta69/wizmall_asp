<!-- #include file = "../../lib/cfg.common.asp" -->
<%
bid = request("bid")
Select Case bid
    Case "board01"
        navy_img = "<img src=""images/support_news.gif"">"
		navy_txt = "&gt; 기술지원 &gt; NEWS"
    Case "board02"
        navy_img = "<img src=""images/support_notice.gif"">"
		navy_txt = "&gt; 기술지원 &gt; NOTICE"
    Case "board03"
        navy_img = "<img src=""images/support01_title01.gif"">"
		navy_txt = "&gt; 기술지원 &gt; Q&A"
    Case "board04"
        navy_img = "<img src=""images/support_title02.gif"">"
		navy_txt = "&gt; 기술지원 &gt; FAQ"
    Case "board05"
        navy_img = "<img src=""images/support_title05.gif"">"
		navy_txt = "&gt; 기술지원 &gt; 자료실"								
End Select 
%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>title</title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<link rel="stylesheet" href="style.css">
<SCRIPT language=javascript>
<!--
var bNetscape4plus = (navigator.appName == "Netscape" && navigator.appVersion.substring(0,1) >= "4");
var bExplorer4plus = (navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.substring(0,1) >= "4");

function always_pos()
{
        var yMenuFrom, yMenuTo, yButtonFrom, yButtonTo, yOffset, timeoutNextCheck;

        if ( bNetscape4plus ) { // 네츠케이프 용 설정
                yMenuFrom   = document["scrollmenu"].top;
                yMenuTo     = top.pageYOffset + 70;   // 화면 위쪽으로 부터의 위치
        }
        else if ( bExplorer4plus ) {  // 익스플로러 용 설정
                yMenuFrom   = parseInt (scrollmenu.style.top, 10);
                yMenuTo     = document.body.scrollTop + 274; // 화면 위쪽으로 부터의 위치
        }

        timeoutNextCheck = 500;

        if ( Math.abs (yButtonFrom - (yMenuTo + 152)) < 6 && yButtonTo < yButtonFrom ) {
                setTimeout ("always_pos()", timeoutNextCheck);
                return;
        }


        if ( yButtonFrom != yButtonTo ) {
                yOffset = Math.ceil( Math.abs( yButtonTo - yButtonFrom ) / 10 );
                if ( yButtonTo < yButtonFrom )
                        yOffset = -yOffset;

                if ( bNetscape4plus )
                        document["divLinkButton"].top += yOffset;
                else if ( bExplorer4plus )
                        divLinkButton.style.top = parseInt (divLinkButton.style.top, 10) + yOffset;

                timeoutNextCheck = 10;
        }
        if ( yMenuFrom != yMenuTo ) {
                yOffset = Math.ceil( Math.abs( yMenuTo - yMenuFrom ) / 20 );
                if ( yMenuTo < yMenuFrom )
                        yOffset = -yOffset;

                if ( bNetscape4plus )
                        document["scrollmenu"].top += yOffset;
                else if ( bExplorer4plus )
                        scrollmenu.style.top = parseInt (scrollmenu.style.top, 10) + yOffset;

                timeoutNextCheck = 10;
        }

        setTimeout ("always_pos()", timeoutNextCheck);
}
function OnLoad()
{
        var y;

        // 프레임 에서 벗어나게 하는 함수입니다. 프레임에 넣으려면 삭제하세요
        if ( top.frames.length )
         //       top.location.href = self.location.href;

        // 페에지 로딩시 포지션
        if ( bNetscape4plus ) {
                document["scrollmenu"].top = top.pageYOffset + 100;
                document["scrollmenu"].visibility = "visible";
        }
        else if ( bExplorer4plus ) {
                scrollmenu.style.top = document.body.scrollTop + 100;
                scrollmenu.style.visibility = "visible";
        }

        always_pos();
        return true;
}

//-->
</SCRIPT>
</head>

<body leftmargin="0" topmargin="0">
<div id="scrollmenu" 
      style="width:84px; height:265px; position:absolute; left:916px; top:110px; z-index:1; visibility:visible;"> 
  <!--위의  left:650px; top:2000px 로 스크롤 배너 레이어의 위치를 조정-->
  <!-- #include virtual = "/inc/quick_menu.asp"-->
  <script>OnLoad();</script>
</DIV>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top"><!-- #include virtual = "/inc/sub_top.asp"--></td>
  </tr>
  <tr>
    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="208" valign="top"><!-- #include virtual = "/inc/leftmenu_inc_05.asp"--></td>
          <td width="699" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="699" height="140">
                  <param name="movie" value="fla/sub_05.swf">
                  <param name="quality" value="high">
                  <embed src="fla/sub_05.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="699" height="140"></embed>
                </object></td>
              </tr>
              <tr>
                <td height="22"></td>
              </tr>
              <tr>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="54"><%=navy_img%></td>
                      <td align="right" class="stxt1"><img src="images/news_icon01.gif" width="2" height="3" hspace="5" align="absmiddle"> 
                        home <%=navy_txt%></td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td height="1" bgcolor="E6E6E6"></td>
              </tr>
              <tr>
                <td></td>
              </tr>
              <tr>
                <td align="center" valign="top">
				<!-- Board Start -->
