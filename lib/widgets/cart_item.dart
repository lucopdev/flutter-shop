import 'package:flutter_shop/common/my_colors.dart';
import 'package:flutter_shop/model/cart.dart';
import 'package:flutter_shop/model/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final CartItemModel cartItemModel;

  const CartItem({
    required this.cartItemModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (_) {
        Provider.of<Cart>(context, listen: false)
            .removeItem(cartItemModel.productId);
      },
      key: ValueKey(cartItemModel.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) {
        return showDialog<bool>(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Tem certeza?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(true),
                  child: const Text('Sim'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(false),
                  child: const Text('Não'),
                ),
              ],
            );
          },
        );
      },
      background: Container(
        color: MyColors.mainColor,
        padding: const EdgeInsets.only(right: 10),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: Card(
        child: ListTile(
          title: Text(cartItemModel.name),
          subtitle: Text(
              'Total: R\$ ${cartItemModel.price * cartItemModel.quantity}'),
          trailing: Text('x${cartItemModel.quantity.toString()}'),
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: FittedBox(
                  child: Text(
                cartItemModel.price.toString(),
                style: const TextStyle(color: MyColors.lightText),
              )),
            ),
          ),
        ),
      ),
    );
  }
}
