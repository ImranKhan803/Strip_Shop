import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'cart_page.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartController>();
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        title: const Text('Shop', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          Obx(() => Padding(
                padding: const EdgeInsets.only(right: 16),
                child: IconButton(
                  onPressed: () => Get.to(() => const CartPage()),
                  icon: Badge(
                    isLabelVisible: cart.count > 0,
                    label: Text('${cart.count}'),
                    child: const Icon(Icons.shopping_cart_outlined),
                  ),
                ),
              )),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: .78),
        itemBuilder: (_, i) => ProductCard(products[i]),
      ),
    );
  }
}
