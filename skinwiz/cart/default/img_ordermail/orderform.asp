<!-- #include file = "../../../lib/cfg.common.asp" -->
<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN'>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>
<link href='{{image_url}}/body.css' rel='stylesheet' type='text/css'>
<style type='text/css'>
<!--
@import url('{{image_url}}/body.css');
-->
</style>
</head>

<body leftmargin='5' topmargin='5' marginwidth='0' marginheight='0'>
<!-- Body Start -->
<table width='653' border='0' cellspacing='0' cellpadding='0'>
  <tr> 
    <td width='650' background='{{image_url}}/body.gif'><table width='650' border='0' cellspacing='0' cellpadding='0'>
        <tr>
          <td height='50'><table width='650' border='0' cellspacing='0' cellpadding='0'>
              <tr>
                <td width='2'><img src='{{image_url}}/img_top_l.gif' width='2' height='50'></td>
                <td background='{{image_url}}/bg_top.gif'><img src='{{image_url}}/img_order.gif' width='650' height='118'></td>
                <td width='2'><img src='{{image_url}}/img_top_r.gif' width='2' height='50'></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td align='center'><table width='600' border='0' cellspacing='0' cellpadding='0'>
              <tr> 
                <td height='80' colspan='2' bgcolor='#F1F1F1'> <table width='565' border='0' cellspacing='0' cellpadding='0'>
                    <tr> 
                      <td width='43'>&nbsp;</td>
                      <td class='company'>�ȳ��ϼ���. <strong>{{sname}}</strong> ����<br> 
                        <br>
                        ���� {{admin_title}} �� �̿��� �ּż� ����� �����մϴ�.<br>
                        ���Բ��� �ֹ��Ͻ� ������ Ȯ���� �帳�ϴ�.</td>
                    </tr>
                  </table></td>
              </tr>
              <tr> 
                <td colspan='2'>&nbsp;</td>
              </tr>
              <tr> 
                <td colspan='2'><!--{{ORDERLIST}}//--><table width='600' border='0' cellpadding='0' cellspacing='0' class='company'>
                    <tr> 
                      <td height='3' colspan='3' bgcolor='#83A1C7'></td>
                    </tr>
                    <tr> 
                      <td width='200' height='27' align='right' bgcolor='#f3f3f3'><font color='#144179'>�ֹ���ȣ&nbsp; 
                        &nbsp; &nbsp; </font></td>
                      <td width='1' height='27'><img src='{{image_url}}/img_a.gif' width='12' height='27'></td>
                      <td width='399' height='27'><font color='618DC4'><strong>{{order_id}}</strong></font></td>
                    </tr>
                    <tr> 
                      <td height='1' colspan='3' bgcolor='#cfcfcf'></td>
                    </tr>
                    <tr> 
                      <td width='200' height='27' align='right' bgcolor='#f3f3f3'><font color='#144179'>�����ôº�&nbsp; 
                        &nbsp; &nbsp; </font></td>
                      <td width='1' height='27'><img src='{{image_url}}/img_a.gif' width='12' height='27'></td>
                      <td width='399' height='27'>{{rname}}</td>
                    </tr>
                    <tr> 
                      <td height='1' colspan='3' bgcolor='#cfcfcf'></td>
                    </tr>
                    <tr> 
                      <td width='200' height='27' align='right' bgcolor='#f3f3f3'><font color='#144179'>����ó&nbsp; 
                        &nbsp; &nbsp; </font></td>
                      <td width='1' height='27'><img src='{{image_url}}/img_a.gif' width='12' height='27'></td>
                      <td width='399' height='27'>&nbsp;{{rtel}}</td>

                    </tr>
                    <tr> 
                      <td height='1' colspan='3' bgcolor='#cfcfcf'></td>
                    </tr>
                    <tr> 
                      <td width='200' height='27' align='right' bgcolor='#f3f3f3'><font color='#144179'>������ 
                        �� �ּ�&nbsp; &nbsp; &nbsp; </font></td>
                      <td width='1' height='27'><img src='{{image_url}}/img_a.gif' width='12' height='27'></td>
                      <td width='399' height='27'>{{raddress}}</td>
                    </tr>
                    <tr> 
                      <td height='1' colspan='3' bgcolor='#cfcfcf'></td>
                    </tr>
                    <tr> 
                      <td width='200' height='27' align='right' bgcolor='#f3f3f3'><font color='#144179'>������&nbsp; 
                        &nbsp; &nbsp; </font></td>
                      <td width='1' height='27'><img src='{{image_url}}/img_a.gif' width='12' height='27'></td>
                      <td width='399' height='27'>{{paymethod}}</td>
                    </tr>
                    <tr> 
                      <td height='1' colspan='3' bgcolor='#cfcfcf'></td>
                    </tr>
                    <tr> 
                      <td width='200' height='27' align='right' bgcolor='#f3f3f3'><font color='#144179'>������&nbsp; 
                        &nbsp; &nbsp; </font></td>
                      <td width='1' height='27'><img src='{{image_url}}/img_a.gif' width='12' height='27'></td>
                      <td width='399' height='27'>{{buydate}}</td>
                    </tr>
                    <tr> 
                      <td height='1' colspan='3' bgcolor='#cfcfcf'></td>
                    </tr>
                    <tr> 
                      <td height='3' colspan='3' bgcolor='#83A1C7'></td>
                    </tr>
                  </table></td>
              </tr>
              <tr> 
                <td colspan='2'>&nbsp;</td>
              </tr>
              <tr> 
                <td height='76' colspan='2' align='center' background='{{image_url}}/bg_b.gif'> 
                  <table width='565' height='50' border='0' cellpadding='0' cellspacing='0'>
                    <tr> 
                      <td width='180' height='64'><img src='{{image_url}}/img_b.gif' width='190' height='50'></td>
                      <td width='49' class='company'> ��ȸ�� <br>
                        ȸ��<br> <br> </td>
                      <td width='336' class='company'>: �ֹ���ȣ�� ���� ���� ��ȸ�Ͻ� �� �ֽ��ϴ�.<br>
                        : �α����Ͻ��� �ֹ���ȣ�� Ŭ���Ͻø� �ڼ��� ������ <br> &nbsp; ��ȸ �Ͻ� �� �ֽ��ϴ�.</td>
                    </tr>
                  </table></td>
              </tr>
              <tr> 
                <td colspan='2'>&nbsp;</td>
              </tr>

              <tr align='center'> 
			  
                <td width='300'><FORM action='{{home_dir}}/wizmember/log_check.asp'>

<input type="hidden" name="fromlogin" value="wizmember.asp">
<input type="hidden" name="loginflag1" value="order"><table width='290' border='0' cellspacing='0' cellpadding='0'>
                    <tr> 
                      <td height='27' bgcolor='#D8D8D8' class='company'>&nbsp; 
                        <font color='#000000'><strong>ȸ���α���</strong> ��ȸ</font></td>
                    </tr>
                    <tr> 
                      <td height='60' align='center' bgcolor='#F6F6F6'> <table width='257' border='0' cellpadding='0' cellspacing='0' class='company'>
                          			  
						  <tr> 
                            <td width='57'>���̵�</td>
                            <td width='10'>:</td>
                            <td width='122'> <input name='login_id' type='text' size='17'></td>
                            <td width='60' rowspan='2' align='center'><input type=image src='{{image_url}}/but_s.gif' width='36' height='36'></td>
                          </tr>
                          <tr> 
                            <td>��й�ȣ</td>
                            <td>:</td>
                            <td> <input name='login_pwd' type='text' size='17'></td>
                          </tr>
                        </table></td>
                    </tr>
                  </table></form> </td>
                <td width='300'><FORM ACTION='{{home_dir}}/wizmember.asp' target='_blank'>
<INPUT TYPE=HIDDEN NAME=smode VALUE='non_member_order'> <table width='290' border='0' cellspacing='0' cellpadding='0'>
                    <tr> 
                      <td height='27' bgcolor='#D8D8D8' class='company'>&nbsp; 
                        <font color='#000000'><strong>�ֹ���ȣ��</strong> ��ȸ (��ȸ��)</font></td>
                    </tr>
                    <tr> 
                      <td height='60' align='center' bgcolor='#F6F6F6'> <table width='246' border='0' cellpadding='0' cellspacing='0' class='company'>
<tr> 
                            <td width='57'>�ֹ���ȣ</td>
                            <td width='10'>:</td>
                            <td width='122'> <input name='codevalue' type='text' id="codevalue" value='{{order_id}}' size='17'> 
                            </td>
                            <td width='60' align='center'><input type=image img src='{{image_url}}/but_s.gif' width='36' height='36'></td>
                          </tr>
                        </table></td>
                    </tr>
                  </table></form></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td height='65' align='right'> <table width='450' border='0' cellspacing='0' cellpadding='0'>
              <tr> 
                <td width='425' align='right' class='company'>{{mall_name}}�� �̿����ּż� 
                  �����մϴ�.<br></td>
                <td width='25'>&nbsp;</td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td height='88' align='center' background='{{image_url}}/bg_bottom.gif' class='company'>�����ŷ�����ȸ 
            ��� ��2000-1ȣ�� ���� �ȳ� ����ڹ�ȣ : {{mall_company_no}}<br>
            �ּ� :{{mall_address}} ��ȣ : {{mall_company}} ��ǥ�ڸ� : {{mall_ceo}}<br>
            ���θ���:{{mall_name}} �� ����ó : {{mall_tel}}, �ѽ���ȣ: {{mall_fax}}</td>
        </tr>
      </table></td>
    <td width='3' valign='top' bgcolor='E4E4E4'><img src='{{image_url}}/img_r.gif' width='3' height='4'></td>
  </tr>
  <tr bgcolor='E4E4E4'> 
    <td height='3' colspan='2' valign='top'><img src='{{image_url}}/img_l.gif' width='3' height='3'></td>
  </tr>
</table>
<!-- Body End -->
</body>
</html>
