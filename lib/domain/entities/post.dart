import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  ///
  /// {userId: 1, id: 1, title: sunt aut facere repellat provident occaecati excepturi optio reprehenderit,
  /// body: quia et suscipit  suscipit recusandae consequuntur expedita et cumreprehenderit
  /// molestiae ut ut quas totam nostrum rerum est autem sunt rem eveniet architecto}
  ///
  Map<String, dynamic> toJson() => _$PostToJson(this);

  /// 선택: POST 요청 등에 사용할 수 있는 JSON 문자열 반환
  ///	dio나 retrofit을 쓴다면 toJson() 호출만으로 충분함 (dio가 내부에서 encode 처리).
  ///{"userId":1,"id":1,"title":"sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
  ///"body":"quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit
  ///molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"}
  ///
  String toBody() => json.encode(toJson());
}
