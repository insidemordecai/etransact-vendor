import 'package:etransact_vendor/model/palette.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import 'signup.dart';
import 'package:etransact_vendor/constants.dart';

class LandingPage extends StatelessWidget {
  final String title = 'eTransact';
  final String subTitle = 'Vendor';
  static const String id = 'landing_page';

  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
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
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: kRoundedBorder,
                    fixedSize: kFixedSize,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  },
                  child: const Text('Create Account'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: kRoundedBorder,
                    fixedSize: kFixedSize,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LogIn()),
                    );
                  },
                  child: const Text('Log In'),
                ),
              ),
            ]),
      ),
    );
  }
}
