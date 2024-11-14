param(
$EventId,
$Newest,
$computerName = "localhost"
)

Get-EventLog -LogName Security -ComputerName $computerName | Where-Object -FilterScript {$PSItem.EventID -eq $EventId} | Select-Object -First $Newest

