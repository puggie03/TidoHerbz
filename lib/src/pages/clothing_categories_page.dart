import 'package:flutter/material.dart';
import '../widgets/clothing_products.dart';

class ClothingCategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320.0,
      child: ClothingProducts(),
    );
  }
}
