# youngo

Flutter example base project.

## Getting Started

[master] 기본 설정만 (yaml등)


## 안드로이드 스튜디오 버전
Android Studio Koala Feature Drop | 2024.1.2 Patch 1
Build #AI-241.19072.14.2412.12360217, built on September 13, 2024
Runtime version: 17.0.11+0-17.0.11b1207.24-11852314 aarch64
VM: OpenJDK 64-Bit Server VM by JetBrains s.r.o.
macOS 15.1.1
GC: G1 Young Generation, G1 Old Generation
Memory: 2048M
Cores: 8
Metal Rendering is ON
Registry:
ide.experimental.ui=true
Non-Bundled Plugins:
Dart (241.18968.26)
mobi.hsz.idea.gitignore (4.5.6)
io.flutter (85.2.1)

## studio_settings_250518 설정 file > IDE > import

## flutter version
Flutter 3.29.3 • channel stable • https://github.com/flutter/flutter.git
Framework • revision ea121f8859 (5 weeks ago) • 2025-04-11 19:10:07 +0000
Engine • revision cf56914b32
Tools • Dart 3.7.2 • DevTools 2.42.3

# flutter setting
"/Users/kilho/development/flutter 3.29.3/bin/flutter" --no-color pub get

# fvm : 개별 프로젝트등 flutter 버전을 다르게 사용하기 위해 
[설치]
brew tap leoafarias/fvm
brew install fvm
[삭제]
brew uninstall fvm
brew untap leoafarias/fvm
[설치 가능 버전]
fvm releases

fvm install <version>
fvm remove <version>
fvm global <version> //전역
[futter 적용]

# FVM 안드로이드 스튜디오 설정
export FVM_HOME="/Users/kilho/fvm"
export PATH="$FVM_HOME/default/bin:$PATH"

해당 flutter 프로젝트 루트에서 (스튜디오로 열고 터미널에서)
fvm use <version> // 특정 프로젝트
Android Studio 또는 Intellij Prefrences에서 Flutter SDK 경로를 . ~/fvm/default로 수정해준다.

Dart SDK
/Users/kilho/Workspace_Flutter/youngo_app/.fvm/flutter_sdk/bin/cache/dart-sdk
Flutter SDK
/Users/kilho/Workspace_Flutter/youngo_app/.fvm/flutter_sdk


[오류 처리]
Using .fvmrc in /Users/kilho 오류인 경우
> 즉, 홈 디렉토리에 있는 .fvmrc가 방해하고 있어서, 프로젝트 경로에 있는 pubspec.yaml 을 인식하지 못하고 있습니다.
rm ~/.fvmrc
rm -rf ~/.fvm

cd ~/Workspace_Flutter/youngo_app
fvm use 3.29.3
성공시
You should add the fvm version directory ".fvm/" to .gitignore.
✔ Would you like to do that now? · yes                                                                                                                            
✓ Added .fvm/ to .gitignore

✓ Project now uses Flutter SDK : SDK Version : 3.29.3

fvm flutter clean cache
fvm flutter pub get   
fvm flutter doctor (안드로이드 : 커맨드라인, 라이센스 동의 확인)
fvm flutter run

🧾 pubspec.yaml = “나는 이런 패키지들이 필요해요!”
🔒 pubspec.lock = “좋아, 실제로는 이 버전들로 설치해둘게요!”

auto_route: ^8.1.3  # 의미: >=8.1.3 <9.0.0 허용
^8.1.3은 **“하위 호환성(호환 가능한 변경)이 유지되는 한 최신 버전까지 허용”**을 의미합니다.

yaml 파일까지 자동으로 업그레이드
fvm flutter pub upgrade --major-versions