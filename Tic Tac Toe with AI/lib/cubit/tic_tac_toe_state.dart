part of 'tic_tac_toe_cubit.dart';

@immutable
abstract class TicTacToeState {}

// ignore: must_be_immutable
class TicTacToeBlocState extends TicTacToeState {
  late List<int> tiles;

  TicTacToeBlocState({
    required this.tiles,
  });
}
