import 'package:flutter/material.dart';
import '/providers/products.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {

  UserProductScreen();
  @override
  Widget build(BuildContext context) {

    final productData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title:Text('Your Products'),
        actions: [
          IconButton(
              icon:Icon(Icons.add ),
          onPressed: (){},
          ),

        ],
      ),
      body: Padding(
        padding:EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (_,i) => UserProductScreen(productData.items[i].title,
              productData.items[i].imageUrl),
          itemCount:  productData.items.length,
        )
      )
    );
  }
}
