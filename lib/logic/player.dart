class Player {
  final int id;
  final String name;
  int score;
  PlayerColor color;
  final bool isComputer;

  Player({
    required this.id,
    required this.name,
    this.score = 0,
    this.color = PlayerColor.red,
    this.isComputer = false,
  });

  void addScore(int points) {
    score += points;
  }

  @override
  String toString() {
    return "Player $id: $name (Score: $score)";
  }

  ///FOR MEMENTO

  Player copy() {
    return Player(id: id, name: name, isComputer: isComputer, score: score);
  }

  /// FOR SAVE LOAD THE GAME

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "isComputer": isComputer,
    "score": score,
  };

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    id: json["id"],
    name: json["name"],
    isComputer: json["isComputer"],
    score: json["score"],
  );
}

enum PlayerColor { red, blue, green, yellow }
