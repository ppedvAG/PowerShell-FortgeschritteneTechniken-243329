param(
[int]$EventId,

[int]$Newest = 5,

[string]$ComputerName = "localhost"
)

Get-EventLog -LogName Security -ComputerName $computerName | Where-Object -FilterScript {$PSItem.EventID -eq $EventId} | Select-Object -First $Newest

