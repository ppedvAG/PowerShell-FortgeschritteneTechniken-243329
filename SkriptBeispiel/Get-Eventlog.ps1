[cmdletBinding()]
param(
[Parameter(Mandatory=$true)]
[int]$EventId,

[int]$Newest = 5,

[string]$ComputerName = "localhost"
)

Write-Verbose -Message "ZUsätzliche Ausgaben"
Write-Verbose -Message "Vom User übergeben: $EventId , $Newest , $ComputerName"

Write-Verbose -Message "Vor der Abfrage"
Get-EventLog -LogName Security -ComputerName $computerName | Where-Object -FilterScript {$PSItem.EventID -eq $EventId} | Select-Object -First $Newest

