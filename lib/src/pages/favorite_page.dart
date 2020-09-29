import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:async/async.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tido_herbz/src/screens/main_screen.dart';

//Custom Widgets
import '../widgets/favorite_card.dart';

class FavoritePage extends StatefulWidget {
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
  _FavoritePageState createState() => _FavoritePageState();

  const FavoritePage(
      {this.cartpage_prod_name,
      this.cartpage_prod_picture,
      this.cartpage_prod_price,
      this.cartpage_prod_size,
      this.cartpage_prod_color,
      this.cartpage_prod_strain,
      this.cartpage_prod_gram,
      this.cartpage_prod_quantity,
      this.cartpage_prod_amount});
}

class _FavoritePageState extends State<FavoritePage> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  Firestore firestore = Firestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  bool _loader = true;

  int favecount;

  List<dynamic> favorites = [];

  @override
  void initState() {
    super.initState();
    getUserFave();
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
                      setState(() {
                        favorites = result["favorites"];
                        _loader = false;
                      }),
                    }
                  else
                    {
                      setState(() {
                        _loader = false;
                      })
                    },
                },
            });
  }

  Future<DocumentReference> _addFavorite() async {
    FirebaseUser user = await firebaseAuth.currentUser();

    if (faves.length > 0) {
      for (var item in faves) {
        firestore.collection("users").document(user.uid).updateData({
          "favorites": FieldValue.arrayUnion([
            {
              "itemname": item.cartpage_prod_name,
              "itemprice": item.cartpage_prod_price,
              "itempicture": item.cartpage_prod_picture,
            }
          ])
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    this._memoizer.runOnce(() async {
      if (widget.cartpage_prod_name != null) {
        faves.add(widget);
        _addFavorite();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Favorites",
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
      body: _loader
          ? Center(
              child: SpinKitWave(
                color: Colors.grey,
                size: 50.0,
              ),
            )
          : ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              scrollDirection: Axis.vertical,
              children: <Widget>[
                if (favorites.length == 0)
                  Card(
                    child: Center(
                      child: Text(
                        "You currently have no favorites",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                if (favorites.length > 0)
                  for (int i = 0; i < favorites.length; i++)
                    FavoriteCard(
                      cart_prod_name: favorites[i]["itemname"],
                      cart_prod_price: favorites[i]["itemprice"],
                      cart_prod_picture: favorites[i]["itempicture"],
                    ),
              ],
            ),
    );
  }
}
