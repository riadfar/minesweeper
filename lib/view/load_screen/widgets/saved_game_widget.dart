import 'package:flutter/material.dart';

import '../../../logic/game_save.dart';
import '../../../utils/constants.dart';
import '../../game/screens/game_screen.dart';
import 'saved_game_widget_content.dart';

class SavedGameWidget extends StatefulWidget {
  const SavedGameWidget({
    super.key,
    required this.gameSave,
    required this.index,
  });

  final GameSave gameSave;
  final int index;

  @override
  State<SavedGameWidget> createState() => _SavedGameWidgetState();
}

class _SavedGameWidgetState extends State<SavedGameWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder:
                    (context) => GameScreen(
                      savedGame: widget.gameSave,
                      index: widget.index,
                    ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          splashColor: Colors.blue.withAlpha(51),
          highlightColor: Colors.transparent,
          child: Container(
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(39),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SavedGameWidgetContent(
                gameSave: widget.gameSave,
                index: widget.index,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
