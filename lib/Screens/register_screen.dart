import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kura/Screens/login_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../Components/rounded_rectangular_button.dart';
import '../constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static String id = 'register_screen';
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(child: Image.asset('assets/images/logo_1.png')),
              const SizedBox(height: 50),
              const Text('Register',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
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
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'Email ID'),
                    ),
                  ),
                ],
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    FontAwesomeIcons.lock,
                    size: 20,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  Expanded(
                    child: TextField(
                      obscureText: obscureText,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Password',
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              child: Icon(obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              const RoundedRectangularButton(title: 'Register'),
              const Flexible(
                  child: SizedBox(
                height: 200,
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(fontSize: 15),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: LoginScreen(),
                              type: PageTransitionType.leftToRight,
                              duration: const Duration(milliseconds: 250)));
                    },
                    child: const Text('  Login',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
