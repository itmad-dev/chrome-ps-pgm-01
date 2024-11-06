<#
  REQUIREMENTS
    Accessible logs location
     e.g., C:\scripts\PowerCLI\logs
#>

<#
.SYNOPSIS
Remove any installed version of Google Chrome using WMI (Windows Management Instrumentation).

.DESCRIPTION
Searches the local Windows device for WMI objects with "Google Chrome" in the name, then uses WMI to install the latest version of Google Chrome.


.NOTES
 Version 1.0
 Author:  Jerry Nihen
 Creation Date:  10/31/2024
 Purpose/change: initial creation
 Documentation:
   chrome-ps-pgm-proc-rvw-01.docx
   itmad-dev GitHub repo chrome-ps-pgm-01\chrome-wmi-uninstall-01\chrome-wmi-uninstall-01.ps1

.EXAMPLE

run chrome-wmi-uinstall-01.bat from or-jmpwin-02 from org prescribed central script location

  chrome-wmi-uninstall-01.bat
    powershell.exe -command . %~dp0\chrome-wmi-uninstall-01.ps1"

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
$script:arrChrome = @()

#------------------------------[Functions]------------------------------

Function Uninstall-GoogleChromeWithWMI {

  Begin {
  #  Write-LogInfo -LogPath $script:strLogFile -Message "Uninstalling Google Chrome with WMI ..."

  }

  Process {
    Try {
        $script:arrChrome = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "Google Chrome" }
        if ($script:arrChrome.Count -ne 0) {
            foreach ($objChrome in $script:arrChrome) {
                Write-Host "Uninstalling Google Chrome"
                $uninstallResult = $objChrome.Uninstall() > $null
                Write-Host "Google Chrome uninstalled successfully"
            }
        } else {
            Write-Host "Google Chrome not found"
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
# Uninstall Google Chrome with WMI
Uninstall-GoogleChromeWithWMI
# Script teardown settings
# Stop-Log -LogPath $strLogFile
Remove-Variable * -ErrorAction SilentlyContinue

