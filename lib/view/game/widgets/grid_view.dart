import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import '../../../cubit/game/game_cubit.dart';
import '../../../logic/game_controller.dart';
import 'block_widget.dart';

class Grid extends StatefulWidget {
  final GameController controller;
  final int gameIndex;

  const Grid({super.key, required this.controller, required this.gameIndex});

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  final AudioPlayer _player = AudioPlayer();

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameCubit>();
    final game = widget.controller.game;
    final config = game.field.config;
    final height = config.height;
    final width = config.width;

    return GridView.builder(
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      primary: true,
      shrinkWrap: true,
      addAutomaticKeepAlives: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: width,
        childAspectRatio: 1.0,
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
      ),
      itemCount: width * height,
      itemBuilder: (context, index) {
        final row = index ~/ width;
        final col = index % width;
        final block = game.field.grid[row][col];

        return InkWell(
          onTap: () async {
            cubit.handleClick(col, row,widget.gameIndex);
            await _playSound("assets/sounds/click_sound.mp3");
          },
          onLongPress: () async {
            cubit.handleLongClick(col, row,widget.gameIndex);
            await _playSound("assets/sounds/click_sound.mp3");
          },
          child: BlockWidget(block: block),
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
