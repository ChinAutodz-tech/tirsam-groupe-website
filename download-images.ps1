$ErrorActionPreference = 'Continue'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$assetDir = Join-Path $root 'assets\vehicles'
New-Item -ItemType Directory -Force -Path $assetDir | Out-Null

$downloads = @(
    @{ File = 'hero-trucks.jpg'; Url = 'https://tirsam.com/wp-content/uploads/2025/09/Frame-1321314479.jpg' },
    @{ File = 'tirsam-13.jpg'; Url = 'https://static.africa-press.net/algeria/sites/2/2025/11/sm_1762997640.002042.jpg' },
    @{ File = 'mini-single-cab.jpg'; Url = 'https://i.dzs.cloud/www.echoroukonline.com/wp-content/uploads/2025/11/tirsam.jpg?resize=790%2C444.375' },
    @{ File = 'mini-double-cab.png'; Url = 'https://hivedigit.org/sites/tirsam/wp-content/uploads/2025/11/1-scaled.png' },
    @{ File = 'truck-35.png'; Url = 'https://cdn.autobip.com/photos/car_models/3461.png' },
    @{ File = 'truck-6t.jpg'; Url = 'https://i.dzs.cloud/www.echoroukonline.com/wp-content/uploads/2025/09/546528061_1218762210282844_620045644510878650_n.jpg?resize=790' },
    @{ File = 'bus-ts9.jpg'; Url = 'https://upload.wikimedia.org/wikipedia/commons/b/b5/Tirsam_TS9_bus_in_Constantine%2C_Algeria.jpg' },
    @{ File = 'bus-ts11-fleet.jpg'; Url = 'https://www.entv.dz/sites/default/files/styles/social_large/public/2026-03/08_1.jpg?h=e5aec6c8&itok=h7v8poBu' },
    @{ File = 'bus-ts12-fleet.jpg'; Url = 'https://alfadjr.dz/storage/GxAbQLZJMDocF4VijmiiFGNIdDARiY2NWfqq3yP8.jpg' }
)

$ok = @()
foreach ($item in $downloads) {
    $dest = Join-Path $assetDir $item.File
    try {
        Write-Host "Downloading $($item.File)..."
        Invoke-WebRequest -Uri $item.Url -OutFile $dest -Headers @{ 'User-Agent' = 'Mozilla/5.0' } -MaximumRedirection 8
        if ((Test-Path $dest) -and (Get-Item $dest).Length -gt 10000) {
            $ok += $item
            Write-Host "  Saved: $dest" -ForegroundColor Green
        } else {
            Remove-Item $dest -ErrorAction SilentlyContinue
            Write-Warning "The response for $($item.File) was too small; kept the website's remote image reference."
        }
    } catch {
        Write-Warning "Could not download $($item.File): $($_.Exception.Message)"
        Remove-Item $dest -ErrorAction SilentlyContinue
    }
}

# Change successful downloads to local paths. Failed downloads stay remote.
$htmlPath = Join-Path $root 'index.html'
$html = Get-Content -Raw -Encoding UTF8 $htmlPath
$map = @{
    'https://tirsam.com/wp-content/uploads/2025/09/Frame-1321314479.jpg' = 'assets/vehicles/hero-trucks.jpg'
    'https://static.africa-press.net/algeria/sites/2/2025/11/sm_1762997640.002042.jpg' = 'assets/vehicles/tirsam-13.jpg'
    'https://i.dzs.cloud/www.echoroukonline.com/wp-content/uploads/2025/11/tirsam.jpg?resize=790%2C444.375' = 'assets/vehicles/mini-single-cab.jpg'
    'https://hivedigit.org/sites/tirsam/wp-content/uploads/2025/11/1-scaled.png' = 'assets/vehicles/mini-double-cab.png'
    'https://cdn.autobip.com/photos/car_models/3461.png' = 'assets/vehicles/truck-35.png'
    'https://i.dzs.cloud/www.echoroukonline.com/wp-content/uploads/2025/09/546528061_1218762210282844_620045644510878650_n.jpg?resize=790' = 'assets/vehicles/truck-6t.jpg'
    'https://upload.wikimedia.org/wikipedia/commons/b/b5/Tirsam_TS9_bus_in_Constantine%2C_Algeria.jpg' = 'assets/vehicles/bus-ts9.jpg'
    'https://www.entv.dz/sites/default/files/styles/social_large/public/2026-03/08_1.jpg?h=e5aec6c8&itok=h7v8poBu' = 'assets/vehicles/bus-ts11-fleet.jpg'
    'https://alfadjr.dz/storage/GxAbQLZJMDocF4VijmiiFGNIdDARiY2NWfqq3yP8.jpg' = 'assets/vehicles/bus-ts12-fleet.jpg'
}
foreach ($item in $ok) {
    $remote = $item.Url
    if ($map.ContainsKey($remote)) { $html = $html.Replace($remote, $map[$remote]) }
}
Set-Content -Path $htmlPath -Value $html -Encoding UTF8
Write-Host "Finished: downloaded $($ok.Count) of $($downloads.Count) images." -ForegroundColor Cyan
Write-Host 'If a source blocks downloads, its remote image URL remains in index.html.'
