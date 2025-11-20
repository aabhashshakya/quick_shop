import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../core/app_config/session_notifier.dart';
import '../../data/model/product.dart';
import '../../data/products_repository.dart';

class ProductListViewModel extends ChangeNotifier {
  final ProductRepository _repository = ProductRepository();

  ProductListViewModel() {
    loadProducts();
    FlutterSessionNotifier().addListener(_onSessionEvent);
  }

  void _onSessionEvent() {
    final event = FlutterSessionNotifier().lastEvent;

    if (event == SessionEventType.login) {
      //login -> reload products
      loadProducts();
    } else if (event == SessionEventType.logout) {
      _onLogout();
    }
  }

  void _onLogout() {
    products = [];
    error = null;
    isLoading = false;
    notifyListeners();
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

  @override
  void dispose() {
    FlutterSessionNotifier().removeListener(_onSessionEvent);
    super.dispose();
  }
}
