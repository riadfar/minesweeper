class FieldConfig {
  final String? difficulty;
  final int width;
  final int height;
  final int minesCount;

  FieldConfig({
    this.difficulty,
    required this.width,
    required this.height,
    required this.minesCount,
  });

  factory FieldConfig.initial() =>
      FieldConfig(width: 0, height: 0, minesCount: 0);

  /// for memento
  FieldConfig copy() => FieldConfig(
    difficulty: difficulty,
    width: width,
    height: height,
    minesCount: minesCount,
  );

  /// for save and load the game
  Map<String, dynamic> toJson() => {
    "difficulty": difficulty,
    "width": width,
    "height": height,
    "minesCount": minesCount,
  };

  factory FieldConfig.fromJson(Map<String, dynamic> json) => FieldConfig(
    difficulty: json["difficulty"],
    width: json["width"],
    height: json["height"],
    minesCount: json["minesCount"],
  );
}

List<FieldConfig> defaultConfigs = [
  FieldConfig(difficulty: "Easy", width: 9, height: 9, minesCount: 10),
  FieldConfig(difficulty: 'Medium', width: 16, height: 16, minesCount: 40),
  FieldConfig(difficulty: 'Hard', width: 16, height: 30, minesCount: 99),
];
