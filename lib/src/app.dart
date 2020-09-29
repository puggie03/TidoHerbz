import 'package:flutter/material.dart';
import 'package:tido_herbz/src/pages/signin_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Tido Herbz",
      theme: ThemeData(primaryColor: Colors.blueAccent), //ThemeData
      home: SignInPage(),
    ); //MaterialApp
  }
}
