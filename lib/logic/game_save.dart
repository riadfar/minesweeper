import 'game_controller.dart';
import 'game_controller_list.dart';
import 'game_memento.dart';

class GameSave {
  String id;
  String date;
  GameControllerList gameList;
  List<ControllerMemento> undoStack = [];
  List<ControllerMemento> redoStack = [];

  GameSave({
    required this.id,
    required this.date,
    required this.gameList,
    required this.undoStack,
    required this.redoStack,
  });

  factory GameSave.initial() => GameSave(
    id: '',
    date: '',
    gameList: GameControllerList(games: [GameController.initial()]),
    undoStack: [],
    redoStack: [],
  );


  GameSave copyWith({
    String? id,
    String? date,
    GameControllerList? gameList,
    List<ControllerMemento>? undoStack,
    List<ControllerMemento>? redoStack,
  }) {
    return GameSave(
      id: id ?? this.id,
      date: date ?? this.date,
      gameList: gameList ?? this.gameList,
      undoStack: undoStack ?? this.undoStack,
      redoStack: redoStack ?? this.redoStack,
    );
  }

  /// HANDLING UNDO,REDO AND SAVING THE STATE

  void undo() {
    if (undoStack.isEmpty) return;
    final previousState = undoStack.removeLast();
    redoStack.add(ControllerMemento(gameList.copy()));
    gameList = previousState.getSavedState();
  }

  void redo() {
    if (redoStack.isEmpty) return;
    final nextState = redoStack.removeLast();
    undoStack.add(ControllerMemento(gameList.copy()));
    gameList = nextState.getSavedState();
  }

  void saveState(GameControllerList state) {
    undoStack.add(ControllerMemento(state.copy()));
    redoStack.clear();
  }

  ///For SAVE LOAD THE GAME

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date,
    'gameList': gameList.toJson(),
    'undoStack': undoStack.map((memento) => memento.toJson()).toList(),
    'redoStack': redoStack.map((memento) => memento.toJson()).toList(),
  };

  factory GameSave.fromJson(Map<String, dynamic> json) => GameSave(
    id: json['id'],
    date: json['date'],
    gameList: GameControllerList.fromJson(json['gameList']),
    undoStack:
        (json['undoStack'] as List)
            .map((m) => ControllerMemento.fromJson(m))
            .toList(),
    redoStack:
        (json['redoStack'] as List)
            .map((m) => ControllerMemento.fromJson(m))
            .toList(),
  );

}
