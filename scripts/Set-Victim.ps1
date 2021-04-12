# Author: Roberto Rodriguez (@Cyb3rWard0g)
# License: GPL-3.0

[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [ValidateSet("Day1","Day2")] 
    [string]$scenario,

    [Parameter(Mandatory=$true)]
    [string]$domainName,

    [Parameter(Mandatory=$false)]
    [switch]$useCalderaDIY
)

# Setup Payloads
if ($useCalderaDIY)
{
    move-item Invoke-Sandcat.ps1 C:\programdata\
}
else
{
    # Unzip file
    write-Host "Decompressing Victim zip .."
<<<<<<< HEAD
    $VictimFilePath = (Get-Item victim.zip).FullName
=======
    $VictimFilePath = (Get-Item default.zip).FullName
>>>>>>> f6a6a1391093a808467d069c51ee4f26d9a13f1b
    expand-archive -path $VictimFilePath -DestinationPath "C:\ProgramData\"
}

# Set up PSRemoting Trusted Hosts
write-host "Setting trusted hosts"
Set-Item WSMan:\localhost\Client\TrustedHosts -Value '*' -Force

# Installing Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation

if ($scenario -eq 'Day1')
{
    # Add user to local administrator group
    net localgroup Administrators "$domainName\mlillard" /add

    # Give Pam Beesly and Dwight Schrute Full control access to C:\Windows\Temp. User is already part of Administrator group which has Full Control access to it, but just in case ;) 
    $acl = Get-Acl C:\Windows\Temp
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$domainName\mlillard","FullControl","Allow")
    $acl.SetAccessRule($AccessRule)
    $acl | Set-Acl C:\Windows\Temp

    # Chrome Installation
    write-host "Installing Chrome"
    choco install googlechrome

    if (!$useCalderaDIY)
    {
        # Import PFX Certificate
<<<<<<< HEAD
        Import-PfxCertificate -Exportable -FilePath C:\programdata\victim\shockwave.local.pfx -CertStoreLocation Cert:\LocalMachine\My
=======
        Import-PfxCertificate -Exportable -FilePath C:\programdata\dafault\shockwave.local.pfx -CertStoreLocation Cert:\LocalMachine\My
>>>>>>> f6a6a1391093a808467d069c51ee4f26d9a13f1b
        
        # rcs.3aka3.doc is downloaded to the victim system via the main ARM template (Private Storage Account ATM)
    }
}
else
{
    # Add user to local administrator group
    net localgroup Administrators "$domainName\fstevens" /add

    $acl = Get-Acl C:\Windows\Temp
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$domainName\fstevens","FullControl","Allow")
    $acl.SetAccessRule($AccessRule)
    $acl | Set-Acl C:\Windows\Temp
    
    # Office 365 Installation
    write-host "Installing Office 365"
    choco install office365business
}
