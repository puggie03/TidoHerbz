import 'package:flutter/material.dart';
import 'dart:async';

import 'package:tido_herbz/src/pages/order_page.dart';

//list
List<OrderPage> items = [];

class OrderCard extends StatefulWidget {
  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_price;
  final cart_prod_size;
  final cart_prod_color;
  final cart_prod_strain;
  final cart_prod_gram;
  final cart_prod_quantity;

  OrderCard(
      {this.cart_prod_name,
      this.cart_prod_picture,
      this.cart_prod_price,
      this.cart_prod_size,
      this.cart_prod_color,
      this.cart_prod_strain,
      this.cart_prod_gram,
      this.cart_prod_quantity});

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  int quantity = 1;

  String color;
  String gram;
  String strain;
  String size;

  OrderPage orderPage = new OrderPage();

  var deleteItem;
  int itemPrice;

  void checkColor() {
    if (widget.cart_prod_color != null) {
      color = widget.cart_prod_color;
    } else {
      color = "";
    }
  }

  void checkGram() {
    if (widget.cart_prod_gram != null) {
      gram = widget.cart_prod_gram;
    } else {
      gram = "";
    }
  }

  void checkStrain() {
    if (widget.cart_prod_strain != null) {
      strain = widget.cart_prod_strain;
    } else {
      strain = "";
    }
  }

  void checkSize() {
    if (widget.cart_prod_size != null) {
      size = widget.cart_prod_size;
    } else {
      size = "";
    }
  }

  removeItem() {
    if (items.length > 0) {
      for (var item in items) {
        if (item.cartpage_prod_name == widget.cart_prod_name) {
          setState(() {
            deleteItem = item;
            itemPrice = item.cartpage_prod_price;
            return;
          });
        }
      }
      if (deleteItem != null) {
        items.remove(deleteItem);
        orderPage.setCartTotal(itemPrice);

        Navigator.of(context).push(PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (BuildContext context, _, __) =>
                        OrderPage()));
      }
      
    }
  }

  @override
  Widget build(BuildContext context) {
    checkColor();
    checkGram();
    checkSize();
    checkStrain();
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 45.0,
              width: 45.0,
              decoration: BoxDecoration(
                border: Border.all(width: 2.0, color: Color(0xFFD3D3D3)),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    quantity.toString(),
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Container(
              height: 70.0,
              width: 70.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.cart_prod_picture),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(35.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 5.0,
                    offset: Offset(0.0, 5.0),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.cart_prod_name,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "R" + widget.cart_prod_price.toString(),
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  height: 35.0,
                  width: 120.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              color,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                "x",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              gram,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                "x",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              size,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                "x",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              strain,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Spacer(),
            GestureDetector(
                onTap: () {
                  removeItem();
                },
                child: Icon(
                  Icons.cancel,
                  color: Colors.grey,
                )),
          ],
        ),
      ),
    );
  }
}
