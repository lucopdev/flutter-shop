import 'package:flutter_shop/common/app_routes.dart';
import 'package:flutter_shop/common/my_colors.dart';
import 'package:flutter_shop/model/product_list.dart';
import 'package:flutter_shop/widgets/app_drawer.dart';
import 'package:flutter_shop/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProductList productList = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUCTFORM);
            },
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: productList.itemsCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              ProductItem(product: productList.items[i]),
              const Divider(),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(22.0),
        child: FloatingActionButton(
          backgroundColor: const Color.fromARGB(150, 255, 255, 255),
          elevation: 4,
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.PRODUCTFORM);
          },
          child: const Icon(
            Icons.add,
            color: MyColors.mainColor,
            size: 40,
          ),
        ),
      ),
    );
  }
}
