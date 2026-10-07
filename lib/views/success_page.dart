import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'shop_page.dart';

class SuccessPage extends StatelessWidget {
  final double amount;
  const SuccessPage({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.check_circle_rounded, size: 110, color: Colors.green),
            const SizedBox(height: 20),
            const Text('Payment Successful',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('You paid \$${amount.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.grey, fontSize: 16)),
            const SizedBox(height: 32),
            FilledButton(
                style: FilledButton.styleFrom(minimumSize: const Size(200, 50)),
                onPressed: () => Get.offAll(() => const ShopPage()),
                child: const Text('Continue Shopping')),
          ]),
        ),
      ),
    );
  }
}
