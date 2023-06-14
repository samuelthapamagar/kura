import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kura/Screens/chat_screen.dart';
import 'package:kura/Screens/login_screen.dart';
import 'package:page_transition/page_transition.dart';
import '../Components/next_screen.dart';
import '../Components/rounded_rectangular_button.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../helper/user_login_status.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static String id = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  bool passwordObscureText = true;
  bool confirmPasswordobscureText = true;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  void register() async {
    if (passwordConfirmed()) {
      try {
        await _auth.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
        addUserDetails(_firstNameController.text.trim(),
            _lastNameController.text.trim(), _emailController.text.trim());
        await UserLoginStatus.saveUserLoggedInStatus(true);
        await UserLoginStatus.saveUserEmailSF(_emailController.text.trim());
        if (context.mounted) nextScreenReplace(context, ChatScreen());
      } catch (e) {
        print('Error is : ' + e.toString());
      }
    } else {
      print('Password don\'t match');
    }
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  Future addUserDetails(String firstName, String lastName, String email) async {
    await _firestore.collection('users').add({
      'first name': firstName,
      'last name': lastName,
      'email': email,
    });
  }

  @override
  void dispose() {
    _confirmPasswordController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
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
              Flexible(child: Image.asset('assets/images/logo_1.png')),
              Flexible(
                child: Center(
                    child: Text('Kura !',
                        style: GoogleFonts.bebasNeue(fontSize: 55))),
              ),
              const SizedBox(height: 20),
              Text('Register',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Row(
                // First name
                children: [
                  Icon(
                    Icons.person,
                    size: 20,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _firstNameController,
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'First Name'),
                    ),
                  ),
                ],
              ),
              Row(
                // Last name
                children: [
                  Icon(
                    Icons.person,
                    size: 20,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _lastNameController,
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'Last Name'),
                    ),
                  ),
                ],
              ),
              Row(
                // Email
                children: [
                  Icon(
                    FontAwesomeIcons.at,
                    size: 20,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _emailController,
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'Email ID'),
                    ),
                  ),
                ],
              ),
              Row(
                //Password
                children: [
                  Icon(
                    FontAwesomeIcons.lock,
                    size: 20,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _passwordController,
                      obscureText: passwordObscureText,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Password',
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  passwordObscureText = !passwordObscureText;
                                });
                              },
                              child: Icon(passwordObscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                    ),
                  ),
                ],
              ),
              Row(
                //confirm password
                children: [
                  Icon(
                    FontAwesomeIcons.lock,
                    size: 20,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _confirmPasswordController,
                      obscureText: confirmPasswordobscureText,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Confirm Password',
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  confirmPasswordobscureText =
                                      !confirmPasswordobscureText;
                                });
                              },
                              child: Icon(confirmPasswordobscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              RoundedRectangularButton(
                title: 'Register',
                onPressed: register,
              ),
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
