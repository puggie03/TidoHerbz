import 'package:flutter/material.dart';
import 'package:tido_herbz/src/pages/notificationspage.dart';

class HomeTopInfo extends StatelessWidget {
  bool isNotified;
  String notifybody;
  String notifytitle;
  HomeTopInfo(String title,String message) {
    if (message == '') {
      isNotified = false;
    } else {
      isNotified = true;
      notifybody = message;
      notifytitle = title;
    }
  }

  final textStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Which flight", style: textStyle),
              Text("would you like to take?", style: textStyle)
            ], //Widget[]
          ),
          isNotified
              ? //Column
              new IconButton(
                  icon: Icon(
                    Icons.notifications,
                    size: 30.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (BuildContext context, _, __) =>
                            NotificationsPage(
                              title: notifytitle,
                              body: notifybody,
                            )));
                  },
                )
              : IconButton(
                  icon: Icon(
                    Icons.notifications_none,
                    size: 30.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    if (notifybody == null) {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (BuildContext context, _, __) =>
                              NotificationsPage(
                                body: notifybody,
                              )));
                    }
                  },
                )
        ], 
      ),
    ); 
  }
}
