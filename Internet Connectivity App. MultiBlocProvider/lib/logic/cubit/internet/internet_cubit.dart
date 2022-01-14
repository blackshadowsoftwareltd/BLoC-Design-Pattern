import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/constants/enums.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  ///
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;

  /// InternetLoading
  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((event) {
      ///
      print(event);
      if (event == ConnectivityResult.wifi) {
        emitInternetConnected(ConnectionType.wife);
      } else if (event == ConnectivityResult.mobile) {
        emitInternetConnected(ConnectionType.mobile);
      } else if (event == ConnectivityResult.ethernet) {
        emitInternetConnected(ConnectionType.ethernet);
      } else if (event == ConnectivityResult.none) {
        emitInternetConnected(ConnectionType.offline);
        emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected(ConnectionType _connectionType) =>
      emit(InternetConnected(connectionType: _connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
