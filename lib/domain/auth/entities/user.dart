///
/// 	•	순수 모델이며 외부 패키지에 의존하지 않음
/// 	•	앱 전반에서 공통으로 사용될 핵심 도메인 모델
///
class User {
  final int? id;
  final String? title;
  final String? body;
  final int? userId;

  User({
    this.id,
    this.title,
    this.body,
    this.userId,
  });
}

// class User {
//   final int? id;
//   final String? email;
//   final String? name;
//
//   User({
//     this.id,
//     this.email,
//     this.name,
//   });
// }
