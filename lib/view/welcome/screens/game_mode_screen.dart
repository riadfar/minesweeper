import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/game/game_cubit.dart';

import '../../../logic/field_config.dart';
import '../../../logic/game_controller.dart';
import '../../../logic/game_save.dart';
import '../../../logic/mode.dart';
import '../../global_elements/custom_app_bar.dart';
import '../../game/screens/game_screen.dart';
import '../widgets/mode_card.dart';
import '../../global_elements/custom_elevated_button.dart';

class GameModeScreen extends StatefulWidget {
  final FieldConfig config;

  const GameModeScreen({super.key, required this.config});

  @override
  State<GameModeScreen> createState() => _GameModeScreenState();
}

class _GameModeScreenState extends State<GameModeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        final cubit = context.read<GameCubit>();
        late GameMode gameMode = GameMode.singlePlayer;
        return Scaffold(
          appBar: CustomAppBar(title: const Text('Choose Game Mode',style: TextStyle(color: Colors.white),)),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                for (final mode in modes)
                  ModeCard(
                    title: mode.title,
                    subtitle: mode.subtitle,
                    icon: mode.iconData,
                    isSelected:
                        state
                            .gameSave
                            .gameList
                            .games[state.gameSave.gameList.currentIndex]
                            .mode ==
                        mode.gameMode,
                    isEnabled: mode.gameMode == GameMode.singlePlayer,
                    // Disable other modes
                    onTap: () {
                      setState(() {
                        gameMode = mode.gameMode;
                      });
                      cubit.setGameMode(mode.gameMode);
                      print(gameMode.toString());
                    },
                  ),

                const SizedBox(height: 32),
                CustomElevatedButton(
                  onPress: () {
                    GameSave initialGame = cubit.state.gameSave;
                    initialGame.gameList.games.first.game.field.printField(
                      revealMines: true,
                    );
                    cubit.resetGame(
                      widget.config,
                      state.gameSave.gameList.games.first.mode,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => GameScreen(initialGame: initialGame),
                      ),
                    );
                  },
                  child: const Text('Play'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
