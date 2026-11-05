import 'package:flutter/material.dart';
import 'package:storeapp/models/product_model.dart';
import 'package:storeapp/screens/product_details.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.id, arguments: product);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 150,
            width: 220,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.2),
                  blurRadius: 50,
                  spreadRadius: 0,
                  offset: Offset(5, 5),
                ),
              ],
            ),
            child: Card(
              elevation: 10,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title.substring(0, 7),
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${product.price.toString()}',
                          style: TextStyle(fontSize: 20),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.favorite, color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 50,
            child:
                (product.image.isNotEmpty &&
                    Uri.tryParse(product.image)?.hasAbsolutePath == true)
                ? Hero(
                    tag: "${product.id}",
                    child: Image.network(
                      Uri.encodeFull(product.image),
                      height: 120,
                      width: 100,
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const SizedBox(
                          height: 120,
                          width: 100,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image, size: 50);
                      },
                    ),
                  )
                : const Icon(Icons.broken_image, size: 50),
          ),
        ],
      ),
    );
  }
}
