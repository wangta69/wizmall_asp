<!-- #include file = "../../../lib/cfg.common.asp" -->
<!-- #include file = "../../../config/db_connect.asp" -->
<!-- #include file = "../../../config/skin_info.asp" -->
<!-- #include file = "../../../lib/class.database.asp" -->
<!-- #include file = "../../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util
''Set util = new utility	
Set db = new database

no = Request("no")
%>
<HTML>
<head>
<TITLE></TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<style type="text/css">
<!--
a:link {  font-family: "굴림", "굴림체"; font-size: 9pt; color: 5D5D5D; text-decoration: none}
a:visited {  font-family: "굴림", "굴림체"; font-size: 9pt; color: #999999; text-decoration: none}
a:active {  font-family: "굴림", "굴림체"; font-size: 9pt; color: #0099CC; text-decoration: underline}
a:hover {  font-family: "굴림", "굴림체"; font-size: 9pt; color: 038CC0; text-decoration: underline}

.txt {  font-family: "굴림", "굴림체"; font-size: 9pt; color: #333333; line-height: 15pt}
.text1{ font-family: "굴림"; font-size: 8pt; color: #666666; line-height: 14px}
.text2 { font-family: "굴림"; font-size: 9pt; color: #333333; padding-left: 5pt}
.text3 {
	font-family: "굴림";
	font-size: 10pt;
	color: #CCCCCC;
	padding-left: 5pt;
	font-weight: bolder;
}
BODY, TEXTAREA,TABLE, TR, TD, INPUT{font-size:12px; font-family:굴림;}
a:link,a:visited {color: #666666; text-decoration: none}
a.com:hover {color: #B47F0C; text-decoration: underline}
-->
</style>
<script language="JavaScript">
<!--
function ChangeImage(ImgName) { 
PathImg = "../../../config/wizstock/"+ImgName;
    if(ImgName != ""){
    document.all.GoodsBigPic.filters.blendTrans.stop();
    document.all.GoodsBigPic.filters.blendTrans.Apply();
    document.all.GoodsBigPic.src=PathImg;
    document.all.GoodsBigPic.filters.blendTrans.Play();
        }  
		
document['GoodsBigPic'].src = PathImg; 
}
-->
</script>
</head>
<%
strSQL="SELECT m1.picture, m2.pname, m2.model, m2.brand, m2.point, m2.price, m2.price1 FROM wizMall m1 left join wizMall m2 on m1.pid = m2.uid WHERE m1.uid = '"&no&"'"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
picture = objRs("picture")
picturesplit = split(picture, "|")
%>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="750" height="592" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="526" align="center" valign="top"> 
      <table width="737" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="524" valign="top"> 
            <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="DFDFDF">
			              <tr> 
                <td align="center" valign="top" bgcolor="#FFFFFF">
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
                    <tr> 
                      <td width="2%" bgcolor="#AD5900"></td>
                      <td width="96%" height="15" align="center" bgcolor="#AD5900" class="text3"><%=HOME_URL%></td>
                      <td width="2%" bgcolor="#AD5900"></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#AD5900"></td>
                      <td height="20"></td>
                      <td bgcolor="#AD5900"></td>
                    </tr>
                    <tr><td bgcolor="#AD5900"></td>
                      <td height="3" bgcolor="#F7F3EF"></td>
                      <td bgcolor="#AD5900"></td></tr>
                    <tr> 
                      <td bgcolor="#F7F3EF"></td>
                      <td height=15></td>
                      <td bgcolor="#F7F3EF"></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr> 
                <td align="center" bgcolor="#FFFFFF"><a href="javascript:window.close();"> 
                  <img name="GoodsBigPic" src='../../../config/wizstock/<% if ubound(picturesplit) > 1 then Response.Write picturesplit(0)%>' style="filter:blendTrans(duration=0.5)" border="0"></a></td>
              </tr>
            </table>
          </td>
          <td width="6"></td>
          <td width="207" valign="top"> 
            <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="DFDFDF" height="552">
              <tr> 
                <td bgcolor="#FFFFFF" align="center" valign="top"><br>
                  <table width="184" border="0" cellspacing="0" cellpadding="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
                    <tr> 
                      <td>&nbsp;</td>
                    </tr>
                    <tr> 
                      <td height="10"></td>
                    </tr>
                    <tr> 
                      <td align="center"> <table width="95%" border="0" cellspacing="0" cellpadding="0" style="font-family: '굴림', '돋움','Arial';font-size: 12px; color:#666666;line-height:140%">
                          <tr> 
                            <td height="25"><font color="#0066CC" style="font-size: 12pt"><b> 
                              <%=pname%>
                              </b></font> </td>
                          </tr>						  
                          <tr> 
                            <td height="25">모델명 | 
                              <%=model%>
                            </td>
                          </tr>
					  
                          <tr> 
                            <td height="25">제조사 | 
                              <%=brand%>
                            </td>
                          </tr>
					  
                          <tr> 
                            <td height="25">적립포인트 | 
                              <%=point%>
                            </td>
                          </tr>
					  
                          <tr> 
                            <td height="25"> 가격 | <font color="#CC3333">\ 
                              <%=price%>
                              </font></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td background="images/pro_line.gif" height="1"></td>
                    </tr>
                    <tr> 
                      <td height="10"></td>
                    </tr>
                    <tr> 
                      <td> <table border="0" cellspacing="1" cellpadding="0" bgcolor="DFDFDF">
                          <tr> 
                            <%
NO=0
for i=1 to ubound(picturesplit)
%>
                            <td bgcolor="#FFFFFF"> <table width="61" border="0" cellspacing="0" cellpadding="0" height="60">
                                <tr> 
                                  <td align="center"><img src="../../../config/wizstock/<%=picturesplit(i)%>" width="60" border="0" onMouseOver="ChangeImage('<%=picturesplit(i)%>')"></td>
                                </tr>
                              </table></td>
                            <%
tmpcnt = cnt mod 3
if tmpcnt = 0 then Response.Write "</tr><tr>"
next
%>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td height="10"></td>
                    </tr>
                    <tr> 
                      <td><font color="#0066CC">이미지위에 마우스 커서를 올려두시면 확대이미지를 보실수 
                        있습니다.</font></td>
                    </tr>
                    <tr> 
                      <td><a href="javascript:window.close();"><img src="./picviewimages/close_btn.gif" width="47" height="21" border="0" hspace="5"></a></td>
                    </tr>
                  </table></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      
    </td>
  </tr>
</table>
</body>
</html>
