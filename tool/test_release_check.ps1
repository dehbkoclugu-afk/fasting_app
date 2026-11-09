$ErrorActionPreference = 'Stop'
$checker = Join-Path $PSScriptRoot 'release_check.ps1'
$engine = (Get-Process -Id $PID).Path
$fixture = Join-Path ([IO.Path]::GetTempPath()) ('fasttrack-preflight-' + [guid]::NewGuid())
$originalLocation = Get-Location

function Write-Fixture {
  param([bool]$IosTestId = $false, [bool]$AndroidKey = $true, [bool]$SigningFile = $true)
  foreach ($directory in @('lib/core/config', 'android/app/src/main', 'ios/Runner')) {
    New-Item -ItemType Directory -Path (Join-Path $fixture $directory) -Force | Out-Null
  }
  $values = @{
    ADMOB_ANDROID_BANNER_ID = 'android-banner'
    ADMOB_ANDROID_INTERSTITIAL_ID = 'android-interstitial'
    ADMOB_IOS_BANNER_ID = 'ios-banner'
    ADMOB_IOS_INTERSTITIAL_ID = 'ios-interstitial'
    PRIVACY_POLICY_URL = 'https://example.com/privacy'
    TERMS_OF_USE_URL = 'https://example.com/terms'
    ANDROID_STORE_URL = 'https://example.com/android'
    IOS_STORE_URL = 'https://example.com/ios'
    REVENUECAT_IOS_API_KEY = 'appl_fixture'
  }
  $values | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $fixture 'release.json')
  $androidFallback = if ($AndroidKey) { 'goog_fixture' } else { '' }
  @"
class BuildConfig {
  static const _revenueCatAndroidKeyFallback =
      '$androidFallback';
  static const _revenueCatIosKeyFallback = '';
}
"@ | Set-Content -LiteralPath (Join-Path $fixture 'lib/core/config/build_config.dart')
  '<manifest><uses-permission android:name="android.permission.INTERNET"/><uses-permission android:name="android.permission.POST_NOTIFICATIONS"/></manifest>' |
    Set-Content -LiteralPath (Join-Path $fixture 'android/app/src/main/AndroidManifest.xml')
  $iosId = if ($IosTestId) { 'ca-app-pub-3940256099942544~1458002511' } else { 'ca-app-pub-fixture~ios' }
  "<plist><key>GADApplicationIdentifier</key><string>$iosId</string></plist>" |
    Set-Content -LiteralPath (Join-Path $fixture 'ios/Runner/Info.plist')
  $signingPath = Join-Path $fixture 'android/key.properties'
  if ($SigningFile) {
    '# Fixture only: this test does not validate a real signing key.' | Set-Content -LiteralPath $signingPath
  } elseif (Test-Path -LiteralPath $signingPath) {
    Remove-Item -LiteralPath $signingPath
  }
}

function Assert-Check {
  param([string]$Name, [int]$ExpectedExit, [string[]]$Arguments = @(), [string]$ExpectedMessage = '', [string]$UnexpectedMessage = '')
  # Read raw child streams so Windows PowerShell 5 does not wrap stderr in
  # NativeCommandError records before we inspect expected validation failures.
  $process = New-Object System.Diagnostics.Process
  $process.StartInfo.FileName = $engine
  $process.StartInfo.WorkingDirectory = (Get-Location).Path
  $process.StartInfo.Arguments = '-NoProfile -NonInteractive -File "' + $checker + '" ' + ($Arguments -join ' ')
  $process.StartInfo.UseShellExecute = $false
  $process.StartInfo.CreateNoWindow = $true
  $process.StartInfo.RedirectStandardOutput = $true
  $process.StartInfo.RedirectStandardError = $true
  try {
    $process.Start() | Out-Null
    $stdout = $process.StandardOutput.ReadToEndAsync()
    $stderr = $process.StandardError.ReadToEndAsync()
    $process.WaitForExit()
    $output = $stdout.Result + $stderr.Result
    $exitCode = $process.ExitCode
  } finally {
    $process.Dispose()
  }
  $normalized = $output -replace '\s+', ''
  $expectedText = $ExpectedMessage -replace '\s+', ''
  $unexpectedText = $UnexpectedMessage -replace '\s+', ''
  if ($exitCode -ne $ExpectedExit -or ($ExpectedMessage -and $normalized -notlike "*$expectedText*") -or
      ($UnexpectedMessage -and $normalized -like "*$unexpectedText*")) {
    throw "$Name expected exit $ExpectedExit, received $exitCode.`n$output"
  }
  Write-Output "PASS $Name"
}

try {
  Write-Fixture
  Set-Location -LiteralPath $fixture
  Assert-Check 'multiline public fallback satisfies the default combined preflight' 0

  Write-Fixture -IosTestId $true
  $androidValues = Get-Content -Raw release.json | ConvertFrom-Json
  foreach ($key in @('ADMOB_IOS_BANNER_ID', 'ADMOB_IOS_INTERSTITIAL_ID', 'IOS_STORE_URL', 'REVENUECAT_IOS_API_KEY')) {
    $androidValues.PSObject.Properties.Remove($key)
  }
  $androidValues | ConvertTo-Json | Set-Content -LiteralPath release.json
  Assert-Check 'Android preflight ignores unfinished iOS configuration' 0 @('-Platform', 'Android')
  Assert-Check 'combined preflight still rejects unfinished iOS configuration' 1 @() 'iOS still uses the AdMob test application ID'

  Write-Fixture -AndroidKey $false
  Assert-Check 'missing Android entitlement key is rejected' 1 @('-Platform', 'Android') 'Missing REVENUECAT_ANDROID_API_KEY'

  Write-Fixture -SigningFile $false
  Assert-Check 'Android signing configuration is required' 1 @('-Platform', 'Android') 'Missing android/key.properties'
  Remove-Item -LiteralPath 'android/app/src/main/AndroidManifest.xml'
  Assert-Check 'iOS preflight does not require Android files' 0 @('-Platform', 'iOS')
  Remove-Item -LiteralPath 'ios/Runner/Info.plist'
  Assert-Check 'iOS configuration file is required' 1 @('-Platform', 'iOS')

  Write-Fixture
  '{"GEMINI_API_KEY":"test-only-secret",' | Set-Content -LiteralPath release.json
  Assert-Check 'malformed configuration fails without echoing credential content' 1 @('-Platform', 'Android') 'Cannot read valid JSON' 'test-only-secret'
} finally {
  Set-Location -LiteralPath $originalLocation.Path
  $resolvedFixture = [IO.Path]::GetFullPath($fixture)
  $tempRoot = [IO.Path]::GetFullPath([IO.Path]::GetTempPath())
  if ($resolvedFixture.StartsWith($tempRoot, [StringComparison]::OrdinalIgnoreCase) -and
      ([IO.Path]::GetFileName($resolvedFixture)).StartsWith('fasttrack-preflight-')) {
    Remove-Item -LiteralPath $resolvedFixture -Recurse -Force
  }
}
