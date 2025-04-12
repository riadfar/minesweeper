import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/game/game_cubit.dart';
import '../../../cubit/save_load/save_load_cubit.dart';

import '../../../logic/game_save.dart';
import '../../global_elements/custom_app_bar.dart';
import '../widgets/action_list.dart';
import '../widgets/field_widget.dart';

class GameScreen extends StatefulWidget {
  final GameSave? savedGame;
  final GameSave? initialGame;
  final int? index;

  const GameScreen({super.key, this.savedGame, this.initialGame, this.index});

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
            appBar: customAppBar(
              title: Text(
                "Minesweeper",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 22,color: Colors.white),
              ),
              actions: actionList(
                state.gameSave,
                widget.savedGame,
                widget.initialGame,
                saveCubit,
                widget.index,
              ),
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
          FloatingActionButton(
                onPressed: () {

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

                },
                child: Icon(Icons.add),
              )
                // state.gameSave.gameList.length == 1
                //     ? FloatingActionButton(
                //       onPressed: () {
                //         if (state.gameSave.gameList.length == 1) {
                //           context.read<GameCubit>().addNewGame(
                //             state
                //                 .gameSave
                //                 .gameList
                //                 .games[state.gameSave.gameList.currentIndex]
                //                 .game
                //                 .field
                //                 .config,
                //             state
                //                 .gameSave
                //                 .gameList
                //                 .games[state.gameSave.gameList.currentIndex]
                //                 .mode,
                //           );
                //         }
                //       },
                //       child: Icon(Icons.add),
                //     )
                //     : null,
          );
        },
      ),
    );
  }
}
