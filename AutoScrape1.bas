Attribute VB_Name = "Module1"
Sub Button1_Click()
Attribute Button1_Click.VB_ProcData.VB_Invoke_Func = " \n14"
'
' Button1_Click Macro
'
'

Dim filename3 As String
  Dim chromePath As String

  chromePath = """C:\Program Files\Google\Chrome\Application\chrome.exe"""
  Shell ("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe -url C:\tmp\SubtitleFiles\16Steps1\01Introduction_en.srt") '// Or the address
  Application.Wait (Now + TimeValue("0:00:05"))
  Set WshShell = CreateObject("WScript.Shell")
    
' WshShell.Run "C:\pvr\translation\OpenFileInChrome.bat"
    
' Shell ("C:\Users\USERNAME\AppData\Local\Google\Chrome\Application\Chrome.exe -url http:google.ca")
' WshShell.Sleep "100"
' WshShell.SendKeys "cd.."
  WshShell.SendKeys "^a"
    
  Application.Wait (Now + TimeValue("0:00:10"))
    
  WshShell.SendKeys "^c"
  WshShell.SendKeys "^w"
    
  filename3 = "C:\tmp\SubtitleFiles\16Steps1\01Introduction_hin.srt"
    
  With Application
    Selection.Copy
    'Shell "Notepad.exe", 3
    Shell ("C:\Windows\system32\notepad.exe" & " " & filename3), 3
    'SendKeys "^v" + "^s" + "%{F4}" + "{ENTER}"
    SendKeys "^v"
    'SendKeys "%{F4}" + "{ENTER}"
    SendKeys "^s" + "%{F4}"
    'SendKeys "C:\tmp\SubtitleFiles\16Steps\01Introduction_spa.srt" & "{ENTER}"
    VBA.AppActivate .Caption
    .CutCopyMode = False
  End With

End Sub


