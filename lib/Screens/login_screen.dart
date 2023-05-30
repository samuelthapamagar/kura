import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kura/Screens/chat_screen.dart';
import 'package:kura/Screens/register_screen.dart';
import '../Components/rounded_rectangular_button.dart';
import '../constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  void login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailTextController.text.trim(),
        password: _passwordTextController.text.trim(),
      );
      // Navigator.pushNamed(context, ChatScreen.id);
    } catch (e) {
      print('Error is : ' + e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
  }

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
              Flexible(
                flex: 2,
                child: Image.asset('assets/images/logo_1.png'),
              ),
              Center(
                  child: Text('Kura !',
                      style: GoogleFonts.bebasNeue(fontSize: 55))),
              const SizedBox(height: 20),
              Text('Login',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
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
                      controller: _emailTextController,
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
                      controller: _passwordTextController,
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
              RoundedRectangularButton(
                title: 'Login',
                onPressed: login,
              ),
              const Flexible(
                  child: SizedBox(
                height: 200,
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(fontSize: 15),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        // RegisterScreen.id,
                        PageTransition(
                            duration: const Duration(milliseconds: 250),
                            type: PageTransitionType.rightToLeft,
                            child: RegisterScreen()),
                      );
                    },
                    child: const Text('  Register',
                        style: TextStyle(
                            color: kPrimaryColor,
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
