import 'package:flutter/material.dart';
import 'package:storeapp/features/products/presentation/screens/home_page.dart';
import 'package:storeapp/features/products/presentation/screens/product_details.dart';
import 'package:storeapp/features/products/presentation/screens/update_product_page.dart';

void main() {
  runApp(const StoreApp());
}

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (_) => const HomePage(),
        UpdateProductPage.id: (_) => UpdateProductPage(),
        ProductDetails.id: (_) => ProductDetails(),
      },
    );
  }
}
