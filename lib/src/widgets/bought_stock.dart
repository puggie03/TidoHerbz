import 'package:flutter/material.dart';
import 'package:tido_herbz/src/pages/edibles_categories_page.dart';
import 'package:tido_herbz/src/pages/fourtwentyproduct_details_page.dart';

class BoughtStock extends StatefulWidget{
  final String id;
  final String name;
  final String imagePath;
  final String category;
  final int price;
  final double ratings;

  BoughtStock({this.id, this.name, this.imagePath, this.category, this.price, this.ratings});
  @override
  _BoughtStockState createState() => _BoughtStockState();
}

class _BoughtStockState extends State<BoughtStock>{
  @override
  Widget build(BuildContext context){
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Stack(
        children: <Widget>[
          InkWell(
            onTap: (){
              if(widget.name == "FourTwenty"){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FourTwentyProductDetailsPage()),
                );
              }
              if(widget.name == "Edibles"){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EdiblesCategoriesPage()),
                );
              }
            },
            child: Container(
              height: 200.0,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(widget.imagePath, fit: BoxFit.cover,),
            ),
          ),
          Positioned(
            left: 0.0,
            bottom: 0.0,
            child: Container(
              height: 60.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black, Colors.black12
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter
                )
              ),
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
                      widget.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.star, color: Theme.of(context).primaryColor, size: 16.0,),
                        Icon(Icons.star, color: Theme.of(context).primaryColor, size: 16.0,),
                        Icon(Icons.star, color: Theme.of(context).primaryColor, size: 16.0,),
                        Icon(Icons.star, color: Theme.of(context).primaryColor, size: 16.0,),
                        Icon(Icons.star, color: Theme.of(context).primaryColor, size: 16.0,),
                        SizedBox(width: 20.0,),
                        Text(
                          "(Infinite Reviews)",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "R"+widget.price.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      "Min Order",
                      style: TextStyle(
                        color: Colors.grey
                      ),
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