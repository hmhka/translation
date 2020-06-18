/***
for permission to run command prompt = optional

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

***/



/***
powershell

$env:GOOGLE_APPLICATION_CREDENTIALS="C:\pvr\translation\html\google-account\ShriMataji-Lectures-7e137546e6c8.json"

***/

/***
filename 
C:\pvr\translation\html\request.json 

{
   "q":"So let us begin anew--remembering on both sides that civility is not a sign of weakness, and sincerity is always subject to proof. Let us never negotiate out of fear. But let us never fear to negotiate.",
   "target":"de",
   "model": "base"
}         


***/


/****
filename 
C:\pvr\translation\html\power-test.ps1


$cred = gcloud auth application-default print-access-token
$headers = @{ "Authorization" = "Bearer $cred" }

Invoke-WebRequest `
  -Method POST `
  -Headers $headers `
  -ContentType: "application/json; charset=utf-8" `
  -InFile request.json `
  -Uri "https://translation.googleapis.com/language/translate/v2
" | Select-Object -Expand Content
****/

/****
/*
The default encoding for command prompt is Windows-1252. Change the code page (chcp command) to 65001 (UTF-8) first and then run your command.
*/
/*
cmd.exe /c chcp 65001 > nul & cmd.exe /c some_command > file
*/
chcp 65001
powershell -file "power-test.ps1" > C:\pvr\translation\html\translated.txt
                                                  
****/

/***
write-output "your text" | out-file -append -encoding utf8 "filename"
**/


/******
filename 
C:\pvr\translation\html\translated.txt


{
  "data": {
    "translations": [
      {
        "translatedText": "Lassen Sie uns also neu beginnen - auf beiden Seiten daran erinnern, dass Zivilität kein Zeichen von Schwäche ist, und Aufrichtigkeit ist immer unter Beweis. Lassen Sie uns nie aus Angst verhandeln heraus. Aber lassen Sie uns nie zu verhandeln fürchten.",
        "detectedSourceLanguage": "en",
        "model": "base"
      }
    ]
  }
}





*******/
/*
output to value("C:\pvr\translation\html\translate.bat").
  PUT UNFORMATTED "chcp 65001" SKIP.
  PUT UNFORMATTED 'powershell -file "C:\pvr\translation\html\power-test.ps1" > C:\pvr\translation\html\translated.txt'.

output close.

OS-COMMAND value("C:\pvr\translation\html\translate.bat").
  */

os-command silent value(  'powershell -file "C:\pvr\translation\html\power-test.ps1" > C:\pvr\translation\html\translated.txt' ).
 
  
MESSAGE "Finished"
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
