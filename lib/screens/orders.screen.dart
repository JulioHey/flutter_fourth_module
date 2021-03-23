import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

import '../providers/orders.provider.dart' show OrdersProvider;

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  
  @override
  Widget build (BuildContext context) {
    final orderData = Provider.of<OrdersProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return OrderItem(
            orderData.orders[index]
          );
        },
        itemCount: orderData.orders.length,
      )
    );
  }
}