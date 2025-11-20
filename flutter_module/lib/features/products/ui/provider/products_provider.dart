import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../data/model/product.dart';
import '../../data/products_repository.dart';

class ProductListViewModel extends ChangeNotifier {
  final ProductRepository _repository = ProductRepository();

  ProductListViewModel() {
    loadProducts();
  }

  bool isLoading = false;
  List<Product> products = [];
  String? error;

  void loadProducts() async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await _repository.getProducts();

      products = result.products;
      error = null;

      if (result.apiFailed && result.fromCache) {
        Fluttertoast.showToast(msg: 'Showing cached data (API failed)');
      } else if (result.replacedCache) {
        Fluttertoast.showToast(msg: 'Fresh data loaded');
      }
    } catch (e) {
      error = e.toString();
      Fluttertoast.showToast(msg: 'Failed to load data');
    }

    isLoading = false;
    notifyListeners();
  }
}
