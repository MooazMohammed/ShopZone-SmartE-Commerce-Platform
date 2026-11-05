import 'package:flutter/material.dart';
import 'package:storeapp/services/get_all_categories.dart';

class Categories extends StatefulWidget {
  final Function(String category) onCategorySelected; 

  const Categories({super.key, required this.onCategorySelected});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int selectedBox = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: GetAllCategories().getCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No categories found"));
        } else {
          final categories = ["all", ...snapshot.data!]; 
          return SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return buildCategory(index, categories);
              },
            ),
          );
        }
      },
    );
  }

  GestureDetector buildCategory(int index, List<dynamic> categories) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedBox = index;
        });
        widget.onCategorySelected(categories[index]); 
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              categories[index].toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedBox == index ? Colors.black : const Color(0xff356c95),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              height: 2,
              width: 30,
              color: selectedBox == index ? Colors.black : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
