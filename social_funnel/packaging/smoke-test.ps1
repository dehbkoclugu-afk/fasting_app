$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$ProjectRoot = Split-Path -Parent $PSScriptRoot
$Executable = Join-Path $ProjectRoot "dist\FastTrack Social Funnel\FastTrack Social Funnel.exe"
$TempRoot = Join-Path ([IO.Path]::GetTempPath()) ("FastTrack-Smoke-" + [guid]::NewGuid().ToString("N"))
$Workspace = Join-Path $TempRoot "Türkçe Çalışma Alanı"
$ReportPath = Join-Path $TempRoot "smoke-report.json"

if (-not (Test-Path -LiteralPath $Executable)) {
    throw "Packaged executable is missing. Run build.ps1 first."
}

New-Item -ItemType Directory -Path $TempRoot | Out-Null
try {
    $env:FASTTRACK_SMOKE_TEST = "1"
    $env:FASTTRACK_SMOKE_WORKSPACE = $Workspace
    $env:FASTTRACK_SMOKE_REPORT = $ReportPath
    $Process = Start-Process -FilePath $Executable -Wait -PassThru -WindowStyle Hidden
    if ($Process.ExitCode -ne 0) {
        $Details = if (Test-Path -LiteralPath $ReportPath) {
            Get-Content -Raw -LiteralPath $ReportPath
        } else {
            "No diagnostic report was written."
        }
        throw "Packaged smoke process failed with exit code $($Process.ExitCode). $Details"
    }
    if (-not (Test-Path -LiteralPath $ReportPath)) {
        throw "Packaged smoke process did not write a report."
    }
    $Report = Get-Content -Raw -LiteralPath $ReportPath | ConvertFrom-Json
    if ($Report.idea_count -ne 30) { throw "Expected 30 ideas." }
    if ($Report.localized_count -ne 90) { throw "Expected 90 localized units." }
    if ($Report.job_count -ne 360) { throw "Expected 360 jobs." }
    if ($Report.account_count -ne 12) { throw "Expected 12 accounts." }
    if ($Report.health -ne "ok") { throw "Local health check failed." }
    if ($Report.rendered -ne $true) { throw "Sample rendering failed." }
    if ($Report.paused -ne $false) { throw "Pause/resume did not finish resumed." }
    if ($Report.shutdown -ne "clean") { throw "Packaged shutdown was not clean." }
    Write-Host "Smoke test passed: 30 ideas, 90 localized units, 360 jobs."
}
finally {
    Remove-Item Env:FASTTRACK_SMOKE_TEST -ErrorAction SilentlyContinue
    Remove-Item Env:FASTTRACK_SMOKE_WORKSPACE -ErrorAction SilentlyContinue
    Remove-Item Env:FASTTRACK_SMOKE_REPORT -ErrorAction SilentlyContinue
    if (Test-Path -LiteralPath $TempRoot) {
        Remove-Item -LiteralPath $TempRoot -Recurse -Force
    }
}
