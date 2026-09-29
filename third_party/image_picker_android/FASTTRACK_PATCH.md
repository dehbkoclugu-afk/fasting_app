# FastTrack Android photo decode patch

This directory vendors the runtime files of `image_picker_android 0.8.13+17`
under its original BSD license. Pub archive SHA-256:
`d5b3e1774af29c9ab00103afb0d4614070f924d2e0057ac867ec98800114793f`.

Source: https://pub.dev/packages/image_picker_android/versions/0.8.13+17

## Why the local override exists

`ImageResizer.resizeImageIfNeeded` reads image dimensions, then creates a new
`BitmapFactory.Options` and passes that unpopulated object to
`calculateSampleSize`. Its `outWidth` and `outHeight` are zero, so `inSampleSize`
stays 1. The full camera bitmap is decoded before scaling to the requested
1024-pixel size. A 12000 x 9000 ARGB bitmap alone requires 432,000,000 bytes.
An Android `OutOfMemoryError` at this point is outside Dart's picker try/catch.

This is a confirmed native code defect and a credible cause of intermittent
photo-related termination. It is not a confirmed trace of a particular user's
device crash. The same defect was present in the published +23 source inspected
on 2026-09-27, so a dependency upgrade alone did not resolve it.

Only `ImageResizer.java` is changed from the upstream runtime files:

- Populate decoder bounds before calculating sample size.
- Reject invalid dimensions and clamp a resized dimension to at least one pixel.
- Recycle decoded/scaled bitmaps, including exceptional paths, without recycling
  the same bitmap twice when scaling returns its input.

The upstream README and LICENSE are retained. Example apps, upstream test
fixtures, and generated build artifacts are intentionally not vendored.

## Regression check

Run `python3 tool/verify_picker_sampling.py` with JDK 17. This compiles the actual
vendored Java resizer against small Android API test doubles. It checks decoder
parameters and bitmap lifetime, not real Android codecs or physical memory.
The upstream source fails the large-image case with sample=1; the patched source
passes all nine cases. The 108 MP case uses sample=8 (6,750,000 decoded bitmap
bytes in the model, before final scaling).

The check runs in Android GitHub Actions and Codemagic workflows. Remove the
override only after an upstream release passes this regression and is compatible
with the project's pinned Flutter toolchain.
