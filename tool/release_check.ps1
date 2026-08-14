param([string]$Config = "release.json")

$errors = @()
$required = @(
  "ADMOB_ANDROID_BANNER_ID", "ADMOB_IOS_BANNER_ID",
  "ADMOB_ANDROID_INTERSTITIAL_ID", "ADMOB_IOS_INTERSTITIAL_ID",
  "PRIVACY_POLICY_URL", "TERMS_OF_USE_URL",
  "ANDROID_STORE_URL", "IOS_STORE_URL"
)

$values = $null
if (-not (Test-Path $Config)) {
  $errors += "Missing $Config"
} else {
  $values = Get-Content -Raw $Config | ConvertFrom-Json
  foreach ($key in $required) {
    if ([string]::IsNullOrWhiteSpace($values.$key)) { $errors += "Missing $key" }
  }
}

# The RevenueCat public SDK keys may come from $Config or from the in-source
# fallbacks in BuildConfig. Either one keeps purchases working.
$service = Get-Content -Raw "lib/core/config/build_config.dart"
foreach ($entry in @(
    @{ Key = "REVENUECAT_ANDROID_API_KEY"; Field = "_revenueCatAndroidKeyFallback" },
    @{ Key = "REVENUECAT_IOS_API_KEY"; Field = "_revenueCatIosKeyFallback" }
  )) {
  $fromConfig = if ($values) { $values.($entry.Key) } else { $null }
  $inSource = $service -match "$($entry.Field) = '[^']+'"
  if ([string]::IsNullOrWhiteSpace($fromConfig) -and -not $inSource) {
    $errors += "Missing $($entry.Key) - set it in $Config or paste the public SDK key into BuildConfig.$($entry.Field)"
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
