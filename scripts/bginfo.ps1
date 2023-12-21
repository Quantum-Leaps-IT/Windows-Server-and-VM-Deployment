# Define the download URL for BGInfo
$BGInfoURL = "https://download.sysinternals.com/files/BGInfo.zip"
$BGInfoZipPath = "$env:TEMP\BGInfo.zip"
$BGInfoExtractPath = "$env:TEMP\BGInfo"

# Download and extract BGInfo
Invoke-WebRequest -Uri $BGInfoURL -OutFile $BGInfoZipPath
Expand-Archive -Path $BGInfoZipPath -DestinationPath $BGInfoExtractPath -Force

# Copy BGInfo files to the system32 directory
$BGInfoExePath = Join-Path $BGInfoExtractPath -ChildPath "Bginfo.exe"
$System32Path = "$($env:SystemRoot)\System32"
Copy-Item -Path $BGInfoExePath -Destination $System32Path -Force

# Clean up temporary files
Remove-Item -Path $BGInfoZipPath -Force
Remove-Item -Path $BGInfoExtractPath -Recurse -Force

Write-Host "BGInfo installed successfully."

# Optional: Run BGInfo with a predefined configuration file
# & "$System32Path\Bginfo.exe" /timer:0 /nolicprompt /silent /all

C:\Windows\System32\Bginfo.exe
