import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/game/game_cubit.dart';
import '../../../logic/field_config.dart';
import '../../global_elements/custom_app_bar.dart';
import '../widgets/config_card.dart';
import '../../global_elements/custom_elevated_button.dart';
import '../widgets/custom_config_widget.dart';
import 'game_mode_screen.dart';

class FieldConfigScreen extends StatefulWidget {
  const FieldConfigScreen({super.key});

  @override
  State<FieldConfigScreen> createState() => _FieldConfigScreenState();
}

class _FieldConfigScreenState extends State<FieldConfigScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameCubit, GameState>(
      listener: (context, state) {
        if (state.error.isNotEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        final cubit = context.read<GameCubit>();
        FieldConfig fieldConfig = defaultConfigs[0];

        return Scaffold(
          appBar: CustomAppBar(
            title: const Text(
              "Choose Field Size",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                for (var config in defaultConfigs)
                  ConfigCard(
                    title: config.difficulty!,
                    subtitle:
                        '${config.width}x${config.height} - ${config.minesCount} mines',
                    isSelected:
                        state
                            .gameSave
                            .gameList
                            .games[state.gameSave.gameList.currentIndex]
                            .game
                            .field
                            .config ==
                        config,
                    onTap: () {
                      fieldConfig = config;
                      cubit.setFieldConfig(config);
                    }, // Use cubit instead of callback
                  ),
                CustomConfigWidget(),
                CustomElevatedButton(
                  child: const Text("Next"),
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => GameModeScreen(config: fieldConfig),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
