# Define the base folder path on the file server
$basePath = "E:\"

# Define the folder names and corresponding AD groups
$folderPermissions = @{
    "Finance"    = "Finance-Staff"
    "HR"         = "HR-Staff"
    "IT"         = "IT-Staff"
    "Marketing"  = "Marketing-Staff"
}

# Apply permissions for each folder
foreach ($folder in $folderPermissions.Keys) {
    # Construct the full folder path
    $folderPath = Join-Path -Path $basePath -ChildPath $folder
    
    # Get the corresponding AD security group
    $groupName = $folderPermissions[$folder]
    
    # Disable inheritance and grant specific permissions for the group
    icacls $folderPath /inheritance:d  # Disable inheritance
    icacls $folderPath /grant "HOMEDC\Departments\$groupName:(OI)(CI)(M)"  # Grant permissions

    # Log the result for this folder
    Write-Output "Permissions successfully applied to $folderPath for group HOMEDC\Departments\$groupName"
}
