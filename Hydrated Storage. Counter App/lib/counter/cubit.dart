import 'package:bloc_z/counter/states.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

/// HydratedBloc instead of Cubit
class CounterCubit extends HydratedBloc<CounterState, IncrementDecrement> {
  CounterCubit()
      : super(IncrementDecrement(counterValue: 0, wasIncremented: false));
  void increment() => emit(IncrementDecrement(
      counterValue: state.counterValue + 1, wasIncremented: true));
  void decrement() => emit(IncrementDecrement(
      counterValue: state.counterValue - 1, wasIncremented: false));

  /// get last state from local storage
  @override
  IncrementDecrement? fromJson(Map<String, dynamic> json) {
    return IncrementDecrement.fromMap(json);
  }

  /// stor last state in the local storage
  @override
  Map<String, dynamic>? toJson(IncrementDecrement state) {
    return state.toMap();
  }

  /// to debug all changes when the cubit is trigered
  @override
  void onChange(Change<IncrementDecrement> change) {
    /// it will print current state data $ next state data
    print(change);
    super.onChange(change);
  }

  /// Called whenever an [error] occurs and notifies [BlocObserver.onError].
  @override
  void onError(Object error, StackTrace stackTrace) {
    print('Error : $error\nStackTrace : $stackTrace');
    super.onError(error, stackTrace);
  }
}
