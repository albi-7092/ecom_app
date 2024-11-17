import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test/api/getdata.dart';
import 'package:test/api/updatedata.dart';
import 'package:test/model/product_model.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial()) {
    on<ProductsEvent>((event, emit) {});

    on<LoadProductsEvent>((event, emit) async {
      emit(ProductsLoading()); // Show loading while data is being fetched

      try {
        var data = await fetchData();
        var productsJson = data['products'] as List;

        // Convert the list of JSON objects into a list of Product instances
        List<Product> products =
            productsJson.map((json) => Product.fromJson(json)).toList();

        log("res:${products[0].availabilityStatus}");

        // Emit the ProductsLoaded state with the fetched products
        emit(ProductsLoaded(products));
      } catch (e) {
        log("Error in LoadProductEvent: $e");
        emit(ProductsError("Failed to load products"));
      }
    });

    on<UpdateProduct>(
      (event, emit) async {
        emit(ProductsLoading());
        final bool x = await updateData(event.id.toString(), event.updatedData);
        log("res in Event:$x");
        if (x) {
          emit(ProductUpdated());
        } else {
          emit(ProductsError("error in updating"));
        }
      },
    );
  }
}
