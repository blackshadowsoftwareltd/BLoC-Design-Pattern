import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/tic_tac_toe_cubit.dart';
import 'screen/home.dart';

void main() => runApp(MultiBlocProvider(
    providers: [BlocProvider<TicTacToeCubit>(create: (_) => TicTacToeCubit())],
    child: const MaterialApp(home: Home())));
