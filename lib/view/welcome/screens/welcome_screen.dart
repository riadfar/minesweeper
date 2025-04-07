import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/game/game_cubit.dart';
import '../../../cubit/save_load/save_load_cubit.dart';
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
          ).showSnackBar(SnackBar(content: Text("No saved games yet!")));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
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
            padding: EdgeInsets.all(24),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomElevatedButton(
                    child: const Text(
                      "New Game",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    onPress: () {
                      final cubit = context.read<GameCubit>();
                      cubit.resetGame(
                        cubit.gameSave!.gameList.games.first.game.field.config,
                        cubit.gameSave!.gameList.games.first.mode,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FieldConfigScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 12),
                  state.status == SaveLoadStatus.loading
                      ? CircularProgressIndicator()
                      : CustomElevatedButton(
                        child: const Text(
                          "Load Game",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        onPress: () {
                          saveCubit.fetchGames();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoadScreen(),
                            ),
                          );
                        },
                      ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
