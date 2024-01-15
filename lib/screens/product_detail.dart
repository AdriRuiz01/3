import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductDetail extends StatelessWidget {
  final Product product;

  final _myTextStyle1 = const TextStyle(color: Colors.blue, fontSize: 30.0);
  final _myTextStyle2 = const TextStyle(color: Colors.indigo, fontSize: 30.0);
  final _myTextStyle3 = const TextStyle(color: Colors.indigo, fontSize: 25.0);
  final _myTextStyle4 = const TextStyle(color: Colors.blue, fontSize: 25.0);
  final _myTextStyle5 = const TextStyle(color: Colors.indigo, fontSize: 20.0);


  const ProductDetail(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product detail')),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.teal.shade100, Colors.teal.shade300])),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Hero(
                tag: 'imageProduct',
                child: Image.asset(
                  product.image,
                  height: 100,
                  width: 100,
                  fit: BoxFit.contain,
                ),
              )
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Id: ', style: _myTextStyle1, textAlign: TextAlign.justify),
                Text("${product.id}", style: _myTextStyle2, textAlign: TextAlign.justify),
                Text(' Name: ', style: _myTextStyle1, textAlign: TextAlign.justify),
                Text(product.name, style: _myTextStyle2, textAlign: TextAlign.justify)
              ],
            ),
            const Divider(color: Colors.grey, thickness: 1),
            Text('Description', style: _myTextStyle1),
            Text(product.description, style: _myTextStyle3, textAlign: TextAlign.justify),
            const Divider(color: Colors.grey, thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Origin: ', style: _myTextStyle1, textAlign: TextAlign.justify),
                Text(product.origin, style: _myTextStyle2, textAlign: TextAlign.justify),
              ],
            ),
            const Divider(color: Colors.grey, thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Nutriscore: ', style: _myTextStyle1, textAlign: TextAlign.justify),
                Text(product.nutriscore, style: _myTextStyle2, textAlign: TextAlign.justify),
                Text("      */100g", style: _myTextStyle5, textAlign: TextAlign.justify),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Calories: ', style: _myTextStyle4, textAlign: TextAlign.justify),
                Text("${product.calories}*", style: _myTextStyle5, textAlign: TextAlign.justify),
                Text(' Proteins: ', style: _myTextStyle4, textAlign: TextAlign.justify),
                Text("${product.proteins}g*", style: _myTextStyle5, textAlign: TextAlign.justify),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Weight: ', style: _myTextStyle4, textAlign: TextAlign.justify),
                Text("${product.weight}g", style: _myTextStyle5, textAlign: TextAlign.justify),
              ],
            ),
            const Divider(color: Colors.grey, thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Price: ', style: _myTextStyle1, textAlign: TextAlign.justify),
                Text("${product.price}€", style: _myTextStyle2, textAlign: TextAlign.justify),
              ],
            )
          ],
        ),
      ),
    );
  }
}
