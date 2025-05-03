# Step 1 - Create department folders inside E: drive and log the activity
$folders = @("IT", "HR", "Marketing", "Finance")
$logFile = "C:\Scripts\FileServerSetup.log"

# Make sure log directory exists
if (-Not (Test-Path -Path "C:\Scripts")) {
    New-Item -Path "C:\Scripts" -ItemType Directory -Force
}

# Start logging
foreach ($folder in $folders) {
    $path = "E:\$folder"
    
    if (-Not (Test-Path -Path $path)) {
        New-Item -Path $path -ItemType Directory -Force
        $message = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Created folder: $path"
        Write-Host $message -ForegroundColor Green
    } else {
        $message = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Folder already exists: $path"
        Write-Host $message -ForegroundColor Yellow
    }

    # Write message to log file
    Add-Content -Path $logFile -Value $message
}

Write-Host "✅ Folder creation finished. Log file located at: $logFile" -ForegroundColor Cyan
