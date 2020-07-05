import 'package:flutter/material.dart';
import 'signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tido_herbz/db/users.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

//use to add add profile,edit profile etc
//final FirebaseDatabase database = FirebaseDatabase.instance;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _toggleVisibility = true;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  UserServices _userServices = UserServices();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name, _email, _password, _phonenumber;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 100.0,
                ),
                Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Please enter a name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Name',
                            hintStyle: TextStyle(
                              color: Color(0xFFBDC2CB),
                              fontSize: 18.0,
                            ),
                          ),
                          onSaved: (input) => _name = input,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Please enter an email address';
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintStyle: TextStyle(
                              color: Color(0xFFBDC2CB),
                              fontSize: 18.0,
                            ),
                          ),
                          onSaved: (input) => _email = input,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Please enter your cellphone number';
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Cellphone Number',
                            hintStyle: TextStyle(
                              color: Color(0xFFBDC2CB),
                              fontSize: 18.0,
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (input) => _phonenumber = input,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          validator: (input) {
                            if (input.length < 6) {
                              return 'Your password needs to be atleast 6 characters long';
                            } else if (input.isEmpty) {
                              return 'Please enter a password';
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintStyle: TextStyle(
                              color: Color(0xFFBDC2CB),
                              fontSize: 18.0,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _toggleVisibility = !_toggleVisibility;
                                });
                              },
                              icon: _toggleVisibility
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                            ),
                          ),
                          onSaved: (input) => _password = input,
                          obscureText: _toggleVisibility,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        /*TextFormField(
                          validator: (input) {
                            if (input.length < 6) {
                              return 'Your password needs to be atleast 6 characters long';
                            } else if (input.isEmpty) {
                              return 'Please enter a password';
                            } else if (_password != input) {
                              return 'The passwords do not match';
                            }else
                              return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            hintStyle: TextStyle(
                              color: Color(0xFFBDC2CB),
                              fontSize: 18.0,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _toggleConfirmVisibility =
                                      !_toggleConfirmVisibility;
                                });
                              },
                              icon: _toggleConfirmVisibility
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                            ),
                          ),
                          onSaved: (input) => _confirmpassword = input,
                          obscureText: _toggleConfirmVisibility,
                        ),*/
                      ],
                    ),
                  ),
                ),
                ButtonTheme(
                  minWidth: 200.0,
                  child: RaisedButton(
                    onPressed: () async {
                      signUp();
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                Divider(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                          color: Color(0xFFBDC2CB),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => SignInPage()));
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Not for Persons Under the Age of 18.",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Future<void> signUp() async {
    FormState formState = _formKey.currentState;
    if (formState.validate()) {
      Firestore firestore = Firestore.instance;
      formState.save();
      try {
        AuthResult user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email.trim(), password: _password.trim());
        user.user.sendEmailVerification();
        firestore.collection("users").document(user.user.uid).setData({
          "favorites": FieldValue.arrayUnion([]),
          "email": _email,
          "name": _name,
          "phonenumber": _phonenumber,

        });
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => SignInPage()));
        //Navigate to Payment Screen
      } catch (e) {
        print(e.message);
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(e.message),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Try Again'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Please enter valid details'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Try Again'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
