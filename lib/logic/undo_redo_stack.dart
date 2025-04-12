// import 'game_memento.dart';
//
// class UndoRedoStack {
//   final List<ControllerMemento> undoStack;
//
//   final List<ControllerMemento> redoStack;
//
//   UndoRedoStack({required this.undoStack, required this.redoStack});
//
//   void execute(target) {
//     undoStack.add(target.saveState());
//     redoStack.clear();
//   }
//
//   void undo(target) {
//     if (undoStack.isEmpty) return;
//     redoStack.add(target.saveState());
//     target.restoreState(undoStack.removeLast());
//   }
//
//   void redo(target) {
//     if (redoStack.isEmpty) return;
//     undoStack.add(target.saveState());
//     target.restoreState(redoStack.removeLast());
//   }
//
//   Map<String, dynamic> toJson() => {
//     'undoStack': this.undoStack,
//     'redoStack': this.redoStack,
//   };
//
//   factory UndoRedoStack.fromJson(Map<String, dynamic> map) => UndoRedoStack(
//     undoStack: map['undoStack'] as List<ControllerMemento>,
//     redoStack: map['redoStack'] as List<ControllerMemento>,
//   );
// }
