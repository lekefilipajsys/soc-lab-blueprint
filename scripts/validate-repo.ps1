$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$errors = New-Object System.Collections.Generic.List[string]

function Add-Error {
    param([string]$Message)
    $errors.Add($Message) | Out-Null
}

function Test-XmlFile {
    param([string]$Path)
    try {
        [xml](Get-Content -Raw -LiteralPath $Path) | Out-Null
    }
    catch {
        Add-Error "XML parse failed: $Path - $($_.Exception.Message)"
    }
}

Push-Location $repoRoot
try {
    $requiredFiles = @(
        "README.md",
        "LICENSE",
        "SECURITY.md",
        "CONTRIBUTING.md",
        ".gitignore",
        "elk-lite/docker-compose.yml",
        "elk-lite/.env.example",
        "wazuh/start-wazuh-single-node.ps1",
        "security-onion/VM-setup-checklist.md"
    )

    foreach ($file in $requiredFiles) {
        if (-not (Test-Path -LiteralPath $file)) {
            Add-Error "Missing required file: $file"
        }
    }

    Test-XmlFile "wazuh/custom-rules/local_rules.xml"
    Test-XmlFile "wazuh/active-response-snippets.xml"

    $forbiddenPatterns = @(
        "\.env$",
        "\.pcap$",
        "\.pcapng$",
        "\.evtx$",
        "\.ova$",
        "\.vmdk$",
        "\.vdi$",
        "\.vhdx$",
        "\.qcow2$"
    )

    $files = Get-ChildItem -Recurse -File -Force |
        Where-Object {
            $_.FullName -notmatch "[/\\]\.git[/\\]" -and
            $_.FullName -notmatch "[/\\]_wazuh-runtime[/\\]"
        }

    foreach ($file in $files) {
        $relative = Resolve-Path -LiteralPath $file.FullName -Relative
        foreach ($pattern in $forbiddenPatterns) {
            if ($relative -match $pattern -and $relative -notmatch "\.env\.example$") {
                Add-Error "Forbidden generated/sensitive file matched ${pattern}: $relative"
            }
        }
    }

    if ($errors.Count -gt 0) {
        Write-Host "Repository validation failed:" -ForegroundColor Red
        foreach ($errorItem in $errors) {
            Write-Host " - $errorItem" -ForegroundColor Red
        }
        exit 1
    }

    Write-Host "Repository validation passed." -ForegroundColor Green
}
finally {
    Pop-Location
}
