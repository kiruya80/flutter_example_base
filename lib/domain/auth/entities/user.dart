import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

///
/// 	•	순수 모델이며 외부 패키지에 의존하지 않음
/// 	•	앱 전반에서 공통으로 사용될 핵심 도메인 모델
///
@freezed
abstract class User with _$User {
  const factory User({
    required int? id,
    String? title,
    String? body,
    int? userId,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

// class User {
//   final int? id;
//   final String? title;
//   final String? body;
//   final int? userId;
//
//   User({
//     this.id,
//     this.title,
//     this.body,
//     this.userId,
//   });
// }
//
