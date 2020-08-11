import 'package:flutter/material.dart';
import 'package:tido_herbz/src/pages/bongsk_categories_page.dart';
import 'package:tido_herbz/src/pages/clothing_categories_page.dart';
import 'package:tido_herbz/src/pages/combo_categories_page.dart';
import 'package:tido_herbz/src/pages/edibles_categories_page.dart';
import 'package:tido_herbz/src/pages/fourtwentyproduct_details_page.dart';

class StockCard extends StatelessWidget{

final String categoryName;
final String imagePath;
final int numberOfItems;

  StockCard({this.categoryName, this.imagePath, this.numberOfItems});

  @override
  Widget build(BuildContext context){
      return Container(
        margin: EdgeInsets.only(right: 20.0),
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: InkWell(
              onTap: (){
                if(categoryName == "Combos"){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ComboCategoriesPage()),
                  );
                }
                if(categoryName == "Edibles"){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EdiblesCategoriesPage()),
                  );
                }
                if(categoryName == "FourTwenty"){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FourTwentyProductDetailsPage()),
                  );
                }
                if(categoryName == "Clothing"){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClothingCategoriesPage()),
                  );
                }
                if(categoryName == "Bongs & Grinders"){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BongsKCategoriesPage()),
                  );
                }
              },
              child: Row(
                children: <Widget>[
                  Image(
                    image: AssetImage(imagePath),
                    height: 65.0,
                    width: 65.0,
                  ),
                  SizedBox(width: 20.0,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(categoryName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                      //sText("$numberOfItems Kinds",)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}