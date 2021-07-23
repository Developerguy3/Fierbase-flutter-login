import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

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
  bool loginfail;
  final _formKey = GlobalKey<FormState>();

  void ontapfunction() {
    _createuser();
  }

  /*Future<void> login() async{
    final  formState = _formkey.currentState;
    if(formState.validate()){
      formState.save();
      try{

        final FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _username, password: _password)).user;
        if(!user.uid.isEmpty()){
         Navigator.push(context, MaterialPageRoute(builder: (context) => Admin()));
        }else{
         setState((){
           loginfail = true; //loginfail is bool
          });
        }

      }catch(e){
        print(e.message);
      }
    }*/
  Future<void> _createuser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: Email_id, password: Password);
      if (userCredential.user!.uid.isNotEmpty) {
      } else {
        setState(() {
          loginfail = true; //loginfail is bool
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
                    decoration: const InputDecoration(
                      labelText: "Email id",
                      hintText: "youremail@email.com",
                      errorText: loginfail ? "incorrect email id" : null,
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
                  height: 40,
                ),
                Container(
                  child: Center(
                    child: AnimatedButton(
                      height: 40,
                      width: 370,
                      text: 'SUBMIT',
                      isReverse: true,
                      enable: true,
                      selectedTextColor: Colors.blue,
                      transitionType: TransitionType.CENTER_ROUNDER,
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                      backgroundColor: Colors.blue,
                      borderColor: Colors.blueAccent,
                      borderRadius: 50,
                      borderWidth: 2,
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          animationornot = true;
                          ontapfunction();
                        } else {
                          animationornot = false;
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                    height: 40,
                    width: 370,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blue,
                              style: BorderStyle.solid,
                              width: 1),
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
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          )
                        ],
                      ),
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
