import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'brightness/cubit.dart';
import 'counter/cubit.dart';
import 'counter/states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  HydratedBlocOverrides.runZoned(() => runApp(const MyApp()), storage: storage);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<BrightnessCubit>(create: (_) => BrightnessCubit()),
          BlocProvider<CounterCubit>(create: (_) => CounterCubit())
        ],
        child: BlocBuilder<BrightnessCubit, Brightness>(
            builder: (context, brightness) {
          return MaterialApp(

              /// birghtness
              theme: ThemeData(brightness: brightness),
              home: const CounterView());
        }));
  }
}

class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(title: const Text('Counter')),
        body: Center(
            child: BlocBuilder<CounterCubit, int>(builder: (context, state) {
          ///
          return Text('$state', style: textTheme.headline2);
        })),

        ///
        floatingActionButton: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ///
              FloatingActionButton(
                  child: const Icon(Icons.brightness_6),
                  onPressed: () =>
                      context.read<BrightnessCubit>().toggleBrightness()),
              const SizedBox(height: 4),

              ///
              FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () =>
                      context.read<CounterCubit>().add(Increment())),
              const SizedBox(height: 4),

              ///
              FloatingActionButton(
                  child: const Icon(Icons.remove),
                  onPressed: () =>
                      context.read<CounterCubit>().add(Decrement())),
              const SizedBox(height: 4),

              ///
              FloatingActionButton(
                  child: const Icon(Icons.delete_forever),
                  onPressed: () {
                    context.read<BrightnessCubit>().clear();
                    context.read<CounterCubit>().clear();
                  })
            ]));
  }
}
