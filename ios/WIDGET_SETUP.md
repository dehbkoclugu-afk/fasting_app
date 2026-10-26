# iOS Widget Setup (Xcode Required)

The Swift code and configuration files are ready in `ios/FastingWidget/`.
To complete the setup, you need Xcode on a Mac (or Codemagic):

## Steps in Xcode:

1. Open `ios/Runner.xcworkspace` in Xcode
2. File > New > Target > Widget Extension
   - Product Name: `FastingWidget`
   - Bundle ID: `com.ceystudios.fasttrack.FastingWidget`
   - Uncheck "Include Configuration Intent"
3. Replace the auto-generated Swift file with `FastingWidget/FastingWidget.swift`
4. Add App Group capability to BOTH targets:
   - Runner target > Signing & Capabilities > + Capability > App Groups
   - Add: `group.com.ceystudios.fasttrack`
   - FastingWidget target > same steps
5. Set deployment target to iOS 17.0 for the widget extension
6. Build and run

## Files Ready:
- `FastingWidget/FastingWidget.swift` - Widget UI + data provider
- `FastingWidget/Info.plist` - Extension config
- `FastingWidget/FastingWidget.entitlements` - App Group
- `Runner/Runner.entitlements` - App Group for main app
