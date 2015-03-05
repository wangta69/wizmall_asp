<?
/**************************************************************************************
	SMS 클래스 사용 예제입니다.
**************************************************************************************/
include "class.sms.php";

$sms_server	= "211.172.232.124";	## SMS 서버 
$sms_id		= "xxxxxx";				## icode 아이디
$sms_pw		= "xxxxxx";				## icode 패스워드
$port		= 7295;				## 정액제 : 7296, 충전식 : 7295

$SMS	= new SMS;
$SMS->SMS_con($sms_server,$sms_id,$sms_pw,$port);

/**************************************************************************************
1단계: 보낼 메시지를 저장합니다. 쇼핑몰에서 장바구니에 물건을 담는다고 생각하면 됩니다.
	
	일반 메시지를 보낼 경우 SMS->Add() 를 사용합니다. 인자는 다음과 같습니다.
		1. 받는 사람 핸드폰 번호
		2. 보내는 사람 전화 (회신번호)
		3. 보내는 사람 이름
		4. 보내는 메시지 (80자 이내)
		5. 예약시간 (12자 - 예약발송일 경우에만 입력. 예: 2001년 5월30일 오후2시30분이면 200105301430)

	URL을 보낼 경우 SMS->AddURL() 을 사용합니다. 인자는 다음과 같습니다.
		1. 받는 사람 핸드폰 번호
		2. URL (50자 이내)
		3. 보내는 메시지 (80자 이내)
		4. 예약시간 (12자 - 예약발송일 경우에만 입력. 예: 2001년 5월30일 오후2시30분이면 200105301430)
	
	잘못된 값이 들어갔을 경우 에러메시지가 리턴됩니다.

	※ .URL 콜백의 경우 건당 50원의 요금이 부과 됩니다.
	※ .SKT(011,017) 번호로 발송하실 경우 사용자 동의를 받지 않아 전송 실패일 경우에도
	    정상적으로 요금이 청구 됩니다.
	※ .KTF(016,018) 번호로 발송하실 경우 회신번호를 반드시 입력하셔야 정상적으로 송신이 됩니다.
**************************************************************************************/

$tran_phone	= $addcall;		# 수신번호
$tran_callback	= "$callback";			# 회신번호
$tran_msg		= $MSG_TXT."\n".$sendername;	# 발송 메세지
$tran_date	= date("YmdHi");				#발송시간
#즉시 전송일 경우 $tran_date	= "" ;
#예약 전송일 경우 $tran_date	= "200412312359";	# 2004년 12월 31일 23시 59분

$result = $SMS->Add($tran_phone,"$tran_callback","$sms_id","$tran_msg","$tran_date");
if ($result) echo $result; //else echo "일반메시지 입력 성공<BR>";

//$result = $SMS->AddURL($tran_phone,"$tran_callback","w.yahoo.co.kr","테스트입니다","");
//if ($result) echo $result; else echo "URL 입력 성공<BR>";
//echo "<HR>";

/**************************************************************************************
2단계: 저장해둔 메시지를 전송합니다. 쇼핑몰에서 결제를 한다고 생각하면 됩니다.

	SMS->Send() 를 실행하면 모아둔 메시지를 모두 발송합니다.
	이때 SMS->Send()가 리턴하는 값은 true, false 입니다.
	이것은 서버와의 접속 상태를 나타냅니다.

	SMS->Send() 를 실행하고 난 후에는 메시지 발송 결과를 조회할 수 있습니다.
	메시지 발송 결과는 SMS->Result 배열에 저장되어 있습니다.
	데이타 형식은 "핸드폰 번호 : 메시지 고유번호" 입니다. 예) 0115511474:13622798 
	전송이 제대로 되지 않은 건에 대해서는 에러 표시가 납니다. 예) 0195200107:Error

	만약 같은 클래스를 재사용할 경우, SMS->Init() 명령으로 메시지 발송 결과를 없애주십시오.
**************************************************************************************/

$result = $SMS->Send();
if ($result) {
	//echo "SMS 서버에 접속했습니다.<br>";
	$success = $fail = 0;
	foreach($SMS->Result as $result) {
		list($phone,$code)=explode(":",$result);
		if ($code=="Error") {
			//echo $phone.'로 발송하는데 에러가 발생했습니다.<br>';
			echo "<script>window.alert('메시지 발송이 실패하였습니다.');</script>";
			$fail++;
		} else {
			//echo $phone."로 전송했습니다. (메시지번호:".$code.")<br>";
			echo "<script>window.alert('메시지가 전송되었습니다.');</script>";
			$success++;
		}
	}
	//echo $success."건을 전송했으며 ".$fail."건을 보내지 못했습니다.<br>";
	$SMS->Init(); // 보관하고 있던 결과값을 지웁니다.
}
else echo "<script>window.alert('에러: SMS 서버와 통신이 불안정합니다.');</script>";
?>
<script>
<!--
self.close();
//-->
</script>
