import 'package:flutter_shop/model/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderGrid extends StatefulWidget {
  final Order order;
  const OrderGrid({
    required this.order,
    super.key,
  });

  @override
  State<OrderGrid> createState() => _OrderGridState();
}

class _OrderGridState extends State<OrderGrid> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            'R\$ ${widget.order.total.toStringAsFixed(2)}',
          ),
          subtitle: Text(
            DateFormat('dd/MM/yyyy hh:mm').format(widget.order.date),
          ),
          trailing: IconButton(
            onPressed: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
            icon: const Icon(Icons.expand_more),
          ),
        ),
        if (_expanded)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 4,
            ),
            height: (widget.order.products.length * 40) + 10,
            child: ListView(
              children: widget.order.products.map((product) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        '${product.quantity.toString()}x ${product.price.toString()}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
