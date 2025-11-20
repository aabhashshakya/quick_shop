/// Created by Aabhash Shakya on 19/11/2025

import '../../../core/cache/db/product_db.dart';
import '../../../core/network/network_service.dart';
import 'model/product.dart';

class ProductResult {
  final List<Product> products;
  final bool fromCache;      //true if data is cached
  final bool replacedCache;  //true if cached data got replaced by fresh
  final bool apiFailed;      //true if api failed while cache exists

  ProductResult({
    required this.products,
    this.fromCache = false,
    this.replacedCache = false,
    this.apiFailed = false,
  });
}


class ProductRepository {
  static final ProductRepository _instance = ProductRepository._internal();
  factory ProductRepository() => _instance;
  ProductRepository._internal();

  final NetworkService _network = NetworkService();
  final ProductDatabase _db = ProductDatabase();

  //returns cached immediately, then fetch fresh in background
  Future<ProductResult> getProducts({bool allowCache = true}) async {
    List<Product> cachedProducts = [];

    if (allowCache) {
      cachedProducts = await _db.getProducts();
    }

    //always fetch fresh data
    try {
      final freshProducts = await _fetchAndCacheProducts();

      //if cache exists, it is now replaced by fresh data
      if (cachedProducts.isNotEmpty) {
        return ProductResult(products: freshProducts, fromCache: false, replacedCache: true);
      }

      //if no cache previously, returning fresh data
      return ProductResult(products: freshProducts, fromCache: false, replacedCache: false);
    } catch (e) {
      //api failed
      if (cachedProducts.isNotEmpty) {
        return ProductResult(products: cachedProducts, fromCache: true, replacedCache: false, apiFailed: true);
      }
      rethrow;
    }
  }

  Future<List<Product>> _fetchAndCacheProducts() async {
    final data = await _network.get<List<dynamic>>('products');
    final products =
    data.map((e) => Product.fromJson(e as Map<String, dynamic>)).toList();
    await _db.insertProducts(products);
    return products;
  }
}
