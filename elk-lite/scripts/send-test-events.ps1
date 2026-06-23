param(
    [string]$HostName = "127.0.0.1",
    [int]$Port = 5514,
    [int]$Count = 5
)

$client = [System.Net.Sockets.TcpClient]::new($HostName, $Port)
$stream = $client.GetStream()

try {
    for ($i = 1; $i -le $Count; $i++) {
        $event = [ordered]@{
            "@timestamp" = (Get-Date).ToUniversalTime().ToString("o")
            message = "SOC_LAB_TEST synthetic validation event $i"
            event = @{
                dataset = "soc_lab.validation"
                kind = "alert"
                category = @("configuration")
                type = @("info")
            }
            host = @{
                name = $env:COMPUTERNAME
            }
            source = @{
                ip = "10.20.20.10"
            }
            rule = @{
                name = "Synthetic SOC validation"
                id = "SOC-LAB-0001"
            }
        }

        $json = ($event | ConvertTo-Json -Depth 8 -Compress) + "`n"
        $bytes = [System.Text.Encoding]::UTF8.GetBytes($json)
        $stream.Write($bytes, 0, $bytes.Length)
        Start-Sleep -Milliseconds 250
    }
}
finally {
    $stream.Dispose()
    $client.Dispose()
}

Write-Host "Sent $Count JSON events to ${HostName}:${Port}."

