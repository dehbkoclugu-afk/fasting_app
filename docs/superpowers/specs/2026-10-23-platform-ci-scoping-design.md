# Platform-specific CI scope

The repository contains a Flutter app and the separate FastTrack Social Funnel Windows app. A pull request that changes only the Windows app should not build or upload an Android App Bundle.

## Triggers

- Run the Android workflow for changes to Flutter source, tests, assets, package metadata, analysis configuration, or Android project files. Apply the same filter to pull requests and pushes to `main`. Keep manual dispatch available.
- Run a Windows workflow for changes under `social_funnel/` or to its workflow file, on pull requests and pushes to `main`. Keep manual dispatch available.

## Windows check

Use a GitHub-hosted Windows runner with Python 3.13. Run the existing `social_funnel/packaging/build.ps1` and `smoke-test.ps1` scripts. The build script executes the Python test suite and packages the EXE; the smoke script verifies the packaged executable in a temporary workspace, including a path with Turkish characters.

Do not upload the Windows package as an Actions artifact. The existing Android artifact quota is already exhausted. Keep the local package and checksum generation behavior unchanged.

## Acceptance

- A Social Funnel-only PR starts the Windows check and skips the Android check.
- Flutter changes still start the Android check.
- Windows CI passes only when Python tests, packaging, and the packaged smoke test pass.
- No workflow step publishes social content or uses production credentials.
