<% Option Explicit %>
<!-- #include file = "../../lib/cfg.common.asp" -->
<!-- #include file = "../admin_access.asp" -->


<!-- #include file = "../../config/db_connect.asp" -->
<!-- #include file = "../../config/skin_info.asp" -->
<!-- #include file = "../../lib/class.database.asp" -->
<!-- #include file = "../../lib/class.util.asp" -->
<!-- #include file = "../../lib/class.admin_member.asp" -->
<%
Dim qry
Dim ESex,CSex,ECompany,CCompany,ECompnum,CCompnum,ETel2,CTel2,EMailReceive,CMailReceive,EBirthDay,CBirthDay,EMarrStatus
Dim CMarrStatus,EJob,CJob,EScholarship,CScholarship,EAddress3,CAddress3,ERecID,CRecID,EGrantSta,EPoint,RPoint,LPoint
Dim INCLUDE_MALL_SKIN,SendMail,member_agreement,use_agreement,privacy_agreement,MemberSkinTop,MemberSkinBottom,WELCOM_MESSAGE
Dim realnameModule, realnameID, realnamePWD

''Dim strSQL,objRs
Dim db,util,member
Set util = new utility	
Set member = new admin_member	
''Set db = new database
qry					= Request("qry")
ESex				= Request("ESex")
CSex				= Request("CSex")
ECompany			= Request("ECompany")
CCompany			= Request("CCompany")
ECompnum			= Request("ECompnum")
CCompnum			= Request("CCompnum")
ETel2				= Request("ETel2")
CTel2				= Request("CTel2")
EMailReceive		= Request("EMailReceive")
CMailReceive		= Request("CMailReceive")
EBirthDay			= Request("EBirthDay")
CBirthDay			= Request("CBirthDay")
EMarrStatus			= Request("EMarrStatus")
CMarrStatus			= Request("CMarrStatus")
EJob				= Request("EJob")
CJob				= Request("CJob")
EScholarship		= Request("EScholarship")
CScholarship		= Request("CScholarship")
EAddress3			= Request("EAddress3")
CAddress3			= Request("CAddress3")
ERecID				= Request("ERecID")
CRecID				= Request("CRecID")
EGrantSta			= Request("EGrantSta")
EPoint				= Request("EPoint")
RPoint				= Request("RPoint")
LPoint				= Request("LPoint")
INCLUDE_MALL_SKIN	= Request("INCLUDE_MALL_SKIN")
SendMail			= Request("SendMail")

realnameModule		= Request("realnameModule")
realnameID			= Request("realnameID")
realnamePWD			= Request("realnamePWD")

member_agreement	= Request("member_agreement")
use_agreement		= Request("use_agreement")
privacy_agreement	= Request("privacy_agreement")
MemberSkinTop		= Request("MemberSkinTop")
MemberSkinBottom	= Request("MemberSkinBottom")
WELCOM_MESSAGE		= Request("WELCOM_MESSAGE")

if qry = "qup" then
	Call util.makeFile_membercheckInfo
	Call member.makeFile_memberagreementInfo()
	Call member.makeFile_useagreementInfo()
	Call member.makeFile_privacyagreementInfo()
	Set util = Nothing
	Set member = Nothing
	Response.Redirect("../main.asp?menushow=menu1&theme=basicinfo/basic_info8")
end if
%>
