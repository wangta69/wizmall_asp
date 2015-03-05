<!-- #include file = "../../../lib/cfg.common.asp" -->
<!-- #include file = "../../../config/db_connect.asp" -->
<!-- #include file = "../../../config/skin_info.asp" -->
<!-- #include file = "../../../lib/class.database.asp" -->
<!-- #include file = "../../../lib/class.util.asp" -->
<%
Dim strSQL,objRs
Dim db,util
Dim Imgsize, Imgwidth, ImgHeight
Set util = new utility	
Set db = new database

no = Request("no")

strSQL="SELECT m1.picture, m2.pname, m2.model, m2.brand, m2.point, m2.price, m2.price1 FROM wizMall m1 left join wizMall m2 on m1.pid = m2.uid WHERE m1.uid = '"&no&"'"
Set objRs	= db.ExecSQLReturnRS(strSQL, Nothing, DbConnect)
picture = objRs("picture")
''Response.Write(picture)
picturesplit = split(picture, "|")
if ubound(picturesplit) > 0 then 
	PictuerView = picturesplit(0)
	filepath = PATH_SYSTEM&"config\wizstock\"&PictuerView
	''Response.Write(filepath)
	Imgsize		= split(util.getImageSize(filepath), "|")
	''Response.Write(Imgsize(0))
	''Response.Write(",")
	''Response.Write(Imgsize(1))
	Imgwidth	= Imgsize(0)
	ImgHeight	= Imgsize(1)	
end if


%>
<HTML>
<head>
<TITLE>상품상세보기</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<script language="javascript">
<!--
function getresizeTo(getwidth, getheight){
    var dH = 0;
    PL_pf=navigator.platform; 
    PL_av=navigator.appVersion; 
    if( PL_pf.indexOf('undefined') >= 0 || PL_pf == '' ) PL_os = 'UNKNOWN' ; 
    else PL_os = PL_pf ; 
    
    if( PL_os.indexOf('Win32') >= 0 ){ 
        if( PL_av.indexOf('98')>=0) PL_os = 'Windows 98' ; 
        else if( PL_av.indexOf('95')>=0 ) PL_os = 'Windows 95' ; 
        else if( PL_av.indexOf('Me')>=0 ) PL_os = 'Windows Me' ; 
        else if( PL_av.indexOf('NT')>=0 ) PL_os = 'Windows NT' ; 
        else PL_os = 'Windows' ; 
        
        if( PL_av.indexOf('NT 5.0')>=0) PL_os = 'Windows 2000' ; 
        if( PL_av.indexOf('NT 5.1')>=0) PL_os = 'Windows XP' ; 
        if( PL_av.indexOf('NT 5.2')>=0) PL_os = 'Windows Server 2003' ; 
    } 
        
    PL_pf_substr = PL_pf.substring(0,4); 
    
    if( PL_pf_substr == 'Wind'){ 
        if( PL_pf_substr == 'Win1') PL_os = 'Windows 3.1'; 
        else if( PL_pf_substr == 'Mac6' ) PL_os = 'Mac' ; 
        else if( PL_pf_substr == 'MacO' ) PL_os = 'Mac' ; 
        else if( PL_pf_substr == 'MacP' ) PL_os = 'Mac' ; 
        else if( PL_pf_substr == 'Linu' ) PL_os = 'Linux' ; 
        else if( PL_pf_substr == 'WebT' ) PL_os = 'WebTV' ; 
        else if( PL_pf_substr =='OSF1' ) PL_os = 'Compaq Open VMS' ; 
        else if( PL_pf_substr == 'HP-U' ) PL_os = 'HP Unix' ; 
        else if( PL_pf_substr == 'OS/2' ) PL_os = 'OS/2' ; 
        else if( PL_pf_substr == 'AIX4' ) PL_os = 'AIX'; 
        else if( PL_pf_substr == 'Free' ) PL_os = 'FreeBSD'; 
        else if( PL_pf_substr == 'SunO' ) PL_os = 'SunO'; 
        else if( PL_pf_substr == 'Drea' ) PL_os = 'Drea'; 
        else if( PL_pf_substr == 'Plan' ) PL_os = 'Plan'; 
        else PL_os = 'UNKNOWN'; 
    } 
    
    if(PL_os == "Windows XP")    dH = 100;
    window.resizeTo(parseInt(getwidth), parseInt(getheight) + parseInt(dH));    

} 

getresizeTo(<%=Imgwidth%>, <%=ImgHeight%>)
//-->
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<a href="javascript:window.close();"> 
                  <img name="GoodsBigPic" src='../../../config/wizstock/<%=PictuerView%>' style="filter:blendTrans(duration=0.5)" border="0"></a>
</body>
</html>
