function Test-paramPosition
{
[cmdletBinding(PositionalBinding=$false)]
param(
    [Parameter(Position=0)]
    $param1,

    [Parameter()]
    $param2
)
    # Ich empfehle tatsächlich die Positionalen Parameter nur dort zu verwenden wo es absolut notwendig ist.
    # Benannte Parameter die sauber mit ParameterName und PArameterwert genutzt sind viel besser zu verstehen sind
    # in einem halben Jahr wenn man das Skript überarbeitet

    Write-Host -Object $param1 -ForegroundColor DarkYellow
    Write-Host -Object $param2 -ForegroundColor DarkCyan

}

function Test-MandatoryHelpMessage
{
[cmdletBinding()]
param(
    [Parameter(Mandatory=$true,
               HelpMessage="Infotext")]
    $param1
)

    Write-Host -ForegroundColor Cyan -Object $param1
}

function Test-ParameterSet
{
[cmdletBinding(DefaultParametersetName="Set1")]
param(
    [Parameter(Mandatory=$true,
               ParameterSetName="Set1")]
    $param1,

    [Parameter(Mandatory=$true,
               ParameterSetName="Set2")]
    $param2 = "Wert2",

    [Parameter(Mandatory=$true,
               ParameterSetName="Set2")]
    [Parameter(Mandatory=$false,
               ParameterSetName="Set1")]
    $param3 
)

}

function Test-CredentialParameter
{
[cmdletBinding()]
param(
    [Parameter()]
    [System.Management.Automation.Credential()][PSCredential]$Credential
)

    

}

function Test-PipelineInput
{
    [cmdletBinding()]
    param(
        [Parameter(ValueFromPipeLineByPropertyName=$true)]
        [string]$DisplayName,

        [Parameter(ValueFromPipeLine=$true,ValueFromPipelineByPropertyName=$true)]
        [string]$Name
    )
    Begin
    {
        Write-Host -ForegroundColor Green -Object "Wird einmalig beim start ausgeführt zb zum importieren von Modulen"
    }
    Process
    {   # Wird für jedes Objekt ausgeführt
        Write-Host -ForegroundColor Yellow -Object $DisplayName
        Write-Host -ForegroundColor White -Object $Name
    }
    End
    {
        Write-Host -ForegroundColor Red -Object "Wird einmalig zum Schluss ausgeführt"
    }
}