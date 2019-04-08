"リモート設定"	

Enable-PSRemoting -SkipNetworkProfileCheck

Set-Item WSMan:\localhost\Client\TrustedHosts * -Force

netsh advfirewall firewall add rule name=PsExec dir=in action=allow localport=rpc-epmap protocol=tcp program= %windir%\system32\svchost.exe
netsh advfirewall firewall add rule name=PsExec dir=in action=allow localport=445 protocol=tcp
netsh advfirewall firewall add rule name=PsExec dir=in action=allow localport=rpc protocol=tcp program=%SystemRoot%\system32\services.exe

pause
