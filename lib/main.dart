import 'package:flutter_shop/common/app_routes.dart';
import 'package:flutter_shop/common/my_colors.dart';
import 'package:flutter_shop/model/cart.dart';
import 'package:flutter_shop/model/order_list.dart';
import 'package:flutter_shop/model/product_list.dart';
import 'package:flutter_shop/screens/cart_screen.dart';
import 'package:flutter_shop/screens/orders_screen.dart';
import 'package:flutter_shop/screens/product_detail_screen.dart';
import 'package:flutter_shop/screens/product_form_screen.dart';
import 'package:flutter_shop/screens/product_overview_page.dart';
import 'package:flutter_shop/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
      ],
      child: MaterialApp(
        title: 'E-Store',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: MyColors.mainColor,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'Anton',
              fontSize: 22,
            ),
          ),
          drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
          iconButtonTheme: const IconButtonThemeData(
              style: ButtonStyle(
                  iconColor: MaterialStatePropertyAll(Colors.white))),
          colorScheme: ColorScheme.fromSeed(
            seedColor: MyColors.mainColor,
          ),
          useMaterial3: true,
          textTheme: const TextTheme(
              headlineLarge: TextStyle(
                color: MyColors.mainColor,
                fontFamily: 'Anton',
                fontSize: 14,
              ),
              headlineMedium: TextStyle(
                color: MyColors.darkText,
                fontFamily: 'Anton',
                fontSize: 14,
              ),
              titleLarge: TextStyle(
                color: MyColors.lightText,
                fontFamily: 'Anton',
              ),
              titleSmall: TextStyle(
                color: MyColors.lightText,
                fontFamily: 'Lato',
                fontSize: 12,
              ),
              titleMedium: TextStyle(
                color: MyColors.mainColor,
                fontFamily: 'Anton',
                fontSize: 14,
              )),
        ),
        home: const ProductOverviewPage(),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.HOME: (ctx) => const ProductOverviewPage(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => const ProductDetailScreen(),
          AppRoutes.CART: (ctx) => const CartScreen(),
          AppRoutes.ORDERS: (ctx) => const OrdersScreen(),
          AppRoutes.PRODUCTS: (ctx) => const ProductScreen(),
          AppRoutes.PRODUCTFORM: (ctx) => const ProductFormScreen(),
        },
      ),
    );
  }
}
