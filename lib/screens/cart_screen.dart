import 'package:flutter_shop/model/cart.dart';
import 'package:flutter_shop/model/order_list.dart';
import 'package:flutter_shop/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final items = cart.items.values.toList();

    return Scaffold(
        appBar: AppBar(title: const Text('Carrinho')),
        body: Column(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Chip(
                      backgroundColor: Theme.of(context).primaryColor,
                      label: Text(
                        'R\$ ${cart.totalPrice.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Provider.of<OrderList>(
                          context,
                          listen: false,
                        ).addOrder(cart);

                        cart.clear();
                      },
                      child: Text(
                        'COMPRAR',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, index) =>
                    CartItem(cartItemModel: items[index]),
              ),
            ),
          ],
        ));
  }
}
