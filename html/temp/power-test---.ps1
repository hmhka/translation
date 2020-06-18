$env:GOOGLE_APPLICATION_CREDENTIALS="C:\pvr\translation\html\google-account\ShriMataji-Lectures-7e137546e6c8.json"
$cred = gcloud auth application-default print-access-token
$headers = @{ "Authorization" = "Bearer $cred" }

Invoke-WebRequest `
  -Method POST `
  -Headers $headers `
  -ContentType: "application/json; charset=utf-8" `
  -InFile C:\pvr\translation\html\request2.json `
  -Uri "https://translation.googleapis.com/v3/projects/shrimataji-lectu-1591255492283/locations/global:translateText
" | Select-Object -Expand Content

