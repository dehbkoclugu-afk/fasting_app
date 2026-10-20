$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$ProjectRoot = Split-Path -Parent $PSScriptRoot
$VenvRoot = Join-Path $PSScriptRoot ".venv"
$Python = Join-Path $VenvRoot "Scripts\python.exe"
$PyInstaller = Join-Path $VenvRoot "Scripts\pyinstaller.exe"
$DistRoot = Join-Path $ProjectRoot "dist"
$BuildRoot = Join-Path $ProjectRoot "build\pyinstaller"
$Spec = Join-Path $PSScriptRoot "social-funnel.spec"

if (-not (Test-Path -LiteralPath $Python)) {
    python -m venv $VenvRoot
    if ($LASTEXITCODE -ne 0) { throw "Virtual environment creation failed." }
}

& $Python -m pip install --disable-pip-version-check --upgrade pip
if ($LASTEXITCODE -ne 0) { throw "pip upgrade failed." }
& $Python -m pip install --disable-pip-version-check -e "${ProjectRoot}[dev,packaging,meta,tiktok]"
if ($LASTEXITCODE -ne 0) { throw "Project installation failed." }
& $Python -m pytest (Join-Path $ProjectRoot "tests") -q
if ($LASTEXITCODE -ne 0) { throw "Test suite failed." }

& $PyInstaller --clean --noconfirm --distpath $DistRoot --workpath $BuildRoot $Spec
if ($LASTEXITCODE -ne 0) { throw "PyInstaller build failed." }

$Application = Join-Path $DistRoot "FastTrack Social Funnel"
if (-not (Test-Path -LiteralPath (Join-Path $Application "FastTrack Social Funnel.exe"))) {
    throw "PyInstaller did not create the expected application."
}

$ChecksumFile = Join-Path $DistRoot "checksums.sha256"
Get-ChildItem -LiteralPath $Application -File -Recurse |
    Sort-Object FullName |
    ForEach-Object {
        $Hash = Get-FileHash -LiteralPath $_.FullName -Algorithm SHA256
        $Relative = $_.FullName.Substring($Application.Length).TrimStart("\")
        "{0}  {1}" -f $Hash.Hash.ToLowerInvariant(), $Relative
    } | Set-Content -LiteralPath $ChecksumFile -Encoding utf8

Write-Host "Built: $Application"
Write-Host "Checksums: $ChecksumFile"
