import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/save_load/save_load_cubit.dart';
import '../../global_elements/custom_app_bar.dart';
import '../widgets/saved_games_list_view.dart';


class LoadScreen extends StatefulWidget {
  const LoadScreen({super.key});

  @override
  State<LoadScreen> createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  @override
  void initState() {
    context.read<SaveLoadCubit>().fetchGames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Text('Load Game',style: TextStyle(color: Colors.white),)),
      body: BlocBuilder<SaveLoadCubit, SaveLoadState>(
        builder: (context, state) {
          if (state.status == SaveLoadStatus.loaded) {
            return Column(
              children: [
                Expanded(child: SavedGamesListView(savedGames: state.games)),
              ],
            );
          } else if (state.status == SaveLoadStatus.error) {
            return Center(child: Text("Error: ${state.error}"));
          } else if (state.status == SaveLoadStatus.loading) {
            return const CircularProgressIndicator();
          } else {
            return const Center(child: Text("No data available"));
          }
        },
      ),
    );
  }
}
