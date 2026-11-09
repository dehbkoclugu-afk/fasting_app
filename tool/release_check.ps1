param(
  [string]$Config = "release.json",
  [ValidateSet('All', 'Android', 'iOS')]
  [string]$Platform = 'All'
)

$checkAndroid = $Platform -in @('All', 'Android')
$checkIos = $Platform -in @('All', 'iOS')

$errors = @()
$required = @(
  "PRIVACY_POLICY_URL", "TERMS_OF_USE_URL"
)
if ($checkAndroid) {
  $required += @('ADMOB_ANDROID_BANNER_ID', 'ADMOB_ANDROID_INTERSTITIAL_ID', 'ANDROID_STORE_URL')
}
if ($checkIos) {
  $required += @('ADMOB_IOS_BANNER_ID', 'ADMOB_IOS_INTERSTITIAL_ID', 'IOS_STORE_URL')
}

$values = $null
if (-not (Test-Path $Config)) {
  $errors += "Missing $Config"
} else {
  try {
    $values = Get-Content -Raw $Config -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
  } catch {
    $errors += "Cannot read valid JSON from $Config"
  }
  foreach ($key in $required) {
    if ([string]::IsNullOrWhiteSpace($values.$key)) { $errors += "Missing $key" }
  }
}

# The RevenueCat public SDK keys may come from $Config or from the in-source
# fallbacks in BuildConfig. Either one keeps purchases working.
$service = Get-Content -Raw "lib/core/config/build_config.dart" -ErrorAction Stop
foreach ($entry in @(
    @{ Key = "REVENUECAT_ANDROID_API_KEY"; Field = "_revenueCatAndroidKeyFallback"; Check = $checkAndroid },
    @{ Key = "REVENUECAT_IOS_API_KEY"; Field = "_revenueCatIosKeyFallback"; Check = $checkIos }
  )) {
  if (-not $entry.Check) { continue }
  $fromConfig = if ($values) { $values.($entry.Key) } else { $null }
  $inSource = $service -match "$($entry.Field)\s*=\s*'[^']+'"
  if ([string]::IsNullOrWhiteSpace($fromConfig) -and -not $inSource) {
    $errors += "Missing $($entry.Key) - set it in $Config or paste the public SDK key into BuildConfig.$($entry.Field)"
  }
}

if ($checkAndroid) {
  if (-not (Test-Path "android/key.properties")) {
    $errors += "Missing android/key.properties"
  }
  $manifest = Get-Content -Raw "android/app/src/main/AndroidManifest.xml" -ErrorAction Stop
  if ($manifest -match "3940256099942544") {
    $errors += "Android still uses the AdMob test application ID"
  }
  if ($manifest -notmatch "android.permission.INTERNET") {
    $errors += "Android release manifest is missing INTERNET permission"
  }
  if ($manifest -notmatch "android.permission.POST_NOTIFICATIONS") {
    $errors += "Android release manifest is missing POST_NOTIFICATIONS permission"
  }
}
if ($checkIos -and (Get-Content -Raw "ios/Runner/Info.plist" -ErrorAction Stop) -match "3940256099942544") {
  $errors += "iOS still uses the AdMob test application ID"
}

if ($errors.Count) {
  $errors | ForEach-Object { Write-Error $_ }
  exit 1
}

Write-Host "FastTrack $Platform configuration preflight passed; signing, build and device validation remain separate checks." -ForegroundColor Green
