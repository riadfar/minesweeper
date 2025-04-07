import 'package:flutter/material.dart';

import 'game_controller.dart';

class Mode {
  final GameMode gameMode;
  final String title;
  final IconData iconData;
  final String subtitle;

  Mode({
    required this.gameMode,
    required this.title,
    required this.iconData,
    required this.subtitle,
  });
}
final List<Mode> modes = [
  Mode(
    gameMode: GameMode.singlePlayer,
    title: 'Single Player',
    iconData: Icons.person_outline,
    subtitle: 'Play alone against the board',
  ),
  Mode(
    gameMode: GameMode.twoPlayer,
    title: 'Two Player',
    iconData: Icons.people_outline,
    subtitle: 'Take turns with a friend',
  ),
  Mode(
    gameMode: GameMode.vsComputer,
    title: 'vs Computer',
    iconData: Icons.computer_outlined,
    subtitle: 'Challenge the AI opponent',
  ),
];