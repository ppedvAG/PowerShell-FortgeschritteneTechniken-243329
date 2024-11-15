class Fahrzeug
{
    [string]$Farbe
    [string]$Hersteller
    [int]$Sitzplätze
}

class Auto : Fahrzeug
{
    [int]$Räder
    [string]$Model
    [int]$PS
    [Antrieb]$Betriebsstoff
    [int]$Höchstgeschwndigkeit

    #Konstruktor
    #Der Konstruktor wird ausgeführt bzw kann ausgeführt werden beim erstellen einer Instanz der Klasse
    #Der Konstruktor hat den gleichen Namen wie die Klasse
    #Es kann mehrere Konstruktoren gebene für verschiedene Anwendungsfälle
    Auto()
    {

    }
    Auto([string]$Hersteller)
    {
        $this.Hersteller = $Hersteller
    }

    #Methoden brauchen immer einen Rückgabewert, wenn keine Rückgabe vorgesehen ist [void]
    [void]Fahre([int]$Strecke)
    {
        [int]$Speed = 0
        [string]$Fahrbahn = "🚗"
        for($i = 1; $i -le $Strecke; $i++)
        {
            $Fahrbahn = "-" + $Fahrbahn
            if($Speed -le $this.Höchstgeschwndigkeit)
            {
                $Speed += 15
            }

            Start-Sleep -Milliseconds (300 - $Speed)
            Clear-Host
            Write-Host -Object $Fahrbahn
        }
    }


    #es ist mögliche bestehende Methoden zu überschreiben / überlagern
    [string]ToString()
    {
        [string]$Ausgabe = "[ "+ $this.Hersteller + " " + $this.Model + " ]"
        return $Ausgabe
    }

    [string]ToSTring([string]$Informationlevel)
    {
        [string]$Ausgabe = ""
        switch($Informationlevel)
        {
            Detailed {$Ausgabe = "[ " + $this.Hersteller + " | " + $this.Model + " Leistung: " + $this.PS + " PS " + "( $($this.Betriebsstoff))" +  "]"}
            Default {$Ausgabe = $this.ToString()}
        }

        return $Ausgabe
    }
}

enum Antrieb
{
    Sonstiges
    Benzin
    Diesel
    Elektrisch
    Hybrid
    Wasserstoff
}

$MyCar = [Auto]::new("BMW")
#$MyCar.Hersteller = "BMW"
$MyCar.Betriebsstoff = [Antrieb]::Benzin
$MyCar.Farbe = [System.ConsoleColor]::DarkCyan
$MyCar.Model = "F31"
$MyCar.PS = 252
$MyCar.Räder = 4
$MyCar.Sitzplätze = 5
$MyCar.Höchstgeschwndigkeit = 260

$CompanyCar = New-Object -TypeName Auto
$CompanyCar.Hersteller = "Tesla"
$CompanyCar.Betriebsstoff = [Antrieb]::Elektrisch
$CompanyCar.Farbe = [System.ConsoleColor]::Gray
$CompanyCar.Model = "Model3"
$CompanyCar.PS = 513
$CompanyCar.Räder = 4
$CompanyCar.Sitzplätze = 4
$CompanyCar.Höchstgeschwndigkeit = 180