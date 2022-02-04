import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tic_tac_toe_state.dart';

class TicTacToeCubit extends Cubit<TicTacToeBlocState> {
  TicTacToeCubit() : super(TicTacToeBlocState(tiles: List.filled(9, 0)));
  void onPressed(index) async {
    if (state.tiles[index] == 0 &&
        !isWinning(1, state.tiles) &&
        !isWinning(2, state.tiles)) {
      state.tiles[index] = 1;

      emit(TicTacToeBlocState(tiles: state.tiles));
      if (!isWinning(1, state.tiles) && !isWinning(2, state.tiles)) {
        await runAi();
      }
    }
  }

  void resetTiles() => emit(TicTacToeBlocState(tiles: List.filled(9, 0)));

  Future<void> runAi() async {
    await Future.delayed(const Duration(milliseconds: 500));
    int? winning;
    int? blocking;
    int? normal;
    for (int i = 0; i < 9; i++) {
      int val = state.tiles[i];
      if (val > 0) {
        continue;
      }
      List<int> future = [...state.tiles]..[i] = 2;
      if (isWinning(2, future)) {
        winning = i;
      }
      future[i] = 1;
      if (isWinning(1, future)) {
        blocking = i;
      }
      normal = i;
    }
    final move = winning ?? blocking ?? normal;
    if (move != null) {
      state.tiles[move] = 2;
    }
    emit(TicTacToeBlocState(tiles: state.tiles));
  }

  bool isWinning(int who, List<int> tiles) {
    return (tiles[0] == who && tiles[1] == who && tiles[2] == who) ||
        (tiles[3] == who && tiles[4] == who && tiles[5] == who) ||
        (tiles[6] == who && tiles[7] == who && tiles[8] == who) ||
        (tiles[0] == who && tiles[4] == who && tiles[8] == who) ||
        (tiles[2] == who && tiles[4] == who && tiles[6] == who) ||
        (tiles[0] == who && tiles[3] == who && tiles[6] == who) ||
        (tiles[1] == who && tiles[4] == who && tiles[7] == who) ||
        (tiles[2] == who && tiles[5] == who && tiles[8] == who);
  }
}
