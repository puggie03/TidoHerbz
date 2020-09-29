import 'package:flutter/material.dart';

import 'package:tido_herbz/src/screens/main_screen.dart';


class NotificationsPage extends StatefulWidget {
  final body;
  final picture;
  final title;

  @override
  _NotificationsPageState createState() => _NotificationsPageState();

  const NotificationsPage({this.title, this.body, this.picture});
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          "Your Notifications",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          new IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        scrollDirection: Axis.vertical,
        children: <Widget>[
          if (widget.body == null)
            Card(
              child: Center(
                child: Text(
                  "You currently have no new notifications",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          if (widget.body != null)
            Card(
              child: Center(
                child: Row(
                  children: <Widget>[
                    Text(
                      widget.title+":\n",
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.body,
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
