import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/orders.screen.dart';
import '../screens/user_products.screen.dart';

import '../providers/auth.provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Hello Friend'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.shop,
            ),
            title: const Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                '/'
              );
            }
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.payment,
            ),
            title: const Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                OrdersScreen.routeName
              );
            }
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.edit,
            ),
            title: const Text('Manage products'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                UserProductsScreen.routeName
              );
            }
          ),
            Divider(),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
            ),
            title: const Text('Log out'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(
                '/'
              );
              Provider.of<AuthProvider>(context, listen: false).logout();
            }
          ),
        ]
      ),
    );
  }
}