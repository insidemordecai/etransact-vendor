//largely based on https://github.com/itsmordecai/flash-chat/blob/master/lib/screens/login_screen.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'home.dart';
import 'package:etransact_vendor/constants.dart';
import 'package:etransact_vendor/model/palette.dart';

class LogIn extends StatefulWidget {
  static const String id = 'login';

  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final String title = 'eTransact';
  final String subTitle = 'Vendor';

  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SizedBox(
              width: 500.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                            fontFamily: 'Roboto'),
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Text(
                        subTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          fontFamily: 'Roboto',
                          color: Palette.kTeal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email',
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password',
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: kRoundedBorder,
                      fixedSize: kFixedSize,
                    ),
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        await _auth.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        User? loggedUser = FirebaseAuth.instance.currentUser;
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Home(uid: loggedUser!.uid)),
                            (Route<dynamic> route) => false);
                        setState(() {
                          showSpinner = false;
                        });
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          setState(() {
                            showSpinner = false;
                          });

                          kShowToast(
                              'No user found for that email. Re-enter credentials');
                        } else if (e.code == 'wrong-password') {
                          setState(() {
                            showSpinner = false;
                          });

                          kShowToast('Wrong password. Re-enter credentials');
                        } else {
                          setState(() {
                            showSpinner = false;
                          });

                          kShowToast('Error. Try again!');
                        }
                      }
                    },
                    child: const Text('Log In'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
