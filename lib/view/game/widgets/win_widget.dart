import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../../global_elements/custom_elevated_button.dart';


class WinWidget extends StatelessWidget {
  final VoidCallback onNewGame;
  final VoidCallback backToMenu;


  const WinWidget(
      {super.key, required this.onNewGame, required this.backToMenu});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 24, 18, 24),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.emoji_events_rounded,
              size: 64,
              color: AppColor.primary,
            ),
            const SizedBox(height: 24),
            Text(
              "You Win!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColor.grey5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Congratulations! You've cleared all\nsafe blocks successfully!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppColor.grey3,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton(
                  onPress: onNewGame,
                  child: const Text("Play Again"),
                ),
                SizedBox(width: 12),
                CustomElevatedButton(
                  onPress: backToMenu,
                  child: const Text("Main menu"),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}