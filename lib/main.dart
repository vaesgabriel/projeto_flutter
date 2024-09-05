import 'package:flutter/material.dart';
import 'package:meuapp/view/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(



        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.deepPurple),
            foregroundColor: WidgetStatePropertyAll(Colors.white)
          ) ),

        colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple, 
        primary: Colors.deepPurple,
         ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

