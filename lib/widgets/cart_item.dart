import 'package:flutter/material.dart';
import 'package:learning_shop_app/providers/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
final String id ;
final String productId ;
 final double price  ;
 final int quantity ;
 final String title ;

 CartItem({
   required this.id,
   required this.productId,
   required this.price,
   required this.quantity,
   required this.title
 });

  @override
  Widget build(BuildContext context) {
    return  Dismissible(
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
       return showDialog(
           context: context,
           builder: (ctx) =>  AlertDialog(
             title:Text('Are You Sure ?'),
             content: Text('Do you wnt to remove the item from the cart ?'),
               actions: [
                 TextButton(
                   child: Text('No'),
                   onPressed: ()
                   {
                     Navigator.of(ctx).pop(false);
                   },
                 ),
                 TextButton(
                   child: Text('No'),
                   onPressed: ()
                   {
                     Navigator.of(ctx).pop(true);
                   },
                 )
               ]
           ),

       );
      },
      onDismissed: (direction)
      {
        Provider.of<Cart>(context, listen:false).removeItem(productId);
      },
      key: ValueKey(id),
      background: Container(
        color: Colors.red,
        child: Icon(Icons.delete,
        size: 30,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right:20),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal:15
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Text("\$$price", style: const TextStyle(
                fontSize: 12
              ),),),
            title: Text(title),
            subtitle: Text('Total: \$${(price*quantity)}'),
            trailing: Text('$quantity'),
          ),
        ),
      ),
    );
  }
}
