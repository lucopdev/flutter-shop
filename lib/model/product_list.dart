import 'dart:convert';
import 'dart:math';
import 'dart:collection';
import 'package:flutter_shop/data/dummy_data.dart';
import 'package:flutter_shop/model/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductList with ChangeNotifier {
  final _baseUrl = 'https://flutter-shop-461bd-default-rtdb.firebaseio.com/';
  final List<Product> _items = DUMMY_PRODUCTS;
  UnmodifiableListView<Product> get items => UnmodifiableListView(_items);
  List<Product> get favoriteItems =>
      _items.where((item) => item.isFavorite).toList();

  void addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/products.json'),
      body: jsonEncode(
        {
          "name": product.name,
          "price": product.price,
          "description": product.description,
          "imageUrl": product.imageUrl,
          "isFavorite": product.isFavorite,
        },
      ),
    );

    if (response.statusCode == 200) {
      final id = jsonDecode(response.body)['name'];
      _items.add(
        Product(
          id: id,
          name: product.name,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
        ),
      );

      notifyListeners();
    } else {
      print('Error');
    }
  }

  void updateProduct(Product product) {
    int index = _items.indexWhere((element) => element.id == product.id);
    if (index >= 0) {
      _items[index] = product;

      notifyListeners();
    }
  }

  void saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final newProduct = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      updateProduct(newProduct);
    } else {
      addProduct(newProduct);
    }
  }

  int get itemsCount {
    return _items.length;
  }

  void deleteProduct(Product product) {
    int index = _items.indexWhere((element) => element.id == product.id);

    if (index >= 0) {
      _items.removeAt(index);

      notifyListeners();
    }
  }

  // bool _showFavoriteOnly = false;

  // UnmodifiableListView<Product> get items {
  //   if (_showFavoriteOnly) {
  //     return UnmodifiableListView(
  //         _items.where((product) => product.isFavorite).toList());
  //   }
  //   return UnmodifiableListView(_items);
  // }

  // void onShowFavoriteOnly() {
  //   _showFavoriteOnly = true;
  //   notifyListeners();
  // }

  // void onShowAll() {
  //   _showFavoriteOnly = false;
  //   notifyListeners();
  // }
}
