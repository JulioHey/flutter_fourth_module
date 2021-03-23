import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/products_overview.screen.dart';
import './screens/product_detail.screen.dart';

import './providers/products.provider.dart';
import './providers/cart.provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
         create: (_) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
         create: (_) => CartProvider(),
        ),
      ],
      // value:ProductsProvider(),
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        }
      )
    );
  }
}

// .value vs create
// .value is better with builder methods and reuses a provider, cause it updates the state correctly
// Whenever you instanciate a class you should use a create method for eficiency
// When we replace a screen is important to clean the provider Data, the ChangeNotifierProvider cleans the Data automaticly