import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter/counter_cubit.dart';

Future<void> main() async {
  /// BlocProvider
  runApp(BlocProvider<CounterCubit>(
    create: (context) => CounterCubit(),
    child: const MaterialApp(home: HomeWithBlocConsumer()),
  ));
}

/// Home With BlocConsumer
class HomeWithBlocConsumer extends StatelessWidget {
  const HomeWithBlocConsumer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            width: double.infinity,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ///  BlocConsumer<CounterCubit, CounterState>(
                  // child : Widget())
                  BlocConsumer<CounterCubit, CounterState>(

                      /// listener:(context,state){},
                      listener: (context, state) {
                        if (state.wasIncremented != null &&
                            state.wasIncremented!) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Incremented'),
                                  duration: Duration(seconds: 1)));
                        } else if (state.wasIncremented != null &&
                            !state.wasIncremented!) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Decremented'),
                                  duration: Duration(seconds: 1)));
                        }
                      },

                      /// builder:(context,state){}
                      builder: (context, state) => Text('${state.counterValue}',
                          style: const TextStyle(fontSize: 50))),

                  ///
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton(
                            onPressed: () {
                              /// BlocProvider
                              BlocProvider.of<CounterCubit>(context)
                                  .decrement();
                            },
                            child: const Icon(Icons.remove)),
                        FloatingActionButton(
                            onPressed: () {
                              /// BlocProvider
                              BlocProvider.of<CounterCubit>(context)
                                  .increment();
                            },
                            child: const Icon(Icons.add))
                      ])
                ])));
  }
}

/// Home With BlocListener
class HomeWithBlocListener extends StatelessWidget {
  const HomeWithBlocListener({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            width: double.infinity,

            ///  BlocListener<CounterCubit, CounterState>(listener:(context,state){},
            // child : Widget())

            child: BlocListener<CounterCubit, CounterState>(
                listener: (context, state) {
                  if (state.wasIncremented != null && state.wasIncremented!) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Incremented'),
                        duration: Duration(seconds: 1)));
                  } else if (state.wasIncremented != null &&
                      !state.wasIncremented!) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Decremented'),
                        duration: Duration(seconds: 1)));
                  }
                },
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ///  BlocBuilder<CounterCubit, CounterState>(builder:(context,state){})
                      BlocBuilder<CounterCubit, CounterState>(
                        builder: (context, state) {
                          return Text('${state.counterValue}',
                              style: const TextStyle(fontSize: 50));
                        },
                      ),

                      ///
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FloatingActionButton(
                                onPressed: () {
                                  /// BlocProvider
                                  BlocProvider.of<CounterCubit>(context)
                                      .decrement();
                                },
                                child: const Icon(Icons.remove)),
                            FloatingActionButton(
                                onPressed: () {
                                  /// BlocProvider
                                  BlocProvider.of<CounterCubit>(context)
                                      .increment();
                                },
                                child: const Icon(Icons.add))
                          ])
                    ]))));
  }
}

/// Home With BlockBuilder
class HomeWithBlockBuilder extends StatelessWidget {
  const HomeWithBlockBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            width: double.infinity,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ///  BlocBuilder<CounterCubit, CounterState>(builder:(context,state){})
                  BlocBuilder<CounterCubit, CounterState>(
                      builder: (context, state) => Text('${state.counterValue}',
                          style: const TextStyle(fontSize: 50))),

                  ///
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton(
                            onPressed: () {
                              /// BlocProvider
                              BlocProvider.of<CounterCubit>(context)
                                  .decrement();
                            },
                            child: const Icon(Icons.remove)),
                        FloatingActionButton(
                            onPressed: () {
                              /// BlocProvider
                              BlocProvider.of<CounterCubit>(context)
                                  .increment();
                            },
                            child: const Icon(Icons.add))
                      ])
                ])));
  }
}
