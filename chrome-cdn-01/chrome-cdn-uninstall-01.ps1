<#
  REQUIREMENTS
    Accessible logs location
     e.g., C:\scripts\PowerCLI\logs
#>

<#
.SYNOPSIS
Remove any installed version of Google Chrome using local Windows registry removal ability provided by the application.

.DESCRIPTION
Searches and applies removal procedures provided by Google Chrome in the the local Windows device registry.


.NOTES
 Version 1.0
 Author:  Jerry Nihen
 Creation Date:  10/31/2024
 Purpose/change: initial creation
 Documentation:
   chrome-ps-pgm-proc-rvw-01.docx
   itmad-dev GitHub repo chrome-ps-pgm-01\chrome-cdn-uninstall-01\chrome-cdn-uninstall-01.ps1

.EXAMPLE

run chrome-cdn-uinstall-01.bat from or-jmpwin-02 from org prescribed central script location

  chrome-cdn-uninstall-01.bat
    powershell.exe -command . %~dp0\chrome-cdn-uninstall-01.ps1"

} 

#>
#------------------------------[Parameters]------------------------------


#------------------------------[Initializations]------------------------------


#------------------------------[Declarations]------------------------------

#Script Version
$script:strScriptVersion = '1.0'

#Date Time format
$script:strDate = (get-date).ToString("MMddyyyy_HHmm")

#Arrays
$script:arrChromeUninstallRegistryKeys = @()

#------------------------------[Functions]------------------------------

Function Uninstall-GoogleChromeWithRegistryInfo {

  Begin {
  #  Write-LogInfo -LogPath $script:strLogFile -Message "Uninstalling Google Chrome with registry info ..."

  }

  Process {

    Try {
        $script:arrChromeUninstallRegistryKeys = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*', `
        'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*', `
        'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*' `
        | Get-ItemProperty | Where-Object {
            $_.DisplayName -eq 'Google Chrome'
        }
        if ($script:arrChromeUninstallRegistryKeys.Count -ne 0) {
            foreach ($objRegistryKey in $script:arrChromeUninstallRegistryKeys) {
                $strUninstallString = $objRegistryKey.UninstallString + " --force-uninstall"
                cmd /c $strUninstallString
            }
        }

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
# Uninstall Google Chrome with Registry Info
Uninstall-GoogleChromeWithRegistryInfo
# Script teardown settings
# Stop-Log -LogPath $strLogFile
Remove-Variable * -ErrorAction SilentlyContinue

