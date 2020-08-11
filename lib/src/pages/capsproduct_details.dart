import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tido_herbz/src/pages/order_page.dart';
import 'package:tido_herbz/src/screens/main_screen.dart';

import 'favorite_page.dart';

class CapsProductDetails extends StatefulWidget {
  final product_detail_name;
  final product_detail_price;
  final product_detail_picture;
  final product_detail_description;
  String _selectedText;

  CapsProductDetails(
      {this.product_detail_name,
      this.product_detail_price,
      this.product_detail_picture,
      this.product_detail_description});

  @override
  _CapsProductDetailsState createState() => _CapsProductDetailsState();
}

class _CapsProductDetailsState extends State<CapsProductDetails> {
  OrderPage _orderPage = new OrderPage();
  String _selectedText;
  bool _isFavorited = false;
  var storeFave;
  var list = <String>[];

  Firestore firestore = Firestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getUserFave();
    setCapColor();
  }

  setCapColor() {
    if (widget.product_detail_name == "TH Suede Caps" ||
        widget.product_detail_name == "TH Brown Suede Cap") {
      setState(() {
        _selectedText = "Brown";
      });

      list = <String>['Brown', 'Dark brown', 'Red'];
    } else if(widget.product_detail_name == "TidoHerbz Cap"){
      _selectedText = "White";
      list = <String>['White', 'Black', 'Red'];
      
    } else if(widget.product_detail_name == "TidoHerbz Beanie"){
      _selectedText = "Pink";
      list = <String>['Pink','Grey', 'Orange', 'Lime'];
    }
  }

  Future<void> getUserFave() async {
    FirebaseUser user = await firebaseAuth.currentUser();

    firestore
        .collection("users")
        .document(user.uid)
        .get()
        .then((DocumentSnapshot result) => {
              if (result["favorites"] != null)
                {
                  if (result["favorites"].length > 0)
                    {
                      for (int i = 0; i < result["favorites"].length; i++)
                        {
                          if (result["favorites"][i]["itemname"] ==
                              widget.product_detail_name)
                            {
                              setState(() {
                                storeFave = result["favorites"][i];
                                _isFavorited = true;
                              }),
                            }
                        }
                    },
                }
            });
  }

  void _toggleFavorite() async {
    FirebaseUser user = await firebaseAuth.currentUser();

    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
        firestore.collection("users").document(user.uid).updateData({
          "favorites": FieldValue.arrayRemove([storeFave])
        });
      } else {
        _isFavorited = true;

        if (widget.product_detail_name != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
                //passing values of combo product to product details page
                builder: (context) => FavoritePage(
                      cartpage_prod_name: widget.product_detail_name,
                      cartpage_prod_price: widget.product_detail_price,
                      cartpage_prod_picture: widget.product_detail_picture,
                      //cart: prod_description,
                    )),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          "Product Details",
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
      body: new ListView(
        children: <Widget>[
          Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.asset(widget.product_detail_picture),
              ),
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(
                    widget.product_detail_name,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "R${widget.product_detail_price}",
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              //Colour dropdown
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return new AlertDialog(
                            title: new Text("Colour"),
                            content: new DropdownButton<String>(
                              hint: Text("Choose the colour"),
                              value: _selectedText,
                              items: list.map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              onChanged: (String val) {
                                //_selectedText = val;
                                setState(() {
                                  _selectedText = val;
                                });
                                Navigator.of(context).pop(context);
                              },
                            ),
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
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(_selectedText),
                      ),
                      Expanded(
                        child: Icon(Icons.arrow_drop_down),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              //Quantity dropdown
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    TimeOfDay tod = TimeOfDay.now();
                    //print("Before tod.hour: " + tod.hour.toString());
                    if (tod.hour < 9 || tod.hour > 19) {
                      //print("tod.hour: " + tod.hour.toString());
                      showDialog(
                          context: context,
                          builder: (context) {
                            return new AlertDialog(
                              title: new Text("Note"),
                              content: new Text(
                                  "Delivery Services are offline currently, please try between 09:00 - 19:00"),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            //passing values of combo product to product details page
                            builder: (context) => OrderPage(
                                  cartpage_prod_name:
                                      widget.product_detail_name,
                                  cartpage_prod_price:
                                      widget.product_detail_price,
                                  cartpage_prod_picture:
                                      widget.product_detail_picture,
                                  cartpage_prod_amount:
                                      _orderPage.calculateTotal(
                                          widget.product_detail_price),
                                  cartpage_prod_color: _selectedText,
                                  //cart: prod_description,
                                )),
                      );
                      showDialog(
                          context: context,
                          builder: (context) {
                            return new AlertDialog(
                              title: new Text("Item"),
                              content: new Text("Added to cart!"),
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
                    }
                  },
                  color: Colors.black,
                  textColor: Colors.white,
                  elevation: 0.2,
                  child: Text("Add to cart"),
                ),
              ),
              new IconButton(
                icon: (_isFavorited
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border)),
                color: Colors.green,
                onPressed: () {
                  _toggleFavorite();
                },
              ),
            ],
          ),
          Divider(),
          new ListTile(
            title: new Text("Product details"),
            subtitle: new Text(widget.product_detail_description),
          )
        ],
      ),
    );
  }
}
