import 'package:flutter/material.dart';
import 'package:tido_herbz/src/pages/comboproduct_details.dart';
import '../pages/comboproduct_details.dart';

class ComboSingle_Prod extends StatelessWidget {
  final String prod_name;
  final String prod_picture;
  final int prod_price;
  final String prod_description;

  ComboSingle_Prod(
      {this.prod_name,
      this.prod_picture,
      this.prod_price,
      this.prod_description});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    //passing values of combo product to product details page
                    builder: (context) => ComboProductDetails(
                          product_detail_name: prod_name,
                          product_detail_price: prod_price,
                          product_detail_picture: prod_picture,
                          product_detail_description: prod_description,
                        )),
              );
            },
            child: Container(
              height: 200.0,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                prod_picture,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            bottom: 0.0,
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black, Colors.black12],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter)),
            ),
          ),
          Positioned(
            left: 10.0,
            bottom: 10.0,
            right: 10.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      prod_name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text("R$prod_price",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
