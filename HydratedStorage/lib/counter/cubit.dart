import 'package:bloc_z/counter/states.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class CounterCubit extends HydratedBloc<CounterState, int> {
  CounterCubit() : super(0) {
    on<Increment>((event, emit) => emit(state + 1));
    on<Decrement>((event, emit) => emit(state - 1));
  }

  @override
  int fromJson(Map<String, dynamic> json) => json['value'] as int;

  @override
  Map<String, int> toJson(int state) => {'value': state};
}
