import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storeapp/models/product_model.dart';
import 'package:storeapp/widgets/custom_button.dart';

// ignore: must_be_immutable
class ProductDetails extends StatelessWidget {
  ProductDetails({super.key});
  static const id = 'priduct details';
  List<Color> colors = [
    Color(0xFF293446),
    Color(0xFFBFBFBF),
    Color(0xFFB1997F),
    Color(0xFF454F68),
    Color(0xFFD1D1D1),
    Color(0xFFD4D4D4),
    Color(0xFFD0D4D9),
    Color(0xFFCD9074),
    Color(0xFF5A595E),
    Color(0xFF515151),
    Color(0xFF0D3738),
    Color(0xFFD4D5D6),
    Color(0xFF8F8B92),
    Color(0xFF36363A),
    Color(0xFF381952),
    Color(0xFF292524),
    Color(0xFFB8BDD3),
    Color(0xFFF3F3F3),
    Color(0xFFC9263B),
    Color(0xFF572A57),
  ];

  ProductModel? product;
  @override
  Widget build(BuildContext context) {
    ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    Color productColor = colors[product.id - 1];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: productColor,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                    top: size.height * 0.12,
                    left: 17.2,
                    right: 17.2,
                  ),
                  height: (0.6 * size.height),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      colorAndSize(productColor: productColor),
                      description(product: product, productColor: productColor),
                      SizedBox(height: 10),
                      cartCounter(),
                      SizedBox(height: 10),
                      addToCart(productColor: productColor,),
                    ],
                  ),
                ),
                productTitleWithImage(context, product),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding productTitleWithImage(BuildContext context, ProductModel product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            product.description.substring(0, 23),
            style: TextStyle(color: Colors.white),
          ),

          Text(
            product.title.substring(0, 10),
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: 'price\n'),
                    TextSpan(
                      text: '\$${product.price}',
                      style: Theme.of(context).textTheme.headlineMedium!
                          .copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 50),
              Expanded(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Hero(
                    tag: "${product.id}",
                    child: Image.network(product.image, fit: BoxFit.contain),
                  ),
                ),
              ),
              // Expanded(child: Image.network(product.image), ),
            ],
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: FaIcon(FontAwesomeIcons.cartShopping, color: Colors.white),
        ),
      ],
    );
  }
}

class addToCart extends StatelessWidget {
  const addToCart({super.key, required this.productColor});
  final Color productColor;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.only(right: 5),
            child: Container(
              height: 50,
              width: 58,
              decoration: BoxDecoration(
                border: Border.all(color: productColor),
                borderRadius: BorderRadius.circular(18),
              ),
              child: IconButton(
                onPressed: () {},
                icon: FaIcon(
                  FontAwesomeIcons.cartPlus,
                  color: productColor,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            width: 290,
            child: CustomButton(
              Color: productColor,
              buttonText: 'Buy Now'.toUpperCase(),
              ontap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class cartCounter extends StatefulWidget {
  const cartCounter({super.key});
  


  @override
  State<cartCounter> createState() => _cartCounterState();
}

class _cartCounterState extends State<cartCounter> {
  int numOfitems = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        outlineButton(Icons.remove, () {
          if (numOfitems > 1) {
            setState(() {
              numOfitems--;
            });
          }
        }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            numOfitems.toString().padLeft(2, '0'),
            style: Theme.of(
              context,
            ).textTheme.headlineMedium,
          ),
        ),
        outlineButton(Icons.add, () {
          setState(() {
            numOfitems++;
          });
        }),
      ],
    );
  }

  Container outlineButton(IconData icon, VoidCallback? press) {
    return Container(
      height: 30,
      width: 32,
      child: OutlinedButton(
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(EdgeInsets.zero),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}

class description extends StatelessWidget {
  const description({
    super.key,
    required this.product,
    required this.productColor,
  });

  final ProductModel product;
  final Color productColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        product.description.length > 400
            ? product.description.substring(0, 200)
            : product.description,
        style: TextStyle(height: 1.5, color: productColor),
      ),
    );
  }
}

class colorAndSize extends StatelessWidget {
  const colorAndSize({super.key, required this.productColor});
  final Color productColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Colors', style: TextStyle(color: productColor)),
              Row(
                children: [
                  ColorDot(color: Color(0xff356c95), isSelected: true),
                  ColorDot(color: Color(0xfff8c078)),
                  ColorDot(color: Color(0xffa29b9b)),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Color(0xff356c95)),
              children: [
                TextSpan(text: 'size\n'),
                TextSpan(
                  text: "12 cm",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff356c95),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ColorDot extends StatelessWidget {
  final Color color;
  final bool isSelected;
  const ColorDot({super.key, required this.color, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(),
      padding: EdgeInsets.all(3),
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: BoxBorder.all(color: isSelected ? color : Colors.transparent),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}
