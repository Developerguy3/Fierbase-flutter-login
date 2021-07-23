import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final _formKey = GlobalKey<FormState>();

  late bool wrongPassword;

  late bool wrongEmail;

  void popup(String a, String b) {
    Alert(
      context: context,
      type: AlertType.error,
      title: a,
      desc: b,
      buttons: [
        DialogButton(
          child: Text(
            "okay",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

  void ontapfunciton() {
    _createuser();
  }

  Future<void> _createuser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: Email_id, password: Password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'ERROR_WRONG_PASSWORD') {
        setState(() {
          wrongPassword = true;
        });
      } else {
        setState(() {
          var emailText = 'User doesn\'t exist';
          var passwordText = 'Please check your email';

          wrongPassword = true;
          wrongEmail = true;
        });
      }
    } catch (e) {
      print("error: $e");
    }
  }

  late String Email_id;
  late String Password;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 50),
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff0275d8)),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 90, left: 20, right: 20),
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      Email_id = value;
                    },
                    decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email id here',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey)),
                  ),
                  TextField(
                    onChanged: (value) {
                      Password = value;
                    },
                    decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password here',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey)),
                    obscureText: true,
                  )
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              height: 40,
              child: Material(
                borderRadius: BorderRadius.circular(20),
                shadowColor: Colors.blueAccent,
                color: Colors.blue,
                elevation: 7,
                child: GestureDetector(
                  onTap: ontapfunciton,
                  child: Center(
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
              width: 40,
            ),
            Container(
              height: 40,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.blue, style: BorderStyle.solid, width: 1),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: ImageIcon(
                        AssetImage('logos/gl.png'),
                        color: Colors.blue,
                      ),
                    ),
                    Center(
                      child: Text(
                        '     Log in with google',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
