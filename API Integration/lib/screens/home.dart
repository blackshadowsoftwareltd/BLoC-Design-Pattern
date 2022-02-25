import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/gamer_data_bloc.dart';
import 'gamer_list.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(title: const Text('Bloc Api')),
        body: BlocBuilder<GamerDataBloc, GamerDataState>(
          builder: (context, state) {
            if (state is GamerDataInitialState) {
              context.read<GamerDataBloc>().add(LoadGamerDataEvent());
            } else if (state is GamerDataLodedState) {
              return GamerList(gamers: state.gamers);
            } else if (state is GamerDataError) {
              return const Center(child: Text('error'));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
