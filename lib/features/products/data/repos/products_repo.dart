import 'package:storeapp/core/helper/api.dart';
import 'package:storeapp/features/products/data/models/product_model.dart';

/// Single source of truth for all product-related API calls.
/// Uses dummyjson.com — a reliable, globally-accessible fake store API
/// with the same product data shape as the original fakestoreapi.com.
class ProductsRepo {
  final Api _api = Api();

  static const _base = 'https://dummyjson.com';

  // ─── Helpers ─────────────────────────────────────────────────────────────

  /// dummyjson wraps product lists: { "products": [...], "total": N, ... }
  List<ProductModel> _parseList(dynamic data) {
    final List<dynamic> list = data is Map
        ? (data['products'] as List<dynamic>)
        : (data as List<dynamic>);
    return list
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // ─── READ ────────────────────────────────────────────────────────────────

  /// Fetch all products (up to 100).
  Future<List<ProductModel>> getAllProducts() async {
    final data = await _api.get(url: '$_base/products?limit=100');
    return _parseList(data);
  }

  /// Fetch products filtered by [category] slug (e.g. "beauty", "laptops").
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    final data =
        await _api.get(url: '$_base/products/category/$category');
    return _parseList(data);
  }

  /// Returns category slugs: ["beauty", "fragrances", "furniture", ...]
  Future<List<String>> getAllCategories() async {
    final List<dynamic> data =
        await _api.get(url: '$_base/products/categories');
    // Each entry: { "slug": "beauty", "name": "Beauty", "url": "..." }
    return data
        .map((e) => (e as Map<String, dynamic>)['slug'] as String)
        .toList();
  }

  // ─── WRITE ───────────────────────────────────────────────────────────────

  Future<ProductModel> addProduct({
    required String title,
    required double price,
    required String description,
    required String image,
    required String category,
  }) async {
    final Map<String, dynamic> data = await _api.post(
      url: '$_base/products/add',
      body: {
        'title': title,
        'price': price,
        'description': description,
        'thumbnail': image,
        'category': category,
      },
      token: null,
    );
    return ProductModel.fromJson(data);
  }

  Future<ProductModel> updateProduct({
    required int id,
    required String title,
    required String price,
    required String description,
    required String image,
    required String category,
  }) async {
    final Map<String, dynamic> data = await _api.put(
      url: '$_base/products/$id',
      body: {
        'title': title,
        'price': double.tryParse(price) ?? 0.0,
        'description': description,
        'thumbnail': image,
        'category': category,
      },
      token: null,
    );
    return ProductModel.fromJson(data);
  }
}
