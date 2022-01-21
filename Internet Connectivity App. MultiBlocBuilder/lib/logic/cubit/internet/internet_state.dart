part of 'internet_cubit.dart';

@immutable
abstract class InternetState {}

/// multiple class extended to the InternetState
class InternetLoading extends InternetState {}

/// multiple class extended to the InternetState
class InternetConnected extends InternetState {
  final ConnectionType connectionType;

  InternetConnected({required this.connectionType});
}

/// multiple class extended to the InternetState
class InternetDisconnected extends InternetState {
  InternetDisconnected();
}
