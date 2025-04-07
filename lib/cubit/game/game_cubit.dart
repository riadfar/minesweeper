import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/field_config.dart';
import '../../logic/game_controller.dart';

import '../../logic/game_save.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameSave? gameSave;
  GameSave? initialGame;

  GameCubit({this.gameSave, this.initialGame})
    : super(GameState.initial(initialGame ?? gameSave!));

  /// SET THE GAME METHODE

  void _saveState() {
    state.gameSave.saveState(state.gameSave.gameList.copy());
    emit(state.copyWith());
  }

  void initializeNewGame(FieldConfig config, GameMode mode) {
    state.gameSave.undoStack.clear();
    state.gameSave.redoStack.clear();
    emit(state.copyWith(status: GameStatus.loading));
    final newGame = GameController(mode: mode, config: config);
    final newGameList = state.gameSave.gameList.addGame(newGame);
    emit(
      state.copyWith(
        gameSave: state.gameSave.copyWith(gameList: newGameList),
        status: GameStatus.playing,
      ),
    );
  }

  void setGameMode(GameMode mode) {
    emit(state.copyWith(status: GameStatus.loading));
    final currentGame = state.gameSave.gameList.currentGame;
    final newGame = GameController(
      mode: mode,
      config: currentGame.game.field.config,
    );
    final newGameList = state.gameSave.gameList.updateCurrentGame(newGame);
    emit(
      state.copyWith(
        gameSave: state.gameSave.copyWith(gameList: newGameList),
        status: GameStatus.playing,
      ),
    );
  }

  void setFieldConfig(FieldConfig config) {
    emit(state.copyWith(status: GameStatus.loading));
    final currentGame = state.gameSave.gameList.currentGame;
    final newGame = GameController(mode: currentGame.mode, config: config);
    final newGameList = state.gameSave.gameList.updateCurrentGame(newGame);
    emit(
      state.copyWith(
        gameSave: state.gameSave.copyWith(gameList: newGameList),
        status: GameStatus.playing,
      ),
    );
  }

  void resetGame(FieldConfig config, GameMode mode) {
    state.gameSave.undoStack.clear();
    state.gameSave.redoStack.clear();
    emit(state.copyWith(status: GameStatus.loading));
    final newGame = GameController(mode: mode, config: config);
    final newGameList = state.gameSave.gameList.updateCurrentGame(newGame);
    emit(
      state.copyWith(
        gameSave: state.gameSave.copyWith(gameList: newGameList),
        status: GameStatus.playing,
      ),
    );
  }

  /// PLAYING METHODE

  void handleClick(int x, int y, int gameIndex) {
    _saveState();
    emit(state.copyWith(status: GameStatus.loading));

    final currentGame = state.gameSave.gameList.games[gameIndex];
    currentGame.handleMove(x, y);

    _checkGameStatus();
    emit(state.copyWith(status: GameStatus.playing));
  }

  void handleLongClick(int x, int y, int gameIndex) {
    _saveState();
    emit(state.copyWith(status: GameStatus.loading));

    final currentGame = state.gameSave.gameList.games[gameIndex];
    currentGame.handleMove(x, y, isFlag: true);

    _checkGameStatus();
    emit(state.copyWith(status: GameStatus.playing));
  }

  void _checkGameStatus() {
    final currentGame = state.gameSave.gameList.currentGame;
    GameStatus newStatus = GameStatus.playing;

    if (!currentGame.game.isRunning) {
      newStatus = currentGame.game.winState ? GameStatus.won : GameStatus.lost;
    }
    if (currentGame.game.winState) {
      newStatus = GameStatus.won;
    }
    emit(state.copyWith(status: newStatus));
  }

  void undo() {
    if (state.gameSave.undoStack.isEmpty) return;
    emit(state.copyWith(status: GameStatus.loading));
    state.gameSave.undo();
    emit(state.copyWith(status: GameStatus.playing));
  }

  void redo() {
    if (state.gameSave.redoStack.isEmpty) return;
    emit(state.copyWith(status: GameStatus.loading));
    state.gameSave.redo();
    emit(state.copyWith(status: GameStatus.playing));
  }

  void addNewGame(FieldConfig config, GameMode mode) {
    _saveState();
    emit(state.copyWith(status: GameStatus.loading));
    final newGame = GameController(mode: mode, config: config);
    final newGameList = state.gameSave.gameList.addGame(newGame);
    emit(
      state.copyWith(
        gameSave: state.gameSave.copyWith(gameList: newGameList),
        status: GameStatus.playing,
      ),
    );
  }
}
