[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$TargetPath,

    [string]$ProjectName = ""
)

$ErrorActionPreference = "Stop"

function Normalize-Path {
    param([string]$Path)

    $fullPath = [System.IO.Path]::GetFullPath($Path)
    return $fullPath.TrimEnd("\")
}

function Update-MasterWorking {
    param(
        [string]$FilePath,
        [string]$CurrentDate,
        [string]$ProjectName
    )

    if (-not (Test-Path -LiteralPath $FilePath)) {
        return
    }

    $lines = [System.Collections.Generic.List[string]]::new()
    foreach ($line in Get-Content -LiteralPath $FilePath) {
        $lines.Add($line)
    }

    $dateUpdated = $false
    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -eq "- date:") {
            $lines[$i] = "- date: $CurrentDate"
            $dateUpdated = $true
            break
        }
    }

    if ($ProjectName) {
        $projectLine = "- project name: $ProjectName"
        $projectUpdated = $false
        for ($i = 0; $i -lt $lines.Count; $i++) {
            if ($lines[$i] -eq "- project name:") {
                $lines[$i] = $projectLine
                $projectUpdated = $true
                break
            }
        }
    }

    Set-Content -LiteralPath $FilePath -Value $lines
}

function Update-Orientation {
    param(
        [string]$FilePath,
        [string]$ProjectName
    )

    if (-not $ProjectName -or -not (Test-Path -LiteralPath $FilePath)) {
        return
    }

    $projectLine = "- project name: $ProjectName"
    $lines = [System.Collections.Generic.List[string]]::new()
    foreach ($line in Get-Content -LiteralPath $FilePath) {
        $lines.Add($line)
    }

    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -eq "- project name:") {
            $lines[$i] = $projectLine
            break
        }
    }

    Set-Content -LiteralPath $FilePath -Value $lines
}

$sourceRoot = Normalize-Path -Path (Split-Path -Parent $MyInvocation.MyCommand.Path)
$resolvedTargetPath = Normalize-Path -Path $TargetPath

if ($resolvedTargetPath -eq $sourceRoot) {
    throw "The target directory matches the Signal Rail source folder. Choose a different folder."
}

$canonicalFiles = @(
    "README.txt",
    "AI_TO_AI__DEPLOYED_INSTANCE_SIGNAL_RAIL.txt",
    "01_orientation.txt",
    "02_protocol_freeze.txt",
    "03_master_working.txt",
    "04_decision_log.txt",
    "05_latent_ideas.txt",
    "06_ai_to_ai.txt",
    "07_guided_prompts_test.txt",
    "08_surface_map.txt",
    "09_handoff_reentry.txt",
    "97_field_findings.txt",
    "98_parking.txt",
    "99_archive.txt",
    "init_signal_rail.bat",
    "init_signal_rail.ps1"
)

if (-not (Test-Path -LiteralPath $resolvedTargetPath)) {
    New-Item -ItemType Directory -Path $resolvedTargetPath | Out-Null
}

$existingCanonicalFiles = @(
    foreach ($fileName in $canonicalFiles) {
        $targetFile = Join-Path $resolvedTargetPath $fileName
        if (Test-Path -LiteralPath $targetFile) {
            $fileName
        }
    }
)

$overwriteExisting = $false
if ($existingCanonicalFiles.Count -gt 0) {
    do {
        $choice = Read-Host "Existing Signal Rail files were found. Do you want to overwrite them? (yes/no)"
        $normalizedChoice = $choice.Trim().ToLowerInvariant()
    } until ($normalizedChoice -in @("yes", "no"))

    $overwriteExisting = $normalizedChoice -eq "yes"
}

$createdFiles = New-Object System.Collections.Generic.List[string]
$updatedFiles = New-Object System.Collections.Generic.List[string]
$skippedFiles = New-Object System.Collections.Generic.List[string]
$customizedFiles = New-Object System.Collections.Generic.List[string]

foreach ($fileName in $canonicalFiles) {
    $sourceFile = Join-Path $sourceRoot $fileName
    $targetFile = Join-Path $resolvedTargetPath $fileName

    if (-not (Test-Path -LiteralPath $sourceFile)) {
        continue
    }

    $targetExists = Test-Path -LiteralPath $targetFile
    if ($targetExists -and -not $overwriteExisting) {
        $skippedFiles.Add($fileName) | Out-Null
        continue
    }

    Copy-Item -LiteralPath $sourceFile -Destination $targetFile -Force

    if ($targetExists) {
        $updatedFiles.Add($fileName) | Out-Null
    } else {
        $createdFiles.Add($fileName) | Out-Null
    }
}

$currentDate = Get-Date -Format "yyyy-MM-dd"
$masterWorkingPath = Join-Path $resolvedTargetPath "03_master_working.txt"
$orientationPath = Join-Path $resolvedTargetPath "01_orientation.txt"

if ($createdFiles.Contains("03_master_working.txt") -or $updatedFiles.Contains("03_master_working.txt")) {
    Update-MasterWorking -FilePath $masterWorkingPath -CurrentDate $currentDate -ProjectName $ProjectName
    $customizedFiles.Add("03_master_working.txt") | Out-Null
}

if ($ProjectName -and ($createdFiles.Contains("01_orientation.txt") -or $updatedFiles.Contains("01_orientation.txt"))) {
    Update-Orientation -FilePath $orientationPath -ProjectName $ProjectName
    $customizedFiles.Add("01_orientation.txt") | Out-Null
}

Write-Host ""
Write-Host "Signal Rail bootstrap completed in: $resolvedTargetPath"

if ($createdFiles.Count -gt 0) {
    Write-Host "Files created: $($createdFiles -join ', ')"
}

if ($updatedFiles.Count -gt 0) {
    Write-Host "Files overwritten: $($updatedFiles -join ', ')"
}

if ($skippedFiles.Count -gt 0) {
    Write-Host "Files skipped: $($skippedFiles -join ', ')"
}

if ($customizedFiles.Count -gt 0) {
    Write-Host "Files customized: $($customizedFiles -join ', ')"
}

Write-Host ""
Write-Host "Recommended entry points:"
Write-Host "1. Protocol: open 06_ai_to_ai.txt and activate 'read 06_ai_to_ai.txt'."
Write-Host "2. Frame: close host project, working object, and mode before writing."
Write-Host "3. Context: AI_TO_AI__DEPLOYED_INSTANCE_SIGNAL_RAIL.txt reminds you that this folder is the tool, not the host project by default."
Write-Host ""
Write-Host "Recommended initial bootstrap:"
Write-Host "1. Read 06_ai_to_ai.txt first."
Write-Host "2. Close host project, working object, and mode."
Write-Host "3. If live source or authority are still unclear, stop and ask before writing."
Write-Host "4. Fill 01_orientation.txt by describing the host project, not Signal Rail by default."
Write-Host "5. Fill 03_master_working.txt with current live state, dominant blocker, and next sensible move."
Write-Host "6. Use 02_protocol_freeze.txt only for identity constants."
Write-Host "7. Use 04_decision_log.txt only for already-won decisions already in effect."
Write-Host "8. Use 05_latent_ideas.txt for live material that is not yet stable enough."
Write-Host "9. Use 08_surface_map.txt to close where the project really lives technically."
Write-Host "10. Use 09_handoff_reentry.txt for continuity and re-entry, not as canonical truth."
Write-Host "11. Use 97_field_findings.txt when you want to keep lateral findings readable before routing or discarding them."
