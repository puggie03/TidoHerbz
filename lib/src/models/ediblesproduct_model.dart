import 'package:flutter/material.dart';
import 'package:tido_herbz/src/pages/ediblesproduct_details.dart';
import 'package:tido_herbz/src/pages/fudgeproduct_details.dart';
import 'package:tido_herbz/src/pages/lollipopsproduct_details.dart';
import 'package:tido_herbz/src/pages/muffinsproduct_details.dart';
import 'package:tido_herbz/src/pages/shroomsproduct_details.dart';

class EdiblesSingle_Prod extends StatelessWidget {
  final String prod_name;
  final String prod_picture;
  final int prod_price;
  final String prod_description;

  EdiblesSingle_Prod({
    this.prod_name,
    this.prod_picture,
    this.prod_price,
    this.prod_description
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: <Widget>[
          InkWell(
            onTap: () {
              if(prod_name == "Lollipops"){
                Navigator.push(
                context,
                MaterialPageRoute(
                    //passing values of combo product to product details page
                    builder: (context) => LollipopsProductDetails(
                          product_detail_name: prod_name,
                          product_detail_price: prod_price,
                          product_detail_picture: prod_picture,
                          product_detail_description: prod_description,
                          product_detail_100mg: 50,
                          product_detail_200mg: 60,
                          product_detail_300mg: 70,
                          product_detail_500mg: 100,
                        )),
                );
              }
              else if(prod_name == "Fudge"){
                Navigator.push(
                context,
                MaterialPageRoute(
                    //passing values of combo product to product details page
                    builder: (context) => FudgeProductDetails(
                          product_detail_name: prod_name,
                          product_detail_price: prod_price,
                          product_detail_picture: prod_picture,
                          product_detail_description: prod_description,
                          product_detail_100mg: 50,
                          product_detail_250mg: 70,
                          product_detail_350mg: 90,
                        )),
                );
              }
              else if(prod_name == "Brownies/Muffinz"){
                Navigator.push(
                context,
                MaterialPageRoute(
                    //passing values of combo product to product details page
                    builder: (context) => MuffinsProductDetails(
                          product_detail_name: prod_name,
                          product_detail_price: prod_price,
                          product_detail_picture: prod_picture,
                          product_detail_description: prod_description,
                          product_detail_200mg: 200,
                          product_detail_250mg: 250,
                          product_detail_300mg: 300,
                        )),
                );
              }
              else if(prod_name == "Shrooms"){
                Navigator.push(
                context,
                MaterialPageRoute(
                    //passing values of combo product to product details page
                    builder: (context) => ShroomsProductDetails(
                          product_detail_name: prod_name,
                          product_detail_price: prod_price,
                          product_detail_picture: prod_picture,
                          product_detail_description: prod_description,
                          product_detail_type1: "Penis Envy",
                          product_detail_type2: "Golden Teachers",
                          product_detail_2g_type3: "African Transkei",
                          product_detail_2g_type4: "Rusky Whites",
                          product_detail_1g_type1: 150,
                          product_detail_1g_type2: 120,
                          product_detail_2g_type1: 280,
                          product_detail_2g_type2: 200,
                        )),
                );
              }
              else{
                Navigator.push(
                context,
                MaterialPageRoute(
                    //passing values of combo product to product details page
                    builder: (context) => EdiblesProductDetails(
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
                        Text("R$prod_price Min Order",
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
