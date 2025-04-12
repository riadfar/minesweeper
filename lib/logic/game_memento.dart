
import 'game_controller_list.dart';

class ControllerMemento implements Memento {

  @override
  final dynamic state;

  ControllerMemento(this.state);

  @override
  dynamic getSavedState() => state.copy();

  ///FOR SAVE AND LOAD THE GAME
  Map<String, dynamic> toJson() => {"state": state.toJson()};

  factory ControllerMemento.fromJson(Map<String, dynamic> json) =>
      ControllerMemento(GameControllerList.fromJson(json['state']));
}

abstract class Memento {
  final dynamic state;

  Memento(this.state);

  dynamic getSavedState() => state.copy();

}
