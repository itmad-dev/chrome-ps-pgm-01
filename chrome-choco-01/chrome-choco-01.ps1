<#
  REQUIREMENTS
    Accessible logs location
     e.g., C:\scripts\PowerCLI\logs
#>

<#
.SYNOPSIS
Deploy latest version of Google Chrome using (first installing) the Chocolatey package manager.

.DESCRIPTION
Executes the Chocolatey installation script directly from the Internet, then uses Chocolatey to install the latest version of Google Chrome.

.PARAMETER 32bitLegacyReplace
Not mandatory. A boolean option to first remove/replace detected Program Files (x86) legacy deployment of Google Chrome program executble. The latest version of Google Chrome will then be installed in the proper Program Files location.


.NOTES
 Version 1.0
 Author:  Jerry Nihen
 Creation Date:  10/31/2024
 Purpose/change: initial creation
 Documentation:
   chrome-ps-pgm-proc-rvw-01.docx
   itmad-dev GitHub repo chrome-ps-pgm-01\chrome-choco-01\chrome-choco-01.ps1

.EXAMPLE

or-jmpwin-02 from org prescribed central script location
 .\chrome-choco-01.ps1

#>
#------------------------------[Parameters]------------------------------
[CmdletBinding()]
param(
    [Parameter(Mandatory=$False, ParameterSetName="baseParams")]
    [bool]$32bitLegacyReplace
)
#------------------------------[Initializations]------------------------------

Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072

#------------------------------[Declarations]------------------------------

#Script Version
$script:strScriptVersion = '1.0'

#Date Time format
$script:strDate = (get-date).ToString("MMddyyyy_HHmm")


#------------------------------[Functions]------------------------------

Function Install-Chocolatey {

  Begin {
  #  Write-LogInfo -LogPath $script:strLogFile -Message "Installing Chocolatey ..."

  }

  Process {
    Try {
      $objChoco = Get-Command -Name choco.exe -ErrorAction SilentlyContinue
      If ($objChoco -eq $null) {
        iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
      } else {
        Write-Host "Chocolatey already installed"
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


Function Install-GoogleChromeWithChocolatey {

  Begin {
  #  Write-LogInfo -LogPath $script:strLogFile -Message "Installing Google Chrome with Chocolatey ..."

  }

  Process {
    Try {
          choco install googlechrome -y

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
# Install Chocolatey 
Install-Chocolatey
# Install Google Chrome with Chocolatey
Install-GoogleChromeWithChocolatey
# Script teardown settings
# Stop-Log -LogPath $strLogFile
Remove-Variable * -ErrorAction SilentlyContinue

