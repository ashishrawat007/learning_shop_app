import 'package:flutter/material.dart';
import 'package:learning_shop_app/providers/cart.dart';
import 'package:learning_shop_app/screens/cart_screen.dart';
import 'package:learning_shop_app/widgets/app_drawer.dart';
import 'package:learning_shop_app/widgets/badge.dart';
import 'package:learning_shop_app/widgets/product_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favourites,
  All
}

class ProductOverViewScreen extends StatefulWidget {



  @override
  State<ProductOverViewScreen> createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {

  var _showOnlyFavorites =false;
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedVal) {
               setState(() {
                 if(selectedVal== FilterOptions.Favourites)
                 {
                   _showOnlyFavorites =true;
                 }
                 else{
                   _showOnlyFavorites =false;
                 }
               });

            },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
              const PopupMenuItem(
              child: Text('Only Favourites'),
              value: FilterOptions.Favourites ,),
              const PopupMenuItem(
                  child: Text('Show All'),
                  value: FilterOptions.All ),
              ] ),
          Consumer<Cart>(
            builder: (_, cart, ch) =>  Badge(
                child:  IconButton(
            icon: const Icon(Icons.shop),
           onPressed: (){
              Navigator.of(context).pushNamed(CartScreen.routeName);
           },
            ),
                value: cart.itemCount.toString(),
                ),

    )

        ],
        title: Text("My Shop")
      ),
      drawer: AppDrawer(),
      body: ProductGrid(_showOnlyFavorites),
    );
  }
}

