import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const YouTubeCloneApp());
}

class YouTubeCloneApp extends StatelessWidget {
  const YouTubeCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube Clone - Tugas UTS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF0000)),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const YouTubeLoginScreen(),
        '/register': (context) => const YouTubeRegisterScreen(),
        '/home': (context) => const YouTubeHomeScreen(),
      },
    );
  }
}
