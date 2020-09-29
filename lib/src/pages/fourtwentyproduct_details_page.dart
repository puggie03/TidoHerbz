import 'package:flutter/material.dart';
import '../widgets/fourtwentybought_stock.dart';

//Data
import '../data/fourtwentystock_data.dart';
import '../models/fourtwentystock_model.dart';

class FourTwentyProductDetailsPage extends StatefulWidget {
  @override
  _FourTwentyProductDetailsPageState createState() =>
      _FourTwentyProductDetailsPageState();
}

class _FourTwentyProductDetailsPageState
    extends State<FourTwentyProductDetailsPage> {
  List<FourTwentyStock> _stock = stock;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backgroundone.jpg"),
            fit: BoxFit.cover,
          ),
          color: Colors.white,
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
          children: <Widget>[
            Text(
              "420",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Column(
              children: stock.map(_buildStockItems).toList(),
            ),
          ],
        ),
      ),
    ]);
  }

  Widget _buildStockItems(FourTwentyStock stock) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: FourTwentyBoughtStock(
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
