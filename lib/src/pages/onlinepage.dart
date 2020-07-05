import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const URL = "https://sandbox.payfast.co.za/eng/process?merchant_id=10016051&merchant_key=sdyya9iok9o1t&amount=150&item_name=Rubber+Pipe";

class OnlinePage extends StatefulWidget {
  @override
  _OnlinePageState createState() => _OnlinePageState();
}

class _OnlinePageState extends State<OnlinePage> {
  @override
  void initState()
  {
    super.initState();
    
  }

  Future launchURL(String url) async{
    if(await canLaunch(url)){
      await launch(url, forceSafariVC: true, forceWebView: true);
    }
    else{
      print("Can't Launch ${url}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebView"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(URL),
            ),
            RaisedButton(
              child: Text("Open Link"),
              onPressed: () {
                launchURL(URL);
              },
              )
          ],
          )
        ),
    );
  }
}
