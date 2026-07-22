$ErrorActionPreference = "Stop"

$signingDirectory = "C:\Users\kedi\fasttrack-signing"
$keystore = Join-Path $signingDirectory "fasttrack-upload.jks"
$credentials = Join-Path $signingDirectory "fasttrack-keystore-credentials.txt"
$properties = Join-Path $PSScriptRoot "..\android\key.properties"
$keytool = "C:\Program Files\Android\Android Studio\jbr\bin\keytool.exe"

if ((Test-Path $keystore) -or (Test-Path $properties)) {
  throw "Signing files already exist; nothing was overwritten."
}
if (-not (Test-Path $keytool)) { throw "Android Studio keytool was not found." }

New-Item -ItemType Directory -Path $signingDirectory -Force | Out-Null
$randomBytes = New-Object byte[] 32
$random = [Security.Cryptography.RandomNumberGenerator]::Create()
$random.GetBytes($randomBytes)
$random.Dispose()
$password = [Convert]::ToBase64String($randomBytes).Replace("+", "-").Replace("/", "_").TrimEnd("=")

& $keytool -genkeypair -v -keystore $keystore -storetype JKS `
  -keyalg RSA -keysize 4096 -validity 10000 -alias upload `
  -storepass $password -keypass $password `
  -dname "CN=FastTrack, OU=Mobile, O=FastTrack, L=Istanbul, ST=Istanbul, C=TR" `
  | Out-Null

@"
FastTrack Android upload key
Alias: upload
Password: $password
Keystore: $keystore

Store this file and the JKS in a secure backup. Do not commit either file.
"@ | Set-Content -Encoding utf8 $credentials

@"
storePassword=$password
keyPassword=$password
keyAlias=upload
storeFile=C:/Users/kedi/fasttrack-signing/fasttrack-upload.jks
"@ | Set-Content -Encoding ascii $properties

& icacls $signingDirectory /inheritance:r /grant:r "$env:USERNAME`:(OI)(CI)F" | Out-Null
Write-Host "Upload keystore created and connected to Gradle." -ForegroundColor Green
