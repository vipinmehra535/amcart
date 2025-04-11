import 'package:amcart/common/widgets/bottom_bar.dart';
import 'package:amcart/features/address/screens/adress_screen.dart';
import 'package:amcart/features/admin/screens/add_product_screen.dart';
import 'package:amcart/features/auth/screens/auth_screen.dart';
import 'package:amcart/features/home/screens/categorey_deal_screen.dart';
import 'package:amcart/features/home/screens/home_screen.dart';
import 'package:amcart/features/product_details/screens/product_details_screen.dart';
import 'package:amcart/features/search/screens/search_screen.dart';
import 'package:amcart/models/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> genrateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const AuthScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const HomeScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const BottomBar(),
      );
    case CategoreyDealScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => CategoreyDealScreen(
          category: category,
        ),
      );

    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const AddProductScreen(),
      );

    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );

    case ProductDetailsScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => ProductDetailsScreen(
          product: product,
        ),
      );

    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmount: totalAmount,
        ),
      );
    // case OrderDetailScreen.routeName:
    //   var order = routeSettings.arguments as Order;
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => OrderDetailScreen(
    //       order: order,
    //     ),
    //   );

    default:
      return MaterialPageRoute(
          builder: (context) =>
              const Scaffold(body: Center(child: Text("InValid Page"))));
  }
}
