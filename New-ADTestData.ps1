function New-ADTestData {
    [CmdletBinding()]
    param(
        # How many records should be created?
        [Parameter()]
        [int]
        $Count = 5
    )

    function New-PhoneNumber {
        [CmdletBinding()]
        param(
            # Define the type of number
            [Parameter()]
            [string]
            [ValidateSet( 'Mobile', 'Landline' )]
            $Type = 'Mobile'
        )
    
        $MobilePrefixes = @( "151", "160", "170", "171", "175", "152", "162", "172", "173", "174", "157", "163", "177", "178", "159", "176", "179" )
        $Prefixes   = @( "2682", "2681", "2686", "2742", "2741", "2246", "2241", "40", "2102", "2161", "2151", "221", "228", "2208", "2206", "2351", "241", "243", "251", "261",
                        "2631", "2741", "331", "335", "3391", "345", "355", "357", "3581", "361", "375", "381", "4131", "4141", "4161", "421", "4221", "4321", "4371", "4372",
                        "4431", "4491", "4541", "461", "4721", "4941", "4921", "491", "4971", "5141", "5151", "5191", "521", "5201", "5231", "5251", "5271", "531", "5341",
                        "6021", "611", "6131", "621", "6221", "6241", "631", "6321", "6331", "6381", "641", "6421", "6441", "6431", "651", "6531", "6561", "6571", "6591",
                        "671", "6721", "6741", "6761", "6771", "7071", "7121", "7131", "7141", "721", "7221", "7231", "7261", "7271", "751", "7551", "761", "7731", "781",
                        "8041", "8141", "8151", "8161", "821", "8341", "841", "851", "8651", "8821", "89", "8961", "9091", "9131", "911", "921", "9221", "931", "941", "951" )
        $RndSevenOrEight = Get-Random -Minimum 7 -Maximum 9
        $ActualNumber = ""

        for( $i = 1; $i -le $RndSevenOrEight; $i++ ) {
            $rnd = Get-Random -Minimum 0 -Maximum 10
            $ActualNumber = "$( $ActualNumber )$( Get-Random -Minimum 0 -Maximum 10 )"
        }
    
        switch ( $Type ) {
            'Mobile' { $PhoneNumber = "+49 $( $MobilePrefixes | Get-Random ) $( $ActualNumber )" }
            'Landline' { $PhoneNumber = "+49 $( $Prefixes | Get-Random ) $( $ActualNumber )" }
        }
    
        return $PhoneNumber
    }
    
    $TestData = @{
        'GivenNames'        = @( "Klaus", "Dieter", "Franz", "Xaver", "Vivian", "Anne", "Michaela", "Manuela", "Eric", "Christine", "Chiara", "Detlef", "Angela", "Wilfried", "Michael", "Ingrid",
                                "Theresa", "Moritz", "Sophia", "Philipp", "Dorothea", "Felix", "Sarah", "Sebastian", "Anna", "Clemens", "Christiane", "Jan", "Maria", "Oliver", "Alexandra", "Paul",
                                "Astrid", "Cornelius", "Elisabeth", "Patrick", "Anika", "Tobias", "Julia", "Maximilian", "Hannah", "David", "Karla", "Theo", "Edith", "Tim" )
        'SurNames'          = @( "König", "Böttcher", "Honig", "Berger", "Tortenhuber", "Reiter", "Engel", "Pracht", "Marenbach", "Hüsch", "Au", "Kurz", "Lang", "Krause", "Schröder", "Werner",
                                "Müller", "Schmidt", "Schneider", "Fischer", "Weber", "Meyer", "Wagner", "Becker", "Schulz", "Hoffmann", "Schäfer", "Bauer", "Koch", "Richter", "Wolf", "Neumann",
                                "Schwarz", "Braun", "Hofmann", "Zimmermann", "Schmitt", "Hartmann", "Krüger", "Schmid", "Lange", "Schmitz", "Meier", "Maier", "Lehmann", "Huber" )
        # 'SamAccountName'    = @()
        'Departments'       = @( "developement", "accounting", "workshop", "sales", "purchasing", "logistics", "IT", "construction", "marketing", "management", "human resources", "research", "production", "service" )
        'Titles'            = @( "Entwicklung", "Buchhaltung", "Werkstatt", "Vertrieb", "Einkauf", "Logistik", "IT", "Konstruktion", "Marketing", "Geschäftsführung", "Personalwesen", "Forschung", "Produktion", "Kundendienst" )
        # 'MobilePhones'      = @()
        'telephoneNumbers'  = "+49 2682 11111"
        'Faxes'             = "+49 2682 11111-50"
        # 'EMailAddress'      = @()
        'HomePages'         = "www.testfirma.de.vu"
        'StreetAddresses'   = "Panzerknackerstrasse 5"
        'PostalCodes'       = "47111"
        'Cities'            = "Entenhausen"
    }
    
    $MyMS365Users = @()

    for($i = 1; $i -le $Count; $i++) {
        # Declarations
        $DeptCount      = $( $TestData.Departments.Count )
        $RandomNumber   = Get-Random -Minimum 0 -Maximum $Deptcount
        $Domain         = ( $TestData.HomePages ).Trim("www.")
        $GivenName      = $TestData.GivenNames | Get-Random
        $SurName        = $TestData.SurNames | Get-Random
        $EmailAddress   = "$( $GivenName ).$( $SurName )@$( $Domain )"

        # Build PSObject
        $MyUser = New-Object -TypeName PSObject -Property @{
            'UserID'           = $i
            'HomePhone'        = New-PhoneNumber -Type Landline
            'GivenName'        = $GivenName
            'SurName'          = $SurName
            'SamAccountName'   = $EmailAddress
            'Department'       = $TestData.Departments[$RandomNumber]
            'Title'            = $TestData.Titles[$RandomNumber]
            'MobilePhone'      = New-PhoneNumber -Type Mobile
            'telephoneNumber'  = "$( $TestData.telephoneNumbers )-$( Get-Random -Minimum 10 -Maximum 1000 )"
            # 'telephoneNumber'  = New-PhoneNumber -Type Mobile
            'Fax'              = $TestData.Faxes
            'EMailAddress'     = $EmailAddress
            'HomePage'         = $TestData.HomePages
            'StreetAddress'    = $TestData.StreetAddresses
            'PostalCode'       = $TestData.PostalCodes
            'City'             = $TestData.Cities
        }

        $MyMS365Users += $MyUser
    }

    return $MyMS365Users
}

# Use Select-Object to order the properties
$TestOutput = New-ADTestData -Count 15 | Select-Object UserID, GivenName, SurName, SamAccountName, EMailAddress, telephoneNumber, Fax, MobilePhone, Title, Department, StreetAddress, PostalCode, City, HomePage, HomePhone
$TestOutput | Out-GridView
