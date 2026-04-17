# ClipboardBar
<<<<<<< HEAD
macOS Clipboard Bar、macOS 剪贴板栏
## Highlights
- You can view the macOS copy history again.
- You can choose how many copies of the copy history to save.
- You can also delete the copy history.
## README↓
[English](English.md)
[日本語](日本語.md)
[简体中文](简体中文.md)
## LICENSE
[LICENSE](LICENSE)
## Screenshot
<img width="300" src="https://private-user-images.githubusercontent.com/220143620/579880232-7064a941-8a96-41a1-928c-b9b06db6e3dd.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NzY0Mjc5OTQsIm5iZiI6MTc3NjQyNzY5NCwicGF0aCI6Ii8yMjAxNDM2MjAvNTc5ODgwMjMyLTcwNjRhOTQxLThhOTYtNDFhMS05MjhjLWI5YjA2ZGI2ZTNkZC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYwNDE3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MDQxN1QxMjA4MTRaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT00NmJiM2MyNzgyMWQ2ZGM0NzRjYzNhYzMxM2ZhMWJkYmU1ZWRiMTcyZWM4NmQ1NmM0OTdiZTAwMzY3MWU1ZWIzJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCZyZXNwb25zZS1jb250ZW50LXR5cGU9aW1hZ2UlMkZwbmcifQ.mwIXtH1mHzwvt0U5ZoIin0LzPLRhpFSB9PNDbtE6Ovs" />
<img width="300" src="https://private-user-images.githubusercontent.com/220143620/579880205-08a8ca13-0104-4ce5-8b64-0df1ce04ba59.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NzY0Mjc3NzMsIm5iZiI6MTc3NjQyNzQ3MywicGF0aCI6Ii8yMjAxNDM2MjAvNTc5ODgwMjA1LTA4YThjYTEzLTAxMDQtNGNlNS04YjY0LTBkZjFjZTA0YmE1OS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYwNDE3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MDQxN1QxMjA0MzNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT04MGJkNzE3NDNmNzMzYjI2YjNmMmJhM2UzZjI3MzM0MTZkNTIxMjE4ZDc1N2M3NWZhYzI1NWFhNjFhY2ZkZWFkJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCZyZXNwb25zZS1jb250ZW50LXR5cGU9aW1hZ2UlMkZwbmcifQ.Wo8Wfb49gKV9DRAtmmHJ_-96qoqVL-fQLf9WMvywm88" />
=======

ClipboardBar is a lightweight macOS menu bar app built with SwiftUI.  
It keeps clipboard history, lets you copy previous items again, and supports English, Japanese, and Simplified Chinese.

## Features

- Menu bar clipboard history viewer
- One-click re-copy and item delete
- Clear all history
- History size limit setting (20-200)
- Launch at login toggle
- In-app language switch (English / Japanese / 简体中文)
- Universal build target (Apple Silicon + Intel)

## Requirements

- macOS Sonoma 14 or later (Sequoia 15 supported)
- Xcode 15 or later

## Run In Xcode

1. Open `ClipboardBar.xcodeproj`
2. Select `ClipboardBar` scheme
3. Run (`Cmd + R`)
4. The app appears in the menu bar

## Build (Universal Binary)

```bash
xcodebuild \
  -project ClipboardBar.xcodeproj \
  -scheme ClipboardBar \
  -configuration Release \
  -destination 'generic/platform=macOS' \
  ARCHS='arm64 x86_64' \
  ONLY_ACTIVE_ARCH=NO \
  build
```

## Publish To GitHub

### 1) Create repository

Create a new repository on GitHub, for example: `ClipboardBar`.

### 2) Push local project

```bash
cd /Users/mochipote/Documents/ClipboardBar
git init
git add .
git commit -m "Initial release: ClipboardBar"
git branch -M main
git remote add origin https://github.com/<YOUR_NAME>/ClipboardBar.git
git push -u origin main
```

### 3) Create first release

```bash
git tag v1.0.0
git push origin v1.0.0
```

Then on GitHub:

1. Open `Releases`
2. Click `Draft a new release`
3. Choose tag `v1.0.0`
4. Upload your built app or zip
5. Publish release

## CI (GitHub Actions)

This repository includes `.github/workflows/macos-build.yml` to automatically verify the project builds on every push and pull request.

## License

MIT License. See [LICENSE](LICENSE).
>>>>>>> 717d625 (Initial release: ClipboardBar)
