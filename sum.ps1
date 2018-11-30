#adds all numbers in command line parameter then displays sum

$ErrorActionPreference="SilentlyContinue"
try
{
$total=0
foreach ($arg in $args)
{
    
    $Total+=[double]$arg
}
}
catch
{
write-host "The statement produced an error, ignoring and continuing to add"

}
write-host "The total is:" $total
$ErrorActionPreference="Continue"