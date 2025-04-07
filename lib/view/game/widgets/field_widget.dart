import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:minesweeper/view/game/widgets/win_widget.dart';

import '../../../cubit/game/game_cubit.dart';
import '../../../logic/game_controller.dart';
import '../../welcome/screens/field_config_screen.dart';
import 'grid_view.dart';
import 'lost_widget.dart';

class FieldWidget extends StatefulWidget {
  final List<GameController> controllers;
  final int controllerIndex;

  const FieldWidget({super.key, required this.controllers, required this.controllerIndex});

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
          await _playSound("assets/sounds/lose.mp3");
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
                    cubit.resetGame(state.gameSave.gameList.games[state.gameSave.gameList.currentIndex].game.field.config,  state.gameSave.gameList.games[state.gameSave.gameList.currentIndex].mode);
                    print(state.gameSave.gameList.games[state.gameSave.gameList.currentIndex].game.field.config.toString());
                    print(state.gameSave.gameList.games[state.gameSave.gameList.currentIndex].mode);

                  },
                ),
          );
        } else if (state.status == GameStatus.won) {
          await _playSound("assets/sounds/win.mp3");
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
                    cubit.resetGame(state.gameSave.gameList.games[state.gameSave.gameList.currentIndex].game.field.config,  state.gameSave.gameList.games[state.gameSave.gameList.currentIndex].mode);
                  },
                ),
          );
        }
      },
      builder: (context, state) {
        return widget.controllers.length==1?Grid(controller: widget.controllers[widget.controllerIndex],gameIndex: 0):Column(
          children: [
            Grid(controller: widget.controllers.first,gameIndex: 0,),
            Grid(controller: widget.controllers.last,gameIndex: 1,),
          ],
        );
      },
    );
  }

  Future<void> _playSound(String sound) async {
    try {
      await _player.setAsset(sound);
      await _player.play();
    } catch (e) {
      debugPrint("Error playing sound: $e");
    }
  }
}
