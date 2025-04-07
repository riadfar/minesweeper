import 'block.dart';
import 'field.dart';

class Game {
  Field field;
  bool isRunning;

  Game({required this.field, this.isRunning = true});


  factory Game.initial() => Game(field: Field.initial());

  void handleClick(int x, int y, {bool isFlag = false}) {
    if (_checkOutOfGrid(x, y)) return;

    final block = field.grid[y][x];
    if (block.state == BlockState.revealed) return;

    if (isFlag) {
      block.toggleFlag();
    } else {
      if (block.type == BlockType.mine) {
        _handleClickMine(block);
        isRunning = false;
      } else {
        block.reveal();
        if (block.number == 0) handleEmptyBlock(x, y);
      }
    }
  }

  bool _checkOutOfGrid(x, y) {
    return x < 0 ||
        x > field.config.width - 1 ||
        y < 0 ||
        y > field.config.height - 1;
  }

  void _handleClickMine(Block block) {
    for (int y = 0; y < field.config.height; y++) {
      for (int x = 0; x < field.config.width; x++) {
        if (field.grid[y][x].type == BlockType.mine) {
          field.grid[y][x].state = BlockState.revealed;
        }
      }
    }
    field.printField(revealMines: true);
    print("You lost");
  }

  void handleEmptyBlock(x, y) {
    handleClick(x - 1, y - 1);
    handleClick(x, y - 1);
    handleClick(x + 1, y - 1);
    handleClick(x - 1, y);
    handleClick(x + 1, y);
    handleClick(x - 1, y + 1);
    handleClick(x, y + 1);
    handleClick(x + 1, y + 1);
  }

  bool get winState {
    if (_checkWinCondition()) {
      print("All safe blocks revealed!");
      isRunning = false;
      return true;
    }
    return false;
  }

  bool _checkWinCondition() {
    for (List<Block> row in field.grid) {
      for (Block block in row) {
        if (block.type != BlockType.mine &&
            block.state != BlockState.revealed) {
          return false;
        }
      }
    }
    isRunning = false;
    return true;
  }

  void printGame() {
    field.printField(revealMines: !isRunning);
  }

  /// for memento

  Game copy() {
    return Game(field: field.copy(), isRunning: isRunning);
  }

  ///for save and load the game
  Map<String, dynamic> toJson() => {
    "field": field.toJson(),
    "isRunning": isRunning,
  };

  factory Game.fromJson(Map<String, dynamic> json) =>
      Game(field: Field.fromJson(json["field"]), isRunning: json["isRunning"]);
}
