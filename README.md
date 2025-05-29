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

## GoRouter + Riverpod + retrofit 샘플

## retrofit
retrofit + dio + riverpod 기반으로 클린 아키텍처 스타일에 맞춰서,
https://jsonplaceholder.typicode.com 에서 샘플 데이터 (예: Posts)를 GET하는 예제를 만들어볼게요.

## riverpod 설정

riverpod_generator
dart run build_runner watch
fvm flutter packages pub run build_runner build
fvm flutter pub run build_runner build --delete-conflicting-outputs
fvm flutter pub run build_runner build

## freezed 설정
freezed는 copyWith, == 연산자, hashCode, toString, fromJson, toJson 등 많은 기능을 자동 생성
flutter pub run build_runner build --delete-conflicting-outputs

# 클린 아키텍쳐
의존성 규칙
모듈의 의존성이 단방향으로 이어져야 한다 (과녁)


## 클린 아키텍쳐 기본 트리
✅ 요약
lib/
├── core/         # 전역 에러 처리, 공통 타입 등 앱의 핵심 요소
├── data/         ## 외부 연동 (API, DB 등) 및 모델/구현
├── domain/       ## 비즈니스 로직: 엔티티, 유스케이스, 추상화 레포지토리
├── presentation/ ## UI 화면 및 위젯
├── state/        # 상태관리 관련 (Provider, Notifier, ViewModel 등)
├── utils/        # 헬퍼 클래스, 유틸성 기능 (formatter, validator 등)
├── main.dart     # 앱 진입점

✅이벤트 흐름
[presentaion]widget > [state]provider(Notifier) > [domain]usecase > repositories 추상화 | [data] repositories
Presentation (UI)
↓        ↑
Provider (StateNotifier / AsyncNotifier)
↓
UseCase (Application Logic)
↓
Repository (Domain abstraction)
↓
Data Source (API, DB, etc)

✅ core/
앱 전역에서 사용하는 공통 요소, 예외 처리, 상수 등

역할             예시
실패 타입 정의   failures.dart
공통 상수        app_constants.dart
글로벌 테마      theme.dart
typedef          typedefs.dart


✅ data/
외부 소스 연동 및 domain 레이어 구현

하위 폴더       역할                              예시
data_sources/   API, DB, SharedPrefs 등           counter_local_data_source.dart
models/         JSON ↔ 객체 변환 모델 (DTO 등)    counter_model.dart  
repositories/   domain 레포지토리 추상화 구현     counter_repository_impl.dart


✅ domain/
비즈니스 로직 중심. 외부 의존 없음

하위 폴더       역할              예시
entities/       앱의 핵심 모델    counter.dart
repositories/   추상화 정의       abstract CounterRepository
usecases/       기능 단위 클래스  IncrementCounter


✅ presentation/
UI 및 화면 구성 관련 요소

하위 폴더   역할                      예시
pages/      각 페이지 화면            counter_page.dart
widgets/    재사용 가능한 UI 위젯     counter_button.dart


✅ state/
상태 관리 관련 요소 (Riverpod 등)

내용              예시
Provider 정의     counter_provider.dart
Notifier 정의     counter_notifier.dart
ViewModel (옵션)  counter_viewmodel.dart


✅ utils/
재사용 가능한 유틸리티 함수, 확장 메서드

역할            예시
날짜 포맷       date_utils.dart
유효성 검사     validator.dart
확장 메서드     string_extensions.dart


📌 보너스: features/로 그룹화하는 구조 (고도화 시)
이 구조는 **기능 단위(feature-based)**로 묶는 방식이며, 규모가 커질수록 가독성, 모듈성, 재사용성이 향상됩니다.
lib/
├── features/
│   └── counter/
│       ├── data/
│       ├── domain/
│       ├── presentation/
│       ├── state/

## 리버팟
flutter pub run build_runner build --delete-conflicting-outputs
flutter pub run build_runner build

✅ autoDispose
AutoDisposeNotifierProvider - @riverpod 또는 @Riverpod()
@Riverpod()
@riverpod
class Counter extends _$Counter

NotifierProvider
@Riverpod(keepAlive: true)
class PersistentCounter extends _$PersistentCounter


✅ build() 함수의 반환 타입에 따른 구분
@override
int build() {
return 0;
}

[Notifier]
@override
T build()

build 반환 타입 : T
Provider 종류 : NotifierProvider<TNotifier, T>
Provider 반환 타입 : ref.watch(...) →T
설명 : 동기 상태를 다루는 일반 Notifier
state : T
state = newValue

ref.read(userNameNotifierProvider.notifier).setUserName(value);

[AsyncNotifier]
@override
Future<T> build()
@override
FutureOr<T> build()

build 반환 타입 : Future<T> 또는 FutureOr<T>
Provider 종류 : AsyncNotifierProvider<TNotifier, T>
Provider 반환 타입 : ref.watch(...) → AsyncValue<T>
설명 : 비동기 상태 처리, AsyncLoading, AsyncError, AsyncData 등 사용
state : AsyncValue<T>
AsyncValue<T>는 비동기 작업의 3가지 상태를 표현하는 추상 클래스
AsyncLoading : state = const AsyncValue.loading();
AsyncData<T> : state = AsyncValue.data(T),
AsyncError : state = AsyncValue.error(_mapFailureToMessage(failure), StackTrace.current),

AsyncValue.guard는 비동기 작업을 안전하게 실행하고, 자동으로 AsyncLoading → AsyncData / AsyncError 상태로 감싸주는 헬퍼 함수
(try-catch를 쓰는 코드를 간결)
Future<void> refreshPosts() async {
state = const AsyncLoading();
state = await AsyncValue.guard(() => ref.read(postRepositoryProvider).getPosts());
}

widget에서
final state = ref.watch(postListNotifierProvider);
state.when(
loading: () => CircularProgressIndicator(),
data: (posts) => ListView(...),
error: (e, st) => Text('오류 발생: $e'),
);
switch (state) {
AsyncData(:final value) => ...,
AsyncError(:final error) => ...,
AsyncLoading() => ...,
};
🔍 Future vs FutureOr
•	Future<T>: 항상 await 필요
•	FutureOr<T>: T 타입이거나 Future<T> 둘 다 가능 → 동기/비동기 혼합 처리할 수 있음

[FutureProvider]

build 반환 타입 : Stream<T>
Provider 종류 : StreamNotifierProvider<TNotifier, T>
Provider 반환 타입 : ref.watch(...) → AsyncValue<T>
설명 : 비동기 상태 처리, AsyncLoading, AsyncError, AsyncData 등 사용
state :
스트림 기반의 상태 처리

✨ 정리

build()에서 사용할 수 있는 주요 반환 타입:
•	T (예: int, List<Post>) → 일반 Notifier
•	Future<T> / FutureOr<T> → AsyncNotifier (비동기)
•	Stream<T> → StreamNotifier
•	AsyncValue<T> / AsyncValue<Either<Failure, T>> → 상태를 명시적으로 관리할 때 유용

👉 일반적인 API 통신에는 AsyncValue<Either<Failure, T>> 구조를 추천합니다.

build() 반환 타입                   생성되는 Provider 타입                 설명
T (int, String, List, bool, etc.)   AutoDisposeProvider<T>                 기본 동기 Provider
Future<T> 또는 FutureOr<T>          AutoDisposeFutureProvider<T>           비동기 Future Provider
Stream<T>                           AutoDisposeStreamProvider<T>           스트림 Provider
Notifier<T>                         AutoDisposeNotifierProvider<T>         동기 상태 관리
AsyncNotifier<T>                    AutoDisposeAsyncNotifierProvider<T>    비동기 상태 관리

## 중요!! state 접근 가능여부
Future<AsyncValue<T>>는 이건 상태를 직접 조작하는 AsyncNotifier가 아니라, 자동 상태 래핑을 위한 내부 구현 구조로 간주돼요.
즉, 초기 상태만 설정하고 나면 외부에서 state = ...으로 변경 불가합니다.
Riverpod이 이걸 내부적으로 관리해서, state라는 변수를 노출하지 않아요.

build() 타입            내부 상속된 클래스      state 접근 가능?        상태 직접 조작 목적에 적합?
AsyncValue<T>           AsyncNotifier<T>        ✅ 가능                ✅ 추천
Future<T>               AsyncNotifier<T>        ✅ 가능                ✅ 가능
Future<AsyncValue<T>>   ❌ 내부 자동 처리      ❌ 불가능              ❌ reset 등 안 

 
 

