import 'game_controller.dart';

class GameControllerList {
  final List<GameController> _games;
  final int currentIndex;

  const GameControllerList({
    List<GameController> games = const [],
    this.currentIndex = 0,
  }) : _games = games;

  GameController get currentGame => _games[currentIndex];

  List<GameController> get games => _games;

  int get length => _games.length;

  GameControllerList addGame(GameController game) {
    return GameControllerList(
      games: List.from(_games)..add(game),
      currentIndex: _games.length,
    );
  }

  GameControllerList removeLastGame() {
    if (_games.length <= 1) return this;
    return GameControllerList(
      games: List.from(_games)..removeLast(),
      currentIndex: (_games.length - 2).clamp(0, _games.length - 2),
    );
  }

  GameControllerList updateCurrentGame(GameController updatedGame) {
    final newGames = List<GameController>.from(_games);
    newGames[currentIndex] = updatedGame;
    return GameControllerList(games: newGames);
  }

  ///FOR MEMENTO

  GameControllerList copy() => GameControllerList(
    games: games.map((game) => game.copy()).toList(),
    currentIndex: currentIndex,
  );

  ///FOR SAVE AND LOAD THE GAME

  Map<String, dynamic> toJson() => {
    'games': _games.map((game) => game.toJson()).toList(),
    'currentIndex': currentIndex,
  };

  factory GameControllerList.fromJson(Map<String, dynamic> json) {
    return GameControllerList(
      games:
          (json['games'] as List)
              .map((gameJson) => GameController.fromJson(gameJson))
              .toList(),
      currentIndex: json['currentIndex'],
    );
  }
}
