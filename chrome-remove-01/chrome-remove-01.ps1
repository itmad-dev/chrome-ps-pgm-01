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

or-jmpwin-02 from org prescribed central script location
 .\chrome-remove-01.ps1


$Chrome = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "Google Chrome*" } 

foreach ($Product in $Chrome) { 

    $Product.Uninstall() 

} 

Write-Output "Google Chrome successfully uninstalled" 


#>
#------------------------------[Parameters]------------------------------


#------------------------------[Initializations]------------------------------

# Runtime IDE session prepped with Set-ExecutionPolicy Bypass -Scope Process -Force

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

