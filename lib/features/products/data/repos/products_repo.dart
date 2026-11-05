import 'package:storeapp/core/helper/api.dart';
import 'package:storeapp/features/products/data/models/product_model.dart';

/// Single source of truth for all product-related API calls.
/// Replaces the old individual service files (get_all_products,
/// get_category, get_all_categories, add_product, update_product).
class ProductsRepo {
  final Api _api = Api();

  // ─── READ ────────────────────────────────────────────────────────────────

  Future<List<ProductModel>> getAllProducts() async {
    final List<dynamic> data =
        await _api.get(url: 'https://fakestoreapi.com/products');
    return data
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<ProductModel>> getProductsByCategory(String category) async {
    final List<dynamic> data = await _api.get(
      url: 'https://fakestoreapi.com/products/category/$category',
    );
    return data
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<String>> getAllCategories() async {
    final List<dynamic> data =
        await _api.get(url: 'https://fakestoreapi.com/products/categories');
    return data.map((e) => e.toString()).toList();
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
      url: 'https://fakestoreapi.com/products',
      body: {
        'title': title,
        'price': price,
        'description': description,
        'image': image,
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
      url: 'https://fakestoreapi.com/products/$id',
      body: {
        'title': title,
        'price': price,
        'description': description,
        'image': image,
        'category': category,
      },
      token: null,
    );
    return ProductModel.fromJson(data);
  }
}
