param([string]$Config = "release.json")

$errors = @()
$required = @(
  "REVENUECAT_ANDROID_API_KEY", "REVENUECAT_IOS_API_KEY",
  "ADMOB_ANDROID_BANNER_ID", "ADMOB_IOS_BANNER_ID",
  "ADMOB_ANDROID_INTERSTITIAL_ID", "ADMOB_IOS_INTERSTITIAL_ID",
  "PRIVACY_POLICY_URL", "TERMS_OF_USE_URL",
  "ANDROID_STORE_URL", "IOS_STORE_URL"
)

if (-not (Test-Path $Config)) {
  $errors += "Missing $Config"
} else {
  $values = Get-Content -Raw $Config | ConvertFrom-Json
  foreach ($key in $required) {
    if ([string]::IsNullOrWhiteSpace($values.$key)) { $errors += "Missing $key" }
  }
}

if (-not (Test-Path "android/key.properties")) {
  $errors += "Missing android/key.properties"
}
if ((Get-Content -Raw "android/app/src/main/AndroidManifest.xml") -match "3940256099942544") {
  $errors += "Android still uses the AdMob test application ID"
}
if ((Get-Content -Raw "ios/Runner/Info.plist") -match "3940256099942544") {
  $errors += "iOS still uses the AdMob test application ID"
}

if ($errors.Count) {
  $errors | ForEach-Object { Write-Error $_ }
  exit 1
}

Write-Host "FastTrack release configuration is complete." -ForegroundColor Green
