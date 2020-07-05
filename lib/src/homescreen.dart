import 'package:flutter/material.dart';
import 'widgets/stock_category.dart';
import 'widgets/home_top_info.dart';
import 'widgets/search_field.dart';
import 'widgets/bought_stock.dart';

//Data
import 'data/stock_data.dart';
import 'models/stock_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Stock> _stock = stock;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        children: <Widget>[
          //HomeTopInfo(),
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
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "View All",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              )
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
