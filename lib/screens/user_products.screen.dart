import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product.screen.dart';

import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';

import '../providers/products.provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/users-product';

  Future<void> _refreshProducts(BuildContext context) async {
    return await Provider.of<ProductsProvider>(context, listen: false)
      .fetchAndSetProducts(true);
  }

  @override
  Widget build (BuildContext context) {
    // final productsData = Provider.of<ProductsProvider>(context);
    print("DALE");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(
                EditProductScreen.routeName,
              );
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapShot) => snapShot.connectionState == ConnectionState.waiting 
        ?
        Center(
          child: CircularProgressIndicator()
        )
        : 
        RefreshIndicator(
          onRefresh: () {
            return _refreshProducts(context);
          },
          child: Consumer<ProductsProvider>(
            builder:(ctx, productsData, _) => Padding(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return Column(
                    children: <Widget>[
                      UserProductItem(
                        productsData.items[index].id,
                        productsData.items[index].title,
                        productsData.items[index].imageUrl,
                      ),
                      Divider(),
                    ]
                  );
                },
                itemCount: productsData.items.length,
              )
            )
          )
        )
      )
    );
  }
}