import 'package:amcart/common/widgets/loader.dart';
import 'package:amcart/features/account/widgets/single_product.dart';
import 'package:amcart/features/admin/services/admin_services.dart';
import 'package:amcart/features/order_details/screens/order_details.dart';
import 'package:amcart/models/order.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    fetchOrders();
    super.initState();
  }

  void fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.5,
            ),
            itemCount: orders?.length ?? 0,
            itemBuilder: (context, index) {
              final order = orders![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, OrderDetailScreen.routeName,
                      arguments: order);
                },
                child: SizedBox(
                  height: 140,
                  child: SingleProduct(
                    image: order.products[0].images[0],
                  ),
                ),
              );
            },
          );
  }
}
