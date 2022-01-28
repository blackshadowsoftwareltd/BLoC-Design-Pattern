import 'package:bloc_z/counter/states.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class CounterCubit extends HydratedBloc<CounterState, IncrementDecrement> {
  CounterCubit()
      : super(IncrementDecrement(counterValue: 0, wasIncremented: false));
  void increment() => emit(IncrementDecrement(
      counterValue: state.counterValue + 1, wasIncremented: true));
  void decrement() => emit(IncrementDecrement(
      counterValue: state.counterValue - 1, wasIncremented: false));

  @override
  IncrementDecrement? fromJson(Map<String, dynamic> json) {
    return IncrementDecrement.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(IncrementDecrement state) {
    return state.toMap();
  }
}
