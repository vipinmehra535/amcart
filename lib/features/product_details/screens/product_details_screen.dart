import 'package:amcart/common/widgets/custom_button.dart';
import 'package:amcart/common/widgets/stars.dart';
import 'package:amcart/constants/global_variables.dart';
import 'package:amcart/constants/utlis.dart';
import 'package:amcart/features/product_details/services/product_details_services.dart';
import 'package:amcart/features/search/screens/search_screen.dart';
import 'package:amcart/models/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final TextEditingController searchController = TextEditingController();
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
    searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      controller: searchController,
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide:
                              BorderSide(color: Colors.black38, width: 1),
                        ),
                        hintText: 'Search amCart.in',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, color: Colors.black, size: 25),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.product.id!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        const Stars(rating: 4.0),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.product.category,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  CarouselSlider(
                    items: widget.product.images.map(
                      (i) {
                        return Builder(
                          builder: (BuildContext context) => ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              i,
                              fit: BoxFit.scaleDown,
                              height: 200,
                            ),
                          ),
                        );
                      },
                    ).toList(),
                    options: CarouselOptions(
                      viewportFraction: 1,
                      height: 300,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 4),
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                      autoPlayCurve: Curves.easeOutBack,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.product.name,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      '\$${widget.product.price}',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.product.description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      '${(widget.product.quantity).toInt()} items available',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.cyan[800],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'Rate this product',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (itemContext, index) =>
                        const Icon(Icons.star, color: Colors.amber),
                    itemCount: 5,
                    onRatingUpdate: (rating) {
                      productDetailsServices.rateProduct(
                        context: context,
                        product: widget.product,
                        rating: rating,
                        onSuccess: () {
                          showSnackBar(context, 'Thanks for your feedback!');
                        },
                      );
                    },
                    unratedColor: Colors.black12,
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.black12, width: 1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(text: 'Buy Now', onTap: () {}),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    text: 'Add to Cart',
                    onTap: () {},
                    color: const Color.fromARGB(255, 70, 145, 160),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
