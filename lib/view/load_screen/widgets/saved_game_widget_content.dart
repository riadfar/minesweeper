import 'package:flutter/material.dart';

import '../../../logic/game_save.dart';
import 'delete_dialog.dart';

class SavedGameWidgetContent extends StatefulWidget {
  const SavedGameWidgetContent({
    super.key,
    required this.gameSave,
    required this.index,
  });

  final GameSave gameSave;
  final int index;

  @override
  State<SavedGameWidgetContent> createState() => _SavedGameWidgetContentState();
}

class _SavedGameWidgetContentState extends State<SavedGameWidgetContent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.gameSave.id,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.gameSave.date,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w200,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            _showDeleteDialog(context, widget.index);
          },
          icon: Icon(Icons.remove_circle, color: Colors.red),
        ),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => DeleteDialog(index: widget.index),
    );
  }
}
