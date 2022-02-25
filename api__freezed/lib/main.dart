import 'package:api_freezed/bloc/gamer_data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/home.dart';

void main() {
  runApp(BlocProvider<GamerDataBloc>(
      create: (context) => GamerDataBloc(),
      child: const MaterialApp(home: Home())));
}
