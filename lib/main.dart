import 'package:flutter/material.dart';
import 'package:guess_turn/presentation/providers/game_provider.dart';
import 'package:guess_turn/presentation/screens/setup_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameProvider(),
      child: MaterialApp(
        title: 'GuessTurn',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const SetupScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}