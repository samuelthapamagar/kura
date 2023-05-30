import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kura/Screens/login_screen.dart';

import 'chat_screen.dart';

class MainScreen extends StatelessWidget {
  static String id = 'main_screen';
  MainScreen({Key? key}) : super(key: key);
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: _auth
            .authStateChanges(), //returns null if there is no user signed in and returns User if signed in
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const ChatScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
