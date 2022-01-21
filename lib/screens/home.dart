import 'package:flutter/material.dart';

import 'package:etransact_vendor/model/sidebar.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String title = "eTransact";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child: Text('Home '),
      ),
      drawer: NavigateDrawer(uid: widget.uid),
    );
  }
}
