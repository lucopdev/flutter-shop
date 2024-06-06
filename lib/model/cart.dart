import 'dart:math';

import 'package:flutter_shop/model/cart_item_model.dart';
import 'package:flutter_shop/model/product.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  bool isTheLastItem = false;

  Map<String, CartItemModel> _items = {};

  Map<String, CartItemModel> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalPrice {
    double total = 0.0;
    _items.forEach((key, item) {
      total += (item.price * item.quantity);
    });
    return total;
  }

  void removeItem(String productId) {
    _items.remove(productId);

    notifyListeners();
  }

  void clear() {
    _items = {};

    notifyListeners();
  }

  void unDoIt(Product product) {
    if (_items.containsKey(product.id) && !isTheLastItem) {
      _items.update(
        product.id,
        (itemFound) {
          itemFound.quantity <= 1 ? isTheLastItem = true : null;
          return CartItemModel(
            id: itemFound.id,
            productId: itemFound.productId,
            name: itemFound.name,
            quantity: itemFound.quantity - 1,
            price: itemFound.price,
          );
        },
      );

      notifyListeners();
    }
    if (isTheLastItem) {
      _items.remove(product.id);
      isTheLastItem = false;

      notifyListeners();
    }
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (itemFound) => CartItemModel(
          id: itemFound.id,
          productId: itemFound.productId,
          name: itemFound.name,
          quantity: itemFound.quantity + 1,
          price: itemFound.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItemModel(
          id: Random().nextDouble().toString(),
          productId: product.id,
          name: product.name,
          quantity: 1,
          price: product.price,
        ),
      );
    }

    notifyListeners();
  }
}
