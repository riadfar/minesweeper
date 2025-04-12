import 'game_memento.dart';

class Undoable {
  ControllerMemento? state;
  List<ControllerMemento> undoStack = [];
  List<ControllerMemento> redoStack = [];

  void undo() {
    if (undoStack.isEmpty) return;
    final lastState = undoStack.removeLast();
    redoStack.add(state!);
    state = lastState.getSavedState();
  }

  void redo() {
    if (redoStack.isEmpty) return;
    final nextState = redoStack.removeLast();
    undoStack.add(state!);
    state = nextState.getSavedState();
  }

  void saveState(state) {
    undoStack.add(state);
    redoStack.clear();
   }

   void fillStacks(savedUndo,savedRedo){
    undoStack = savedUndo;
    redoStack = savedRedo;
   }
}
