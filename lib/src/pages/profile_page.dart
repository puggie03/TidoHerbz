import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tido_herbz/src/pages/signin_page.dart';
import 'package:tido_herbz/src/widgets/favorite_card.dart';
import 'package:tido_herbz/src/widgets/order_card.dart';
import 'order_page.dart';

//Firebase
import 'package:firebase_auth/firebase_auth.dart';

//String useremail, name, phonenumber;
TextEditingController _email = new TextEditingController();
TextEditingController _name = new TextEditingController();
TextEditingController _phonenumber = new TextEditingController();

class ProfilePage extends StatefulWidget {
  //const ProfilePage({Key key, this.user}) : super(key: key);
  //final FirebaseUser user;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;

  OrderPage orderPage = new OrderPage();

  bool _loader = true;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    FirebaseUser user = await firebaseAuth.currentUser();

    firestore
        .collection("users")
        .document(user.uid)
        .get()
        .then((DocumentSnapshot result) => {
              setState(() {
                _email.text = result["email"];
                _name.text = result["name"];
                _phonenumber.text = result["phonenumber"];
                _loader = false;
              }),
            });
  }

  void signOut() async {
    items.clear();
    faves.clear();
    orderPage.resetCartTotal();
    await firebaseAuth.signOut();
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => SignInPage()));
  }

  void editProfile(_email, _name, _phonenumber) async {
    FirebaseUser user = await firebaseAuth.currentUser();

    if (user.email != _email) {
      try {
        user.updateEmail(_email);
        //user.sendEmailVerification();
        //print("verified: "+user.isEmailVerified.toString());

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
    }
    firestore.collection("users").document(user.uid).updateData({
      "email": _email,
      "name": _name,
      "phonenumber": _phonenumber,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          new IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).push(PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (BuildContext context, _, __) => OrderPage()));
            },
          )
        ],
      ),
      body: _loader
          ? Center(
              child: SpinKitWave(
                color: Colors.grey,
                size: 50.0,
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        "Email",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  //Row(
                  // children: <Widget>[
                  TextField(
                    controller: _email,
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  // ],
                  //),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Text(
                        "Name",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  //Row(
                  //children: <Widget>[
                  TextField(
                    controller: _name,
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  //],
                  //),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Text(
                        "Phone Number",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  //Row(
                  //children: <Widget>[
                  TextField(
                    controller: _phonenumber,
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  // ],
                  //),
                  SizedBox(height: 20.0),
                  ButtonTheme(
                    minWidth: 100.0,
                    child: RaisedButton(
                      onPressed: () {
                        editProfile(_email.text, _name.text, _phonenumber.text);
                        return showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Success'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text('Your details have been updated'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        'Update',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 100.0,
                    child: RaisedButton(
                      onPressed: () {
                        signOut();
                      },
                      child: Text(
                        'Sign Out',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
