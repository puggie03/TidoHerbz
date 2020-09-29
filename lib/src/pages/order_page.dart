import 'package:flutter/material.dart';
import 'package:tido_herbz/src/pages/payment_page.dart';

import 'package:async/async.dart';
import 'package:tido_herbz/src/screens/main_screen.dart';

//Custom Widgets
import '../widgets/order_card.dart';

int cart_total = 0;

int discount = 0;

class OrderPage extends StatefulWidget {
  final cartpage_prod_name;
  final cartpage_prod_picture;
  final cartpage_prod_price;
  final cartpage_prod_size;
  final cartpage_prod_color;
  final cartpage_prod_strain;
  final cartpage_prod_gram;
  final cartpage_prod_quantity;
  final cartpage_prod_amount;

  @override
  _OrderPageState createState() => _OrderPageState();

  const OrderPage(
      {this.cartpage_prod_name,
      this.cartpage_prod_picture,
      this.cartpage_prod_price,
      this.cartpage_prod_size,
      this.cartpage_prod_color,
      this.cartpage_prod_strain,
      this.cartpage_prod_gram,
      this.cartpage_prod_quantity,
      this.cartpage_prod_amount});

  calculateTotal(int _amount) {
    cart_total += _amount;
  }

  setCartTotal(int itemPrice) {
    cart_total -= itemPrice;
  }

  resetCartTotal() {
    cart_total = 0;
  }
}

class _OrderPageState extends State<OrderPage> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  @override
  Widget build(BuildContext context) {
    this._memoizer.runOnce(() async {
      if (widget.cartpage_prod_name != null) {
        items.add(widget);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Items Cart",
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
          if (items.length == 0)
            Card(
              child: Center(
                child: Text(
                  "There are currently no items in the cart",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          if (items.length == 0)
            Container(
              child: Center(
                child: ButtonTheme(
                  minWidth: 100.0,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) =>
                              MainScreen()));
                    },
                    child: Text(
                      'Browse',
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
              ),
            ),
          if (items.length > 0)
            for (var item in items)
              OrderCard(
                cart_prod_name: item.cartpage_prod_name,
                cart_prod_price: item.cartpage_prod_price,
                cart_prod_picture: item.cartpage_prod_picture,
                cart_prod_color: item.cartpage_prod_color,
                cart_prod_gram: item.cartpage_prod_gram,
                cart_prod_size: item.cartpage_prod_size,
                cart_prod_strain: item.cartpage_prod_strain,
              ),
        ],
      ),
      bottomNavigationBar: _builTotalContainer(),
    );
  }

  int getTotalValue() {
    cart_total -= discount;
    return cart_total;
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
                "Cart Total",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              Spacer(),
              Text(
                "R" + getTotalValue().toString(),
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              Text(
                "Discount",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              Spacer(),
              Text(
                "R"+discount.toString(),
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              Text(
                "Vat",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              Spacer(),
              Text(
                "0%",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
          Divider(
            height: 40.0,
            color: Color(0xFFD3D3D3),
          ),
          Row(
            children: <Widget>[
              Text(
                "Sub Total",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              Spacer(),
              Text(
                "R" + getTotalValue().toString(),
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
              if (getTotalValue() == 0) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return new AlertDialog(
                        title: new Text("Error"),
                        content: new Text("Cart is empty, please add items!"),
                        actions: <Widget>[
                          new MaterialButton(
                            onPressed: () {
                              Navigator.of(context).pop(context);
                            },
                            child: new Text("close"),
                          )
                        ],
                      );
                    });
              } else {
                Navigator.of(context).push(PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (BuildContext context, _, __) => PaymentPage(
                          cartpay_prod_price: getTotalValue(),
                        )));
              }
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
                  "Proceed to checkout",
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
