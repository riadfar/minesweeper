import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/save_load/save_load_cubit.dart';
import 'save_dialog.dart';
import 'undo_redo.dart';
import 'update_dialog.dart';

List<Widget> ActionList (gameSave,savedGame,initialGame,saveCubit,index,){
  return [
    UndoRedo(),
    IconButton(
      onPressed: () {
        print(gameSave.gameList.length);
        gameSave.gameList.games.first.game.field.printField(
          revealMines: true,
        );
        gameSave.gameList.games.last.game.field.printField(
          revealMines: true,
        );
      },
      icon: Icon(Icons.question_mark),
    ),
    BlocBuilder<SaveLoadCubit, SaveLoadState>(
      builder: (context, state) {
        return state.status == SaveLoadStatus.loading
            ? CircularProgressIndicator()
            : IconButton(
          onPressed: () {
            savedGame == null
                ? _showSaveDialog(context, saveCubit)
                : initialGame == null
                ? _showUpdateDialog(context, saveCubit,index)
                : null;
            print(state.games.length);
            state.games.first.gameList.games.first.game.field
                .printField(revealMines: true);
            state.games.first.gameList.games.last.game.field
                .printField(revealMines: true);
          },
          icon: Icon(Icons.file_upload),
        );
      },
    ),
  ];
}
void _showSaveDialog(BuildContext context, SaveLoadCubit saveCubit) {
  showDialog(
    context: context,
    builder: (context) => SaveDialog(saveCubit: saveCubit),
  );
}

void _showUpdateDialog(BuildContext context, SaveLoadCubit saveCubit,index) {
  showDialog(
    context: context,
    builder: (context) => UpdateDialog(saveCubit: saveCubit,gameIndex: index,),
  );
}