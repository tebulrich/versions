param(
  [Parameter(Mandatory = $true)][string]$App,
  [Parameter(Mandatory = $true)][string]$Zip,
  [string]$Version = ""
)

$ErrorActionPreference = "Stop"
if ($Version -match '(?i)x$') {
  throw "Refusing an experimental version. Stable zips have no x suffix."
}
if (-not (Test-Path -LiteralPath $Zip)) {
  throw "Missing zip: $Zip"
}

$jsonPath = Join-Path $PSScriptRoot "$App.json"
if (-not (Test-Path -LiteralPath $jsonPath)) {
  throw "Unknown app file: $jsonPath"
}

$tag = "$App-stable"
$stage = Join-Path $env:TEMP "tebs-publish-stable"
New-Item -ItemType Directory -Force -Path $stage | Out-Null
$asset = Join-Path $stage "stable.zip"
Copy-Item -LiteralPath $Zip -Destination $asset -Force

$preference = $ErrorActionPreference
$ErrorActionPreference = "Continue"
& gh release view $tag --repo tebulrich/versions *> $null
$releaseExists = $LASTEXITCODE -eq 0
$ErrorActionPreference = $preference
$ErrorActionPreference = "Continue"
if ($releaseExists) {
  & gh release upload $tag $asset --repo tebulrich/versions --clobber
} else {
  & gh release create $tag $asset --repo tebulrich/versions --title "$App stable" --notes "Latest stable zip. Experimental builds are not published here."
}
$published = $LASTEXITCODE
$ErrorActionPreference = "Stop"
if ($published -ne 0) {
  throw "The GitHub release was not updated."
}

$url = "https://github.com/tebulrich/versions/releases/download/$tag/stable.zip"
$text = Get-Content -LiteralPath $jsonPath -Raw
if ($text -match '"stableZip"') {
  $text = [regex]::Replace($text, '"stableZip"\s*:\s*"[^"]*"', "`"stableZip`": `"$url`"")
} else {
  $text = $text -replace '"experimentalUrl"\s*:\s*"[^"]*"', "`$0,`r`n  `"stableZip`": `"$url`""
}
if ($Version) {
  $text = [regex]::Replace($text, '"stable"\s*:\s*"[^"]*"', "`"stable`": `"$Version`"")
}
$utf8 = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText($jsonPath, $text.TrimEnd() + "`n", $utf8)
Write-Output "Stored $tag/stable.zip"
