import 'package:flutter/material.dart';

import '../../../logic/game_save.dart';
import 'saved_game_widget.dart';

class SavedGamesListView extends StatelessWidget {
  const SavedGamesListView({super.key, required this.savedGames});

  final List<GameSave> savedGames;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: savedGames.length,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (ctx, index) => SavedGameWidget(gameSave: savedGames[index],index: index,),
    );
  }
}
