import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/Bloc/products_bloc.dart';
import 'package:test/model/product_model.dart';
import 'package:test/presentation/productpage.dart'; // Import the ProductsBloc

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(LoadProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: BlocBuilder<ProductsBloc, ProductsState>(
                    builder: (context, state) {
                      if (state is ProductsLoading) {
                        return const Center(
                            child:
                                CircularProgressIndicator()); // Show loading spinner while data is being fetched
                      } else if (state is ProductsLoaded) {
                        List<Product> products = state.products;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(FontAwesomeIcons.bars),
                                Icon(
                                  FontAwesomeIcons.cartShopping,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Text(
                              "Discover Our exclusive\nproducts",
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "in this marketplace,you will find various technics in the cheapest price",
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Products",
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                                child: GridView.builder(
                              padding: const EdgeInsets.all(
                                  12), // Add padding around the grid
                              itemCount: products.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // 2 items per row
                                crossAxisSpacing: 12.0, // Space between columns
                                mainAxisSpacing: 12.0, // Space between rows
                                childAspectRatio:
                                    0.75, // Adjust aspect ratio for larger cards
                              ),
                              itemBuilder: (context, index) {
                                Product product = products[index];
                                return GestureDetector(
                                  onTap: () {
                                    log("Tapped on product: ${product.id}");
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                        return ProductPage(
                                          id: product.id,
                                        );
                                      }),
                                    );
                                  },
                                  child: Card(
                                    color: Colors.white,
                                    elevation:
                                        6, // Increase shadow for emphasis
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          16), // Larger rounded corners
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                          12.0), // Add padding inside the card
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                product.thumbnail,
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            product.title,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  16, // Larger font size for title
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            '\$${product.price}',
                                            style: const TextStyle(
                                              color: Colors.green,
                                              fontSize:
                                                  14, // Larger font size for price
                                            ),
                                          ),
                                          Text(
                                            'Availability: ${product.availabilityStatus}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize:
                                                    12), // Adjusted font size
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )),
                          ],
                        );
                      } else if (state is ProductsError) {
                        return Center(child: Text('Error: ${state.message}'));
                      } else {
                        return const Center(
                            child: Text('No products available.'));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
