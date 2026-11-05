import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storeapp/features/products/data/repos/products_repo.dart';
import 'package:storeapp/features/products/logic/cubit/products_cubit.dart';
import 'package:storeapp/features/products/presentation/widgets/categories.dart';
import 'package:storeapp/features/products/presentation/widgets/custom_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const id = 'homePge';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsCubit(ProductsRepo())..fetchAllProducts(),
      child: const _HomePageView(),
    );
  }
}

// ─── Private view — has access to the Cubit via context ──────────────────────

class _HomePageView extends StatefulWidget {
  const _HomePageView();

  @override
  State<_HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<_HomePageView> {
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
                  final cubit = context.read<ProductsCubit>();
                  if (category == 'all') {
                    cubit.fetchAllProducts();
                  } else {
                    cubit.fetchProductsByCategory(category);
                  }
                },
              ),
            ),
            const SizedBox(height: 50),
            Expanded(child: _ProductsGrid()),
          ],
        ),
      ),
    );
  }
}

// ─── Products grid — reacts to Cubit state ───────────────────────────────────

class _ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        return switch (state) {
          ProductsInitial() ||
          ProductsLoading() =>
            const Center(child: CircularProgressIndicator()),

          ProductsError(:final message) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.wifi_off, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () =>
                          context.read<ProductsCubit>().fetchAllProducts(),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),

          ProductsSuccess(:final products) when products.isEmpty =>
            const Center(child: Text('No products found')),

          ProductsSuccess(:final products) => GridView.builder(
              clipBehavior: Clip.none,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 60,
                crossAxisSpacing: 10,
                childAspectRatio: 1.1,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) =>
                  CustomCard(product: products[index]),
            ),
        };
      },
    );
  }
}
