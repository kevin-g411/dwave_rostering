Attribute VB_Name = "Module2"
Dim stamp As String


Sub table()
Attribute table.VB_ProcData.VB_Invoke_Func = " \n14"
'
' table Macro

Dim ii As Integer
Dim j As Integer
Dim k As Integer

Dim members As Integer
Dim days As Integer
Dim skills As Integer
members = Range("C2").Value
days = Range("C3").Value
skills = Range("C4").Value

Cells.Clear
Range("B2").Value = "人数"
Range("C2").Value = members
Range("B3").Value = "日数"
Range("C3").Value = days
Range("B4").Value = "スキル数"
Range("C4").Value = skills


Range("B6").Value = "スキル表"
For i = 0 To members - 1
  Cells(i + 7, 2).Value = Chr(i + 65)
Next i

For k = 0 To skills - 1
  Cells(6, k + 3).Value = Chr(k + 97)
Next k

Cells(6, skills + 4).Value = "出勤希望日"
For i = 0 To members - 1
  Cells(i + 7, skills + 4).Value = Chr(i + 65)
Next i

For j = 0 To days - 1
  Cells(6, j + skills + 5).Value = j + 1
Next j

Cells(6, skills + days + 6).Value = "必要スキル数"
For k = 0 To skills - 1
  Cells(6, k + skils + days + 10).Value = Chr(k + 97)
Next k
  
For j = 0 To days - 1
  Cells(j + 7, skills + days + 6).Value = j + 1
Next j
 
Cells.Select
Selection.EntireColumn.AutoFit

    Range("C2:D2").Select
    Selection.Merge True
    Range("C3:D3").Select
    Selection.Merge True
    Range("C4:D4").Select
    Selection.Merge True
    
    Range("B2:D2").Select
    With Selection.Borders(xlEdgeBottom)
        .LineStyle = xlContinuous
        .ColorIndex = 0
    End With
    Range("B3:D3").Select
    With Selection.Borders(xlEdgeTop)
        .LineStyle = xlContinuous
        .ColorIndex = 0
    End With
    With Selection.Borders(xlEdgeBottom)
        .LineStyle = xlContinuous
        .ColorIndex = 0
    End With
    Range("B4:D4").Select
    With Selection.Borders(xlEdgeBottom)
        .LineStyle = xlContinuous
        .ColorIndex = 0
    End With
    With Selection.Borders(xlEdgeBottom)
        .LineStyle = xlContinuous
        .ColorIndex = 0
    End With
 
     Range(Cells(6, 2), Cells(6, 2 + skills)).Select
    With Selection.Borders(xlEdgeBottom)
        .LineStyle = xlContinuous
        .ColorIndex = 0
    End With
    Range(Cells(6, 4 + skills), Cells(6, 4 + skills + days)).Select
    With Selection.Borders(xlEdgeBottom)
        .LineStyle = xlContinuous
        .ColorIndex = 0
     End With
    Range(Cells(6, 6 + skills + days), Cells(6, 6 + 2 * skills + days)).Select
    With Selection.Borders(xlEdgeBottom)
        .LineStyle = xlContinuous
        .ColorIndex = 0
    End With
    
    Range(Cells(6, 2), Cells(6 + members, 2)).Select
    With Selection.Borders(xlEdgeRight)
        .LineStyle = xlContinuous
        .ColorIndex = 0
    End With
    Range(Cells(6, 4 + skills), Cells(6 + members, 4 + skills)).Select
    With Selection.Borders(xlEdgeRight)
        .LineStyle = xlContinuous
        .ColorIndex = 0
    End With
    Range(Cells(6, 6 + skills + days), Cells(6 + days, 6 + skills + days)).Select
    With Selection.Borders(xlEdgeRight)
        .LineStyle = xlContinuous
        .ColorIndex = 0
    End With
    
End Sub
Sub execute()
Attribute execute.VB_ProcData.VB_Invoke_Func = " \n14"
'
' execute Macro
'
Dim i As Integer, j As Integer, ind As Integer
Dim members As Integer, days As Integer, skills As Integer
Dim name As String

members = Range("C2").Value
days = Range("C3").Value
skills = Range("C4").Value


Worksheets(3).Cells.Clear
        
Worksheets(3).Cells(1, 1).Value = Range("C2")
Worksheets(3).Cells(1, 2).Value = Range("C3")
Worksheets(3).Cells(1, 3).Value = Range("C4")


For i = 0 To members - 1
    For j = 0 To skills - 1
        ind = i * skills + j
        Worksheets(3).Cells(2, ind + 1).Value = Cells(7 + i, 3 + j)
    Next j
Next i

For i = 0 To members - 1
    For j = 0 To days - 1
        ind = j * members + i
        Worksheets(3).Cells(3, ind + 1).Value = Cells(7 + i, skills + 5 + j)
    Next j
Next i

For i = 0 To days - 1
    For j = 0 To skills - 1
        ind = i * skills + j
        Worksheets(3).Cells(4, ind + 1).Value = Cells(7 + i, skills + days + 7 + j)
    Next j
Next i

For i = 1 To days * members
    Worksheets("params").Cells(3, i).Value = Worksheets("params").Cells(3, i) - 1
    If Worksheets("params").Cells(3, i) < 0 Then
        Worksheets("params").Cells(3, i).Value = -1 * Worksheets("params").Cells(3, i)
    End If
Next
Application.DisplayAlerts = False
    
Worksheets(3).Copy
stamp = Format(Now, "mmdd_hhmm")
ActiveWorkbook.SaveAs FileName:="C:\Users\watanabe.kevin\Desktop\d-wave_output_oji\params\prm" + stamp + ".csv", _
    FileFormat:=xlCSV
ActiveWindow.Close
    
Application.DisplayAlerts = True
'
End Sub

Sub output()
Attribute output.VB_ProcData.VB_Invoke_Func = " \n14"
'
' output Macro
'

'd-wave output name candidates
'startdate_members_days_skills_alpha.csv
'

Dim n As Integer, i As Integer, j As Integer, k As Integer, ind As Integer, ind2 As Integer, lack As Integer
Dim s As String, t As String
Dim str1 As String, str2 As String, str3 As String, str4 As String, str5 As String
Dim buf As Integer, name As String, Target As String
Dim binary() As Variant
Dim members As Integer, days As Integer
Dim dif As Integer, wf As Double
Dim objSheet As Variant

Sheets(2).Activate
Range("5:1048576").Delete

members = Worksheets("params").Range("A1")
days = Worksheets("params").Range("B1")
skills = Worksheets("params").Range("C1")
Range("C2").Value = stamp
Range("C3").Value = days
Range("C4").Value = members
               
For i = 1 To days * members
    Worksheets("params").Cells(3, i).Value = Worksheets("params").Cells(3, i) - 1
    If Worksheets("params").Cells(3, i) < 0 Then
        Worksheets("params").Cells(3, i).Value = -1 * Worksheets("params").Cells(3, i)
    End If
Next
               
Range(Cells(7, 6), Cells(6 + members, 6)).Select
With Selection
    .HorizontalAlignment = xlCenter
    .VerticalAlignment = xlCenter
    .MergeCells = True
End With
Range(Cells(5, 8), Cells(5, 7 + days)).Select
With Selection
    .HorizontalAlignment = xlCenter
    .VerticalAlignment = xlCenter
    .MergeCells = True
End With

Range("F7").Value = "従業員"
Range("H5").Value = "時間"
For i = 0 To members - 1
    Cells(i + 7, 7).Value = Chr(i + 65)
Next i
Cells(i + 7, 7).Value = "スキル不足"
Columns("G:G").EntireColumn.AutoFit
For j = 0 To days - 1
    Cells(6, j + 8).Value = j + 1
Next j


Dim skill() As Variant
ReDim skill(members * skills)
For i = 1 To members * skills
    skill(i - 1) = Worksheets("params").Cells(2, i)
Next
Dim subm() As Variant
ReDim subm(members * days)
For i = 1 To members * days
    subm(i - 1) = Worksheets("params").Cells(3, i)
Next
Dim req() As Variant
ReDim req(days * skills)
For i = 1 To skills * days
    req(i - 1) = Worksheets("params").Cells(4, i)
Next

ind = 1
n = 1
name = "C:\Users\watanabe.kevin\Desktop\d-wave_output_oji\Dwave" + stamp + ".csv"
Open name For Input As #n
    
'    Do While Not EOF(n)
'        i = i + 1
    Input #n, str1, str2, str3, str4, str5
    
    i = 0
    j = 0
           
    Do While ind <> 0
        s = CStr(j)
        t = "x" + s
        If j < 10 Then
            buf = Mid(str1, InStr(1, str1, t) + 5, 1)
        ElseIf j < 100 Then
            buf = Mid(str1, InStr(1, str1, t) + 6, 1)
        Else
            buf = Mid(str1, InStr(1, str1, t) + 7, 1)

        End If
        
        'Cells(14 + j, 30).Value = buf
        'Cells(14 + j, 31).Value = j
        
        ReDim Preserve binary(j)
        binary(j) = buf
        
        j = j + 1
        ind = InStr(str1, j)
    Loop
Close #n

For i = 0 To days - 1
    For j = 0 To members - 1
        ind = i * members + j
        Cells(j + 7, i + 8).Value = binary(ind)
        dif = binary(ind) - subm(ind)
        Cells(j + 7, i + 8).Select
        If binary(ind) = 0 Then
            With Selection.Font
                .ThemeColor = xlThemeColorDark1
                .TintAndShade = 0
            End With
        End If
        If dif = 0 Then
            With Selection.Interior
                .Pattern = xlSolid
                .PatternColorIndex = xlAutomatic
                .ThemeColor = xlThemeColorAccent6
                .TintAndShade = 0.599993896298105
                .PatternTintAndShade = 0
            End With
        ElseIf dif < 0 Then
            With Selection.Interior
                .Pattern = xlSolid
                .PatternColorIndex = xlAutomatic
                .ThemeColor = xlThemeColorAccent4
                .TintAndShade = 0.599993896298105
                .PatternTintAndShade = 0
            End With
        Else
            With Selection.Interior
                .Pattern = xlSolid
                .PatternColorIndex = xlAutomatic
                .Color = 10053375
                .TintAndShade = 0
                .PatternTintAndShade = 0
            End With
        End If
    Next j
Next i
    
For i = 0 To days - 1
    lack = 0
    For j = 0 To skills - 1
        wf = 0
        For k = 0 To members - 1
            ind = i * members + k
            ind2 = k * skills + j
            wf = wf + binary(ind) * skill(ind2)
        Next k
        ind = i * skills + j
        dif = wf - req(ind)
        If dif < 0 Then
           lack = lack + 1
        End If
    Next j
    If lack = 0 Then
        Cells(7 + members, 8 + i).Value = "なし"
        Cells(7 + members, 8 + i).Font.Color = xlThemeColorLight1
    Else
        Cells(7 + members, 8 + i).Value = "あり"
        Cells(7 + members, 8 + i).Font.Color = -16776961
    End If
Next i
    
'    Loop
End Sub

Public Sub python_exe()
'
' python_exe Macro
'
   Call RunPython("import staff_rostering_1062; staff_rostering_1062.callDwave('" & stamp & "')")
'
End Sub

Sub button()
Attribute button.VB_ProcData.VB_Invoke_Func = " \n14"
'
' button Macro
'
MsgBox "計算準備中"
Call execute

MsgBox "計算開始"
Call python_exe

MsgBox "計算終了"
Call output

End Sub
