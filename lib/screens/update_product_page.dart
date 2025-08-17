import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:storeapp/models/product_model.dart';
import 'package:storeapp/screens/home_page.dart';
import 'package:storeapp/services/update_product.dart';
import 'package:storeapp/widgets/custom_button.dart';
import 'package:storeapp/widgets/custom_text_field.dart';
import 'package:storeapp/widgets/show_message.dart';

// ignore: must_be_immutable
class UpdateProductPage extends StatefulWidget {
  UpdateProductPage({super.key});
  static const id = 'update product';

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  String? name, description, image;

  String? price;
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, HomePage.id);
            },
            icon: const Icon(Icons.arrow_back_ios_sharp),
          ),
          backgroundColor: Colors.transparent,
          title: const Text('Update Product'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                onChanged: (p0) {
                  name = p0;
                },
                hint: 'Product name',
                inputType: TextInputType.text,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                onChanged: (p0) {
                  price = p0;
                },
                hint: 'Product price',
                inputType: TextInputType.number,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                onChanged: (p0) {
                  description = p0;
                },
                hint: 'Product description',
                inputType: TextInputType.text,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                onChanged: (p0) {
                  image = p0;
                },
                hint: 'Product image',
                inputType: TextInputType.text,
              ),
              const SizedBox(
                height: 40,
              ),
              CustomButton(
                Color: Colors.blue,
                buttonText: 'update',
                ontap: () {
                  isloading = true;
                  setState(() {});
                  try {
                    updateProduct(product);
                    showMessage(context: context, text: 'Update Successfully');
                    print(product);
                  } catch (e) {
                    print(e.toString());
                  }
                  isloading = false;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateProduct(ProductModel product) {
    UpdateProductservice().update(
      id: product.id,
      title: name == null ? product.title : name!,
      price: price == null ? product.price.toString() : price!,
      description: description == null ? product.description : name!,
      image: image == null ? product.image : image!,
      category: product.category,
    );
  }
}
