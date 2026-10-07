import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import '../models/product.dart';
import '../services/stripe_service.dart';
import '../views/success_page.dart';

class CartController extends GetxController {
  final items = <Product, int>{}.obs; // product -> quantity
  final isPaying = false.obs;

  int qty(Product p) => items[p] ?? 0;
  int get count => items.values.fold(0, (a, b) => a + b);
  double get total =>
      items.entries.fold(0.0, (sum, e) => sum + e.key.price * e.value);

  void add(Product p) => items[p] = qty(p) + 1;

  void remove(Product p) {
    qty(p) <= 1 ? items.remove(p) : items[p] = qty(p) - 1;
  }

  void clear() => items.clear();

  Future<void> checkout() async {
    if (items.isEmpty) return;
    final paid = total;
    isPaying.value = true;
    try {
      await StripeService.pay(paid);
      clear();
      Get.offAll(() => SuccessPage(amount: paid));
    } on StripeException catch (e) {
      debugPrint('STRIPE EXCEPTION: ${e.error.localizedMessage}');
      _msg('Payment cancelled', e.error.localizedMessage ?? 'Cancelled');
    } catch (e, stack) {
      debugPrint('CHECKOUT ERROR: $e');
      debugPrint('CHECKOUT STACKTRACE: $stack');
      _msg('Error', e.toString());
    } finally {
      isPaying.value = false;
    }
  }

  void _msg(String title, String body) => Get.snackbar(
        title, body,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        backgroundColor: Colors.black87,
        colorText: Colors.white,
      );
}
