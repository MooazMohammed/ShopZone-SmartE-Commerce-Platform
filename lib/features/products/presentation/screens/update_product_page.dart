import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:storeapp/features/products/data/models/product_model.dart';
import 'package:storeapp/features/products/data/repos/products_repo.dart';
import 'package:storeapp/features/products/presentation/screens/home_page.dart';
import 'package:storeapp/features/products/presentation/widgets/custom_button.dart';
import 'package:storeapp/features/products/presentation/widgets/custom_text_field.dart';
import 'package:storeapp/features/products/presentation/widgets/show_message.dart';

// ignore: must_be_immutable
class UpdateProductPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  UpdateProductPage({super.key});
  static const id = 'update product';

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  String? _name, _description, _image, _price;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;

    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pushNamed(context, HomePage.id),
            icon: const Icon(Icons.arrow_back_ios_sharp),
          ),
          backgroundColor: Colors.transparent,
          title: const Text('Update Product'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                hint: 'Product name',
                inputType: TextInputType.text,
                onChanged: (v) => _name = v,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                hint: 'Product price',
                inputType: TextInputType.number,
                onChanged: (v) => _price = v,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                hint: 'Product description',
                inputType: TextInputType.text,
                onChanged: (v) => _description = v,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                hint: 'Product image URL',
                inputType: TextInputType.text,
                onChanged: (v) => _image = v,
              ),
              const SizedBox(height: 40),
              CustomButton(
                Color: Colors.blue,
                buttonText: 'Update',
                ontap: () => _submit(product),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit(ProductModel product) async {
    setState(() => _isLoading = true);
    try {
      await ProductsRepo().updateProduct(
        id: product.id,
        title: _name ?? product.title,
        price: _price ?? product.price.toString(),
        description: _description ?? product.description,
        image: _image ?? product.image,
        category: product.category,
      );
      if (mounted) showMessage(context: context, text: 'Updated successfully!');
    } catch (e) {
      if (mounted) showMessage(context: context, text: 'Update failed: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
