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
   itmad-dev GitHub repo chrome-ps-pgm-01\chrome-remove-01\chrome-remove-01.ps1

.EXAMPLE

run chrome-remove-01.bat from or-jmpwin-02 from org prescribed central script location

  chrome-remove-01.bat
    powershell.exe -command "Set-ExecutionPolicy Bypass -Scope Process -Force;. %~dp0\chrome-choco-01.ps1"


$Chrome = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "Google Chrome*" } 

foreach ($Product in $Chrome) { 

    $Product.Uninstall() 

} 

Write-Output "Google Chrome successfully uninstalled" 


#>
#------------------------------[Parameters]------------------------------


#------------------------------[Initializations]------------------------------

# Runtime IDE session prepped with Set-ExecutionPolicy Bypass -Scope Process -Force

#------------------------------[Declarations]------------------------------

#Script Version
$script:strScriptVersion = '1.0'

#Date Time format
$script:strDate = (get-date).ToString("MMddyyyy_HHmm")


#------------------------------[Functions]------------------------------

Function Uninstall-GoogleChromeWithWMI {

  Begin {
  #  Write-LogInfo -LogPath $script:strLogFile -Message "Uninstalling Google Chrome with WMI ..."

  }

  Process {
    Try {
        $arrChrome = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "Google Chrome*" }
        foreach ($objChrome in $arrChrome) {
            $objChrome.Uninstall()
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

