import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'product_item.dart';

import '../providers/products.provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  ProductsGrid(
    this.showFavs,
  );
  
  @override
  Widget build (BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);

    final products = showFavs ? productsData.favoriteItems : productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemBuilder: (ctx, index) {
        return ChangeNotifierProvider.value(
          value: products[index],
          child: ProductItem(
            // products[index].imageUrl,
            // products[index].title,
            // products[index].id,
          ),
        );
      },
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3/2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}