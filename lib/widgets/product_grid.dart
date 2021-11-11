import 'package:flutter/material.dart';
import 'package:learning_shop_app/providers/products.dart';
import 'package:provider/provider.dart';
import 'product_item.dart';

class ProductGrid extends StatelessWidget {

  final bool showFavs ;
  ProductGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {

    final productData = Provider.of<Products>(context);
    final products = showFavs ? productData.favoriteItems : productData.items;

    return GridView.builder(
      padding:const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) =>
          ChangeNotifierProvider.value(
              value:  products[index],
              child: ProductItem()
          ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2 ,
          childAspectRatio: 3/2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10
      ),
      shrinkWrap: true,
    );
  }
}
