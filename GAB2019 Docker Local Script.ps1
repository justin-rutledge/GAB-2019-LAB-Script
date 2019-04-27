# You must have docker installed for this to work.

$envVariablesFilePath = "$($env:APPDATA)\GAB2019variables.env"
if(-not (Test-Path $envVariablesFilePath)){
    $environmentVariables = @{
        Email = 'youremail@domain.com'
        Fullname = 'yourname'
        TeamName= 'ColumbusOH'
        CompanyName = 'idk'
        CountryCode = 'US'
        LabKeyCode = '3817'    
    }

    $fileContents = $environmentVariables.keys.ForEach{
        "BatchClient__$_=$($environmentVariables[$_])"    
    }
    $fileContents | Out-File $envVariablesFilePath -Encoding default
}

[ValidateRange(1,20)]
$numberOfInstances = 10
$startPort = 8080
$endPort = [int]($startPort + $numberOfInstances)
$appendPort = ':80'


($startPort..$endPort).ForEach{
    docker run -d -p "$_$appendPort" --env-file $envVariablesFilePath --restart always globalazurebootcamp/sciencelab2019:latest
}