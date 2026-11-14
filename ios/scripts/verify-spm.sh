#!/bin/bash
set -euo pipefail

ios_dir="$(dirname "$(dirname "$(realpath "$0")")")"

if ! xcodebuild -version; then
  echo "Full Xcode is required. Set DEVELOPER_DIR to Xcode.app/Contents/Developer." >&2
  exit 2
fi
xcrun --sdk iphoneos --show-sdk-path
xcrun --sdk iphonesimulator --show-sdk-path

# Keep downloaded packages, build products, logs and xcresults outside the repo.
work_dir="${SPM_VERIFY_WORK_DIR:-$(mktemp -d "${TMPDIR:-/tmp}/lynx-spm-verify.XXXXXX")}"
mkdir -p "$work_dir"
results_dir="$(mktemp -d "$work_dir/results.XXXXXX")"
echo "Verification output: $work_dir"

for demo in HelloLynxSwiftSPM HelloLynxObjcSPM; do
  if [[ "$demo" == HelloLynxSwiftSPM ]]; then
    scheme=Hello-Lynx
  else
    scheme=Hello-Lynx-OC
  fi
  project="$ios_dir/$demo/$scheme.xcodeproj"
  common=(
    -project "$project"
    -scheme "$scheme"
    -clonedSourcePackagesDirPath "$work_dir/SourcePackages"
    -onlyUsePackageVersionsFromResolvedFile
  )
  xcodebuild "${common[@]}" -resolvePackageDependencies \
    2>&1 | tee "$work_dir/$demo-resolve.log"

  for sdk in iphonesimulator iphoneos; do
    if [[ "$sdk" == iphonesimulator ]]; then
      configuration=Debug
      destination="generic/platform=iOS Simulator"
    else
      configuration=Release
      destination="generic/platform=iOS"
    fi
    derived="$work_dir/$demo-$sdk"
    xcodebuild "${common[@]}" \
      -configuration "$configuration" -sdk "$sdk" \
      -destination "$destination" -derivedDataPath "$derived" \
      -resultBundlePath "$results_dir/$demo-$sdk.xcresult" \
      CODE_SIGNING_ALLOWED=NO build \
      2>&1 | tee "$work_dir/$demo-$sdk.log"

    app="$derived/Build/Products/$configuration-$sdk/$scheme.app"
    test -s "$app/main.lynx.bundle"
    test -s "$app/Lynx_LynxPackageSupport.bundle/LynxResources.bundle/lynx_core.js"
    # Catch malformed embedded frameworks even when no simulator is available.
    # Installation requires CFBundleExecutable and its corresponding binary.
    python3 - "$app" <<'PY'
import pathlib
import plistlib
import sys

for framework in sorted((pathlib.Path(sys.argv[1]) / "Frameworks").glob("*.framework")):
    with (framework / "Info.plist").open("rb") as source:
        info = plistlib.load(source)
    executable = info.get("CFBundleExecutable")
    if not isinstance(executable, str) or not executable or pathlib.Path(executable).name != executable:
        raise SystemExit(f"Invalid CFBundleExecutable: {framework}")
    if not (framework / executable).is_file():
        raise SystemExit(f"Missing framework executable: {framework / executable}")
PY
    echo "PASS: $demo $configuration $sdk build, resources and framework metadata"

    # Optional launch check. Choose an already booted simulator explicitly.
    # A successful launch is not proof that the Lynx page rendered correctly.
    if [[ "$sdk" == iphonesimulator && -n "${SIMULATOR_UDID:-}" ]]; then
      xcrun simctl install "$SIMULATOR_UDID" "$app"
      xcrun simctl launch "$SIMULATOR_UDID" "test.$scheme.spm"
    fi
  done
done

echo "PASS: both demos built for simulator and device; resources are present."
echo "Logs and build products: $work_dir"
echo "Build results: $results_dir"
