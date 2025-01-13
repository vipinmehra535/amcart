import 'package:amcart/common/widgets/loader.dart';
import 'package:amcart/features/account/widgets/single_product.dart';
import 'package:amcart/features/admin/services/admin_services.dart';
import 'package:amcart/models/product.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final AdminServices adminServices = AdminServices();

  List<Product>? products;

  @override
  void initState() {
    super.initState();
    fetchAllProducts();

  }

  void fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(
      context: context,
    );
    setState(() {});
  }

  void deleteProducts(Product product, int index) {
    adminServices.deleteProducts(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, '/add-product');
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: products == null
          ? const Loader()
          : GridView.builder(
              itemCount: products!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final product = products![index];
                return Column(
                  children: [
                    SizedBox(
                      child: SingleProduct(
                        image: product.images[0],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        IconButton(
                          onPressed: () => deleteProducts(product, index),
                          icon: const Icon(Icons.delete),
                        )
                      ],
                    )
                  ],
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddProduct,
        tooltip: 'Add a new product',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
