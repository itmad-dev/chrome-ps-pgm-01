<#
  REQUIREMENTS
    Accessible logs location
     e.g., C:\scripts\PowerCLI\logs
#>

<#
.SYNOPSIS
Install latest version of Google Chrome directly using a Content Delivery Network endpoint (e.g., Google).

.DESCRIPTION
Installs latest version of Google Chrome directly from specified CDN.

.PARAMETER 32bitLegacyReplace
Not mandatory. A boolean option to first remove/replace detected Program Files (x86) legacy deployment of Google Chrome program executble. The latest version of Google Chrome will then be installed in the proper Program Files location.


.NOTES
 Version 1.0
 Author:  Jerry Nihen
 Creation Date:  10/31/2024
 Purpose/change: initial creation
 Documentation:
   chrome-ps-pgm-proc-rvw-01.docx
   itmad-dev GitHub repo chrome-ps-pgm-01\chrome-cdn-01\chrome-cdn-install-01.ps1

.EXAMPLE

run chrome-cdn-install-01.bat from or-jmpwin-02 from org prescribed central script location

  chrome-cdn-install-01.bat
    powershell.exe -command "Set-ExecutionPolicy Bypass -Scope Process -Force;. %~dp0\chrome-cdn-install-01.ps1"

#>
#------------------------------[Parameters]------------------------------
[CmdletBinding()]
param(
    [Parameter(Mandatory=$False, ParameterSetName="baseParams")]
    [bool]$32bitLegacyReplace,
    [Parameter(Mandatory=$False, ParameterSetName="baseParams")]
    [String]$InstallerFileName,
    [Parameter(Mandatory=$False, ParameterSetName="baseParams")]
    [String]$CDNUri
)
#------------------------------[Initializations]------------------------------

# Runtime IDE session prepped with Set-ExecutionPolicy Bypass -Scope Process -Force

[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072

#------------------------------[Declarations]------------------------------

#Script Version
$script:strScriptVersion = '1.0'

#Date Time format
$script:strDate = (get-date).ToString("MMddyyyy_HHmm")

#Locations
$script:dirTemp = $env:TEMP
$script:strInstallFilename = "chrome_installer.exe"
$script:strCDNUri = "https://dl.google.com/chrome/install/375.126/chrome_installer.exe"


#------------------------------[Functions]------------------------------


Function Install-GoogleChromeFromCDN {

  Begin {
  #  Write-LogInfo -LogPath $script:strLogFile -Message "Installing Google Chrome from CDN ..."

  }

  Process {
    Try {
        $objWebClient = New-Object System.Net.WebClient
        $objWebClient.DownloadFile("$script:strCDNUri", "$script:dirTemp\chrome_installer.exe")
        Start-Process -FilePath "$script:dirTemp\chrome_installer.exe" -ArgumentList '/silent /install' -Verb RunAs -Wait
        Remove-Item "$script:dirTemp\chrome_installer.exe"
    }

    Catch {
      # Write-LogError -LogPath $script:strLogFile -Message $_.Exception -ExitGracefully
      Break
    }
  }

  End {
    If ($?) {
      # Write-LogInfo -LogPath $script:strLogFile -Message 'Completed Successfully.'
      # Write-LogInfo -LogPath $script:strLogFile -Message ' '
    }
  }
}
    
#------------------------------[Execution]------------------------------

# Script setup settings
# Start-Log -LogPath $script:strLogPath -LogName $script:strLogFileName -ScriptVersion $strScriptVersion
# Install Google Chrome from CDN
Install-GoogleChromeFromCDN
# Script teardown settings
# Stop-Log -LogPath $strLogFile
Remove-Variable * -ErrorAction SilentlyContinue

