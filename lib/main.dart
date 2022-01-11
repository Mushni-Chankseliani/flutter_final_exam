import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/presentation/screens/auth_screen.dart';
import 'package:todo_app/presentation/screens/home_screen.dart';

import 'provider/todo_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => TodoProvider())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const AuthScreen(),
      routes: {
        AuthScreen.route: (_) => const AuthScreen(),
        HomeScreen.route: (_) => const HomeScreen(),
      },
    );
  }
}
