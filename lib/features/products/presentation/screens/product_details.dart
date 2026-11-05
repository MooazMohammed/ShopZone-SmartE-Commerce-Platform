import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storeapp/features/products/data/models/product_model.dart';
import 'package:storeapp/features/products/presentation/widgets/custom_button.dart';

// ignore: must_be_immutable
class ProductDetails extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  ProductDetails({super.key});
  static const id = 'priduct details';

  final List<Color> _colors = const [
    Color(0xFF293446), Color(0xFFBFBFBF), Color(0xFFB1997F),
    Color(0xFF454F68), Color(0xFFD1D1D1), Color(0xFFD4D4D4),
    Color(0xFFD0D4D9), Color(0xFFCD9074), Color(0xFF5A595E),
    Color(0xFF515151), Color(0xFF0D3738), Color(0xFFD4D5D6),
    Color(0xFF8F8B92), Color(0xFF36363A), Color(0xFF381952),
    Color(0xFF292524), Color(0xFFB8BDD3), Color(0xFFF3F3F3),
    Color(0xFFC9263B), Color(0xFF572A57),
  ];

  @override
  Widget build(BuildContext context) {
    final product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    final Color productColor = _colors[(product.id - 1) % _colors.length];
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: productColor,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // ── White card bottom sheet ─────────────────────────────────
            Container(
              margin: EdgeInsets.only(top: size.height * 0.3),
              padding: EdgeInsets.only(
                top: size.height * 0.12,
                left: 17.2,
                right: 17.2,
              ),
              height: size.height * 0.6,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  _ColorAndSize(productColor: productColor),
                  _Description(product: product, productColor: productColor),
                  const SizedBox(height: 10),
                  const _CartCounter(),
                  const SizedBox(height: 10),
                  _AddToCart(productColor: productColor),
                ],
              ),
            ),
            // ── Floating title + image ──────────────────────────────────
            _buildTitleWithImage(context, product),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleWithImage(BuildContext context, ProductModel product) {
    final descPreview = product.description.length > 23
        ? product.description.substring(0, 23)
        : product.description;
    final titlePreview = product.title.length > 10
        ? product.title.substring(0, 10)
        : product.title;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(descPreview, style: const TextStyle(color: Colors.white)),
          Text(
            titlePreview,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(text: 'price\n'),
                    TextSpan(
                      text: '\$${product.price.toStringAsFixed(2)}',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 50),
              Expanded(
                child: SizedBox(
                  height: 200,
                  child: Hero(
                    tag: '${product.id}',
                    child: Image.network(product.image, fit: BoxFit.contain),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const FaIcon(FontAwesomeIcons.cartShopping, color: Colors.white),
        ),
      ],
    );
  }
}

// ─── Sub-widgets ──────────────────────────────────────────────────────────────

class _AddToCart extends StatelessWidget {
  const _AddToCart({required this.productColor});
  final Color productColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Container(
              height: 50,
              width: 58,
              decoration: BoxDecoration(
                border: Border.all(color: productColor),
                borderRadius: BorderRadius.circular(18),
              ),
              child: IconButton(
                onPressed: () {},
                icon: FaIcon(FontAwesomeIcons.cartPlus, color: productColor),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            width: 290,
            child: CustomButton(
              Color: productColor,
              buttonText: 'BUY NOW',
              ontap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _CartCounter extends StatefulWidget {
  const _CartCounter();

  @override
  State<_CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<_CartCounter> {
  int _count = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _counterButton(Icons.remove, () {
          if (_count > 1) setState(() => _count--);
        }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            _count.toString().padLeft(2, '0'),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        _counterButton(Icons.add, () => setState(() => _count++)),
      ],
    );
  }

  Widget _counterButton(IconData icon, VoidCallback onPressed) {
    return SizedBox(
      height: 30,
      width: 32,
      child: OutlinedButton(
        style: ButtonStyle(
          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        onPressed: onPressed,
        child: Icon(icon),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({required this.product, required this.productColor});
  final ProductModel product;
  final Color productColor;

  @override
  Widget build(BuildContext context) {
    final text = product.description.length > 400
        ? product.description.substring(0, 200)
        : product.description;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(text, style: TextStyle(height: 1.5, color: productColor)),
    );
  }
}

class _ColorAndSize extends StatelessWidget {
  const _ColorAndSize({required this.productColor});
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
              const Row(
                children: [
                  _ColorDot(color: Color(0xff356c95), isSelected: true),
                  _ColorDot(color: Color(0xfff8c078)),
                  _ColorDot(color: Color(0xffa29b9b)),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Color(0xff356c95)),
              children: [
                const TextSpan(text: 'size\n'),
                TextSpan(
                  text: '12 cm',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff356c95),
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

class _ColorDot extends StatelessWidget {
  final Color color;
  final bool isSelected;
  const _ColorDot({required this.color, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            color: isSelected ? color : Colors.transparent),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}
