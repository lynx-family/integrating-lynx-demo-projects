# integrating-lynx-demo-projects

This repository includes some demo projects of platform applications for getting started with integrating Lynx to existing project.

## Android Empty Projects

- [`KotlinEmptyProject`] : Language of Main Activity and build configuration is Kotlin.
- [`JavaEmptyProject`] : Languange of Main Activity is Java and languange of build configuration is groovy.

## iOS Projects

- [`SwiftEmptyProject`] : Swift / UIKit project using CocoaPods.
- [`ObjcEmptyProject`] : Objective-C project using CocoaPods.
- [Swift SPM Demo](./ios/HelloLynxSwiftSPM) : Independent Swift Package Manager project.
- [Objective-C SPM Demo](./ios/HelloLynxObjcSPM) : Independent Swift Package Manager project.

The original demos retain their CocoaPods configuration. The separate SPM demos use
[`lynx-family/lynx-spm`](https://github.com/lynx-family/lynx-spm)
and share the original demos' source code and resources.
Open the SPM `.xcodeproj` directly; for CocoaPods, run `pod install` in the original
demo directory and open the generated `.xcworkspace`.
See [iOS setup and integration verification](./ios/README.md).

## harmony Empty Projects

- [`HarmonyEmptyProject`] : ArkTs Harmony project.

[`JavaEmptyProject`]: ./android/JavaEmptyProject
[`KotlinEmptyProject`]: ./android/KotlinEmptyProject
[`ObjcEmptyProject`]: ./ios/HelloLynxObjc
[`SwiftEmptyProject`]: ./ios/HelloLynxSwift
[`HarmonyEmptyProject`]: ./harmony/HarmonyEmptyProject
