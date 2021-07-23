import 'package:fierbase_login/home.dart';
import 'package:fierbase_login/loginpage.dart';
import 'package:fierbase_login/scrap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: logincopy(),
    );
  }
}

class Lendpage extends StatelessWidget {
  //const lendpage({Key? key}) : super(key: key);

  final Future<FirebaseApp> initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Scaffold(
              body: Center(
                child: Text("error:${snapshot.error} "),
              ),
            );

          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  User? user = snapshot.data as User?;
                  if (user == null) {
                    return loginpage();
                  } else {
                    return Home();
                  }
                }
                return Scaffold(
                  body: Center(child: Text("hello")),
                );
              },
            );
          }
          return Scaffold(
            body: Center(
              child: Text("connecting to the app"),
            ),
          );
        });
  }
}
