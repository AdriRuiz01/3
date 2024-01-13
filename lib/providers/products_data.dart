import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/product.dart';


enum OrderBy {id, name, category, price, nutriscore, origin, calories, weight, proteins}

class ProductsData{
  final List<Product> _products;

  ProductsData._(this._products);

  factory ProductsData.fromJson(String jsonData, OrderBy orderBy){

    Map<String, dynamic> mapJson = json.decode(jsonData);

    List<dynamic> list = mapJson["products"];

    List<Product> productsList = list.map((element) => Product.fromMap(element)).toList();

    sortList(productsList, orderBy);

    return ProductsData._(productsList);
  }

  Product getProduct(int index) => _products[index];
  int getSize() => _products.length;

  List<Product> getProducts() => _products;

  static Future<String> loadJson(BuildContext context, String file) async{
    await Future.delayed(const Duration(seconds: 2));
    return await DefaultAssetBundle.of(context).loadString(file);
  }

  static sortList(List<Product> list, OrderBy orderBy){
    switch(orderBy){
      case OrderBy.id:
        list.sort((prodA, prodB) => prodA.id.compareTo(prodB.id));
        break;
      case OrderBy.name:
        list.sort((prodA, prodB) => prodA.name.compareTo(prodB.name));
        break;
      case OrderBy.category:
        list.sort((prodA, prodB) => prodA.category.compareTo(prodB.category));
        break;
      case OrderBy.price:
        list.sort((prodA, prodB) => prodA.price.compareTo(prodB.price));
        break;
      case OrderBy.origin:
        list.sort((prodA, prodB) => prodA.origin.compareTo(prodB.origin));
        break;
      case OrderBy.calories:
        list.sort((prodA, prodB) => prodA.calories.compareTo(prodB.calories));
        break;
      case OrderBy.weight:
        list.sort((prodA, prodB) => prodA.weight.compareTo(prodB.weight));
        break;
      case OrderBy.proteins:
        list.sort((prodA, prodB) => prodA.proteins.compareTo(prodB.proteins));
        break;
      case OrderBy.nutriscore:
        list.sort((prodA, prodB) => prodA.nutriscore.compareTo(prodB.nutriscore));
        break;
    }
  }
}