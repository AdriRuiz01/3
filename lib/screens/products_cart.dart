import 'package:flutter/material.dart';
import 'package:t3_shopping_list/screens/product_detail.dart';
import '../models/product.dart';

class CartScreen extends StatefulWidget {
  final List<Product> selectedProducts;

  const CartScreen(this.selectedProducts, {Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {

    double totalSum = 0.0;
    for (Product product in widget.selectedProducts) {
      totalSum += product.price * product.quantity;
    }

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Text('My Shopping cart'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Text(
              '${totalSum.toStringAsFixed(2)} €',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.teal.shade100, Colors.teal.shade300]),
      ),

        child: ListView.builder(
          itemCount: widget.selectedProducts.length,
          itemBuilder: (context, index) => _cartItem(context, widget.selectedProducts[index]),
        ),
      ),
    );
  }

  Widget _cartItem(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
    child: Container(
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
    color: Colors.teal.shade50,
    width: 2.0,
    ),
    ),
    child: ListTile(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(product),
          ),
        ),
        leading: Image.asset(
          product.image,
          width: 100.0,
          height: 100.0,
          fit: BoxFit.contain,
          alignment: Alignment.bottomCenter,
        ),
        title: Text(product.name),
        subtitle: Text('${product.price} €/Kg'),
        shape: RoundedRectangleBorder(
          side:  BorderSide(color:  Colors.teal.shade50),
          borderRadius: BorderRadius.circular(10.0),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline, color: Colors.red,),
              onPressed: () {
                setState(() {
                  if (product.quantity > 1) {
                    product.quantity--;
                  }
                });
              },
            ),
            Text(product.quantity.toString(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
            IconButton(
              icon: const Icon(Icons.add_circle_outline, color: Colors.green,),
              onPressed: () {
                setState(() {
                  product.quantity++;
                });
              },
            ),
          ],
        ),
      ),
    ),
    );
  }
}
