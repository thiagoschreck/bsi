Param(
  [Parameter(Position=1)][string]$option
)

function Manual {
    Write-Host("`nNAME`n`tBetter System Info`n`nDESCRIPTION`n`tThis is a script created in order to retrieve and show basic system information.`n`tThe retrieved information consists of: IP Address, Operative System, CPU and RAM.`n`nSYNTAX`n`t.\BetterSystemInfo.ps1 (command)`n`nCOMMANDS`n`t[help] - Shows the commands available.`n`t[quiet] - Disables command output.`n`t[graphic] - Default parameter. Shows the retrieved information in a table.`n")
}

function GetData {
    $global:ip = "IPv4: " + ((Get-NetIPAddress -AddressFamily IPv4).IPAddress[0] -split "\n")[0] 
    $global:capt = (Get-CimInstance Win32_OperatingSystem).Caption
    $global:arch = (Get-CimInstance Win32_OperatingSystem).OSArchitecture
    $global:os = "OS:   " + $capt + " " + $arch
    $global:cpu = "CPU:  " + ((Get-WMIObject win32_Processor).Name[0] -split "\n")[0]
    $global:ram = "RAM:  " + ((((Get-WmiObject win32_physicalmemory).Capacity/1GB)[0] -split "\n")[0]) + "GB"
}

function BeQuiet {
    GetData
}

function BeLoud {
    GetData
    Write-Host("`nSystem information`n------------------")
    $ip
    $os
    $cpu
    $ram
    Write-Host("")
}

function Credits {
    Write-Host("`nThis script was written by Thiago Schreck Barreiro, with the help of SM.`n")
}

Switch ($option)
{
   "quiet" { BeQuiet }
   "graphic" { BeLoud }
   "help" { Manual }
   "whomadethis" { Credits }
   default { BeLoud }
}

cmd /c pause