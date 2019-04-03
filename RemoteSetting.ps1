	
Enable-PSRemoting -SkipNetworkProfileCheck


Set-Item WSMan:\localhost\Client\TrustedHosts * -Force

pause