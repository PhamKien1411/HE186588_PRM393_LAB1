import 'package:flutter/material.dart';
import 'entity/product.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductPage(),
    );
  }
}

class ProductPage extends StatefulWidget {
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Product> productList = [
    Product(
      id: 1,
      name: "Laptop",
      image:
      "https://images.unsplash.com/photo-1496181133206-80ce9b88a853",
      price: 1000,
    ),

    Product(
      id: 2,
      name: "IPhone",
      image:
      "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9",
      price: 500,
    ),

    Product(
      id: 3,
      name: "Samsung",
      image:
      "https://images.unsplash.com/photo-1610945265064-0e34e5519bbf",
      price: 400,
    ),
  ];

  List<Product> filteredList = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredList = productList;
  }


  void addProduct() {
    setState(() {
      productList.add(
        Product(
          id: productList.length + 1,
          name: "New Product",
          image: "https://picsum.photos/202",
          price: 300,
        ),
      );

      filteredList = productList;
    });
  }


  void deleteProduct(int index) {
    setState(() {
      productList.removeAt(index);
      filteredList = productList;
    });
  }


  void updateProduct(int index) {
    setState(() {
      productList[index].name = "Updated Product";
      productList[index].price = 999;

      filteredList = productList;
    });
  }


  void searchProduct(String keyword) {
    setState(() {
      filteredList = productList.where((product) {
        return product.name
            .toLowerCase()
            .contains(keyword.toLowerCase());
      }).toList();
    });
  }


  void sortAscending() {
    setState(() {
      productList.sort((a, b) => a.price.compareTo(b.price));
      filteredList = productList;
    });
  }



  void sortDescending() {
    setState(() {
      productList.sort((a, b) => b.price.compareTo(a.price));
      filteredList = productList;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Product Manager"),
        backgroundColor: Colors.blue,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: addProduct,
        child: Icon(Icons.add),
      ),

      body: Column(
        children: [


          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: searchController,
              onChanged: searchProduct,
              decoration: InputDecoration(
                labelText: "Search Product",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              ElevatedButton(
                onPressed: sortAscending,
                child: Text("Sort ASC"),
              ),

              ElevatedButton(
                onPressed: sortDescending,
                child: Text("Sort DESC"),
              ),
            ],
          ),

          SizedBox(height: 10),


          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {

                Product product = filteredList[index];

                return Card(
                  margin: EdgeInsets.all(10),

                  child: ListTile(

                    leading: Image.network(
                      product.image,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),

                    title: Text(product.name),

                    subtitle: Text(
                      "Price: \$${product.price}",
                    ),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        

                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            updateProduct(index);
                          },
                        ),


                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            deleteProduct(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}