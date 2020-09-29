import 'package:flutter/material.dart';
import 'package:tido_herbz/src/pages/find_locationpage.dart';
import 'order_page.dart';

class PaymentPage extends StatefulWidget {
  final cartpay_prod_price;

  PaymentPage(
      {this.cartpay_prod_price,});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _currentIndex = "Cash on Delivery";

  List<String> _texts = [
    "Cash on Delivery",
    "Card on Delivery",
    "Online Payment"
  ];
  @override
  Widget build(BuildContext context) {
    //print("pay: " + widget.cartpay_prod_price.toString());
    return Scaffold(
      appBar: AppBar(
        //title: Text('Payment ${widget.user.email}'),
        leading: BackButton(color: Colors.black),
        title: Text(
          "Payment Options",
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
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: _texts
            .map((text) => RadioListTile(
                  groupValue: _currentIndex,
                  title: Text(text),
                  value: text,
                  onChanged: (val) {
                    setState(() {
                      _currentIndex = val;
                    });
                  },
                ))
            .toList(),
      ),
      bottomNavigationBar: _builTotalContainer(),
    );
  }

  Widget _builTotalContainer() {
    return Container(
      height: 220.0,
      margin: EdgeInsets.only(top: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "Amount",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              Spacer(),
              Text(
                "R" + widget.cartpay_prod_price.toString(),
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          GestureDetector(
            onTap: () {
              String method;
              if (_currentIndex == "Cash on Delivery") {
                method = "Cash on Delivery";
              } else if (_currentIndex == "Card on Delivery") {
                method = "Card on Delivery";
              } else if (_currentIndex == "Online Payment") {
                method = "Online Payment";
              }
              Navigator.of(context).push(PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (BuildContext context, _, __) =>
                      FindLocationPage(
                        subtotal: widget.cartpay_prod_price,
                        method: method,
                      )));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Center(
                child: Text(
                  "Next",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
