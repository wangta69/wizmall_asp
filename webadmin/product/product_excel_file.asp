<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->
<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/mall_config.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.mall.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<%
Dim strSQL,objRs
Dim db,util,mall
''Set util = new utility	
Set db		= new database
Set mall	= new malls

%>
<script language="javascript" type="text/javascript">
<!--

-->
</script>


<table class="table_outline">
  <tr>
    <td>
	
	
<fieldset class="desc">
<legend>제품 등록</legend>
<div class="notice">[note]</div>
<div class="comment">아래 샘플보기를 참조하여 엑셀파일을 업로드 해 주세요<br />
                	<a href="./product/sample.xls" target="_blank">[샘플보기]</a><br />
                	그림은  ftp를 이용하여 ./config/wizstock에 이미지를 올려주시기 바랍니다.<br />
                	상품상세설명에 들어갈 이미지는 ./config/wizstock/descimg 에 올려주시기 바랍니다.<br /></div>
</fieldset>
<div class="space20"></div>



      <form  action="./product/product_excel_file_qry.asp" method='post' name="writeForm" enctype='multipart/form-data' onsubmit="return checkPdForm();">
	  <input type="hidden" name="qry"  value="excel_up" />
        <table class="table_main w_default">
          <tr>
            <td width=100 name="theme"><P>엑셀업로드</P></td>
            <td ><table width="583" border="0" cellpadding="0" cellspacing="0" height="18">
                <tr>
                  <td>&nbsp;
                    <input type='file' name='attached'></td>
                  <td>&nbsp;</td>
                </tr>
              </table></td>
          </tr>
         
        </table>
        <br />
        <table width="750" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td><div align="center">
                <input type="image" src="img/sul.gif" width="68" height="20">
              </div><!--<a href="javascript:checkPdForm()">afasdf</a>--></td>
          </tr>
        </table>
        <br />
        <br />
      </form></td>
  </tr>
</table>
