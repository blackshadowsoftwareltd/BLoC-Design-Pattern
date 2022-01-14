import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/enums.dart';
import 'logic/cubit/internet/internet_cubit.dart';

Future<void> main() async {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// MultiBlocProvider
    return MultiBlocProvider(providers: [
      BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: Connectivity())),
    ], child: const MaterialApp(home: HomeScreen()));
  }
}

/// Home
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(

        /// BlocBuilder
        child: BlocBuilder<InternetCubit, InternetState>(
            builder: (context, state) {
      /// InternetDisconnected
      if (state is InternetDisconnected) {
        return const Text('Offline', style: TextStyle(fontSize: 25));
      }

      /// InternetConnected
      if (state is InternetConnected) {
        return Text(
            state.connectionType == ConnectionType.wife
                ? 'Connection type WiFe'
                : state.connectionType == ConnectionType.mobile
                    ? 'Connection type Mobile'
                    : state.connectionType == ConnectionType.ethernet
                        ? 'Connection type Ethernet'
                        : state.connectionType == ConnectionType.offline
                            ? 'Connection type Offline'
                            : '',
            style: const TextStyle(fontSize: 25));
      }
      return const Center(child: CircularProgressIndicator());
    })));
  }
}
