import 'dart:io';
import 'field_config.dart';
import 'game_controller.dart';

void main() {
  print("Welcome to Minesweeper!");

  print("Enter field width:");
  int width = int.parse(stdin.readLineSync()!);
  print("Enter field height:");
  int height = int.parse(stdin.readLineSync()!);
  print("Enter number of mines:");
  int minesCount = int.parse(stdin.readLineSync()!);

  final config = FieldConfig(
    width: width,
    height: height,
    minesCount: minesCount,
  );


  print("Choose game mode:");
  print("1 - Single Player");
  print("2 - Two Players");
  print("3 - vs Computer");
  final modeChoice = int.parse(stdin.readLineSync()!);
  final mode = GameMode.values[modeChoice - 1];


  final controller = GameController(
    mode: mode,
    config: config,
  );


  controller.game.printGame();

  while (controller.game.isRunning) {
    final currentPlayer = controller.players[controller.currentPlayerIndex];

    if (currentPlayer.isComputer) {
      print("\n${currentPlayer.name}'s turn...");
      controller.handleComputerMove();
      controller.game.printGame();
    } else {
      print("\n${currentPlayer.name}'s turn (Score: ${currentPlayer.score})");
      print("Enter coordinates and action (X Y [R/F]):");
      final input = stdin.readLineSync()?.split(' ') ?? [];

      try {
        final x = int.parse(input[0]);
        final y = int.parse(input[1]);
        final action = input.length > 2 ? input[2].toUpperCase() : 'R';

        controller.handleMove(
          x,
          y,
          isFlag: action == 'F',
        );

        controller.game.printGame();
      } catch (e) {
        print("Invalid input. Use format: X Y [R/F]");
      }
    }

  }

  print("Game over!");
}