c:\zabbix\bin\zabbix_agentd.exe -c c:\zabbix\conf\zabbix_agentd.conf -i

netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol="icmpv4:8,any" dir=in action=allow
netsh advfirewall firewall add rule name="Open Port 10050" dir=in action=allow protocol=TCP localport=10050

Set-Service -Name "Zabbix Agent" -StartupType Automatic
Start-Service "Zabbix Agent"