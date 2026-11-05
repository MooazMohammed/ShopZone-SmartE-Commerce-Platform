import 'package:flutter/material.dart';
import 'package:storeapp/features/products/data/repos/products_repo.dart';

class Categories extends StatefulWidget {
  final Function(String category) onCategorySelected;

  const Categories({super.key, required this.onCategorySelected});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: ProductsRepo().getAllCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No categories found'));
        }

        final categories = ['all', ...snapshot.data!];

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) =>
              _buildChip(index, categories[index]),
        );
      },
    );
  }

  Widget _buildChip(int index, String label) {
    final bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedIndex = index);
        widget.onCategorySelected(label);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.black : const Color(0xff356c95),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              height: 2,
              width: 30,
              color: isSelected ? Colors.black : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
