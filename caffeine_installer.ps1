# URL of the zip
$zipUrl = "https://www.zhornsoftware.co.uk/caffeine/caffeine.zip"

# Local paths
$tempZip = Join-Path $env:TEMP "caffeine.zip"
$installDir = Join-Path $env:USERPROFILE "Desktop\Caffeine"  # Full path to Desktop

# Download the zip
Write-Host "Downloading caffeine.zip from $zipUrl ..."
Invoke-WebRequest -Uri $zipUrl -OutFile $tempZip

# Create install dir
if (-not (Test-Path $installDir)) {
    New-Item -ItemType Directory -Path $installDir | Out-Null
}

# Extract the zip
Write-Host "Extracting to $installDir ..."
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($tempZip, $installDir)

# Optionally, create a shortcut or add to PATH
# Example: add install dir to user PATH
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($userPath -notlike "*$installDir*") {
    [Environment]::SetEnvironmentVariable("Path", "$userPath;$installDir", "User")
    Write-Host "Added $installDir to User PATH"
}

# Clean up
Remove-Item $tempZip

# Run Caffeine64.exe
Write-Host "Launching Caffeine64.exe ..."
Start-Process -FilePath (Join-Path $installDir "caffeine64.exe")

Write-Host "Caffeine is now running!"
