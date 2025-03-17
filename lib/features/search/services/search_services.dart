import 'package:amcart/models/product.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:amcart/constants/error_handling.dart';
import 'package:amcart/constants/global_variables.dart';
import 'package:amcart/constants/utlis.dart';
import 'package:amcart/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SearchServices {
  /// Fetches the list of products based on the search query.
  ///
  /// [searchQuery] is the query string to search for.
  ///
  /// Returns a list of [Product] that match the search query.
  ///
  /// Calls [httpErrorHandle] to handle any errors that occur during the
  /// request.
  ///
  /// If the request is successful, it adds each product to the [productList]
  /// and returns it.
  ///
  /// If the request fails, it shows the error in a [SnackBar] using
  /// [showSnackBar].
  ///
  /// Requires the [BuildContext] and the [UserProvider] to be available
  /// in the widget tree.
  Future<List<Product>> fetchSearchProduct({
    required BuildContext context,
    required String searchQuery,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/products?search=$searchQuery'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
    return productList;
  }
}
