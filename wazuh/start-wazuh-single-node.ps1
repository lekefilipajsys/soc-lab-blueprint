param(
    [string]$InstallRoot = "$PSScriptRoot\_wazuh-runtime",
    [string]$WazuhVersion = "v4.14.5"
)

$ErrorActionPreference = "Stop"

function Require-Command {
    param([string]$Name)
    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        throw "Required command '$Name' was not found. Install it and run this script again."
    }
}

Require-Command git
Require-Command docker

Write-Host "Checking Docker Compose..."
docker compose version | Out-Host

Write-Host ""
Write-Host "If Docker uses WSL2/Linux, make sure this has been run inside that environment:"
Write-Host "  sudo sysctl -w vm.max_map_count=262144"
Write-Host ""

New-Item -ItemType Directory -Force -Path $InstallRoot | Out-Null

$repoPath = Join-Path $InstallRoot "wazuh-docker"
if (-not (Test-Path $repoPath)) {
    git clone https://github.com/wazuh/wazuh-docker.git -b $WazuhVersion $repoPath
}
else {
    git -C $repoPath fetch --tags
    git -C $repoPath checkout $WazuhVersion
}

$singleNodePath = Join-Path $repoPath "single-node"
if (-not (Test-Path $singleNodePath)) {
    throw "Could not find Wazuh single-node directory at $singleNodePath."
}

Push-Location $singleNodePath
try {
    $certDir = Join-Path $singleNodePath "config\wazuh_indexer_ssl_certs"
    $needsCerts = -not (Test-Path $certDir) -or -not (Get-ChildItem $certDir -File -ErrorAction SilentlyContinue)

    if ($needsCerts) {
        Write-Host "Generating Wazuh self-signed certificates..."
        docker compose -f generate-indexer-certs.yml run --rm generator
    }
    else {
        Write-Host "Certificate directory already contains files. Skipping certificate generation."
    }

    Write-Host "Starting Wazuh single-node stack..."
    docker compose up -d
}
finally {
    Pop-Location
}

Write-Host ""
Write-Host "Wazuh dashboard: https://localhost"
Write-Host "Default first-login credentials from the official compose stack: admin / SecretPassword"
Write-Host "Change the default password before keeping the lab online."

