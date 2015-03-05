<!-- #include file = "../../lib/cfg.common.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfg.Item("lan")%>">
<title>▒▒ WizBoard For ASP Install Guide ▒▒</title>
<link rel="stylesheet" href="../../css/base.css" type="text/css"> 
<script language="javascript">
<!--
function check(){
	var f=document.InstallFrm
	if(!f.formcheckbox1.checked) {
		alert("위즈몰를 설치하기 전에 동의하셔야 합니다.");
		f.formcheckbox1.focus();
		return false;
	}

	f.action = "install2.asp"
	f.submit();
}
-->
</script>
</head>
<body bgcolor="#17823A">
<table cellpadding="0" cellspacing="1" bgcolor="white" width="790" align="center">
  <form name="InstallFrm" method="post" onSubmit="return check();">
    <tr> 
      <td width="788" height="1" bgcolor="#BBBBBB"></td>
    </tr>
    <tr> 
      <td width="788"> <table cellpadding="0" cellspacing="0" width="788">
          <tr> 
            <td height="116" bgcolor="#005B1E">&nbsp;&nbsp;&nbsp;&nbsp;</td>
          </tr>

          <tr> 
            <td bgcolor="#17823A">&nbsp;
            <textarea name="formtextarea1" rows="18" style="width:100%" readonly>
소개 

위즈몰는 홈페이지에서 기존 위즈몰(APM) 버전을 ASP 버전으로 컨버젼한 것입니다.
지속적인 기능보강을 통해 APM 버젼에 버금가는 ASP버젼이 되도록 하겠습니다.


라이센스 

위즈몰에 대한 라이센스입니다. 

아래 라이센스에 동의하시는 분만 위즈몰를 사용할수 있습니다.
프로그램명 : wizboard (위즈몰)
개발환경 : Windows2000server + MS-SQL2000
개발자 : 폰돌
Homepage : http://shop-wiz.com 



* 본 프로그램은 대한민국 지적 재산권법 및 저작권법에 의해 보호되고 있습니다.

* 본 프로그램 소스를 이용한 2차적 저작물 제작은 금하여, 이를 위반시 지적재산권 보호법에 의한 조치가 취해지는 불이익을 받을 수 있습니다. 소스를 타 프로그램에서 무단 도용할 경우, 사전 통보 없이 법적 불이익을 받을 수 있습니다.

* 위즈몰 공개버전 사용권

  - 아무런 댓가 없이 무한정 무료로 사용할 수 있습니다.
  - 위즈몰 사용시 저작권 명시부분을 훼손하면 안됩니다. 프로그램 소스, ASP 소스상의 라이센스 및 웹상 출력물 하단에 있는 카피라이트와 링크를 수정하지 마십시요. (저작권 표시는 게시판 배포시 작성된 형식만을 허용합니다. 임의 수정은 금지합니다) 
  - 위즈몰의 재 배포는 shop-wiz.com과 shop-wiz.com에서 허용한 곳에서만 할 수 있습니다
  - 링크서비스등의 기본 용도에 맞지 않는 사용은 금지합니다. 
  - 원본형태로만 재 배포가 허용되며 수정한 소스는 재 배포할 수 없습니다.
  - 위즈몰에 쓰인 스킨의 저작권은 스킨 제작자에게 있으며 제작자의 동의하에 수정배포가 가능합니다.

* 위즈몰 ASP 버젼 정식버전 사용권

  - 정식으로 사용자등록을 하고 구입금액을 지불한 경우에만 사용이 허용되고, 사용기간 제한은 없습니다.
  - 정식 등록버젼은 저작권 표시를 삭제할수 있습니다. 
  - 정식 등록버젼에 대한 문의는 http://shop-wiz.com 에서 위즈몰 메뉴에서 찾아주시기 바랍니다. 
  - 1copy 지불금의 사용권한은 1개의 홈사이트(도메인기준)에 한정합니다.
  - 하나의 홈 사이트 내에서는 복사, 중복 설치에 제한을 두지 않습니다. 그러나 타인 또는 동일인 소유의 다른 홈사이트(도메인기준)에 추가 설치하고자 할 경우, 그에 따른 추가구입을 하여야 합니다. 서비스를 목적으로 한 2차 도메인의 홈 사이트의 경우도 각각의 도메인으로 간주합니다.
  - 타 홈페이지등에 링크를 해주는 링크 서비스는 불허입니다.
  - 정식등록 원본 소스는 http://shop-wiz.com 사이트에서만 배포(판매)되며, 타 사이트에서 무단 배포할 경우 사전통보 없이 법적 불이익을 받을 수 있습니다.
  - 설치와 동시에 'shop-wiz.com' 에 설치 URL이 자동통보 되도록 되어 있습니다.

* 제작사 책임및 의무

   - 본 프로그램 사용중 발생한 데이터 유실이나 기타 피해에 대해 제작사에서는 어떠한 책임도 지지 않습니다.
   - 위즈몰에 대해 위즈몰 개발자는 유지/ 보수의 의무가 없습니다.
   - 단 정식버전 판매이후에 프로그램 자체에서 치명적인 오류가 발견될 경우, 제작자 및 제작사는 이를 보완하여 다시 제공할 의무를 가집니다. 


※ 기타 의문사항은 http://shop-wiz.com의 위즈몰 메뉴를 이용해 주시기 바랍니다. (질문등에 대한 내용은 메일로 받지 않습니다) </textarea><br />
<br />
<input type="checkbox" name="formcheckbox1"> 
              <font color="white">위 내용에 동의 합니다.</td>
          </tr>
          <tr> 
            <td bgcolor="#005B1E" height="77" align="center"><input type="submit" name="Submit" value="설치">
              &nbsp;&nbsp;
              <input type="button" name="Submit2" value="취소" onClick="javascript:self.close();"></td>
          </tr>
      </table></td>
    </tr>
  </form>
</table>
</body>
</html>
