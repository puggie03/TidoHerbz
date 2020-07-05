import 'package:flutter/material.dart';
import '../widgets/stock_category.dart';
import '../widgets/home_top_info.dart';
import '../widgets/search_field.dart';
import '../widgets/bought_stock.dart';

//Data
import '../data/stock_data.dart';
import '../models/stock_model.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Stock> _stock = stock;

  String _message = '';
  String _title = '';

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _register() {
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessage();
    _register();
  }

  void getMessage() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('on message $message');
      setState(() {
        _title = message["notification"]["title"];
        _message = message["notification"]["body"];
      });
    }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      setState(() {
        _title = message["notification"]["title"];
        _message = message["notification"]["body"];
      });
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      setState(() {
        _title = message["notification"]["title"];
        _message = message["notification"]["body"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ListView(
        padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        children: <Widget>[
          HomeTopInfo(_title,_message),
          StockCategory(),
          SizedBox(
            height: 20.0,
          ),
          SearchField(),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Frequently bought items",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Column(
            children: stock.map(_buildStockItems).toList(),
          ),
        ], // <Widget>[]
      ), //ListView
    ); //Scaffold
  }

  Widget _buildStockItems(Stock stock) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: BoughtStock(
        id: stock.id,
        name: stock.name,
        imagePath: stock.imagePath,
        category: stock.category,
        price: stock.price,
        ratings: stock.ratings,
      ),
    );
  }
}
