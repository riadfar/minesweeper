import 'dart:math';

import 'block.dart';
import 'field_config.dart';

class Field {
  late List<List<Block>> grid;
  FieldConfig config;

  Field({required this.config}) {
    _initializeGrid();
    _placeMines();
    _calculateNumbers();
  }

  factory Field.initial() => Field(config: FieldConfig.initial());

  void _initializeGrid() {
    grid = List.generate(
      config.height,
      (y) => List.generate(config.width, (x) => Block(type: BlockType.empty)),
    );
  }

  void _placeMines() {
    int minesPlaced = 0;
    final random = Random();

    while (minesPlaced < config.minesCount) {
      final x = random.nextInt(config.width);
      final y = random.nextInt(config.height);

      if (grid[y][x].type != BlockType.mine) {
        grid[y][x] = Block(type: BlockType.mine);
        minesPlaced++;
      }
    }
  }

  void _calculateNumbers() {
    for (int y = 0; y < config.height; y++) {
      for (int x = 0; x < config.width; x++) {
        if (grid[y][x].type != BlockType.mine) {
          final count = _countAdjacentMines(x, y);
          if (count > 0) {
            grid[y][x] = Block(type: BlockType.number, number: count);
          }
        }
      }
    }
  }

  int _countAdjacentMines(int x, int y) {
    int count = 0;
    for (int dy = -1; dy <= 1; dy++) {
      for (int dx = -1; dx <= 1; dx++) {
        final nx = x + dx;
        final ny = y + dy;
        if (nx >= 0 &&
            nx < config.width &&
            ny >= 0 &&
            ny < config.height &&
            grid[ny][nx].type == BlockType.mine) {
          count++;
        }
      }
    }
    return count;
  }

  void printField({bool revealMines = false}) {
    for (int y = 0; y < config.height; y++) {
      String rowStr = '';
      for (int x = 0; x < config.width; x++) {
        final block = grid[y][x];
        if (block.isRevealed || revealMines) {
          rowStr += '${_getBlockSymbol(block)} ';
        } else if (block.isFlagged) {
          rowStr += 'F ';
        } else {
          rowStr += '. ';
        }
      }
      print(rowStr);
    }
    print("--------------------");
  }

  String _getBlockSymbol(Block block) {
    if (block.type == BlockType.mine) {
      return '*';
    } else if (block.type == BlockType.number && block.number > 0) {
      return block.number.toString();
    } else {
      return ' ';
    }
  }

  /// FOR MEMENTO

  Field copy() => Field._copy(this);

  Field._copy(Field original) : config = original.config.copy() {
    grid =
        original.grid
            .map((row) => row.map((block) => block.copy()).toList())
            .toList();
  }

  /// FOR SAVE THE GAME

  Map<String, dynamic> toJson() => {
    "grid":
        grid.map((row) => row.map((block) => block.toJson()).toList()).toList(),
    "field_config": config.toJson(),
  };

  factory Field.fromJson(Map<String, dynamic> json) {
    final field = Field(config: FieldConfig.fromJson(json["field_config"]));
    field.grid =
        (json['grid'] as List)
            .map(
              (row) =>
                  (row as List).map((block) => Block.fromJson(block)).toList(),
            )
            .toList();
    return field;
  }
}
