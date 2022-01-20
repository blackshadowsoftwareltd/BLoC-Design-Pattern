import 'package:connectivity/logic/cubit/counter/counter_cubit.dart';
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
      ///
      BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: Connectivity())),

      ///
      BlocProvider<CounterCubit>(create: (context) => CounterCubit()),

      ///
    ], child: const MaterialApp(home: HomeScreen()));
  }
}

/// Home
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// BlocListener only listen. not rebuild states
    return BlocListener<InternetCubit, InternetState>(
        listener: (context, state) {
          /// It will increment or decrement when the connection type will be changed
          if (state is InternetConnected &&
              state.connectionType == ConnectionType.wifi) {
            BlocProvider.of<CounterCubit>(context).increment();
          } else if (state is InternetConnected &&
              state.connectionType == ConnectionType.mobile) {
            BlocProvider.of<CounterCubit>(context).decrement();
          }
        },
        child: Scaffold(
            body: Center(

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
                    state.connectionType == ConnectionType.wifi
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
            })),

            ///
            floatingActionButton: FloatingActionButton(
                child: BlocBuilder<CounterCubit, CounterState>(

                    /// Counter value
                    builder: (context, state) => Text(
                        state.counterValue.toString(),
                        style: const TextStyle(fontSize: 30))),
                onPressed: null)));
  }
}
