import 'package:flutter/material.dart';
import '/providers/cart.dart';
import '/providers/product.dart';
import 'package:provider/provider.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context,listen: false);
    final cart = Provider.of<Cart>(context,listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                  arguments: product.id);
            },
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
              backgroundColor: Colors.black87,
              leading:  Consumer<Product>(
                builder: (ctx, product, child) => IconButton(
                  // widget which don't build
                  // title: child  -> child argument in builder
                    icon: Icon(product.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border),
                    onPressed: () {
                      product.toggleFavoriteStatus();
                    },
                    color: Theme.of(context).primaryColor),
                //child: Text("hello "), -> will not a part of re renders
              ),
              trailing: IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: (){
                    cart.addItem(product.id , product.price, product.title);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('add item to cart'),
                        duration: Duration(seconds: 1),
                          action: SnackBarAction(
                            label: 'UNDO' ,
                            onPressed: (){
                              cart.removeSingleItem(product.id);
                            },),
                        ));
                  },
                  color: Theme.of(context).primaryColor),
              title: Text(product.title, textAlign: TextAlign.center))),
    );
  }
}
