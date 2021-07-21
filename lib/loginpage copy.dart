import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class Loginpagecopy extends StatelessWidget {
  late String Email_id;
  late String Password;

  final _formKey = GlobalKey<FormState>();

  void ontapfunction() {
    _createuser();
  }

  Future<void> _createuser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: Email_id, password: Password);
    } on FirebaseAuthException catch (e) {
      print("error: $e");
    } catch (e) {
      print("error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: AppBar(
            flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'The Mma',
                  style: TextStyle(fontSize: 50),
                )
              ],
            ),
          ),
        )),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Center(
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                    ),
                  ))
            ],
          )),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: TextFormField(
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email id';
                      } else {
                        Email_id = value;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: TextFormField(
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      } else {
                        Password = value;
                      }
                      return null;
                    },
                  ),
                ),
                Spacer(),
                Container(
                  child: Center(
                    child: AnimatedButton(
                      height: 40,
                      width: 370,
                      text: 'SUBMIT',
                      isReverse: true,
                      selectedTextColor: Colors.black,
                      transitionType: TransitionType.CENTER_ROUNDER,
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                      backgroundColor: Colors.blue,
                      borderColor: Colors.blueAccent,
                      borderRadius: 50,
                      borderWidth: 2,
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          ontapfunction();
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
