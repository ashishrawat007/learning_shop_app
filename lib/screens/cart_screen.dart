import 'package:flutter/material.dart';
import '/providers/cart.dart';
import '/providers/orders.dart';
import 'package:provider/provider.dart';
import '../widgets/cart_item.dart' as ci;
class CartScreen extends StatelessWidget {
static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart")
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child:Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total' ,
                    style:  TextStyle(
                        fontSize: 20
                    ),),
                 const Spacer(),
                  Chip(
                      label: Text('\$${cart.totalAmount.toStringAsFixed(2)}' ,
                      style: TextStyle(color: Colors.white),
                      ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    child: const Text('Order Now'),
                  onPressed: ()
                    {
                      Provider.of<Orders>(context, listen: false).addOrder(
                          cart.items.values.toList(),
                          cart.totalAmount);

                      cart.clear();
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)
                    ),
                  )

                ],
              ),
            ) ,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
            itemCount: cart.items.length,
              itemBuilder: (ctx,i) => ci.CartItem(
                productId: cart.items.keys.toList()[i],
                  id: cart.items.values.toList()[i].id,
                  title: cart.items.values.toList()[i].title,
                  quantity: cart.items.values.toList()[i].quantity,
                  price: cart.items.values.toList()[i].price),

            ),
          )
        ],
      ),
    );
  }
}
