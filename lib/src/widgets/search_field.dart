import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:tido_herbz/src/models/clothingproduct_model.dart';
import 'package:tido_herbz/src/models/greenhouseproduct_model.dart';
import 'package:tido_herbz/src/pages/bongskproduct_details.dart';
import 'package:tido_herbz/src/pages/capsproduct_details.dart';
import 'package:tido_herbz/src/pages/clothingproduct_details.dart';
import 'package:tido_herbz/src/pages/comboproduct_details.dart';
import 'package:tido_herbz/src/pages/ediblesproduct_details.dart';
import 'package:tido_herbz/src/pages/exoticghproduct_details.dart';
import 'package:tido_herbz/src/pages/fourtwentyproduct_details_page.dart';
import 'package:tido_herbz/src/pages/greenhouseproduct_details.dart';
import 'package:tido_herbz/src/pages/indoorproduct_details.dart';
import 'package:tido_herbz/src/pages/lollipopsproduct_details.dart';
import 'package:tido_herbz/src/pages/shroomsproduct_details.dart';
import '../data/bongskproduct_data.dart';
import 'package:tido_herbz/src/models/bongzkproduct_model.dart';
import '../data/clothingproduct_data.dart';
import '../data/comboproduct_data.dart';
import '../models/comboproduct_model.dart';
import '../data/ediblesproduct_data.dart';
import '../models/ediblesproduct_model.dart';
import '../data/exoticgreenhouseproduct_data.dart';
import '../models/exoticgreenhouseproduct_model.dart';
import '../data/fourtwentystock_data.dart';
import '../models/fourtwentystock_model.dart';
import '../data/greenhouseproduct_data.dart';
import '../data/indoorproduct_data.dart';
import '../models/indoorproduct_model.dart';

class Names {
  final String title;

  Names(this.title);
}

class SearchField extends StatelessWidget {
  final List<BongsKSingle_Prod> bongProduct = bongsProductlist;
  final List<ClothingSingle_Prod> clothingProduct = clothingProductlist;
  final List<ComboSingle_Prod> comboProduct = comboProductlist;
  final List<EdiblesSingle_Prod> ediblesProduct = ediblesProductlist;
  final List<ExoticSingle_Prod> exoticProduct = exoticProductlist;
  List<FourTwentyStock> fourTwentystock = stock;
  final List<Single_Prod> greenProduct = greenProductlist;
  final List<IndoorSingle_Prod> indoorProduct = indoorProductlist;

  List<String> products = [];

  final TextEditingController _typeAheadController = TextEditingController();

  String query;

  bool firstSearch;

  List<String> alldata() {
    for (int i = 0; i < bongProduct.length; i++) {
      products.add(bongProduct[i].prod_name);
    }
    for (int i = 0; i < clothingProduct.length; i++) {
      products.add(clothingProduct[i].prod_name);
    }
    for (int i = 0; i < comboProduct.length; i++) {
      products.add(comboProduct[i].prod_name);
    }
    for (int i = 0; i < ediblesProduct.length; i++) {
      products.add(ediblesProduct[i].prod_name);
    }
    for (int i = 0; i < exoticProduct.length; i++) {
      products.add(exoticProduct[i].prod_name);
    }
    for (int i = 0; i < fourTwentystock.length; i++) {
      products.add(fourTwentystock[i].name);
    }
    for (int i = 0; i < greenProduct.length; i++) {
      products.add(greenProduct[i].prod_name);
    }
    for (int i = 0; i < indoorProduct.length; i++) {
      products.add(indoorProduct[i].prod_name);
    }
    return products;
  }

  List<String> getSuggestions(String value) {
    List<String> filter = [];

    filter.addAll(products);
    filter.retainWhere(
        (products) => products.toLowerCase().contains(value.toLowerCase()));
    return filter;
  }

  @override
  Widget build(BuildContext context) {
    alldata();
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      child: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
            controller: _typeAheadController,
            autofocus: false,
            style: DefaultTextStyle.of(context)
                .style
                .copyWith(fontStyle: FontStyle.italic),
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
                hintText: "Search any paradise",
                suffixIcon: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      for (int i = 0; i < bongProduct.length; i++) {
                        if (bongProduct[i].prod_name.toLowerCase() ==
                            _typeAheadController.text.toLowerCase()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                //passing values of combo product to product details page
                                builder: (context) => BongsKProductDetails(
                                      product_detail_name:
                                          bongProduct[i].prod_name,
                                      product_detail_price:
                                          bongProduct[i].prod_price,
                                      product_detail_picture:
                                          bongProduct[i].prod_picture,
                                      product_detail_description:
                                          bongProduct[i].prod_description,
                                    )),
                          );
                        }
                      }
                      for (int i = 0; i < clothingProduct.length; i++) {
                        if (clothingProduct[i].prod_name.toLowerCase() ==
                            _typeAheadController.text.toLowerCase()) {
                          if (clothingProduct[i].prod_name == "TH Suede Caps" ||
                              clothingProduct[i].prod_name ==
                                  "TH Brown Suede Cap" ||
                              clothingProduct[i].prod_name == "TidoHerbz Cap") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  //passing values of cap product to product details page
                                  builder: (context) => CapsProductDetails(
                                        product_detail_name:
                                            clothingProduct[i].prod_name,
                                        product_detail_price:
                                            clothingProduct[i].prod_price,
                                        product_detail_picture:
                                            clothingProduct[i].prod_picture,
                                        product_detail_description:
                                            clothingProduct[i].prod_description,
                                      )),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  //passing values of clothing product to product details page
                                  builder: (context) => ClothingProductDetails(
                                        product_detail_name:
                                            clothingProduct[i].prod_name,
                                        product_detail_price:
                                            clothingProduct[i].prod_price,
                                        product_detail_picture:
                                            clothingProduct[i].prod_picture,
                                        product_detail_description:
                                            clothingProduct[i].prod_description,
                                      )),
                            );
                          }
                        }
                      }
                      for (int i = 0; i < comboProduct.length; i++) {
                        if (comboProduct[i].prod_name.toLowerCase() ==
                            _typeAheadController.text.toLowerCase()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                //passing values of combo product to product details page
                                builder: (context) => ComboProductDetails(
                                      product_detail_name:
                                          comboProduct[i].prod_name,
                                      product_detail_price:
                                          comboProduct[i].prod_price,
                                      product_detail_picture:
                                          comboProduct[i].prod_picture,
                                      product_detail_description:
                                          comboProduct[i].prod_description,
                                    )),
                          );
                        }
                      }
                      for (int i = 0; i < ediblesProduct.length; i++) {
                        if (ediblesProduct[i].prod_name.toLowerCase() ==
                            _typeAheadController.text.toLowerCase()) {
                          if (ediblesProduct[i].prod_name == "Lollipops") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  //passing values of combo product to product details page
                                  builder: (context) => LollipopsProductDetails(
                                        product_detail_name:
                                            ediblesProduct[i].prod_name,
                                        product_detail_price:
                                            ediblesProduct[i].prod_price,
                                        product_detail_picture:
                                            ediblesProduct[i].prod_picture,
                                        product_detail_description:
                                            ediblesProduct[i].prod_description,
                                        product_detail_100mg: 50,
                                        product_detail_200mg: 60,
                                        product_detail_300mg: 70,
                                        product_detail_500mg: 100,
                                      )),
                            );
                          } else if (ediblesProduct[i].prod_name == "Shrooms") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  //passing values of combo product to product details page
                                  builder: (context) => ShroomsProductDetails(
                                        product_detail_name:
                                            ediblesProduct[i].prod_name,
                                        product_detail_price:
                                            ediblesProduct[i].prod_price,
                                        product_detail_picture:
                                            ediblesProduct[i].prod_picture,
                                        product_detail_description:
                                            ediblesProduct[i].prod_description,
                                        product_detail_type1: "Penis Envy",
                                        product_detail_type2: "Golden Teachers",
                                        product_detail_1g_type1: 150,
                                        product_detail_1g_type2: 120,
                                        product_detail_2g_type1: 280,
                                        product_detail_2g_type2: 200,
                                      )),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  //passing values of combo product to product details page
                                  builder: (context) => EdiblesProductDetails(
                                        product_detail_name:
                                            ediblesProduct[i].prod_name,
                                        product_detail_price:
                                            ediblesProduct[i].prod_price,
                                        product_detail_picture:
                                            ediblesProduct[i].prod_picture,
                                        product_detail_description:
                                            ediblesProduct[i].prod_description,
                                      )),
                            );
                          }
                        }
                      }
                      for (int i = 0; i < exoticProduct.length; i++) {
                        if (exoticProduct[i].prod_name.toLowerCase() ==
                            _typeAheadController.text.toLowerCase()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                //passing values of combo product to product details page
                                builder: (context) => ExoticGHProductDetails(
                                      product_detail_name:
                                          exoticProduct[i].prod_name,
                                      product_detail_price:
                                          exoticProduct[i].prod_4g,
                                      product_detail_picture:
                                          exoticProduct[i].prod_picture,
                                      product_detail_description:
                                          exoticProduct[i].prod_description,
                                    )),
                          );
                        }
                      }
                      for (int i = 0; i < fourTwentystock.length; i++) {
                        if (fourTwentystock[i].name.toLowerCase() ==
                            _typeAheadController.text.toLowerCase()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FourTwentyProductDetailsPage()),
                          );
                        }
                      }
                      for (int i = 0; i < greenProduct.length; i++) {
                        if (greenProduct[i].prod_name.toLowerCase() ==
                            _typeAheadController.text.toLowerCase()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                //passing values of combo product to product details page
                                builder: (context) => GreenHouseProductDetails(
                                      product_detail_name:
                                          greenProduct[i].prod_name,
                                      product_detail_price:
                                          greenProduct[i].prod_4g,
                                      product_detail_picture:
                                          greenProduct[i].prod_picture,
                                      product_detail_description:
                                          greenProduct[i].prod_description,
                                    )),
                          );
                        }
                      }
                      for (int i = 0; i < indoorProduct.length; i++) {
                        if (indoorProduct[i].prod_name.toLowerCase() ==
                            _typeAheadController.text.toLowerCase()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                //passing values of combo product to product details page
                                builder: (context) => IndoorProductDetails(
                                      product_detail_name:
                                          indoorProduct[i].prod_name,
                                      product_detail_price:
                                          indoorProduct[i].prod_1g,
                                      product_detail_picture:
                                          indoorProduct[i].prod_picture,
                                      product_detail_description:
                                          indoorProduct[i].prod_description,
                                    )),
                          );
                        }
                      }
                    },
                  ),
                ),
                border: InputBorder.none)),
        suggestionsCallback: (pattern) {
          return getSuggestions(pattern);
        },
        itemBuilder: (context, suggestion) {
          return ListTile(title: Text(suggestion));
        },
        onSuggestionSelected: (suggestion) {
          _typeAheadController.text = suggestion;
          for (int i = 0; i < bongProduct.length; i++) {
            if (bongProduct[i].prod_name.toLowerCase() ==
                _typeAheadController.text.toLowerCase()) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    //passing values of combo product to product details page
                    builder: (context) => BongsKProductDetails(
                          product_detail_name: bongProduct[i].prod_name,
                          product_detail_price: bongProduct[i].prod_price,
                          product_detail_picture: bongProduct[i].prod_picture,
                          product_detail_description:
                              bongProduct[i].prod_description,
                        )),
              );
            }
          }
          for (int i = 0; i < clothingProduct.length; i++) {
            if (clothingProduct[i].prod_name.toLowerCase() ==
                _typeAheadController.text.toLowerCase()) {
              if (clothingProduct[i].prod_name == "TH Suede Caps" ||
                  clothingProduct[i].prod_name == "TH Brown Suede Cap" ||
                  clothingProduct[i].prod_name == "TidoHerbz Cap") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      //passing values of cap product to product details page
                      builder: (context) => CapsProductDetails(
                            product_detail_name: clothingProduct[i].prod_name,
                            product_detail_price: clothingProduct[i].prod_price,
                            product_detail_picture:
                                clothingProduct[i].prod_picture,
                            product_detail_description:
                                clothingProduct[i].prod_description,
                          )),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      //passing values of clothing product to product details page
                      builder: (context) => ClothingProductDetails(
                            product_detail_name: clothingProduct[i].prod_name,
                            product_detail_price: clothingProduct[i].prod_price,
                            product_detail_picture:
                                clothingProduct[i].prod_picture,
                            product_detail_description:
                                clothingProduct[i].prod_description,
                          )),
                );
              }
            }
          }
          for (int i = 0; i < comboProduct.length; i++) {
            if (comboProduct[i].prod_name.toLowerCase() ==
                _typeAheadController.text.toLowerCase()) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    //passing values of combo product to product details page
                    builder: (context) => ComboProductDetails(
                          product_detail_name: comboProduct[i].prod_name,
                          product_detail_price: comboProduct[i].prod_price,
                          product_detail_picture: comboProduct[i].prod_picture,
                          product_detail_description:
                              comboProduct[i].prod_description,
                        )),
              );
            }
          }
          for (int i = 0; i < ediblesProduct.length; i++) {
            if (ediblesProduct[i].prod_name.toLowerCase() ==
                _typeAheadController.text.toLowerCase()) {
              if (ediblesProduct[i].prod_name == "Lollipops") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      //passing values of combo product to product details page
                      builder: (context) => LollipopsProductDetails(
                            product_detail_name: ediblesProduct[i].prod_name,
                            product_detail_price: ediblesProduct[i].prod_price,
                            product_detail_picture:
                                ediblesProduct[i].prod_picture,
                            product_detail_description:
                                ediblesProduct[i].prod_description,
                            product_detail_100mg: 50,
                            product_detail_200mg: 60,
                            product_detail_300mg: 70,
                            product_detail_500mg: 100,
                          )),
                );
              } else if (ediblesProduct[i].prod_name == "Shrooms") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      //passing values of combo product to product details page
                      builder: (context) => ShroomsProductDetails(
                            product_detail_name: ediblesProduct[i].prod_name,
                            product_detail_price: ediblesProduct[i].prod_price,
                            product_detail_picture:
                                ediblesProduct[i].prod_picture,
                            product_detail_description:
                                ediblesProduct[i].prod_description,
                            product_detail_type1: "Penis Envy",
                            product_detail_type2: "Golden Teachers",
                            product_detail_1g_type1: 150,
                            product_detail_1g_type2: 120,
                            product_detail_2g_type1: 280,
                            product_detail_2g_type2: 200,
                          )),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      //passing values of combo product to product details page
                      builder: (context) => EdiblesProductDetails(
                            product_detail_name: ediblesProduct[i].prod_name,
                            product_detail_price: ediblesProduct[i].prod_price,
                            product_detail_picture:
                                ediblesProduct[i].prod_picture,
                            product_detail_description:
                                ediblesProduct[i].prod_description,
                          )),
                );
              }
            }
          }
          for (int i = 0; i < exoticProduct.length; i++) {
            if (exoticProduct[i].prod_name.toLowerCase() ==
                _typeAheadController.text.toLowerCase()) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    //passing values of combo product to product details page
                    builder: (context) => ExoticGHProductDetails(
                          product_detail_name: exoticProduct[i].prod_name,
                          product_detail_price: exoticProduct[i].prod_4g,
                          product_detail_picture: exoticProduct[i].prod_picture,
                          product_detail_description:
                              exoticProduct[i].prod_description,
                        )),
              );
            }
          }
          for (int i = 0; i < fourTwentystock.length; i++) {
            if (fourTwentystock[i].name.toLowerCase() ==
                _typeAheadController.text.toLowerCase()) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FourTwentyProductDetailsPage()),
              );
            }
          }
          for (int i = 0; i < greenProduct.length; i++) {
            if (greenProduct[i].prod_name.toLowerCase() ==
                _typeAheadController.text.toLowerCase()) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    //passing values of combo product to product details page
                    builder: (context) => GreenHouseProductDetails(
                          product_detail_name: greenProduct[i].prod_name,
                          product_detail_price: greenProduct[i].prod_4g,
                          product_detail_picture: greenProduct[i].prod_picture,
                          product_detail_description:
                              greenProduct[i].prod_description,
                        )),
              );
            }
          }
          for (int i = 0; i < indoorProduct.length; i++) {
            if (indoorProduct[i].prod_name.toLowerCase() ==
                _typeAheadController.text.toLowerCase()) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    //passing values of combo product to product details page
                    builder: (context) => IndoorProductDetails(
                          product_detail_name: indoorProduct[i].prod_name,
                          product_detail_price: indoorProduct[i].prod_1g,
                          product_detail_picture: indoorProduct[i].prod_picture,
                          product_detail_description:
                              indoorProduct[i].prod_description,
                        )),
              );
            }
          }
        },
      ),
    );
  }
}
