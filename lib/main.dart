import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/products_overview.screen.dart';
import './screens/product_detail.screen.dart';
import './screens/cart.screen.dart';
import './screens/orders.screen.dart';
import './screens/user_products.screen.dart';
import './screens/edit_product.screen.dart';
import './screens/auth.screen.dart';

import './providers/products.provider.dart';
import './providers/cart.provider.dart';
import './providers/orders.provider.dart';
import './providers/auth.provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider()
        ),
        ChangeNotifierProvider(
         create: (_) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
         create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
         create: (_) => OrdersProvider(),
        ),
      ],
      // value:ProductsProvider(),
      child: Consumer<AuthProvider>(
        builder:(ctx, authData, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: authData.isAuth ? ProductsOverviewScreen() : AuthScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          }
        )
      )
    );
  }
}

// .value vs create
// .value is better with builder methods and reuses a provider, cause it updates the state correctly
// Whenever you instanciate a class you should use a create method for eficiency
// When we replace a screen is important to clean the provider Data, the ChangeNotifierProvider cleans the Data automaticly