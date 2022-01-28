import 'dart:convert';

abstract class CounterState {}

class IncrementDecrement extends CounterState {
  late int counterValue;
  bool? wasIncremented;
  IncrementDecrement({
    required this.counterValue,
    this.wasIncremented,
  });

  Map<String, dynamic> toMap() {
    return {
      'counterValue': counterValue,
      'wasIncremented': wasIncremented,
    };
  }

  factory IncrementDecrement.fromMap(Map<String, dynamic> map) {
    return IncrementDecrement(
      counterValue: map['counterValue'],
      wasIncremented: map['wasIncremented'],
    );
  }

  String toJson() => json.encode(toMap());

  factory IncrementDecrement.fromJson(String source) =>
      IncrementDecrement.fromMap(json.decode(source));

  @override
  String toString() =>
      'IncrementDecrement(counterValue: $counterValue, wasIncremented: $wasIncremented)';
}
