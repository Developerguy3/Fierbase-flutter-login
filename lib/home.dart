import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("home page"),
        ),
        body: Center(
          child: MaterialButton(
            onPressed: () async {await FirebaseAuth.instance.signOut();},
            child: Text("sign out"),
          ),
        ));
  }
}
