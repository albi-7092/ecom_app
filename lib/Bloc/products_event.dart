part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent {}

class LoadProductsEvent extends ProductsEvent {}

// ignore: must_be_immutable
class UpdateProduct extends ProductsEvent {
  int id;
  Map<String, dynamic> updatedData;
  UpdateProduct({required this.id, required this.updatedData});
}

// ignore: must_be_immutable
class Updated extends ProductsState {
  String msg;
  Updated({required this.msg});
}
