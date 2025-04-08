enum BlockType { empty, mine, number }

enum BlockState { hidden, revealed, flagged }

class Block {
  int number;
  final BlockType type;
  BlockState state;

  Block({required this.type, this.number = 0, this.state = BlockState.hidden});

  void toggleFlag() {
    if (state == BlockState.flagged) {
      state = BlockState.hidden;
    } else if (state == BlockState.hidden) {
      state = BlockState.flagged;
    }
  }

  void reveal() {
    if (state != BlockState.revealed) {
      state = BlockState.revealed;
    }
  }

  bool get isRevealed => state == BlockState.revealed;

  bool get isFlagged => state == BlockState.flagged;

  /// FOR MEMENTO

  Block copy() {
    return Block(type: type, number: number, state: state);
  }

  /// FOR SAVE LOAD THE GAME
  Map<String, dynamic> toJson() => {
    "type": type.index,
    "number": number,
    "state": state.index,
  };

  factory Block.fromJson(Map<String, dynamic> json) => Block(
    type: BlockType.values[json['type']],
    number: json['number'],
    state: BlockState.values[json['state']],
  );
}
