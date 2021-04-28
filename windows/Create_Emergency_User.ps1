$Password = Read-Host -Prompt "Emergency Passwort"

$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force


New-LocalUser "Emergency" -Password $SecurePassword -FullName "Emergency" -Description "Notfall Account RedIT" -PasswordNeverExpires -AccountNeverExpires
Add-LocalGroupMember -Group "Administrators" -Member "Emergency"

$UserAccount = Get-LocalUser -Name "Emergency"
$UserAccount | Set-LocalUser -Password $SecurePassword

pause