import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kura/Components/rounded_rectangular_button.dart';
import 'package:kura/Screens/login_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static String id = 'chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Chat Screen : Signed in as ${_auth.currentUser?.email}',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              RoundedRectangularButton(
                title: 'Sign Out',
                onPressed: () async {
                  try {
                    // Navigator.pushNamed(context, LoginScreen.id);
                    if (_auth.currentUser != null) {
                      await _auth
                          .signOut(); //don't need navigator because of the condition in MainScreen
                      // Navigator.pushNamed(context, LoginScreen.id);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
