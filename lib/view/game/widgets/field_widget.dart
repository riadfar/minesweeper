import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import '../../../cubit/game/game_cubit.dart';
import '../../../logic/field_config.dart';
import '../../../logic/game_controller.dart';
import '../../welcome/screens/field_config_screen.dart';
import 'grid_view.dart';
import 'lost_widget.dart';
import 'win_widget.dart';

class FieldWidget extends StatefulWidget {
  final List<GameController> controllers;
  final int controllerIndex;

  const FieldWidget({
    super.key,
    required this.controllers,
    required this.controllerIndex,
  });

  @override
  State<FieldWidget> createState() => _FieldWidgetState();
}

class _FieldWidgetState extends State<FieldWidget> {
  final AudioPlayer _player = AudioPlayer();

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameCubit>();

    return BlocConsumer<GameCubit, GameState>(
      listener: (context, state) async {
        if (state.status == GameStatus.lost) {
          _playSound("assets/sounds/lose.mp3");
          showDialog(
            context: context,
            builder:
                (_) => LostWidget(
                  backToMenu: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FieldConfigScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  onNewGame: () {
                    Navigator.pop(context);
                    FieldConfig config =
                        state
                            .gameSave
                            .gameList
                            .games[state.gameSave.gameList.currentIndex]
                            .game
                            .field
                            .config;
                    GameMode mode =
                        state
                            .gameSave
                            .gameList
                            .games[state.gameSave.gameList.currentIndex]
                            .mode;
                    cubit.resetGame(config, mode);
                  },
                ),
          );
        } else if (state.status == GameStatus.won) {
          _playSound("assets/sounds/win.mp3");
          showDialog(
            context: (context),
            builder:
                (_) => WinWidget(
                  backToMenu: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FieldConfigScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  onNewGame: () {
                    Navigator.pop(context);
                    cubit.resetGame(
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
                ),
          );
        }
      },
      builder: (context, state) {
        return SizedBox(height: MediaQuery.of(context).size.height *0.9,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.controllers.length,
            itemBuilder:
                (context, index) =>
                    Grid(controller: widget.controllers[index], gameIndex: index),
          ),
        );
      },
    );
  }

  void _playSound(String sound) {
    try {
      _player.setAsset(sound);
      _player.play();
    } catch (e) {
      debugPrint("Error playing sound: $e");
    }
  }
}
