class Product {
   int id;
   String name;
   String image;
   double price;

  Product({required this.id, this.name = "", this.image = "", this.price = 0.0});

  @override
  String toString() {
    return 'ID: $id - Name: $name - Price: $price';
  }
}