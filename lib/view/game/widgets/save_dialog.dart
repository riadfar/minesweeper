import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/save_load/save_load_cubit.dart';
import '../../global_elements/custom_elevated_button.dart';
import '../../welcome/screens/welcome_screen.dart';
import '../../global_elements/my_text_field.dart';

class SaveDialog extends StatefulWidget {


  const SaveDialog({super.key});

  @override
  State<SaveDialog> createState() => _SaveDialogState();
}

class _SaveDialogState extends State<SaveDialog> {
  @override
  Widget build(BuildContext context) {
    TextEditingController gameNameTextController = TextEditingController();
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
              MyTextField(
                controller: gameNameTextController,
                concept: "",
                hint: "game name",
                name: true,
              ),
              SizedBox(height: 18),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomElevatedButton(
                    child: Text("Save"),
                    onPress: () {
                      print("-----------------------------------");
                      print(gameNameTextController.text);
                      print("-----------------------------------");
                      SaveLoadCubit saveCubit =context.read<SaveLoadCubit>();
                      saveCubit.saveGame(gameNameTextController.text);

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
