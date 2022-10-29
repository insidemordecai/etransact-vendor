// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../constants.dart';
import 'package:etransact_vendor/screens/landing_page.dart';

class NavigateDrawer extends StatefulWidget {
  final String uid;
  const NavigateDrawer({Key? key, required this.uid}) : super(key: key);

  @override
  _NavigateDrawerState createState() => _NavigateDrawerState();
}

class _NavigateDrawerState extends State<NavigateDrawer> {
  DatabaseReference dbRef = FirebaseDatabase.instance
      .reference()
      .child("Vendors"); // get vendors data

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        // padding: EdgeInsets.zero, - it was this if parent was list view
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: FutureBuilder(
                future: dbRef.child(widget.uid).once(),
                builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data!.value['email'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator(
                      color: Colors.white10,
                    );
                  }
                }),
            accountName: FutureBuilder(
                future: dbRef.child(widget.uid).once(),
                builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data!.value['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator(
                      color: Colors.white10,
                    );
                  }
                }),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.home_rounded,
                      color: Colors.black,
                    ),
                    minLeadingWidth: 20,
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.receipt_rounded,
                      color: Colors.black,
                    ),
                    minLeadingWidth: 20,
                    title: const Text('QuickBill'),
                    onTap: () {
                      html.window.open(
                          'https://punitgr.github.io/QuickBill/',
                          "_blank");
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: kRoundedBorder,
                fixedSize: const Size(250, 30),
              ),
              onPressed: () {
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut().then((res) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LandingPage()),
                      (Route<dynamic> route) => false);
                });
              },
              child: const Text('Log Out'),
            ),
          ),
        ],
      ),
    );
  }
}
