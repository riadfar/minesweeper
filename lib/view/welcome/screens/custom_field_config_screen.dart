import 'package:flutter/material.dart';

import '../../../logic/field_config.dart';
import '../../global_elements/custom_app_bar.dart';
import '../../global_elements/my_text_field.dart';
import '../../global_elements/custom_elevated_button.dart';
import 'game_mode_screen.dart';

class CustomFieldConfigScreen extends StatefulWidget {
  const CustomFieldConfigScreen({super.key});

  @override
  _CustomFieldConfigScreenState createState() => _CustomFieldConfigScreenState();
}

class _CustomFieldConfigScreenState extends State<CustomFieldConfigScreen> {
  final _formKey = GlobalKey<FormState>();
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();
  final _minesController = TextEditingController();

  @override
  void dispose() {
    _widthController.dispose();
    _heightController.dispose();
    _minesController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final config = FieldConfig(
        width: int.parse(_widthController.text),
        height: int.parse(_heightController.text),
        minesCount: int.parse(_minesController.text),
      );


      // Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GameModeScreen(config: config,)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: const Text("Custom Configuration",style: TextStyle(color: Colors.white),)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              MyTextField(
                concept: "Width",
                hint: "Enter field width.",
                controller: _widthController,
                name: false,
              ),
              const SizedBox(height: 16),
              MyTextField(
                concept: "Height",
                hint: "Enter field height ",
                controller: _heightController,
                name: false,
              ),
              const SizedBox(height: 16),
              MyTextField(
                controller: _minesController,
                concept: "Number of Mines",
                hint: "Enter number of mines ",
                name: false,
              ),
              const SizedBox(height: 32),
              CustomElevatedButton(
                child: const Text("Submit"),
                onPress: _submit, // Use local submit handler
              ),
            ],
          ),
        ),
      ),
    );
  }
}