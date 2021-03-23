import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build (BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children : <Widget>[
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.headline1.color,
                      )
                    ),
                    backgroundColor: Theme.of(context).primaryColor,                      
                  ),
                  TextButton(
                    child: Text(
                      'Order Now',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ]
              )
            ),
          )
        ]
      ),
    );
  }
}