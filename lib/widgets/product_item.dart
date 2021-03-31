import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail.screen.dart';

import '../providers/product.provider.dart';
import '../providers/cart.provider.dart';
import '../providers/auth.provider.dart';

class ProductItem extends StatelessWidget {
  // final String imageUrl;
  // final String title;
  // final String id;

  // ProductItem(
  //   this.imageUrl,
  //   this.title,
  //   this.id,
  // );
  
  @override
  Widget build (BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);
    final authData = Provider.of<AuthProvider>(context, listen: false);
    
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              placeholder: AssetImage('assets/images/product-placeholder.png'),
              image: NetworkImage(
                product.imageUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id
            );
          }
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          leading: Consumer<Product>(
            builder: (ctx, product, _) {
              return IconButton(
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border
                ),
                onPressed:() {
                  product.toggleFavoriteStatus(authData.token, authData.userId);
                },
                color: Theme.of(context).accentColor,
              );
            },
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(
                id: product.id,
                title: product.title,
                price: product.price,
              );
              ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(
                  content: const Text(
                    "Added item to Cart"
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: "Undo",
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    }
                  ),
                )
              );
            },
            color: Theme.of(context).accentColor,
          ) 
        )
      )
    );
  }
}

// Consumer vs Provider
// Provider will rerun whenever the data changes
// When you only want to change a sub part of the widget you can use a consumer to just observe this part of the widget