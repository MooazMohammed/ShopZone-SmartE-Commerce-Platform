import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storeapp/models/product_model.dart';
import 'package:storeapp/services/get_all_products.dart';
import 'package:storeapp/widgets/custom_card.dart';
import 'package:storeapp/widgets/categories.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const id = 'homePge';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> allProducts = [];
  String selectedCategory = "all";

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final products = await GetAllProducts().getAllProducts();
    setState(() {
      allProducts = products;
    });
  }

  List<ProductModel> get filteredProducts {
    if (selectedCategory == "all") {
      return allProducts;
    } else {
      return allProducts
          .where((product) => product.category == selectedCategory)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text('New Trend'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const FaIcon(
              FontAwesomeIcons.cartShopping,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 8, left: 8, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
              child: Categories(
                onCategorySelected: (category) {
                  setState(() {
                    selectedCategory = category;
                  });
                },
              ),
            ),

            const SizedBox(height: 50),

            Expanded(
              child: allProducts.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : filteredProducts.isEmpty
                  ? const Center(child: Text('No products found'))
                  : GridView.builder(
                      clipBehavior: Clip.none,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 60,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1.1,
                          ),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        return CustomCard(product: filteredProducts[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
