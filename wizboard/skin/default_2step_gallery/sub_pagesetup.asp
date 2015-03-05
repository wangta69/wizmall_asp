<%
Dim TransDate
TransData = "&bmode=view&bid=" & bid & "&gid=" & gid & "&uid=" & puid & "&page=" & page & "&adminmode=" & adminmode & "&search_title=" & search_title & "&search_keyword=" & search_keyword
%>
<table width="155" height="30" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td align="center"> <%
	IntStart = INT((((subpage - 1) \ setPageLink)) * setPageLink + 1)
	IntEnd = INT(((((subpage - 1) + setPageLink) \ setPageLink)) * setPageLink)
	
	
	
	IF INT(TotalPage) < intEnd THEN IntEnd = TotalPage
		IF INT(subpage) > INT(setPageLink) THEN
			RESPONSE.WRITE "<a href='wizboard.asp?subpage=" & int(subpage - setPageLink) & TransData & "'><img src='" & skin_path & "icon/prev_btn.gif' border=0>"
			RESPONSE.WRITE "<a href='wizboard.asp?subpage=1" & TransData & "'></a>.. &nbsp;"
		END IF
%> </td>
    <td align="center"><%


		FOR I = IntStart TO IntEnd 
			IF I = IntStart THEN
				'TMPSPLIT = ""
			ELSE 
				'TMPSPLIT = "/"
			END IF 
			
			IF INT(I) = INT(subpage) THEN
				RESPONSE.WRITE "&nbsp;<b>["&i&"]</b>&nbsp;"
			ELSE
				RESPONSE.WRITE "<a href='wizboard.asp?subpage=" & I & TransData & "'>&nbsp;["& I & "]&nbsp;</a>"
			END IF
		NEXT
%></td>
    <td align="center"> <%
		IF INT(TotalPage - IntStart + 1) > INT(setPageLink) THEN RESPONSE.WRITE "<a href='wizboard.asp?subpage=" & TotalPage & TransData & "'></a>"

		IF INT(subpage) + setPageLink > TotalPage + 1 THEN
		ELSEIF INT(subpage) + setPageLink < TotalPage + 1 THEN
			RESPONSE.WRITE "<a href='wizboard.asp?subpage=" & INT(subpage + setPageLink) & TransData & "'><img src='" & skin_path & "icon/next_btn.gif' border=0>"
		END IF
%> </td>
  </tr>
</table>
