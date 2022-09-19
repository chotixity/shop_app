import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/Cart_screen.dart';
import '../providers/products_provider.dart';
import '../widgets/product_item.dart';
import '../providers/product.dart';
import '../widgets/201 badge.dart';
import '../providers/cart.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatelessWidget {
  ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions value) {
              if (value == FilterOptions.Favorites) {
                productsData.showFavoriesOnly();
              } else {
                productsData.showAll();
              }
            },
            itemBuilder: ((context) => [
                  const PopupMenuItem(
                    value: FilterOptions.Favorites,
                    child: Text('only Favorites'),
                  ),
                  const PopupMenuItem(
                    value: FilterOptions.All,
                    child: Text('show all'),
                  ),
                ]),
            icon: const Icon(Icons.more_vert),
          ),
          Consumer<Cart>(
            builder: (context, cart, child) => Badge(
              value: cart.itemCount.toString(),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routename);
                },
              ),
            ),
          )
        ],
      ),
      body: ProductsGrid(),
    );
  }
}

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: ProductItem(
            //products[index].id,
            //products[index].title,
            //products[index].imageUrl,
            ),
      ),
      itemCount: products.length,
    );
  }
}
