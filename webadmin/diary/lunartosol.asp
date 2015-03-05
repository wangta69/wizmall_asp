<% Option Explicit %>
<%
dim exyear,exmonth,exday,exyuk,exddi
Function gf_lun2sol(gf_year,gf_month,gf_day,howconvert)

	LTBLSTR="1212122322121-1212121221220-1121121222120-2112132122122-2112112121220-2121211212120-2212321121212-2122121121210-2122121212120-1232122121212-1212121221220-1121123221222-1121121212220-1212112121220-2121231212121-2221211212120-1221212121210-2123221212121-2121212212120-1211212232212-1211212122210-2121121212220-1212132112212-2212112112210-2212211212120-1221412121212-1212122121210-2112212122120-1231212122212-1211212122210-2121123122122-2121121122120-2212112112120-2212231212112-2122121212120-1212122121210-2132122122121-2112121222120-1211212322122-1211211221220-2121121121220-2122132112122-1221212121120-2121221212110-2122321221212-1121212212210-2112121221220-1231211221222-1211211212220-1221123121221-2221121121210-2221212112120-1221241212112-1212212212120-1121212212210-2114121212221-2112112122210-2211211412212-2211211212120-2212121121210-2212214112121-2122122121120-1212122122120-1121412122122-1121121222120-2112112122120-2231211212122-2121211212120-2212121321212-2122121121210-2122121212120-1212142121212-1211221221220-1121121221220-2114112121222-1212112121220-2121211232122-1221211212120-1221212121210-2121223212121-2121212212120-1211212212210-2121321212221-2121121212220-1212112112210-2223211211221-2212211212120-1221212321212-1212122121210-2112212122120-1211232122212-1211212122210-2121121122210-2212312112212-2212112112120-2212121232112-2122121212110-2212122121210-2112124122121-2112121221220-1211211221220-2121321122122-2121121121220-2122112112322-1221212112120-1221221212110-2122123221212-1121212212210-2112121221220-1211231212222-1211211212220-1221121121220-1223212112121-2221212112120-1221221232112-1212212122120-1121212212210-2112132212221-2112112122210-2211211212210-2221321121212-2212121121210-2212212112120-1232212122112-1212122122120-1121212322122-1121121222120-2112112122120-2211231212122-2121211212120-2122121121210-2124212112121-2122121212120-1212121223212-1211212221220-1121121221220-2112132121222-1212112121220-2121211212120-2122321121212-1221212121210-2121221212120-1232121221212-1211212212210-2121123212221-2121121212220-1212112112220-1221231211221-2212211211220-1212212121210-2123212212121-2112122122120-1211212322212-1211212122210-2121121122120-2212114112122-2212112112120-2212121211210-2212232121211-2122122121210-2112122122120-1231212122212-1211211221220-2121121321222-2121121121220-2122112112120-2122141211212-1221221212110-2121221221210-2114121221221" '2050
    LTBL = Split(LTBLSTR,"-")
    
    LDAYSTR="31-0-31-30-31-30-31-31-30-31-30-31"
    LDAY = Split(LDAYSTR,"-")

    DT = LTBL

    YUKSTR="갑-을-병-정-무-기-경-신-임-계"
    YUK=Split(YUKSTR,"-")

    GAPSTR="자-축-인-묘-진-사-오-미-신-유-술-해"
    GAP=Split(GAPSTR,"-")

    DDISTR="쥐-소-호랑이-토끼-용-뱀-말-양-원숭이-닭-개-돼지"
    DDI=Split(DDISTR,"-")

    WEEKSTR="일-월-화-수-목-금-토"
    WEEK=Split(WEEKSTR,"-")
    
    If gf_Year <= 1881 Or gf_Year >= 2050 Then '년수가 해당일자를 넘는 경우
       gf_Is_Yun = 0
%>
<script language="javascript">
<!--
alert("년도가 범위를 벗어납니다. \n\n1882년부터 2049년사이의 년도를 입력하세요.");

history.back();
//-->
</script>
<%
    End If 
    If gf_Month + 1 > 13 Then '달수가 13이 넘는 경우
       gf_Is_Yun = 0
%>
<script language="javascript">
<!--
alert("달수가 범위를 벗어납니다. \n\n1월부터 12월사이의 달을 입력하세요.");

history.back();
//-->
</script>
<%
    End If
    
    M1 = gf_Year - 1881
    If Mid(LTBL(M1), 13, 1) = 0 Then '윤달이 없는 해임
        gf_Is_Yun = 0
    Else
        If Mid(LTBL(M1), gf_Month + 1, 1) > 2 Then
            gf_Is_Yun = 1
        Else
            gf_Is_Yun = 0
        End If
    End If


if howconvert="1" then
'------------------------양력변환--------------------

    M1 = -1
    TD = 0
    
    If gf_Year > 1881 And gf_Year < 2050 Then
       M1 = gf_Year - 1882
       For I = 0 To M1
           For J = 1 To 13
              TD = TD + CLng(Mid(LTBL(I), J, 1))
           Next
       If Mid(LTBL(I), 13, 1) = 0 Then
          TD = TD + 336
       Else
          TD = TD + 362
       End If
       Next
    Else
        GF_LUN2SOL = 0
    End If
    
    M1 = M1 + 1
    N2 = gf_Month - 1
    M2 = -1
    
    Do
       M2 = M2 + 1
       If Mid(LTBL(M1), M2 + 1, 1) > 2 Then
          TD = TD + 26 + CLng(Mid(LTBL(M1), M2 + 1, 1))
          N2 = N2 + 1
       Else
          If M2 = N2 Then
            If GF_YUN = True Then
                TD = TD + 28 + CLng(Mid(LTBL(M1), M2 + 1, 1))
            End If
            Exit Do
          Else
             TD = TD + 28 + CLng(Mid(LTBL(M1), M2 + 1, 1))
          End If
       End If
     Loop
     
     TD = TD + CLng(GF_DAY) + 29
     M1 = 1880
     Do
          M1 = M1 + 1
          If M1 Mod 400 = 0 Or M1 Mod 100 <> 0 And M1 Mod 4 = 0 Then
             LEAP = 1
          Else
             LEAP = 0
          End If
          
          If LEAP Then
             M2 = 366
          Else
             M2 = 365
          End If
          If TD < CLng(M2) Then
             Exit Do
          End If
          TD = TD - CLng(M2)
     Loop
     SYEAR = M1
     LDAY(1) = M2 - 337

     M1 = 0
     
     Do
          M1 = M1 + 1
          If TD <= CLng(LDAY(M1 - 1)) Then
             Exit Do
          End If
          TD = TD - CLng(LDAY(M1 - 1))
     Loop
     SMONTH = M1
     SDAY = CInt(TD)
     Y = CLng(SYEAR - 1)
     TD = CLng(Y * 365) + CLng(Y / 4) - CLng(Y /100) + CLng(Y /400)
     
     If SYEAR Mod 400 = 0 Or SYEAR Mod 100 <> 0 And SYEAR Mod 4 = 0 Then
        LEAP = 1
     Else
        LEAP = 0
     End If
 
     If LEAP=1 Then
        LDAY(1) = 29
     Else
        LDAY(1) = 28
     End If
     For I = 0 To SMONTH - 2
         TD = TD + CLng(LDAY(I))
     Next
     TD = TD + CLng(SDAY)
     W = CInt(TD Mod 7)
     
     sweek = WEEK(W)
     GF_LUN2SOL = 1

	exyear=syear
	exmonth=smonth
	exday=sday
	exweek=sweek

else
'------------------------음력변환--------------------
    For I = 0 To 168
        DT(I) = 0
        For J = 1 To 12
            Select Case Mid(LTBL(I), J, 1)
                   Case 1, 3
                        DT(I) = DT(I) + 29
                   Case 2, 4
                        DT(I) = DT(I) + 30
            End Select
        Next
        
        Select Case Mid(LTBL(I), 13, 1)
               Case 0
               Case 1, 3
                    DT(I) = DT(I) + 29
               Case 2, 4
                    DT(I) = DT(I) + 30
        End Select
    Next
    TD1 = CLng(CLng(1880) * CLng(365)) + 1880 \ 4 - 1880 \ 100 + 1880 \ 400 + 30
    K11 = CLng(gf_Year - 1)
    TD2 = K11 * CLng(365) + K11 \ 4 - K11 \ 100 + K11 \ 400
    
    If gf_Year Mod 400 = 0 Or gf_Year Mod 100 <> 0 And gf_Year Mod 4 = 0 Then
        LDAY(1) = 29
    Else
        LDAY(1) = 28
    End If
    If gf_Month > 13 Then
        GF_SOL2LUN = 0
    End If
    If GF_DAY > LDAY(gf_Month - 1) Then
        GF_SOL2LUN = 0
    End If
    
    For I = 0 To gf_Month - 2
        TD2 = TD2 + CLng(LDAY(I))
    Next
    TD2 = TD2 + CLng(GF_DAY)
    TD = TD2 - TD1 + 1
    TD0 = CLng(DT(0))

    For I = 0 To 168
        If TD <= TD0 Then
           Exit For
        End If
        TD0 = TD0 + CLng(DT(I + 1))
    Next
    
    rYear = I + 1881
    TD0 = TD0 - CLng(DT(I))
    TD = TD - TD0
    
    If Mid(LTBL(I), 13, 1) = 0 Then
       JCOUNT = 11
    Else
       JCOUNT = 12
    End If
    M2 = 0
    
    For J = 0 To JCOUNT '달수 check, 윤달 > 2 (by harcoon)
        If Mid(LTBL(I), J + 1, 1) <= 2 Then
            M2 = M2 + 1
            M1 = Mid(LTBL(I), J + 1, 1) + 28
            GF_YUN = 0
        Else
            M1 = Mid(LTBL(I), J + 1, 1) + 26
            GF_YUN = 1
        End If
        If TD <= CLng(M1) Then
           Exit For
        End If
        TD = TD - CLng(M1)
    Next

     k1=(ryear+6) Mod 10
     syuk = YUK(k1)
     k2=(ryear+8) Mod 12
     sgap = GAP(k2)
     sddi=DDI(k2)
    
    GF_SOL2LUN = 1

	exyear=ryear
	exmonth=M2
	exday=TD
	exyuk=syuk&sgap
	exddi=sddi
end if
end function
%>
