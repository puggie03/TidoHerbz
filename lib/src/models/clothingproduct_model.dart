import 'package:flutter/material.dart';
import 'package:tido_herbz/src/pages/capsproduct_details.dart';
import 'package:tido_herbz/src/pages/clothingproduct_details.dart';

class ClothingSingle_Prod extends StatelessWidget {
  final String prod_name;
  final String prod_picture;
  final int prod_price;
  final String prod_description;

  ClothingSingle_Prod(
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
              if (prod_name == "TH Suede Caps" ||
                  prod_name == "TH Brown Suede Cap" ||
                  prod_name == "TidoHerbz Cap" ||
                  prod_name == "TidoHerbz Beanie") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      //passing values of cap product to product details page
                      builder: (context) => CapsProductDetails(
                            product_detail_name: prod_name,
                            product_detail_price: prod_price,
                            product_detail_picture: prod_picture,
                            product_detail_description: prod_description,
                          )),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      //passing values of clothing product to product details page
                      builder: (context) => ClothingProductDetails(
                            product_detail_name: prod_name,
                            product_detail_price: prod_price,
                            product_detail_picture: prod_picture,
                            product_detail_description: prod_description,
                          )),
                );
              }
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
                    FittedBox(
                      child: Text(
                        prod_name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text("R$prod_price each",
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
