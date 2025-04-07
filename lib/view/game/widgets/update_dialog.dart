import 'package:flutter/material.dart';

import '../../../cubit/save_load/save_load_cubit.dart';
import '../../global_elements/custom_elevated_button.dart';
import '../../welcome/screens/welcome_screen.dart';

class UpdateDialog extends StatefulWidget {
  final SaveLoadCubit saveCubit;
  final int gameIndex;
  const UpdateDialog({super.key, required this.saveCubit, required this.gameIndex});

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Save The Game!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 32),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomElevatedButton(
                    child: Text("Save"),
                    onPress: () {
                      widget.saveCubit.updateGame(widget.gameIndex);

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomeScreen(),
                        ),
                            (Route<dynamic> route) => false,
                      );
                    },
                  ),
                  CustomElevatedButton(
                    child: Text("Cancel"),
                    onPress: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
