import '../../../domain/count/entities/counter.dart';

class CounterModel extends Counter {
  const CounterModel({required int value}) : super(value: value);

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
