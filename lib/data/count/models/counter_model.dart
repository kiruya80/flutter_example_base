import '../../../domain/count/entities/counter.dart';

///
/// 클린 아키텍처에서 data 레이어의 Model이 domain 레이어의 Entity를 **상속하는 것은 절대 추천하지 않습니다.
/// 이는 의존성 방향 원칙(Dependency Rule)을 어기게 됩니다.
///
class CounterModel extends Counter {
  const CounterModel({required super.value});

  factory CounterModel.fromJson(Map<String, dynamic> json) {
    return CounterModel(value: json['value'] as int);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }

  Counter toEntity() {
    return Counter(value: value);
  }
}
