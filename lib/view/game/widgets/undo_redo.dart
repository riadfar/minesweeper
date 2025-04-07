import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/game/game_cubit.dart';

class UndoRedo extends StatelessWidget {
  const UndoRedo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        // final canUndo =
        //     context.read<GameCubit>().state.gameList.games[state.gameList.currentIndex].undoStack.isNotEmpty;
        // final canRedo =
        //     context.read<GameCubit>().state.gameList.games[state.gameList.currentIndex].redoStack.isNotEmpty;

        return Row(
          children: [
            IconButton(
              onPressed: () => context.read<GameCubit>().undo(),
              icon: Icon(Icons.undo),
            ),
            IconButton(
              onPressed: () => context.read<GameCubit>().redo(),
              icon: Icon(Icons.redo),
            ),
          ],
        );
      },
    );
  }
}
