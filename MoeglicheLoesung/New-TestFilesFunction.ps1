[cmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [ValidateScript({Test-Path -Path $PSItem -Pathtype Container})]
    [string]$Path,

    [Validatelength(2,15)]
    [string]$DirName = "TestFiles2",

    [ValidateRange(1,20)]
    [int]$FileCount = 9,

    [ValidateRange(0,20)]
    [int]$DirCount = 2,

    [switch]$force
)
# Start Funktionsdeklartion
function New-TestFiles
{
    [cmdletBinding()]
    param(
    [Parameter(Mandatory=$true)]
    [ValidateScript({Test-Path -Path $PSItem -Pathtype Container})]
    [string]$Path,

    
    [ValidateRange(1,20)]
    [int]$FileCount = 9,

    [Validatelength(2,50)]
    [string]$Name = "File"
    )

    for($i = 1; $i -le $FileCount; $i++)
    { #Schleife zum erstellen der Dateien im Root Verzeichnis
        $FileNumber = "{0:D3}" -f $i
        $FileName = $Name + $FileNumber + ".txt"

        New-Item -Path $Path -Name $FileName -ItemType File
    }
}
# Ende Funktionsdeklaration


$TestDirPath = Join-Path -Path $Path -ChildPath $DirName

if(Test-Path -Path $TestDirPath -PathType Container)
{ #Prüfen ob Ordner vorhanden ansonsten warnung oder löschen bei force
    if($force)
    {
        Remove-Item -Path $TestDirPath -Force -Recurse
    }
    else
    {
        Write-Error -ErrorAction Stop -Message "Ordner bereits vorhanden" -TargetObject (Get-Item -Path $TestDirPath)
    }
}

$TestDir = New-Item -Path $Path -Name $DirName -ItemType Directory


New-TestFiles -Path $TestDir.FullName -FileCount $FileCount 
<# Ersetzt durch Funktion New-TestFiles
Write-Verbose -Message "Vor Schleife Files Root"
for($i = 1; $i -le $FileCount; $i++)
{ #Schleife zum erstellen der Dateien im Root Verzeichnis
    $FileNumber = "{0:D3}" -f $i
    $FileName = "File" + $FileNumber + ".txt"

    New-Item -Path $TestDir.FullName -Name $FileName -ItemType File
}#> 

Write-Debug -Message "Vor Schleife Ordner"

Write-Verbose -Message "Vor Schleife Ordner"
for($i = 1; $i -le $DirCount; $i++)
{ #Schleife zum anlegen der Ordner
    $DirNumber = "{0:D3}" -f $i
    $DirName = "Dir" + $DirNumber

    $subdir = New-Item -Path $TestDir.FullName -Name $DirName -ItemType Directory

    New-TestFiles -Path $subdir.FullName -FileCount $FileCount -Name "Dir$($DirNumber)-File"
    <# Ersetzt durch Funktion New-TestFiles
    for($j = 1; $j -le $FileCount; $j++)
    {
        $FileNumber = "{0:D3}" -f $j
        $FileName = "File" + $FileNumber + ".txt"

        New-Item -Path $subdir.FullName -Name $FileName -ItemType File
    }#>
}