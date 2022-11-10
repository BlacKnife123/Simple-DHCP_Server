$NICNAME = "card-name"
$IFINDEX = (Get-NetAdapter | Where-Object Name -EQ "$NICNAME" | Select-Object -ExpandProperty "IfIndex")
$IPADDRESS = "40.40.40.1"
$PREFIX = "24"
$MASK = "255.255.255.0"
$LOOPBACK = "127.0.0.1"
$SERVICE = "DHCP"
$SCOPENAME = "NAME2"
$STARTRANGE = "40.40.40.100"
$ENDRANGE = "40.40.40.150"

New-NetIPAddress -InterfaceIndex "$IFINDEX" -IPAddress "$IPADDRESS" -PrefixLength "$PREFIX"
Set-DnsClientServerAddress -InterfaceIndex "$IFINDEX" -ServerAddresses "$LOOPBACK"

Install-WindowsFeature -Name "$SERVICE" -IncludeManagementTools

Add-DhcpServerv4Scope -Name "$SCOPENAME" -StartRange "$STARTRANGE" -EndRange "$ENDRANGE" -SubnetMask "$MASK" -State Active
Set-DhcpServerv4OptionValue -Router "$IPADDRESS"





