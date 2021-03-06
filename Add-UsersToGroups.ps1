Import-Module ActiveDirectory
$file = "C:\Users\administrator.CONTOSO\Documents\Visual Studio 2010\Projects\PerfTestHarness\SupportGroups200.txt"
$SupportGroups = Get-Content $file

foreach($SupportGroupName in $SupportGroups)
{
    $ss = ConvertTo-SecureString -AsPlainText -Force -String SMX#2001
    $UserName = $SupportGroupName + "User"
    $EmailAddress = $SupportGroupName + "@contoso.com"
    $User = New-ADUser -Name $UserName -CannotChangePassword $true -ChangePasswordAtLogon $false -DisplayName $UserName -Enabled $true -PassThru -PasswordNeverExpires $true -SamAccountName $UserName -AccountPassword $ss -EmailAddress $EmailAddress
    $Group = Get-ADGroup -Identity $SupportGroupName
    Add-ADGroupMember -Identity $Group -Members $User
}