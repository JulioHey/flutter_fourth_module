import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart.screen.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';

import '../providers/cart.provider.dart';

enum FilterOptions {
  Favorites,
  All
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductsOverviewScreen>{
  var _showOnlyFavorites = false;
  
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products Overview'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert
            ),
            itemBuilder: (_) {
              return [
                PopupMenuItem(
                  child: Text('Only Favorites'),
                  value: FilterOptions.Favorites,
                ),
                PopupMenuItem(
                  child: Text('Show All'),
                  value: FilterOptions.All,
                ),
              ];
            }
          ),
          Consumer<CartProvider>(
            builder: (_, cart, child) {
              return Badge(
                child: child,
                value: cart.itemCount.toString(),
              );
            },
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  CartScreen.routeName
                );
              },
            ),
          )
        ]
      ),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}

// Added PopupManu to handle just show favorites