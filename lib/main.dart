import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kura/Screens/main_screen.dart';
import 'Screens/login_screen.dart';
import 'package:kura/Screens/register_screen.dart';
import 'package:kura/Screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kura App',
      initialRoute: MainScreen.id,
      routes: {
        MainScreen.id: (context) => MainScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegisterScreen.id: (context) => const RegisterScreen(),
        ChatScreen.id: (context) => const ChatScreen(),
      },
    );
  }
}
