
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
          //TODO Activ1: Si pulsamos en el icono de la cesta, nos llevará a la pantalla con los productos seleccionados
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
          //TODO Activ2: añadimos la cabecera
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

  //TODO Activ2: widget que construye la cabecera
  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 40.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildHeaderItem(context, OrderBy.id, 'Id'),
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

  //TODO Activ2: widget que construye los items de la cabecera
  Widget _buildHeaderItem(BuildContext context, OrderBy orderBy, String title) {
    return InkWell(
      onTap: () {
        productListState.sortList(orderBy);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.teal.shade50,
          border: Border.all(
            color: Colors.teal.shade300,
            width: 2.0
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.teal,
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
  //TODO Activ1: lista de items seleccionados
  final List<Product> _selectedProducts = [];
  //TODO Activ1: variable para saber el orden de la lista,
  // lo inicializo en name para que se ordene de esta forma al iniciar la app
  OrderBy _currentOrderBy = OrderBy.name;

  //TODO Activ2: método que se encarga de ordenar la lista
  void sortList(OrderBy orderBy) {
    setState(() {
      _currentOrderBy = orderBy;
      ProductsData.sortList(widget._productsData.getProducts(), orderBy);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.teal.shade100, Colors.teal.shade300]),
        ),
        child: ListView.builder(
          itemCount: widget._productsData.getSize(),
          itemBuilder: (context, index) => _listItem(context, widget._productsData.getProduct(index)),
        ),
      ),
    );
  }

  Widget _listItem(BuildContext context, Product product) {
    //TODO: Activ1: variable para saber si el item esta seleccionado
    final bool isSelected = _selectedProducts.contains(product);

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
          alignment: Alignment.centerLeft,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            //TODO Activ4: añadimos la imagen de la categoria al item
            Image.asset(
              product.getImageCategory(),
              width: 30.0,
              height: 30.0,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 30.0),
            IconButton(
              //TODO: Activ1: si el item esta seleccionado mostrar el icono como marcado (verde),
              // de lo contrario mostrar el icono como no marcado (gris)
              icon: Icon(Icons.shopping_bag, color: isSelected ? Colors.teal.shade300 : null),
              onPressed: () {
                setState(() {
                  //TODO: Activ1: agregar o quitar el item de la lista de seleccionados
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
      ),
    ),
    );
  }

  //TODO: Activ1: método para obtener los productos seleccionados
  List<Product> getSelectedProducts() {
    return _selectedProducts;
  }


}