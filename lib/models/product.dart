class Product{
  int id;
  String name;
  double price;
  String category;
  String image;
  String description;
  int calories;
  int weight;
  double proteins;
  String nutriscore;
  String origin;
 late int quantity;

  Product(this.id, this.name,this.price, this.category, this.image, this.description, this.calories, this.weight, this.proteins, this.nutriscore, this.origin) {
    quantity = 0;
  }

  factory Product.fromMap(Map<String, dynamic> map) => Product(
    map['id'],
    map['name'],
    map['price'],
    map['category'],
    map['image'],
    map['description'],
    map['calories'],
    map['weight'],
    map['proteins'],
    map['nutriscore'],
    map['origin']);

  //TODO: Activ4: metodo para obtener la imagen de la categoria de cada item
  String getImageCategory() {

    switch(category) {
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