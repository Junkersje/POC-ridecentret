param (
    [Parameter(Mandatory=$true)]
    [string]$CommitMessage,

    [Parameter(Mandatory=$true)]
    [string[]]$Files
)

Write-Host "--- GitHub Manager Eksekverer ---" -ForegroundColor Cyan

foreach ($file in $Files) {
    if (Test-Path $file) {
        git add $file
        Write-Host "Staged: $file" -ForegroundColor Green
    } else {
        Write-Warning "Filen findes ikke: $file"
    }
}

# Kør commit
git commit -m "$CommitMessage"

if ($LASTEXITCODE -eq 0) {
    Write-Host "Commit gennemført med succes!" -ForegroundColor Green
} else {
    Write-Error "Git commit fejlede. Tjek om der var ændringer at committe."
}

