import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';
import 'screens/home.dart';
import 'screens/landing_page.dart';
import 'screens/login.dart';
import 'screens/signup.dart';
import 'model/palette.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // check for already logged in user on start up
    User? loggedUser = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eTransact',
      theme: ThemeData(
        primarySwatch: Palette.kTeal,
      ),
      // if user is logged in go to home, if not -> landingpage
      home:
          loggedUser != null ? Home(uid: loggedUser.uid) : const LandingPage(),
      routes: {
        LandingPage.id: (context) => const LandingPage(),
        LogIn.id: (context) => const LogIn(),
        SignUp.id: (context) => const SignUp(),
      },
    );
  }
}
