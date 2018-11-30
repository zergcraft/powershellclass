
$Users = Import-CSV Users.csv
$ExistingUserIDs = $Users | foreach { $_.ID }

# Get the ID number and ensure it is both numeric and unique:
# ----------------------------------------------------------    
    while( $True )
    {
        write-host -nonewline "`nEmployee ID number: "
        $ID = Read-Host
        if ( $ID -eq "" ) { exit 0 }
        if ( ($ID -as [int]) -eq $null )
        {
            write-host -foregroundcolor yellow  "`a   '$ID' is not numeric, please use a numeric ID number"
            continue
        }
         if ( $ExistingUserIDs -notcontains $ID )
        {
            write-host -foregroundcolor yellow  "`a   '$ID' does not exists!please retry script!"
            exit 1
        }
        if ( $ExistingUserIDs -contains $ID )
        {
            write-host -foregroundcolor yellow  "`a   '$ID' exists! it will be deleted!"
            break
        }
        break
    }

$users | ?{$_.ID -ne $ID} | export-csv -NoTypeInfo users.new

    Move-Item -force Users.Csv Users.Bak
    Move-Item Users.New Users.Csv
    
    write-host
    write-host -foregroundcolor cyan "Employee $ID has been removed!"