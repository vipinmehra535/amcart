import 'package:amcart/common/widgets/loader.dart';
import 'package:amcart/constants/global_variables.dart';
import 'package:amcart/features/home/widgets/address_box.dart';
import 'package:amcart/features/product_details/screens/product_details_screen.dart';
import 'package:amcart/features/search/services/search_services.dart';
import 'package:amcart/features/search/widget/search_product.dart';
import 'package:amcart/models/product.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({
    super.key,
    required this.searchQuery,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? productList;
  final SearchServices searchServices = SearchServices();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchSearchProduct();
  }

  fetchSearchProduct() async {
    productList = await SearchServices()
        .fetchSearchProduct(context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

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
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
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
      body: productList == null
          ? const Loader()
          : Column(
              children: [
                const AddressBox(),
                Expanded(
                  child: ListView.builder(
                    itemCount: productList!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          ProductDetailsScreen.routeName,
                          arguments: productList![index],
                        ),
                        child: SearchProduct(
                          product: productList![index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
