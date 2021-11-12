import 'package:flutter/foundation.dart';

class CartItem
{
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price
  });
}



class Cart with ChangeNotifier
{
 Map<String, CartItem> _items ={};

Map<String , CartItem> get items
{
  return {..._items};
}

double get totalAmount
{
 double total =0.0 ;
 _items.forEach((key, cartItem) {
    total += cartItem.price * cartItem.quantity;
  });
 return total;
}
int get itemCount
{
if (_items == null) {
  return 0;
} else {
  return _items.length;
}
}

void addItem(String productId, double price , String title)
{
  if(_items.containsKey(productId))
    {
      _items.update(productId,
              (existingCartItem) =>  CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity + 1 ,
          price: existingCartItem.price));
    }
  else
    {
      _items.putIfAbsent(productId ,
          ()=> CartItem(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price),

      );
    }
  notifyListeners();
}

    void removeItem(String prodId)
    {
      _items.remove(prodId);
      notifyListeners();
    }

    void removeSingleItem(String prodId)
    {
      if(!_items.containsKey(prodId))
        {
          return ;
        }
    if(_items[prodId]!.quantity > 1)
      {
        _items.update(prodId, (existingItem)
        => CartItem(
            id: existingItem.id,
            title: existingItem.title,
            quantity: existingItem.quantity-1,
            price: existingItem.price));
      }
    else
      {
        _items.remove(prodId);
      }
    notifyListeners();
    }
    void clear()
    {
      _items = {};
      notifyListeners();
    }
}