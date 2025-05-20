# Define source and destination paths
$sourcePath = "c:\Users\Chen\Zomboid\mods\VFES_UnofficialB41Finish"
$destinationPath = "..\..\Workshop\VFES_UnofficialB41Finish\Contents\mods\VFES_UnofficalB41Finish"

# Ensure the destination directory exists
New-Item -ItemType Directory -Force -Path $destinationPath > $null 2>&1

# Define the media folder path in the destination
$destinationMediaPath = Join-Path -Path $destinationPath -ChildPath "media"

# Delete all files and subfolders inside the media folder of the workshop
if (Test-Path $destinationMediaPath) {
    Remove-Item -Path $destinationMediaPath\* -Recurse -Force > $null 2>&1
} else {
    Write-Host "Media folder in the workshop does not exist. Skipping deletion."
}

# Copy the media folder
Copy-Item -Path "$sourcePath\media" -Destination $destinationPath -Recurse -Force > $null 2>&1

# Copy individual files (LICENSE, mod.info, poster.png)
$filesToCopy = @("LICENSE", "mod.info", "poster.png")
foreach ($file in $filesToCopy) {
    $filePath = Join-Path -Path $sourcePath -ChildPath $file
    if (Test-Path $filePath) {
        Copy-Item -Path $filePath -Destination $destinationPath -Force > $null 2>&1
    } else {
        Write-Host "File not found: $filePath"
    }
}

Write-Host "Deployment completed successfully!"
