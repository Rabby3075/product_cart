import 'package:flutter/material.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Product(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
        )
      ),
    );
  }
}
class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  List<Map<String, dynamic>> items = [
    {"name": "Product 1", "Price": "\$10.5", "count": 0},
    {"name": "Product 2", "Price": "\$15.0", "count": 0},
    {"name": "Product 3", "Price": "\$20.5", "count": 0},
    {"name": "Product 4", "Price": "\$25.5", "count": 0},
    {"name": "Product 5", "Price": "\$43.5", "count": 0},
    {"name": "Product 6", "Price": "\$75.5", "count": 0},
  ];
  int getTotalItemCount() {
    return items.where((item) => item['count'] > 0).length;
  }

  @override
  Widget build(BuildContext context) {
    int totalItemCount = getTotalItemCount();
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${items[index]['name']}'),
            subtitle: Text(items[index]['Price']),
            trailing: Scrollbar(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Count: ${items[index]['count'].toString()}'),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          items[index]['count']++;
                          if(items[index]['count'] == 5){
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Congratulations!'),
                                    content: Text('You\'ve bought 5 ${items[index]['name']}!'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          print('Pressed');
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                }
                            );
                          }
                        });
                      },
                      child: Text('Buy Now'),
                    ),
                  ],
                ),
              ),
            ),
          );

        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          int totalBought = getTotalItemCount();
          Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(totalBought)),
          );
        },
        child: Icon(Icons.shopping_cart),
      ),

    );
  }
}
class CartPage extends StatelessWidget {
  final int totalProductsBought;

  CartPage(this.totalProductsBought);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Center(
        child: Text('Total Products : $totalProductsBought'),
      ),
    );
  }
}




