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
    }, child: Scaffold(body: Center(

            /// Builder
            child: Builder(builder: (context) {
      /// First way
      final _counterStateContext = context.watch<CounterCubit>().state;
      final _internetStateContext = context.watch<InternetCubit>().state;

      /// Second way (like provider) (listen: true/false)
      final _counterState =
          BlocProvider.of<CounterCubit>(context, listen: true).state;
      final _internetState =
          BlocProvider.of<InternetCubit>(context, listen: true).state;

      /// not will listen & not rebuild state
      final _counter = BlocProvider.of<CounterCubit>(context, listen: false);
      final _internet = BlocProvider.of<InternetCubit>(context, listen: false);

      /// InternetDisconnected
      if (_internetState is InternetDisconnected) {
        return const Text('Offline', style: TextStyle(fontSize: 25));
      }

      /// InternetConnected
      if (_internetState is InternetConnected) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  _internetState.connectionType == ConnectionType.wifi
                      ? 'Connection type WiFe'
                      : _internetState.connectionType == ConnectionType.mobile
                          ? 'Connection type Mobile'
                          : _internetState.connectionType ==
                                  ConnectionType.ethernet
                              ? 'Connection type Ethernet'
                              : _internetState.connectionType ==
                                      ConnectionType.offline
                                  ? 'Connection type Offline'
                                  : '',
                  style: const TextStyle(fontSize: 25)),
              Text(_counterState.counterValue.toString(),
                  style: const TextStyle(fontSize: 30)),

              ///
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                FloatingActionButton(
                    onPressed: () {
                      _counter.decrement();
                    },
                    child: const Icon(Icons.remove)),
                FloatingActionButton(
                    onPressed: () {
                      _counter.increment();
                    },
                    child: const Icon(Icons.add))
              ])
            ]);
      }
      return const Center(child: CircularProgressIndicator());
    }))));
  }
}
