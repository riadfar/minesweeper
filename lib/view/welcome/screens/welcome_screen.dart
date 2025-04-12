import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/game/game_cubit.dart';
import '../../../cubit/save_load/save_load_cubit.dart';
import '../../../logic/field_config.dart';
import '../../../logic/game_controller.dart';
import '../../global_elements/custom_app_bar.dart';
import '../../global_elements/custom_elevated_button.dart';
import '../../load_screen/screen/load_screen.dart';
import 'field_config_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final saveCubit = context.read<SaveLoadCubit>();
    return BlocConsumer<SaveLoadCubit, SaveLoadState>(
      listener: (context, state) {
        if (state.status == SaveLoadStatus.emptyData) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("No saved games yet!")));
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/background_image.png',
                fit: BoxFit.fill,
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: customAppBar(
                title: const Text(
                  "Welcome",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomElevatedButton(
                        child: const Text(
                          "New Game",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPress: () {
                          final cubit = context.read<GameCubit>();
                          GameMode mode =
                              cubit.gameSave!.gameList.games.first.mode;
                          FieldConfig config =
                              cubit
                                  .gameSave!
                                  .gameList
                                  .games
                                  .first
                                  .game
                                  .field
                                  .config;

                          cubit.resetGame(config, mode);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FieldConfigScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      state.status == SaveLoadStatus.loading
                          ? const CircularProgressIndicator()
                          : CustomElevatedButton(
                            child: const Text(
                              "Load Game",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPress: () {
                              saveCubit.fetchGames();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoadScreen(),
                                ),
                              );
                            },
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
