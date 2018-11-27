#COMP3771 Powershell Session 10 Assignment 10, Question 5 - RAPHAEL VECINA
#----------------------------------------------------------------------------
#TASK:
#Write a script called Add-User.ps1:
#-Read the user info from USERS.CSV into a collection of user objects
#-User info: UserName,AccountName,EmployeeID,PhoneNo,PC
#-Accept input for new user information and validate
#-Once Validated, replay input back to user and confirm
#-Once confirmed, Add new user to CSV file in a safe manner
#-Uses two functions to check AccountName and EmployeeID if they exist


# Show explanatory message:
# ------------------------
    write-host
    write-host -foregroundcolor cyan "Add a new User to the Users.csv file"
    write-host
    write-host "At any prompt you may press ENTER without typing anything to cancel the update"
    write-host
    
# Read the old Users file:
# --------------------------
    $ErrorActionPreference = "SilentlyContinue"
    $Users = Import-CSV Users.CSV 
    
    
#Check to see if import-csv command above was succesful, if not give error and exit
#-----------------------------------------------------------------------------------
if ( -not $? )
{
write-host –foregroundcolor red `
"Unable to find Users.CSV in this folder, please retry!"
$ErrorActionPreference = "Continue"
exit 1
}

#Function to check if accountname already exists
#-----------------------------------------------
 Function AccountNameExists ($AccountInF,$ExistingAccountNameF){
 if ( $AccountInF -eq "" ) { exit 0 }
 if ( $ExistingAccountNameF -notcontains $AccountInF ) { break }
 write-host -foregroundcolor yellow "`a   '$AccountInF' is already on file, please choose a different name"
}

#Function to check if employeeid already exists and if it starts with letter "M" followed by 8 digits
#-----------------------------------------------------------------
 Function EmployeeIDExists ($EmployeeInF,$ExistingEmployeeIDF){
 if ( $EmployeeInF -eq "" ) { exit 0 }

 if ( $ExistingEmployeeIDF -contains $EmployeeInF )
    {
    write-host -foregroundcolor yellow "`a   '$EmployeeInF' is already on file, please choose a different name"
    continue
    }
 if ( $EmployeeInF -notlike "M[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]" )
    {
    write-host -foregroundcolor yellow "`a   'EmployeeID' needs to start with letter "'M'" followed by 8 digits" 
    continue
    }
break
}

# Get collections of the user name and IDs to be used for validation:

# Get the UserName and ensure not blank:
# ------------------------------------
    write-host -nonewline "UserName: "
    $UserIn = Read-Host
    if ( $UserIn -eq "" ) { exit 0 }
    

# Get the Account name and ensure it is validated through the "AccountNameExists" Function:
# -----------------------------------------
    while ( $True )
    {
        $ExistingAccountName = $Users | foreach { $_.AccountName }
        write-host -nonewline "AccountName: "
        $AccountIn = Read-Host
        AccountNameExists $AccountIn $ExistingAccountName
    }

# Get the EmployeeID and ensure it is unique
# The EmployeeID must be the letter "M" followed by 8 Digits, validated through "EmployeeIDExists" function:
# -----------------------------------------
    while ( $True )
    {
        $ExistingEmployeeID = $Users | foreach { $_.EmployeeID }
        write-host -nonewline "EmployeeID: "
        $EmployeeIn = Read-Host
        EmployeeIDExists $EmployeeIn $ExistingEmployeeID
    }

#Get the PhoneNo and ensure its not blank
#The PhoneNo must also be 10 digit number with no spaces or dashes
#-------------------------------------
    while ( $True )
    {   
        write-host -nonewline "PhoneNo: "
        $PhoneIn = Read-Host
        if ( $PhoneIn -eq "" ) { exit 0 }

        if ( $PhoneIn -notlike "[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]" )
        {
        write-host -foregroundcolor yellow "`a   'PhoneNo' needs to be 10 digits with no Spaces or Dashes" 
        continue
        }
    break
    }

#Get the PC Name and ensure input is not blank
#The PC name must also start with "PC" or "WS" followed by 4 digits
#-------------------------------------------
    while ( $True )
    {
        write-host -nonewline "PC: "
        $PCIn = Read-Host
        if ( $PCIn -eq "" ) { exit 0 }
        if ( $PCIn -notlike "[PW][CS][0-9][0-9][0-9][0-9]" )
        {
        write-host -foregroundcolor yellow "`a   'PC' needs to start with ""PC"" or ""WS"" followed by 4 digits" 
        continue
        }
    break

    }

#Once all information has been read and validated, display the information and ask confirmation
#---------------------------------
while ($True)
{
write-host
"Username: $UserIn
Accountname: $AccountIn
EmployeeID: $EmployeeIn
PhoneNo: $PhoneIn
PC: $PCIn"
write-host -foregroundcolor green "All fields validated - Confirm (Y/N)?"

$Confirm = Read-Host
if ($Confirm -eq "Y"){break}
if ($Confirm -eq "N"){write-host -foregroundcolor red "User $UserIn not entered - aborted" 
Exit 0}
write-host -foregroundcolor red "Please enter only ""Y"" for Yes, ""N"" for No"
}

#-Create an object for the new user and add it to the collection

$New= New-Object Object
$New | Add-member Noteproperty Username $UserIn
$New | Add-member Noteproperty Accountname $AccountIn
$New | Add-member Noteproperty EmployeeID $EmployeeIn
$New | Add-member Noteproperty PhoneNo $PhoneIn
$New | Add-member Noteproperty PC $PCIn

# Read the old Users file and add the new User to it:

$users += $New 

#-Write the updated collection back to the Users.CSV file in order by Account Name
#-Use a safe update strategy to ensure that no data will be lost
# ----------------------------------------------------------------------------------

$users | sort AccountName | export-csv users.new -NoTypeInformation
Move-Item -force Users.Csv Users.Bak -EA SilentlyContinue #if it errors, it continues to next line
Move-Item users.new Users.Csv -EA SilentlyContinue #if it errors, it continues to next line

#Check to see if the script was succesful in writing to the Users.CSV file
#-----------------------------------------------------------------------------------
if ( -not $? )
{
write-host –foregroundcolor red `
"Unable to write to Users.CSV - File may be in use! Please re-run the script"
exit 1
}

write-host
write-host -foregroundcolor cyan "Username $UserIn has been added to the file"