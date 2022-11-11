$MyRoot = "C:\Test"
if(!(Test-Path $MyRoot)) { New-Item -Path $MyRoot -ItemType Directory }

$i = 0
$MyPath = "$MyRoot\$i"
$IHaveDoneSomething = $false

while(!($IHaveDoneSomething)) {
    if(!(Test-Path $MyPath)) {
        New-Item -Path $MyPath -ItemType Directory
        $IHaveDoneSomething = $true
    } else {
        $i++
        $MyPath = "$MyRoot\$i"
    }
}