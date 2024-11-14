<#
.SYNOPSIS
 Kurzbeschreibung des Skriptes: Abfrage von Events
.DESCRIPTION
 Längere Beschreibung: Abfrage des Security Eventlogs nach An bzw Abmeldebezogenen Events
.PARAMETER EventId
 Es sind folgende Werte möglich
 4624 -> Anmeldeevent
 4625 -> fehlgeschlagene Anmeldung
 4634 -> Abmeldung
.EXAMPLE
 Get-Eventlog.ps1 -EventId 4624 -Newest 2

   Index Time          EntryType   Source                 InstanceID Message
   ----- ----          ---------   ------                 ---------- -------
  774062 Nov 14 13:36  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  774059 Nov 14 13:36  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....

  bla bla Erklärung blabla
.EXAMPLE
 Bla Bla Erklärung 
 Get-Eventlog.ps1 -EventId 4624 -Newest 2 -Verbose
AUSFÜHRLICH: ZUsätzliche Ausgaben
AUSFÜHRLICH: Vom User übergeben: 4624 , 2 , localhost
AUSFÜHRLICH: Vor der Abfrage

   Index Time          EntryType   Source                 InstanceID Message
   ----- ----          ---------   ------                 ---------- -------
  774062 Nov 14 13:36  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  774059 Nov 14 13:36  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....

.LINK
 https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-5.1#syntax-for-comment-based-help-in-scripts
#>
[cmdletBinding()]
param(
[ValidateSet(4624,4634,4625)]
[Parameter(Mandatory=$true)]
[int]$EventId,

[ValidateRange(1,10)]
[int]$Newest = 5,

[ValidateScript({Test-NetConnection -ComputerName $PSItem -CommonTcpPort WinRm -InformationLevel Quiet})]
[string]$ComputerName = "localhost"
)

Write-Verbose -Message "ZUsätzliche Ausgaben"
Write-Verbose -Message "Vom User übergeben: $EventId , $Newest , $ComputerName"

Write-Verbose -Message "Vor der Abfrage"
Get-EventLog -LogName Security -ComputerName $computerName | Where-Object -FilterScript {$PSItem.EventID -eq $EventId} | Select-Object -First $Newest

