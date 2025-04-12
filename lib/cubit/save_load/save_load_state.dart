part of 'save_load_cubit.dart';

enum SaveLoadStatus { initial, loading, loaded, error, create, save, delete ,emptyData}

class SaveLoadState extends Equatable {
  final SaveLoadStatus status;
  final GameSave gameSave;
  final List<GameSave> games;
  final String error;

  const SaveLoadState({
    required this.status,
    required this.gameSave,
    required this.games,
    required this.error,
  });

  factory SaveLoadState.initial() => SaveLoadState(
    status: SaveLoadStatus.initial,
    gameSave: GameSave.initial(),
    games: [],
    error: "",
  );

  SaveLoadState copyWith({
    SaveLoadStatus? status,
    GameSave? gameSave,
    List<GameSave>? games,
    String? error,
  }) {
    return SaveLoadState(
      status: status ?? this.status,
      gameSave: gameSave ?? this.gameSave,
      games: games ?? this.games,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, gameSave, games, error];
}
