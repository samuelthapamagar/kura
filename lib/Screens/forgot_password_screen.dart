import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Components/rounded_rectangular_button.dart';
import '../constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String id = 'forgot_password_screen';
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _forgotPasswordTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    super.dispose();
    _forgotPasswordTextController.dispose();
  }

  Future resetPassword() async {
    try {
      await _auth.sendPasswordResetEmail(
          email: _forgotPasswordTextController.text.trim());
      if (mounted) {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content:
                    Text('Password reset link sent. Please Check your email.'),
              );
            });
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset('assets/images/logo_1.png')),
                SizedBox(height: 50),
                Text(
                  'Forgot\nPassword?',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  'Enter your email and we will send you a password reset link.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                      FontAwesomeIcons.at,
                      size: 20,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _forgotPasswordTextController,
                        decoration:
                            kTextFieldDecoration.copyWith(hintText: 'Email ID'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                RoundedRectangularButton(
                  title: 'Submit',
                  onPressed: resetPassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
