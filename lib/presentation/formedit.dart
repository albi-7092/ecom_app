import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/Bloc/products_bloc.dart';
import 'package:test/presentation/home.dart';

// ignore: must_be_immutable
class Formedit extends StatelessWidget {
  final int id;
  Formedit({super.key, required this.id});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController title = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            log("Current state: $state"); // Log the state

            if (state is ProductsLoaded) {
              log('ProductsLoaded state triggered');
              return SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 70,
                          ),
                          TextFormField(
                            controller: title,
                            decoration: const InputDecoration(
                              labelText: 'Update the product name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a product name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: price,
                            decoration: const InputDecoration(
                              labelText: 'Update the price',
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a price';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: description,
                            decoration: const InputDecoration(
                              labelText: 'Update the description',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a description';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else if (state is ProductsLoading) {
              log('ProductsLoading state triggered');
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              );
            } else if (state is ProductUpdated) {
              log("ProductUpdated state triggered");

              WidgetsBinding.instance.addPostFrameCallback((_) {
                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                    (route) => false,
                  );
                });
              });
              return Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Product Updated Successfully',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 300,
                        height: 300,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('asset/Image/confirmed.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is ProductsError) {
              return const Center(
                child: Text(
                  "Something went wrong",
                  style: TextStyle(color: Colors.black),
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoaded) {
            log('BottomAppBar is displayed');
            return BottomAppBar(
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
                    if (_formKey.currentState?.validate() ?? false) {
                      var updateData = {
                        "title": title.text,
                        "description": description.text,
                        "price": price.text
                      };

                      log('Dispatching UpdateProduct event');
                      context.read<ProductsBloc>().add(
                            UpdateProduct(id: id, updatedData: updateData),
                          );
                    }
                  },
                  child: const Text(
                    'Update Details',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          } else {
            return const BottomAppBar(
              color: Colors.white,
            );
          }
        },
      ),
    );
  }
}
