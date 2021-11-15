import 'package:flutter/material.dart';
import '/widgets/app_drawer.dart';
import '/widgets/user_product_item.dart';
import '/providers/products.dart';
import 'package:provider/provider.dart';

import 'edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
static const routeName = '/user-products';

// final String id;
// final String title;
// final String imageUrl;
// UserProductScreen(this.imageUrl,this.title,this.id);

  @override
  Widget build(BuildContext context) {

    final productData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title:const Text('Your Products'),
        actions: [
          IconButton(
              icon:const Icon(Icons.add ),
              onPressed: (){
              //  Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: id );
              },
          ),

        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding:const EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (_,i) => UserProductItem(
              productData.items[i].id,
              productData.items[i].title,
              productData.items[i].imageUrl),
          itemCount:  productData.items.length,
        )
      )
    );
  }
}
