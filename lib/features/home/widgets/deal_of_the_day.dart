import 'package:amcart/common/widgets/loader.dart';
import 'package:amcart/features/home/services/home_services.dart';
import 'package:amcart/models/product.dart';
import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  final HomeServices homeServices = HomeServices();
  Product? product;

  @override
  void initState() {
    fetchDealOfTheDay();
    super.initState();
  }

  void fetchDealOfTheDay() async {
    // Fetch the deal of the day from the server or local storage
    // This is just a placeholder for the actual implementation
    product = await homeServices.fetchDealOfTheDay(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox(
                height: 235,
                child: Center(
                  child: Text(
                    'No deal of the day available',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )
            : GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  '/product-details',
                  arguments: product,
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15, top: 15),
                      child: const Text(
                        'Deal of the day',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Image.network(
                      product!.images[0],
                      width: double.infinity,
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        '\$100',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 15, top: 15, right: 40),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Viveka 100% cotton suit set',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: product!.images
                            .map(
                              (e) => Image.network(
                                e,
                                height: 100,
                                width: 100,
                                fit: BoxFit.fitHeight,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              );
  }
}
