import 'package:flutter/material.dart';
import 'package:tido_herbz/src/models/category_model.dart';
import 'stock_card.dart';

//Data
import '../data/category_data.dart';

//Model
import '../models/category_model.dart';

class StockCategory extends StatelessWidget{

  final List<Category> _categories = categories;

  @override
  Widget build(BuildContext context){
    return Container(
      height: 80.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (BuildContext context, int index){
          return StockCard(
           categoryName: _categories[index].categoryName,
           imagePath: _categories[index].imagePath,
           numberOfItems: _categories[index].numberOfItems,
          );
        },
      ),
    );
  }
}