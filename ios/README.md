# Lynx iOS demos: CocoaPods and Swift Package Manager

The original `HelloLynxSwift` and `HelloLynxObjc` demos retain their CocoaPods
projects, Podfiles and lockfiles. Run `pod install` in the selected
original demo directory, then open its generated `.xcworkspace`.

The separate `HelloLynxSwiftSPM` and `HelloLynxObjcSPM` projects use
`https://github.com/lynx-family/lynx-spm.git`. Dependency versions are maintained
in each project's package requirements and `Package.resolved` lockfile.
The package's binary downloads are hosted in the matching release of
`lynx-family/lynx`.

## Open and run the SPM demos

Use full Xcode with the iOS SDK and a compatible simulator runtime.
Check the selected SDK release's toolchain requirements and each target's
deployment settings when choosing Xcode and a run destination.

| Demo | Open | Scheme |
| --- | --- | --- |
| Swift / UIKit | `HelloLynxSwiftSPM/Hello-Lynx.xcodeproj` | `Hello-Lynx` |
| Objective-C | `HelloLynxObjcSPM/Hello-Lynx-OC.xcodeproj` | `Hello-Lynx-OC` |

Allow Xcode to resolve packages, choose an iOS simulator, then run.
For a physical device, select your own development team under Signing & Capabilities.
The package downloads binary XCFrameworks; allow disk space for the downloads,
extraction and build products.

The SPM projects reference source code, storyboards, assets, Info.plist and
`main.lynx.bundle` in their sibling CocoaPods demo directories. The Swift project
also references the original bridging header. Keep these directories together;
there is no duplicated application source to maintain.

Only the SPM projects use SwiftPM dependencies; the original CocoaPods projects
remain unchanged. The SPM bundle identifiers are `test.Hello-Lynx.spm` and
`test.Hello-Lynx-OC.spm`, allowing them to coexist with the CocoaPods apps.

## Dependency mapping

| CocoaPods dependencies | SwiftPM product |
| --- | --- |
| Lynx/Framework, PrimJS | `Lynx-Framework` |
| LynxService Image/Http/Log, SDWebImage, SDWebImageWebPCoder | `LynxService` |
| XElement, skity, LynxTextra and other transitive dependencies | `XElement` |

The packages provide the transitive binary dependencies and system linker settings.
In this release, subspec-style product names are aliases for the complete parent
framework: `LynxService` also brings Devtool dependencies, and `XElement` includes
AnimaX. Selecting `LynxService-Image` would not reduce that binary dependency set.

### Dependency and resource setup

The upstream `XElement` product includes the `skity` and `LynxTextra`
binary targets, with versioned download URLs and checksums. Both projects use
these official artifacts directly.

Both targets explicitly set `-ObjC` to retain Objective-C categories and classes
used through runtime registration. The Objective-C app also enables embedding
Swift standard libraries because `LynxPackageSupport` contains Swift code.
The Swift demo retains its existing Objective-C bridging header.

SwiftPM copies the SDK resources into `Lynx_LynxPackageSupport.bundle`; this SDK
version's Darwin resource loader understands that location. Do not add a second
manual copy of `LynxResources.bundle`. The app's `main.lynx.bundle` remains in
the app's own Copy Bundle Resources phase.

Both SPM projects track `Package.resolved` and shared schemes for reproducible builds.

## Build verification

From the repository root:

```sh
DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer \
  bash ios/scripts/verify-spm.sh
```

The script targets only `HelloLynxSwiftSPM` and `HelloLynxObjcSPM`. It resolves the
pinned packages, builds **both SPM** demos for **Debug iOS
Simulator** and **Release iOS device** without signing, and checks that each
application contains `main.lynx.bundle` and the packaged `lynx_core.js`.
It also checks embedded frameworks for a valid `CFBundleExecutable` entry
and the corresponding binary file, detecting malformed framework metadata
even without an installed simulator runtime.
Logs, `.xcresult` bundles, packages and build products are kept in a printed
temporary directory outside the repository. Any failed command stops the script.

To reuse downloaded dependencies and build products on subsequent runs, set
`SPM_VERIFY_WORK_DIR` to that printed directory. Each run creates a separate
results directory for its `.xcresult` bundles.

To additionally install and launch the Debug builds on an already booted
simulator, specify its UDID:

```sh
xcrun simctl list devices booted
DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer \
  SIMULATOR_UDID=<booted-simulator-udid> bash ios/scripts/verify-spm.sh
```

After launch, inspect the Lynx demo page and Xcode console for template or
JavaScript errors. Installation and process launch alone do not prove rendering
succeeded. These demos do not currently have automated UI tests.

Command Line Tools alone cannot build an iOS app. Package resolution and
XCFramework metadata checks are useful preliminary checks, but cannot replace
the Xcode build and simulator render checks above.
