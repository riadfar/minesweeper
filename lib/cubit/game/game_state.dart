part of 'game_cubit.dart';

enum GameStatus { loading, playing, won, lost }

class GameState extends Equatable {
  final GameSave gameSave;
  final GameStatus status;
  final String error;

  const GameState({
    required this.gameSave,
    required this.status ,
    required this.error,
  });

  factory GameState.initial(GameSave game) =>
      GameState(status: GameStatus.playing, gameSave: game, error: '');

  GameState copyWith({GameSave? gameSave, GameStatus? status, String? error}) {
    return GameState(
      gameSave: gameSave ?? this.gameSave,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [gameSave, status, error];
}
