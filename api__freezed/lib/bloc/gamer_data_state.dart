part of 'gamer_data_bloc.dart';

@immutable
abstract class GamerDataState {}

class GamerDataInitialState extends GamerDataState {}

class LoadingState extends GamerDataState {}

class GamerDataLodedState extends GamerDataState {
  final List<GamerModel> gamers;
  GamerDataLodedState({required this.gamers});
}

class GamerDataError extends GamerDataState {}
