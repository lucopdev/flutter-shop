import 'package:flutter_shop/common/app_routes.dart';
import 'package:flutter_shop/model/cart.dart';
import 'package:flutter_shop/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/common/my_colors.dart';
import 'package:flutter_shop/widgets/product_grid.dart';
import 'package:provider/provider.dart';

enum FilteredOptions {
  favorite,
  all,
}

class ProductOverviewPage extends StatefulWidget {
  const ProductOverviewPage({super.key});

  @override
  State<ProductOverviewPage> createState() => _ProductOverviewPageState();
}

class _ProductOverviewPageState extends State<ProductOverviewPage> {
  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.mainColor,
        title: const Text(
          'E-Store',
        ),
        actions: [
          Stack(children: [
            IconButton(
              onPressed: () => Navigator.of(context).pushNamed(
                AppRoutes.CART,
              ),
              icon: const Icon(Icons.shopping_cart),
              style: ButtonStyle(
                  iconColor: MaterialStateProperty.all(Colors.white)),
            ),
            Positioned(
              top: 7,
              right: 3,
              child: Consumer<Cart>(
                builder: (context, cart, child) => Badge.count(
                  count: cart.itemCount,
                ),
              ),
            ),
          ]),
          PopupMenuButton(
            color: MyColors.accentColor,
            iconColor: Colors.white,
            itemBuilder: (_) => [
              PopupMenuItem(
                value: FilteredOptions.favorite,
                child: Text(
                  'Favoritos',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              PopupMenuItem(
                value: FilteredOptions.all,
                child: Text(
                  'Todos',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
            onSelected: (value) {
              setState(() {
                value == FilteredOptions.favorite
                    ? _showFavoriteOnly = true
                    : _showFavoriteOnly = false;
              });
            },
          ),
        ],
      ),
      body: ProductGrid(showFavoriteOnly: _showFavoriteOnly),
      drawer: const AppDrawer(),
    );
  }
}
