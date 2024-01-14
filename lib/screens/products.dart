
import 'package:flutter/material.dart';
import 'package:t3_shopping_list/screens/product_detail.dart';
import 'package:t3_shopping_list/screens/products_cart.dart';
import '../models/product.dart';
import '../providers/products_data.dart';


class ProductsScreen extends StatelessWidget {
  final _ProductsListViewState productListState = _ProductsListViewState();

  ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(productListState.getSelectedProducts()),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: FutureBuilder(
              future: ProductsData.loadJson(context, 'assets/json/products.json'),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return ProductsListView(
                    ProductsData.fromJson(snapshot.data!, productListState._currentOrderBy),
                    productListState,
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 40.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildHeaderItem(context, OrderBy.name, 'Name'),
          _buildHeaderItem(context, OrderBy.category, 'Category'),
          _buildHeaderItem(context, OrderBy.price, 'Price'),
          _buildHeaderItem(context, OrderBy.origin, 'Origin'),
          _buildHeaderItem(context, OrderBy.calories, 'Calories'),
          _buildHeaderItem(context, OrderBy.weight, 'Weight'),
          _buildHeaderItem(context, OrderBy.proteins, 'Proteins'),
          _buildHeaderItem(context, OrderBy.nutriscore, 'Nutriscore'),
        ],
      ),
    );
  }

  Widget _buildHeaderItem(BuildContext context, OrderBy orderBy, String title) {
    return InkWell(
      onTap: () {
        productListState.sortList(orderBy);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class ProductsListView extends StatefulWidget {
  final ProductsData _productsData;
  final _ProductsListViewState productListState;

  const ProductsListView(this._productsData, this.productListState, {Key? key}) : super(key: key);

  @override
  _ProductsListViewState createState() => productListState;
}

class _ProductsListViewState extends State<ProductsListView> {
  final List<Product> _selectedProducts = [];
  OrderBy _currentOrderBy = OrderBy.name;

  void sortList(OrderBy orderBy) {
    setState(() {
      _currentOrderBy = orderBy;
      ProductsData.sortList(widget._productsData.getProducts(), orderBy);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget._productsData.getSize(),
        itemBuilder: (context, index) => _listItem(context, widget._productsData.getProduct(index)),
      ),
    );
  }

  Widget _listItem(BuildContext context, Product product) {
    final bool isSelected = _selectedProducts.contains(product);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(product.id, product.name, product.description),
          ),
        ),
        leading: Image.asset(
          product.image,
          width: 100.0,
          height: 100.0,
          fit: BoxFit.contain,
          alignment: Alignment.centerLeft,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              getImageCategory(product.category), // Reemplaza con la ruta correcta de tu imagen
              width: 30.0, // Ajusta según sea necesario
              height: 30.0, // Ajusta según sea necesario
              fit: BoxFit.contain,
            ),
            SizedBox(width: 30.0), // Espacio entre la imagen y el icono
            IconButton(
              icon: Icon(Icons.shopping_bag, color: isSelected ? Colors.green : null),
              onPressed: () {
                setState(() {
                  if (!isSelected) {
                    product.quantity = 1;
                    _selectedProducts.add(product);
                  } else {
                    _selectedProducts.remove(product);
                  }
                });
              },
            ),
          ],
        ),
        title: Text(product.name, style: TextStyle(fontSize: 13.0)),
        subtitle: Text('${product.price} €/Kg'),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.indigo),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }


  List<Product> getSelectedProducts() {
    return _selectedProducts;
  }

  String getImageCategory(String productCategory) {

    switch(productCategory) {
      case 'fruits':
        return 'assets/image/frutas.png';
        break;
      case 'vegetables':
        return 'assets/image/brocoli.png';
        break;
      case 'fish':
        return 'assets/image/pescado.png';
        break;
      case 'meat':
        return 'assets/image/filete.png';
        break;
      case 'bakery':
        return 'assets/image/tarta.png';
        break;
      default:
        return "";
    }

  }

}