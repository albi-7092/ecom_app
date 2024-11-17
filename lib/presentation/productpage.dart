import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/Bloc/products_bloc.dart';
import 'package:test/model/product_model.dart';
import 'package:test/presentation/formedit.dart'; // Assuming Product model is defined in this file

// ignore: must_be_immutable
class ProductPage extends StatelessWidget {
  final int id; // The id of the product to show

  // Constructor to receive the id
  const ProductPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(FontAwesomeIcons.arrowLeft)),
        actions: const [
          Icon(FontAwesomeIcons.heart),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoaded) {
              Product? selectedProduct = state.products.firstWhere(
                (product) => product.id == id,
                orElse: () => Product(
                  images: [''],
                  meta: Meta(
                      createdAt: '', updatedAt: '', barcode: '', qrCode: ''),
                  minimumOrderQuantity: 0,
                  returnPolicy: '',
                  reviews: [],
                  shippingInformation: '',
                  warrantyInformation: '',
                  brand: '',
                  sku: '',
                  weight: 0,
                  dimensions: Dimensions(width: 0, height: 0, depth: 0),
                  tags: [],
                  stock: 0,
                  rating: 0,
                  discountPercentage: 0,
                  category: '',
                  id: 0,
                  title: 'No Product Found',
                  description: 'This product is not available.',
                  price: 0.0,
                  availabilityStatus: 'Unavailable',
                  thumbnail: '',
                ),
              );

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product image
                      Image.network(selectedProduct.thumbnail),
                      const SizedBox(height: 20),
                      // Product title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${selectedProduct.price}',
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Transform.scale(
                            alignment: Alignment.centerRight,
                            scale: 0.6,
                            child: RatingBar.builder(
                              initialRating: selectedProduct.rating,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 1),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                log("rating:$rating");
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              selectedProduct.title,
                              maxLines: 3,
                              style: const TextStyle(
                                  overflow: TextOverflow.visible,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(selectedProduct.category)
                        ],
                      ),
                      Text(
                        "${selectedProduct.stock} stock left",
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 10),
                      // Product description
                      Text(
                        selectedProduct.description,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [Text("brand :${selectedProduct.brand}")],
                      )
                    ],
                  ),
                ),
              );
            } else if (state is ProductsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductsError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('No products available.'));
            }
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        shape: const CircularNotchedRectangle(),
        color: Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF17203A),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Formedit(
                  id: id,
                );
              }));
            },
            child: const Text(
              'Edit product details',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
