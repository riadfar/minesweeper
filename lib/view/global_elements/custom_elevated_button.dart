import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class CustomElevatedButton extends StatefulWidget {
  final Function() onPress;
  final Widget child;

  const CustomElevatedButton({
    super.key,
    required this.child,
    required this.onPress,
  });

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  final AudioPlayer _player = AudioPlayer();

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await _playSound();
        await Future.delayed(const Duration(milliseconds: 100));
        widget.onPress();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: widget.child,
    );
  }

  Future<void> _playSound() async {
    try {
      await _player.setAsset('assets/sounds/click_sound_2.mp3');
      await _player.play();
    } catch (e) {
      debugPrint("Error playing sound: $e");
    }
  }
}
