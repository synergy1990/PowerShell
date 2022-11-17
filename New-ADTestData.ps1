function New-MobilePhoneNumber {
    [CmdletBinding()]

    $Prefixes = @("151", "160", "170", "171", "175", "152", "162", "172", "173", "174", "157", "163", "177", "178", "159", "176", "179")
    $RndSevenOrEight = Get-Random -Minimum 7 -Maximum 9
    $ActualNumber = ""    
    for($i = 1; $i -le $RndSevenOrEight; $i++) {
        $rnd = Get-Random -Minimum 0 -Maximum 10
        $ActualNumber = $ActualNumber + $(Get-Random -Minimum 0 -Maximum 10).ToString()
    }

    $MobPhonNumber = "+49 " + $($Prefixes | Get-Random) + " " + $ActualNumber

    return $MobPhonNumber

}

function New-ADTestData {
    [CmdletBinding()]
    param(
        $Count = 5
    )
    
    $TestData = @{
            'HomePhones'        = "i.A."
            'GivenNames'        = @("Klaus", "Dieter", "Franz", "Xaver", "Vivian", "Anne", "Michaela", "Manuela", "Eric", "Christine", "Chiara", "Detlef", "Angela", "Wilfried", "Michael", "Ingrid")
            'SurNames'          = @("Koenig", "Boettcher", "Honig", "Berger", "Tortenhuber", "Reiter", "Engel", "Pracht", "Marenbach", "Huesch", "Au", "Kurz", "Lang", "Krause", "Schroeder", "Werner")
           #'SamAccountName'    = @()
            'Departments'       = @("Entwicklung", "Buchhaltung", "Werkstatt", "Vertrieb", "Einkauf", "Logistik", "IT", "Konstruktion")
            'Titles'            = @("developement", "accounting", "workshop", "sales", "purchasing", "logistics", "IT", "construction")
           #'MobilePhones'      = @()
            'telephoneNumbers'  = "+49 2682 11111-"
            'Faxes'             = "+49 2682 11111-50"
           #'EMailAddress'      = @()
            'HomePages'         = "www.testfirma.de.vu"
            'Domains'           = "testfirma.de.vu"
            'StreetAddresses'   = "Panzerknackerstrasse 5"
            'PostalCodes'       = "47111"
            'Cities'            = "Entenhausen"
    }
    
    $MyMS365Users = @()
    for($i = 1; $i -le $Count; $i++) {
        $DeptCount = $($TestData.Departments.Length)
        $RandomNumber = Get-Random -Minimum 0 -Maximum $Deptcount
        $GivenName = $TestData.GivenNames | Get-Random
        $SurName = $TestData.SurNames | Get-Random
        $MyUser = New-Object -TypeName PSObject -Property @{
            'HomePhone'        = $TestData.HomePhones
            'GivenName'        = $GivenName
            'SurName'          = $SurName
            'SamAccountName'   = "$($GivenName).$($SurName)"
            'Department'       = $TestData.Departments[$RandomNumber]
            'Title'            = $TestData.Titles[$RandomNumber]
            'MobilePhone'      = New-MobilePhoneNumber
            'telephoneNumber'  = $TestData.telephoneNumbers + $(Get-Random -Minimum 10 -Maximum 100).ToString()
            'Fax'              = $TestData.Faxes
            'EMailAddress'     = "$($GivenName).$($SurName)@$($TestData.Domains)"
            'HomePage'         = $TestData.HomePages
            'StreetAddress'    = $TestData.StreetAddresses
            'PostalCode'       = $TestData.PostalCodes
            'City'             = $TestData.Cities
        }
        $MyMS365Users += $MyUser
    }

    return $MyMS365Users
}
