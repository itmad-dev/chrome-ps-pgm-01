<#
  REQUIREMENTS
    Accessible logs location
     e.g., C:\scripts\PowerCLI\logs
#>

<#
.SYNOPSIS
Remove any version of Google Chrome managed by the Chocolatey package manager.

.DESCRIPTION
Uses the installed Chocolatey package manager to uninstall Google Chrome.


.NOTES
 Version 1.0
 Author:  Jerry Nihen
 Creation Date:  10/31/2024
 Purpose/change: initial creation
 Documentation:
   chrome-ps-pgm-proc-rvw-01.docx
   itmad-dev GitHub repo chrome-ps-pgm-01\chrome-choco-01\chrome-choco-uninstall-01.ps1

.EXAMPLE

run chrome-choco-uninstall-01.bat from or-jmpwin-02 from org prescribed central script location

  chrome-choco-uninstall-01.bat
    powershell.exe -command . %~dp0\chrome-choco-uninstall-01.ps1"

} 

#>
#------------------------------[Parameters]------------------------------


#------------------------------[Initializations]------------------------------


#------------------------------[Declarations]------------------------------

#Script Version
$script:strScriptVersion = '1.0'

#Date Time format
$script:strDate = (get-date).ToString("MMddyyyy_HHmm")


#------------------------------[Functions]------------------------------

Function Uninstall-GoogleChromeWithChocolatey {

  Begin {
  #  Write-LogInfo -LogPath $script:strLogFile -Message "Uninstalling Google Chrome with Chocolatey ..."

  }

  Process {
    Try {
          choco uninstall googlechrome -y > $null
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
# Uninstall Google Chrome with Chocolatey
Uninstall-GoogleChromeWithChocolatey
# Script teardown settings
# Stop-Log -LogPath $strLogFile
Remove-Variable * -ErrorAction SilentlyContinue

