# Run this from INSIDE your cloned Zohra_Design_Studio_Automation folder.
# Usage (PowerShell): .\setup_zohra_automation_folders.ps1

Write-Host "Creating folder structure (Employee, Purchase, Work modules)..."

$folders = @(
    "Zohra_Employee_Module\Zohra_Employee_Screens",
    "Zohra_Employee_Module\Zohra_Employee_Database",
    "Zohra_Employee_Module\Zohra_Employee_Code",
    "Zohra_Employee_Module\Zohra_Employee_Documentation",
    "Zohra_Purchase_Module\Zohra_Purchase_Screens",
    "Zohra_Purchase_Module\Zohra_Purchase_Database",
    "Zohra_Purchase_Module\Zohra_Purchase_Code",
    "Zohra_Purchase_Module\Zohra_Purchase_Documentation",
    "Zohra_Work_Module\Zohra_Work_Screens",
    "Zohra_Work_Module\Zohra_Work_Database",
    "Zohra_Work_Module\Zohra_Work_Code",
    "Zohra_Work_Module\Zohra_Work_Documentation"
)

foreach ($folder in $folders) {
    New-Item -ItemType Directory -Force -Path $folder | Out-Null
}

Write-Host "Adding placeholder README files (Git doesn't track empty folders)..."

Get-ChildItem -Recurse -Directory | ForEach-Object {
    $items = Get-ChildItem $_.FullName -Force
    if ($items.Count -eq 0) {
        $name = $_.Name -replace '_', ' '
        "# $name" | Out-File -FilePath (Join-Path $_.FullName "README.md") -Encoding utf8
    }
}

Write-Host "Staging, committing, and pushing..."
git add .
git commit -m "Add folder structure for Employee, Purchase, and Work modules"
git push origin main

Write-Host ""
Write-Host "Done! Refresh Zohra_Design_Studio_Automation on github.com to check it."
