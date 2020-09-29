import 'package:flutter/material.dart';

const htmlData = """ 
<!DOCTYPE html>
<html>
<body>

<h2>HTML Forms</h2>
<form action="https://sandbox.payfast.co.za/eng/process" method="POST">
  <input type="hidden" name="merchant_id" value="10000100">
  <input type="hidden" name="merchant_key" value="46f0cd694581a">
  <input type="hidden" name="return_url" value="https://www.yoursite.com/return">
  <input type="hidden" name="cancel_url" value="https://www.yoursite.com/cancel">
  <input type="hidden" name="notify_url" value="https://www.yoursite.com/notify">
</form>
</body>
</html>
 """;

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


  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('Online Payment')),
          body: Center(
            child: RaisedButton(
              child: Text('Proceed to Payment'),
              onPressed: (){
                
                }
            ),
          ),
        ),
      );
  /*Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Online Payment"),
      ),
      body: SingleChildScrollView(
        child: Html(
          data: htmlData,
          //Optional parameters:
          /*style: {
            "html": Style(
              backgroundColor: Colors.black12,
//              color: Colors.white,
            ),
          },*/
          customRender: {
            "flutter": (RenderContext context, Widget child, attributes, _) {
              return FlutterLogo(
                style: (attributes['horizontal'] != null)
                    ? FlutterLogoStyle.horizontal
                    : FlutterLogoStyle.markOnly,
                textColor: context.style.color,
                size: context.style.fontSize.size * 5,
              );
            },
          },
          onLinkTap: (url) {
            print("Opening $url...");
          },
          onImageTap: (src) {
            print(src);
          },
          onImageError: (exception, stackTrace) {
            print(exception);
          },
        ),
        ),
    );
  }*/
}
