import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/game/game_cubit.dart';
import '../screens/custom_field_config_screen.dart';
import 'config_card.dart';

class CustomConfigWidget extends StatelessWidget {
  const CustomConfigWidget({super.key, required this.cubit});

  final GameCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Text(
          "Choose your own configuration",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 16),

        ConfigCard(
          title: 'Custom',
          subtitle: 'Create your own field configuration',
          isSelected: false,
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => BlocProvider.value(
                        value: cubit,
                        child: CustomFieldConfigScreen(),
                      ),
                ),
              ),
        ),

        const SizedBox(height: 32),
      ],
    );
  }
}
