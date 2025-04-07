import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/game_save.dart';
import '../../utils/hive_service.dart';

part 'save_load_state.dart';

class SaveLoadCubit extends Cubit<SaveLoadState> {
  SaveLoadCubit() : super(SaveLoadState.initial());

  HiveService hiveService = HiveService();

  void setGames(List<GameSave> games) {
    emit(state.copyWith(status: SaveLoadStatus.loading));
    try {
      emit(
        state.copyWith(
          games: games,
          gameSave: games.first,
          status: SaveLoadStatus.loaded,
        ),
      );
    } catch (e) {
      _errorHandler("set the game", e);
    }
  }

  ///HANDLE CRUD METHODE

  Future<void> saveGame(String gameName) async {
    emit(state.copyWith(status: SaveLoadStatus.loading));
    try {
      String date = DateTime.now().toString().substring(0, 16);
      GameSave newGame = state.gameSave;
      newGame.date = date;
      gameName == '' ? newGame.id = "Saved Game" : newGame.id = gameName;
      emit(state.copyWith(status: SaveLoadStatus.save, gameSave: newGame));
      await hiveService.create(state.gameSave.toJson());
      emit(state.copyWith(status: SaveLoadStatus.loaded));
    } catch (e) {
      _errorHandler("save game", e);
    }
  }

  Future<void> fetchGames() async {
    emit(state.copyWith(status: SaveLoadStatus.loading));
    try {
      final rawData = await hiveService.readAll();
      List<GameSave> games = [];
      for (var game in rawData) {
        games.add(GameSave.fromJson(game));
      }
      games.isNotEmpty
          ? emit(state.copyWith(games: games, status: SaveLoadStatus.loaded))
          : emit(
            state.copyWith(games: games, status: SaveLoadStatus.emptyData),
          );
    } catch (e) {
      _errorHandler("load games", e);
    }
  }

  Future<void> updateGame(int index) async {
    emit(state.copyWith(status: SaveLoadStatus.loading));
    try {
      await hiveService.update(index, state.gameSave.toJson());
      List<GameSave> newGames = state.games;
      newGames[index] = state.gameSave;
      emit(state.copyWith(status: SaveLoadStatus.loaded, games: newGames));
    } catch (e) {
      _errorHandler("update game", e);
    }
      emit(state.copyWith(status: SaveLoadStatus.loaded));
  }

  Future<void> deleteGame(int index) async {
    emit(state.copyWith(status: SaveLoadStatus.loading));
    try {
      await hiveService.delete(index);
      List<GameSave> games = state.games;
      games.removeAt(index);
      state.copyWith(status: SaveLoadStatus.loaded, games: games);
    } catch (e) {
      _errorHandler("delete game", e);
    }
    emit(state.copyWith(status: SaveLoadStatus.loaded));
  }

  void _errorHandler(String methodName, e) {
    state.copyWith(
      status: SaveLoadStatus.error,
      error: "Failed to $methodName: ${e.toString()}",
    );
  }
}
