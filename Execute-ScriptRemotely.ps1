# Hinweis: Es kommen hin und wieder (auch auskommentiert) Platzhalter vor.
# Diese sind in <> eingegrenzt, siehe erste Zeile '<Mein-PC'>
$ComputerList = @('<MeinPC>')

$ScriptPath = "<\\meinserver\meinefreigabe>" # Hier bitte UNC-Pfad eintragen
$ScriptFile = "Create-A-Folder.ps1" # Beispielskript

# Wahlweise die PC-Liste aus dem AD beziehen
#$ComputerList = Get-ADComputer -Filter * -Properties Name | Where-Object {(($_.DistinguishedName -like '*OU=<MeineOU>,*') -or ($_.DistinguishedName -like '*OU=<MeineAndereOU>,*')) -and ($_.DistinguishedName -notlike '*OU=<OU-fuer-deaktivierte-PCs>,*')} | Select-Object -Property Name

# Administrator-Credentials holen (z.B. Domaenen-Administrator)
$AdminCredentials = Get-Credential

# Skript auf die entfernten PCs kopieren und dort ausfuehren
foreach ($pc in $ComputerList) {
    Invoke-Command -ComputerName $pc -ScriptBlock {
        Set-ExecutionPolicy RemoteSigned
        New-PSDrive -Name "R" -PSProvider FileSystem -Root $args[1] -Credential $args[0]
        Set-Location -Path R:
        $tmpdir = "C:\Windows\Temp"
        $sfile = $args[2].ToString()
        Copy-Item $sfile $tmpdir
        Set-Location $tmpdir
        & ".\$sfile"
    } -Args $AdminCredentials, $ScriptPath, $ScriptFile
}