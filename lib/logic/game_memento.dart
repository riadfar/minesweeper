import 'game_controller_list.dart';

class ControllerMemento {
  final GameControllerList _state;

  ControllerMemento(this._state);

  GameControllerList getSavedState() => _state.copy();

  ///FOR SAVE AND LOAD THE GAME

  Map<String, dynamic> toJson() => {"state": _state.toJson()};

  factory ControllerMemento.fromJson(Map<String, dynamic> json) =>
      ControllerMemento(GameControllerList.fromJson(json['state']));
}
