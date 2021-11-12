import 'package:flutter/material.dart';
import '/providers/orders.dart';
import '/screens/cart_screen.dart';
import 'screens/orders_screen.dart';
import 'package:provider/provider.dart';
import './screens/product_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import 'providers/cart.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.deepOrange,
          primaryColor: Colors.deepOrange,
          fontFamily: 'Lato'
        ),
        home: ProductOverViewScreen(),
        routes: {
          ProductDetailScreen.routeName : (ctx) =>  ProductDetailScreen(),
          CartScreen.routeName : (ctx) =>  CartScreen(),
          OrdersScreen.routeName : (ctx) =>  OrdersScreen(),

        },
      ),
    );
  }
}

