import 'package:api_freezed/apis/api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../models/model.dart';

part 'gamer_data_event.dart';
part 'gamer_data_state.dart';

class GamerDataBloc extends Bloc<GamerDataEvent, GamerDataState> {
  GamerDataBloc() : super(GamerDataInitialState()) {
    on<GamerDataEvent>((event, emit) async {
      if (event is LoadGamerDataEvent) {
        emit(LoadingState());
        final result = await GammerApi.getGamerData();
        if (result == null) {
          emit(GamerDataError());
        } else {
          emit(GamerDataLodedState(gamers: result));
        }
      }
    });
  }
}
