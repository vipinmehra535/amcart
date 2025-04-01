import 'dart:convert';

import 'package:amcart/constants/error_handling.dart';
import 'package:amcart/constants/global_variables.dart';
import 'package:amcart/constants/utlis.dart';
import 'package:amcart/models/product.dart';
import 'package:amcart/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:http/http.dart' as http;

class ProductDetailsServices {
  // This class will handle the product details related services
  // such as fetching product details, adding to cart, etc.
  // For now, we will leave it empty and implement it later.
  // This class will be used to fetch product details from the API
  // and return the product details to the UI.

  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
    required VoidCallback onSuccess,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/admin/rating"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.user.token,
        },
        body: jsonEncode(
          <String, dynamic>{
            'id': product.id!,
            'rating': rating,
          },
        ),
      );
      if (!context.mounted) return;
      httpErrorHandle(response: res, context: context, onSuccess: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
