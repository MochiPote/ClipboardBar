# ClipboardBar
macOS Clipboard Bar、macOS 剪贴板栏
## Features
- Menu bar clipboard history viewer
- One-click re-copy and item delete
- Clear all history
- History size limit setting (20-200)
- Launch at login toggle
- In-app language switch (English / Japanese / 简体中文)
- Universal build target (Apple Silicon + Intel)
## README↓
[English](English.md)
[日本語](日本語.md)
[简体中文](简体中文.md)
## LICENSE
[LICENSE](LICENSE)
## Screenshot
<img width="300" src="https://private-user-images.githubusercontent.com/220143620/579880232-7064a941-8a96-41a1-928c-b9b06db6e3dd.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NzY0MzI3MzUsIm5iZiI6MTc3NjQzMjQzNSwicGF0aCI6Ii8yMjAxNDM2MjAvNTc5ODgwMjMyLTcwNjRhOTQxLThhOTYtNDFhMS05MjhjLWI5YjA2ZGI2ZTNkZC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYwNDE3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MDQxN1QxMzI3MTVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1lMGRiZjIyZjFkZjAwOGEzZmYxNDFjMmRhNjQyYzM5YjYwZTkzMDZkNWE3YWM0NmQ3ZTk1MWQ4MjVmMTJmYjYyJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCZyZXNwb25zZS1jb250ZW50LXR5cGU9aW1hZ2UlMkZwbmcifQ.jwwrKUhmBmONfneX2cDel8RF05Y7w_9EwxL6Udg-wfI" />
<img width="300" src="https://private-user-images.githubusercontent.com/220143620/579880205-08a8ca13-0104-4ce5-8b64-0df1ce04ba59.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NzY0MzI2NTgsIm5iZiI6MTc3NjQzMjM1OCwicGF0aCI6Ii8yMjAxNDM2MjAvNTc5ODgwMjA1LTA4YThjYTEzLTAxMDQtNGNlNS04YjY0LTBkZjFjZTA0YmE1OS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYwNDE3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MDQxN1QxMzI1NThaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1kOWI2NmFhNjA5NzNhYmUwNjY0ZTg5MzAwMWI2ZjI5NmNjZGNkYzEyMDgxNzk4OGU5ZjBmZmRlM2Q3M2VhZDliJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCZyZXNwb25zZS1jb250ZW50LXR5cGU9aW1hZ2UlMkZwbmcifQ.O-owFIASlmZnYsXKEXancJ8EFHsnzWX7HCg6tp1_R8M" />

## Build Requirements

- macOS Sonoma 14 or later (Tahoe,Sequoia supported)
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
[LICENSE](LICENSE)
