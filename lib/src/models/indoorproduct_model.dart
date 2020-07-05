import 'package:flutter/material.dart';
import 'package:tido_herbz/src/pages/indoorproduct_details.dart';

class IndoorSingle_Prod extends StatelessWidget {
  final String prod_name;
  final String prod_picture;
  final int prod_1g;
  final int prod_2g;
  final String prod_description;

  IndoorSingle_Prod({
    this.prod_name,
    this.prod_picture,
    this.prod_1g,
    this.prod_2g,
    this.prod_description
  });

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
                    builder: (context) => IndoorProductDetails(
                          product_detail_name: prod_name,
                          product_detail_price: prod_1g,
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
                        Text("R$prod_1g 1g|",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(
                          width: 2.0,
                        ),
                        Text("R$prod_2g 2g",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
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
