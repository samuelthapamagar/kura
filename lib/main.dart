import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kura/helper/user_login_status.dart';
import 'Screens/login_screen.dart';
import 'package:kura/Screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await UserLoginStatus.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("signed in status : $_isSignedIn");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kura App',
      home: _isSignedIn ? const ChatScreen() : const LoginScreen(),
    );
  }
}
