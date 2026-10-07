import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../models/product.dart';
import 'qty_stepper.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartController>();
    final theme = Theme.of(context);

    return Card(
      elevation: 2.5,
      shadowColor: Colors.black.withOpacity(0.12),
      color: const Color(0xFFFFFBF6),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: LinearGradient(
                    colors: [product.color.withOpacity(.25), product.color.withOpacity(.08)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
              ),
              child: Icon(product.icon, size: 52, color: product.color),
            ),
          ),
          const SizedBox(height: 10),
          Text(product.name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
          Text('\$${product.price.toStringAsFixed(2)}',
              style: TextStyle(
                  color: theme.colorScheme.primary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          SizedBox(
            height: 40,
            child: Obx(() {
              final q = cart.qty(product);
              return q == 0
                  ? SizedBox(
                      width: double.infinity,
                      child: FilledButton.tonalIcon(
                          onPressed: () => cart.add(product),
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text('Add')))
                  : Center(
                      child: QtyStepper(
                          qty: q,
                          onAdd: () => cart.add(product),
                          onRemove: () => cart.remove(product)));
            }),
          ),
        ]),
      ),
    );
  }
}
