<#
PowerShell helper to download and extract a standalone MinGW (winlibs) GCC build
into D:\Dcuments\VS Code\mingw64 and add it to the user PATH.

Usage: run this from an elevated PowerShell or a PowerShell with permission to write to the destination.
You will be prompted for a download URL. If you press Enter, a sample URL placeholder is used — replace with a current winlibs URL.
#>

$dest = 'D:\\Dcuments\\VS Code\\mingw64'
if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Path $dest -Force | Out-Null }

$defaultUrl = 'https://github.com/brechtsanders/winlibs_mingw/releases/download/2023-12-13/winlibs-x86_64-posix-seh-gcc-13.2.0-12.0.1-r5.zip'
$url = Read-Host "Enter winlibs GCC zip URL (press Enter to use a sample URL)"
if ([string]::IsNullOrWhiteSpace($url)) { $url = $defaultUrl }

$zip = Join-Path $env:TEMP 'mingw.zip'
Write-Output "Downloading $url ..."
Invoke-WebRequest -Uri $url -OutFile $zip -UseBasicParsing

Write-Output "Extracting to $dest ..."
Expand-Archive -Path $zip -DestinationPath $dest -Force

# If the archive created a single top-level folder, move its contents up one level
$children = Get-ChildItem -Path $dest | Where-Object { $_.PSIsContainer }
if ($children.Count -eq 1) {
    $inner = $children[0].FullName
    Get-ChildItem -Path $inner -Force | Move-Item -Destination $dest -Force
    Remove-Item -Path $inner -Recurse -Force
}

# Add to user PATH (effective after new terminal)
$bin = Join-Path $dest 'bin'
Write-Output "Adding $bin to user PATH (setx)."
setx PATH "$env:PATH;$bin" | Out-Null

Remove-Item -Path $zip -Force
Write-Output "Done. Restart your terminal or log out/in to refresh PATH."
Write-Output "Afterward, build with: g++ -g src/main.cpp -std=c++17 -O0 -o bin/main.exe"
