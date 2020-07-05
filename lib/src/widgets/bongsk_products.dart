import 'package:flutter/material.dart';
import 'package:tido_herbz/src/pages/order_page.dart';
import 'package:tido_herbz/src/screens/main_screen.dart';
import '../data/bongskproduct_data.dart';
import '../models/bongzkproduct_model.dart';

class BongsKProducts extends StatelessWidget {
  final List<BongsKSingle_Prod> _product_list = bongsProductlist;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/images/backgroundone.jpg"), // <-- BACKGROUND IMAGE
            fit: BoxFit.cover,
          ),
          color: Colors.white,
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: BackButton(color: Colors.black),
          title: Text(
            "Bongs&Grinders",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          backgroundColor: Colors.transparent,
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
            new IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderPage()),
                );
              },
            )
          ],
        ),
        body: GridView.builder(
            itemCount: bongsProductlist.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return BongsKSingle_Prod(
                prod_name: _product_list[index].prod_name,
                prod_picture: _product_list[index].prod_picture,
                prod_price: _product_list[index].prod_price,
                prod_description: _product_list[index].prod_description,
              );
            }),
      ),
    ]);
  }
}
