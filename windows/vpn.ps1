REG ADD HKLM\SYSTEM\CurrentControlSet\Services\PolicyAgent /v AssumeUDPEncapsulationContextOnSendRule /t REG_DWORD /d 0x2 /f


Add-VpnConnection -Name Home -ServerAddress "ip.lklaus.ch" -TunnelType L2tp -RememberCredential -L2tpPsk "31Yxcvbnm,.-vpn" -AuthenticationMethod MSChapv2 -DnsSuffix "klaus.local" -Force
