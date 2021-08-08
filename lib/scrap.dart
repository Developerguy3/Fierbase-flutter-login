import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class logincopy extends StatefulWidget {
  const logincopy({Key? key}) : super(key: key);

  @override
  _logincopyState createState() => _logincopyState();
}

class _logincopyState extends State<logincopy>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  late String Email_id;
  late String Password;
  bool _isObscure = true;
  bool animationornot = false;

  //var buttnenable = AnimationController();
  final _formKey = GlobalKey<FormState>();

  void ontapfunction() {
    _createuser();
  }

  Future<void> _createuser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: Email_id, password: Password);
      if (userCredential.user!.uid.isNotEmpty) {
      } else {
        setState(() {
          // loginfail = true; //loginfail is bool
        });
      }
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
                    decoration: InputDecoration(
                      labelText: "Email id",
                      hintText: "youremail@email.com",
                      // errorText: loginfail ? "incorrect email id" : null,
                    ),
                    // The validator receives the text that the user has entered.
                    onChanged: (value) {
                      if (_formKey.currentState!.validate()) {
                        animationornot = true;
                      }
                    },
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty && !value.contains("@")) {
                        return 'Please enter valid email id';
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
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        //errorText: loginfail ? "incorrect email id" : null,
                        suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            })),
                    onChanged: (value) {
                      if (_formKey.currentState!.validate()) {
                        animationornot = true;
                      }
                    },
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
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("FP"),
                    ],
                  ),
                ),
                /* Container(
                    padding: EdgeInsets.only(right: 20),
                    child: Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Forgot Password?"),
                        GestureDetector(
                          onTap: () {
                            print("clicked on forgot password");
                          },
                        )
                      ],
                    )),*/
                /*Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Forgot Password?"),
                      GestureDetector(
                        onTap: () {},
                      )
                    ],
                  ),
                ),*/
                SizedBox(
                  height: 40,
                ),
                Container(
                    child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        animationornot = true;
                        ontapfunction();
                      } else {
                        animationornot = false;
                      }
                    },
                    child: Text("Sign in"),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        minimumSize: Size(350, 40)),
                  ),
                )),
                SizedBox(
                  height: 20,
                ),
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: ImageIcon(
                        AssetImage('logos/gl.png'),
                        color: Colors.blue,
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: Size(350, 40),
                          side: BorderSide(width: 1, color: Colors.blue),
                          primary: Colors.transparent,
                          onSurface: Colors.transparent,
                          shadowColor: Colors.grey.shade50),
                      label: Text(
                        "Sign in with google",
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                )),
              ],
            ),
          )
        ],
      )),
    );
  }
}
