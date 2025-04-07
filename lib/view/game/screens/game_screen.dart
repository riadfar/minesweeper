import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/game/game_cubit.dart';
import '../../../cubit/save_load/save_load_cubit.dart';

import '../../../logic/game_save.dart';
import '../../global_elements/custom_app_bar.dart';
import '../widgets/field_widget.dart';
import '../widgets/save_dialog.dart';
import '../widgets/undo_redo.dart';
import '../widgets/update_dialog.dart';

class GameScreen extends StatefulWidget {
  final GameSave? savedGame;
  final GameSave? initialGame;
  final int? index;

  GameScreen({super.key, this.savedGame, this.initialGame, this.index});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    final saveCubit = context.read<SaveLoadCubit>();
    return BlocProvider(
      create:
          (context) =>
              widget.savedGame == null
                  ? GameCubit(initialGame: widget.initialGame)
                  : GameCubit(gameSave: widget.savedGame!),
      child: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          widget.savedGame == null
              ? saveCubit.setGames([state.gameSave])
              : saveCubit.setGames([widget.savedGame!]);
          return Scaffold(
            appBar: CustomAppBar(
              title: Text(
                "Minesweeper",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 22),
              ),
              actions: [
                UndoRedo(),
                IconButton(
                  onPressed: () {
                    print(state.gameSave.gameList.length);
                    state.gameSave.gameList.games.first.game.field.printField(
                      revealMines: true,
                    );
                    state.gameSave.gameList.games.last.game.field.printField(
                      revealMines: true,
                    );
                  },
                  icon: Icon(Icons.question_mark),
                ),
                BlocBuilder<SaveLoadCubit, SaveLoadState>(
                  builder: (context, state) {
                    return state.status == SaveLoadStatus.loading
                        ? CircularProgressIndicator()
                        : IconButton(
                          onPressed: () {
                            widget.savedGame == null
                                ? _showSaveDialog(context, saveCubit)
                                : widget.initialGame == null
                                ? _showUpdateDialog(context, saveCubit)
                                : null;
                            print(state.games.length);
                            state.games.first.gameList.games.first.game.field
                                .printField(revealMines: true);
                            state.games.first.gameList.games.last.game.field
                                .printField(revealMines: true);
                          },
                          icon: Icon(Icons.file_upload),
                        );
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(4.0),
              child: SingleChildScrollView(
                child: FieldWidget(
                  controllers: state.gameSave.gameList.games,
                  controllerIndex: state.gameSave.gameList.currentIndex,
                ),
              ),
            ),
            floatingActionButton:
                state.gameSave.gameList.length == 1
                    ? FloatingActionButton(
                      onPressed: () {
                        if (state.gameSave.gameList.length == 1) {
                          context.read<GameCubit>().addNewGame(
                            state
                                .gameSave
                                .gameList
                                .games[state.gameSave.gameList.currentIndex]
                                .game
                                .field
                                .config,
                            state
                                .gameSave
                                .gameList
                                .games[state.gameSave.gameList.currentIndex]
                                .mode,
                          );
                        }
                      },
                      child: Icon(Icons.add),
                    )
                    : null,
          );
        },
      ),
    );
  }

  void _showSaveDialog(BuildContext context, SaveLoadCubit saveCubit) {
    showDialog(
      context: context,
      builder: (context) => SaveDialog(saveCubit: saveCubit),
    );
  }

  void _showUpdateDialog(BuildContext context, SaveLoadCubit saveCubit) {
    print("-----------------");
    print(widget.index);
    print("-----------------");
    showDialog(
      context: context,
      builder: (context) => UpdateDialog(saveCubit: saveCubit,gameIndex: widget.index!,),
    );
  }
}
