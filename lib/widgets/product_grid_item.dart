import 'package:flutter_shop/common/app_routes.dart';
import 'package:flutter_shop/common/my_colors.dart';
import 'package:flutter_shop/model/cart.dart';
import 'package:flutter_shop/model/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(
      context,
      listen: false,
    );
    final cart = Provider.of<Cart>(
      context,
      listen: false,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          title: Text(
            product.name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          backgroundColor: MyColors.shadow,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              onPressed: product.toggleFavorite,
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_outline),
              color: MyColors.mainColor,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(product);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Produto adicionado com sucesso!'),
                  duration: const Duration(milliseconds: 2000),
                  action: SnackBarAction(
                    label: 'Desfazer',
                    onPressed: () {
                      cart.unDoIt(product);
                    },
                  ),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart),
            color: MyColors.mainColor,
          ),
        ),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(
            AppRoutes.PRODUCT_DETAIL,
            arguments: product,
          ),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
