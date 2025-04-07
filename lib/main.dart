import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'cubit/game/game_cubit.dart';
import 'cubit/save_load/save_load_cubit.dart';
import 'logic/game_save.dart';
import 'view/welcome/screens/welcome_screen.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return GameCubit(gameSave: GameSave.initial());
        }),
        BlocProvider(
          create:
              (context) => SaveLoadCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: WelcomeScreen(),
      ),
    );
  }
}
