[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$TargetPath,
    [string]$Profile = "international-en-core"
)

$ErrorActionPreference = "Stop"

function Normalize-Path {
    param([string]$Path)

    $fullPath = [System.IO.Path]::GetFullPath($Path)
    return $fullPath.TrimEnd("\")
}

function Add-Finding {
    param(
        [System.Collections.Generic.List[object]]$Bucket,
        [string]$Path,
        [int]$LineNumber,
        [string]$Kind,
        [string]$Text
    )

    $Bucket.Add([PSCustomObject]@{
        path = $Path
        line = $LineNumber
        kind = $Kind
        text = $Text.Trim()
    }) | Out-Null
}

function Get-LineNumberFromIndex {
    param(
        [string]$Text,
        [int]$Index
    )

    if ($Index -lt 0) {
        return 0
    }

    $prefix = $Text.Substring(0, [Math]::Min($Index, $Text.Length))
    return ([regex]::Matches($prefix, "`n")).Count + 1
}

function Get-BootstrapPlaceholders {
    param([string]$BootstrapText)

    $matches = [regex]::Matches($BootstrapText, 'if \(\$lines\[\$i\] -eq "(?<placeholder>- [^"]+:)"\)')
    $placeholders = New-Object 'System.Collections.Generic.List[string]'

    foreach ($match in $matches) {
        $placeholder = $match.Groups["placeholder"].Value
        if (-not $placeholders.Contains($placeholder)) {
            $placeholders.Add($placeholder) | Out-Null
        }
    }

    return $placeholders
}

function Test-ExcludedFile {
    param(
        [string]$FullName,
        [string]$RootPath
    )

    $relativePath = $FullName.Substring($RootPath.Length).TrimStart("\")

    if ($relativePath -like "SR Localization Kit\*") {
        return $true
    }

    return $false
}

$resolvedTargetPath = Normalize-Path -Path $TargetPath

if (-not (Test-Path -LiteralPath $resolvedTargetPath)) {
    throw "Target path does not exist: $resolvedTargetPath"
}

$supportedProfiles = @("international-en-core")

if ($supportedProfiles -notcontains $Profile) {
    throw "Unsupported profile: $Profile. Supported profiles: $($supportedProfiles -join ', ')"
}

$files = Get-ChildItem -LiteralPath $resolvedTargetPath -File -Recurse | Where-Object {
    $_.Extension -ne ".html" -and -not (Test-ExcludedFile -FullName $_.FullName -RootPath $resolvedTargetPath)
}

$baselinePatterns = @(
    @{ kind = "baseline_tag"; pattern = "project name" },
    @{ kind = "baseline_tag"; pattern = "identity constants" },
    @{ kind = "baseline_tag"; pattern = "links to" },
    @{ kind = "baseline_tag"; pattern = "external reference" },
    @{ kind = "baseline_tag"; pattern = "won against" },
    @{ kind = "baseline_tag"; pattern = "Current Objective" },
    @{ kind = "baseline_tag"; pattern = "Current Blocker" },
    @{ kind = "baseline_tag"; pattern = "Current State" },
    @{ kind = "baseline_tag"; pattern = "Work In Progress" },
    @{ kind = "baseline_tag"; pattern = "Open Items That Matter Now" },
    @{ kind = "baseline_tag"; pattern = "Real Open Questions" },
    @{ kind = "baseline_tag"; pattern = "Active Risks" },
    @{ kind = "baseline_tag"; pattern = "Next Step" },
    @{ kind = "baseline_tag"; pattern = "Possible Destination" },
    @{ kind = "baseline_tag"; pattern = "Likely Direction" },
    @{ kind = "baseline_tag"; pattern = "What Is Still Missing" },
    @{ kind = "baseline_tag"; pattern = "Why It Matters" },
    @{ kind = "baseline_tag"; pattern = "Why It Is Strong" },
    @{ kind = "baseline_tag"; pattern = "Key Repos / Folders" },
    @{ kind = "baseline_tag"; pattern = "Entrypoints" },
    @{ kind = "baseline_tag"; pattern = "false entrypoint" },
    @{ kind = "baseline_tag"; pattern = "sensitive point" },
    @{ kind = "baseline_tag"; pattern = "minimum safe move" },
    @{ kind = "baseline_tag"; pattern = "shape of the content" },
    @{ kind = "baseline_tag"; pattern = "stability" },
    @{ kind = "baseline_tag"; pattern = "unresolved hinge" },
    @{ kind = "baseline_tag"; pattern = "bounded move" },
    @{ kind = "baseline_tag"; pattern = "controlled transit" },
    @{ kind = "baseline_tag"; pattern = "findings" },
    @{ kind = "baseline_tag"; pattern = "REFINEMENT" },
    @{ kind = "baseline_tag"; pattern = "SIGNAL" },
    @{ kind = "baseline_tag"; pattern = "SEED" },
    @{ kind = "baseline_tag"; pattern = "- where:" },
    @{ kind = "baseline_tag"; pattern = "- what:" },
    @{ kind = "baseline_tag"; pattern = "- why it matters:" },
    @{ kind = "baseline_tag"; pattern = "- note:" },
    @{ kind = "baseline_ui"; pattern = "Paste the target directory" },
    @{ kind = "baseline_ui"; pattern = "Host project name" },
    @{ kind = "baseline_ui"; pattern = "Operation cancelled" },
    @{ kind = "baseline_ui"; pattern = "Bootstrap completed" },
    @{ kind = "baseline_ui"; pattern = "Recommended entry points" },
    @{ kind = "baseline_ui"; pattern = "Recommended initial bootstrap" },
    @{ kind = "baseline_ui"; pattern = "Existing Signal Rail files were found. Do you want to overwrite them? (yes/no)" }
)

$findings = New-Object 'System.Collections.Generic.List[object]'

foreach ($file in $files) {
    $relativePath = $file.FullName.Substring($resolvedTargetPath.Length).TrimStart("\")
    $lines = Get-Content -LiteralPath $file.FullName

    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]

        foreach ($entry in $baselinePatterns) {
            if ($line -match [regex]::Escape($entry.pattern)) {
                Add-Finding -Bucket $findings -Path $relativePath -LineNumber ($i + 1) -Kind $entry.kind -Text $line
            }
        }
    }
}

$bootstrapFindings = New-Object 'System.Collections.Generic.List[object]'
$markerFindings = New-Object 'System.Collections.Generic.List[object]'
$bootstrapPath = Join-Path $resolvedTargetPath "init_signal_rail.ps1"
$orientationPath = Join-Path $resolvedTargetPath "01_orientation.txt"
$masterWorkingPath = Join-Path $resolvedTargetPath "03_master_working.txt"

if (Test-Path -LiteralPath $bootstrapPath) {
    $bootstrapText = Get-Content -Raw -LiteralPath $bootstrapPath
    $bootstrapPlaceholders = Get-BootstrapPlaceholders -BootstrapText $bootstrapText

    if ($bootstrapPlaceholders.Count -eq 0) {
        Add-Finding -Bucket $bootstrapFindings -Path "init_signal_rail.ps1" -LineNumber 0 -Kind "bootstrap_placeholder" -Text "No template placeholder matches were detected in the bootstrap script."
    } else {
        $templateTexts = @()

        if (Test-Path -LiteralPath $orientationPath) {
            $templateTexts += (Get-Content -Raw -LiteralPath $orientationPath)
        }

        if (Test-Path -LiteralPath $masterWorkingPath) {
            $templateTexts += (Get-Content -Raw -LiteralPath $masterWorkingPath)
        }

        $joinedTemplateText = $templateTexts -join "`n"

        foreach ($placeholder in $bootstrapPlaceholders) {
            if ($joinedTemplateText -notmatch [regex]::Escape($placeholder)) {
                Add-Finding -Bucket $bootstrapFindings -Path "init_signal_rail.ps1" -LineNumber 0 -Kind "bootstrap_placeholder" -Text "Bootstrap expects placeholder '$placeholder' but it was not found in 01_orientation.txt or 03_master_working.txt."
            }
        }
    }
} else {
    Add-Finding -Bucket $bootstrapFindings -Path "init_signal_rail.ps1" -LineNumber 0 -Kind "bootstrap_placeholder" -Text "Bootstrap script not found."
}

$markerContractFiles = @(
    "04_decision_log.txt",
    "05_latent_ideas.txt",
    "08_surface_map.txt",
    "09_handoff_reentry.txt",
    "97_field_findings.txt",
    "98_parking.txt",
    "99_archive.txt"
)

foreach ($markerFile in $markerContractFiles) {
    $fullPath = Join-Path $resolvedTargetPath $markerFile
    if (-not (Test-Path -LiteralPath $fullPath)) {
        Add-Finding -Bucket $markerFindings -Path $markerFile -LineNumber 0 -Kind "marker_contract" -Text "Required append-driven canonical file not found."
        continue
    }

    $text = Get-Content -Raw -LiteralPath $fullPath
    $legacyMatches = [regex]::Matches($text, '(?m)^--- ENTRIES START BELOW ---\s*$')
    if ($legacyMatches.Count -gt 0) {
        $line = Get-LineNumberFromIndex -Text $text -Index $legacyMatches[0].Index
        Add-Finding -Bucket $markerFindings -Path $markerFile -LineNumber $line -Kind "marker_contract" -Text "Legacy marker '--- ENTRIES START BELOW ---' found. Use '--- ENTRIES START ---'."
    }

    $startMatches = [regex]::Matches($text, '(?m)^--- ENTRIES START ---\s*$')
    $endMatches = [regex]::Matches($text, '(?m)^--- ENTRIES END ---\s*$')

    if ($startMatches.Count -ne 1) {
        $line = if ($startMatches.Count -gt 0) { Get-LineNumberFromIndex -Text $text -Index $startMatches[0].Index } else { 0 }
        Add-Finding -Bucket $markerFindings -Path $markerFile -LineNumber $line -Kind "marker_contract" -Text "Expected exactly 1 '--- ENTRIES START ---' marker, found $($startMatches.Count)."
    }

    if ($endMatches.Count -ne 1) {
        $line = if ($endMatches.Count -gt 0) { Get-LineNumberFromIndex -Text $text -Index $endMatches[0].Index } else { 0 }
        Add-Finding -Bucket $markerFindings -Path $markerFile -LineNumber $line -Kind "marker_contract" -Text "Expected exactly 1 '--- ENTRIES END ---' marker, found $($endMatches.Count)."
    }

    if ($startMatches.Count -eq 1 -and $endMatches.Count -eq 1) {
        if ($startMatches[0].Index -ge $endMatches[0].Index) {
            $line = Get-LineNumberFromIndex -Text $text -Index $startMatches[0].Index
            Add-Finding -Bucket $markerFindings -Path $markerFile -LineNumber $line -Kind "marker_contract" -Text "Marker order invalid: ENTRIES START must appear before ENTRIES END."
        }
    }
}

Write-Host ""
Write-Host "SR localization audit"
Write-Host "Target: $resolvedTargetPath"
Write-Host "Profile: $Profile"
Write-Host "Scope: core non-HTML Signal Rail files only"
Write-Host "Mode: baseline-English residue and bootstrap/template consistency check"
Write-Host ""

if ($findings.Count -eq 0 -and $bootstrapFindings.Count -eq 0 -and $markerFindings.Count -eq 0) {
    Write-Host "No baseline-English localization drift or marker-contract issues found in the localized core."
    exit 0
}

if ($findings.Count -gt 0) {
    Write-Host "Baseline-English residue findings:"
    Write-Host "These findings show baseline terms that still remain in the localized SR core."
    foreach ($finding in $findings) {
        Write-Host "- [$($finding.kind)] $($finding.path):$($finding.line) -> $($finding.text)"
    }
    Write-Host ""
}

if ($bootstrapFindings.Count -gt 0) {
    Write-Host "Bootstrap/template consistency findings:"
    Write-Host "These findings show placeholders expected by the bootstrap that were not found in the localized templates."
    foreach ($finding in $bootstrapFindings) {
        Write-Host "- [$($finding.kind)] $($finding.path) -> $($finding.text)"
    }
}

if ($markerFindings.Count -gt 0) {
    Write-Host "Marker contract findings:"
    Write-Host "These findings show missing, duplicate, malformed, or misordered ENTRIES markers in append-driven canonicals."
    foreach ($finding in $markerFindings) {
        Write-Host "- [$($finding.kind)] $($finding.path):$($finding.line) -> $($finding.text)"
    }
}
Write-Host ""

exit 1
