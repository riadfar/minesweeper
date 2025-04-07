import 'dart:math';

import 'block.dart';
import 'field.dart';
import 'field_config.dart';
import 'game.dart';
import 'player.dart';

enum GameMode { singlePlayer, twoPlayer, vsComputer }

class GameController {
  final List<Player> players;
  final GameMode mode;
  int currentPlayerIndex;
  Game game;
  final Random _random = Random();


  GameController({required this.mode, required FieldConfig config})
    : players = _createPlayers(mode),
      currentPlayerIndex = 0,
      game = Game(field: Field(config: config));

  factory GameController.initial() =>
      GameController(mode: GameMode.singlePlayer, config: defaultConfigs[0]);

  static List<Player> _createPlayers(GameMode mode) {
    switch (mode) {
      case GameMode.singlePlayer:
        return [Player(id: 1, name: "Player 1")];
      case GameMode.twoPlayer:
        return [
          Player(id: 1, name: "Player 1"),
          Player(id: 2, name: "Player 2"),
        ];
      case GameMode.vsComputer:
        return [
          Player(id: 1, name: "Human"),
          Player(id: 2, name: "Computer", isComputer: true),
        ];
    }
  }

  void handleMove(int x, int y, {bool isFlag = false}) {
    if (!game.isRunning) return;

    final currentPlayer = players[currentPlayerIndex];
    final previousRevealed = _countRevealedBlocks();
    game.handleClick(x, y, isFlag: isFlag);

    if (!game.isRunning) {
      _handleGameEnd(currentPlayer);
      return;
    }

    _updateScore(currentPlayer, x, y, isFlag, previousRevealed);

    if (mode != GameMode.singlePlayer) switchTurn();
  }

  void switchTurn() {
    if (mode == GameMode.singlePlayer) return;
    currentPlayerIndex = (currentPlayerIndex + 1) % players.length;
  }

  void _handleGameEnd(Player currentPlayer) {
    if (game.field.grid.any(
      (row) =>
          row.any((block) => block.type == BlockType.mine && block.isRevealed),
    )) {
      print("${currentPlayer.name} hit a mine! Game over.");
      if (mode == GameMode.vsComputer) {
        print(currentPlayer.isComputer ? "Human wins!" : "Computer wins!");
      } else if (mode == GameMode.twoPlayer) {
        final winner = players[(currentPlayerIndex + 1) % players.length];
        print("${winner.name} wins!");
      }
    } else {
      players.sort((a, b) => b.score.compareTo(a.score));
      print("${players.first.name} wins with score ${players.first.score}!");
    }
  }

  void _updateScore(
    Player player,
    int x,
    int y,
    bool isFlag,
    int previousRevealed,
  ) {
    if (isFlag) {
      final block = game.field.grid[y][x];
      if (block.isFlagged) {
        block.type == BlockType.mine
            ? player.addScore(10)
            : player.addScore(-5);
      } else {
        block.type == BlockType.mine
            ? player.addScore(-10)
            : player.addScore(5);
      }
    } else {
      final points = _countRevealedBlocks() - previousRevealed;
      if (points > 0) player.addScore(points);
    }
  }

  int _countRevealedBlocks() {
    return game.field.grid
        .expand((row) => row)
        .where((block) => block.isRevealed)
        .length;
  }

  void handleComputerMove() {
    final Player computer = players[currentPlayerIndex];
    print("${computer.name}'s turn...");

    int x, y;
    Block block;
    do {
      x = _random.nextInt(game.field.config.width);
      y = _random.nextInt(game.field.config.height);
      block = game.field.grid[y][x];
    } while (block.isRevealed || block.isFlagged);

    final isFlag = _random.nextDouble() < 0.2;
    handleMove(x, y, isFlag: isFlag);
  }

  ///FOR MEMENTO

  GameController._({
    required this.mode,
    required this.players,
    required this.currentPlayerIndex,
    required this.game,
  });

  GameController copy() {
    return GameController._(
      mode: mode,
      players: players.map((player) => player.copy()).toList(),
      currentPlayerIndex: currentPlayerIndex,
      game: game.copy(),
    );
  }

  ///FOR SAVE AND LOAD THE GAME

  Map<String, dynamic> toJson() => {
    "mode": mode.index,
    "players": players.map((player) => player.toJson()).toList(),
    "currentPlayerIndex": currentPlayerIndex,
    "game": game.toJson(),
  };

  factory GameController.fromJson(Map<String, dynamic> json) => GameController._(
    mode: GameMode.values[json['mode']],
    players:
        (json['players'] as List)
            .map((pJson) => Player.fromJson(pJson))
            .toList(),
    currentPlayerIndex: json['currentPlayerIndex'],
    game: Game.fromJson(json['game']),
  );
}
