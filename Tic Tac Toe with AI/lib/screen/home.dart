import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamez/cubit/tic_tac_toe_cubit.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<TicTacToeCubit, TicTacToeBlocState>(
            builder: (context, state) {
          ///
          final bloc = BlocProvider.of<TicTacToeCubit>(context, listen: false);
          final blocState =
              BlocProvider.of<TicTacToeCubit>(context, listen: true);

          ///
          return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Switch(
                        value: state.startWithAi,
                        onChanged: (value) => bloc.setStartWith()),
                    const SizedBox(width: 10),
                    Text(
                      state.startWithAi ? 'Started with AI' : 'Started with me',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                    width: 300,
                    height: 300,
                    child: AspectRatio(
                        aspectRatio: 1,
                        child: GridView.count(crossAxisCount: 3, children: [
                          ///
                          for (int i = 0; i < 9; i++)
                            Padding(
                                padding: const EdgeInsets.all(5),
                                child: OutlinedButton(

                                    /// onPressed
                                    onPressed: () => bloc.onPressed(i),

                                    ///
                                    child: Text(state.tiles[i] == 0
                                        ? ''
                                        : state.tiles[i] == 1
                                            ? 'X'
                                            : 'O'),
                                    style: OutlinedButton.styleFrom(
                                        primary: Colors.black,
                                        backgroundColor: Colors.white,
                                        elevation: 5,
                                        padding: EdgeInsets.zero,
                                        shadowColor: Colors.black26,
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)))))
                        ]))),

                ///
                Text(
                    blocState.isWinning(1, state.tiles)
                        ? 'You won!'
                        : blocState.isWinning(2, state.tiles)
                            ? 'You lost!'
                            : 'Your move',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30)),

                /// Restart
                OutlinedButton(
                    onPressed: () => bloc.resetTiles(),
                    child:
                        const Text('Restart', style: TextStyle(fontSize: 30)))
              ]));
        }));
  }
}
