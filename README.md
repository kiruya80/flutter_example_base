## riverpod 설정

riverpod_generator
dart run build_runner watch
flutter packages pub run build_runner build
flutter pub run build_runner build --delete-conflicting-outputs
flutter pub run build_runner build

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

