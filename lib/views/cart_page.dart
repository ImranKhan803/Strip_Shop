import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../widgets/qty_stepper.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartController>();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        surfaceTintColor:Colors.blue.shade50,
        title: const Text('Cart', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: cart.clear,
              icon: const Icon(Icons.delete_sweep_outlined)),
        ],
      ),
      body: Obx(() {
        if (cart.items.isEmpty) {
          return const Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.shopping_bag_outlined, size: 72, color: Colors.grey),
            SizedBox(height: 12),
            Text('Your cart is empty', style: TextStyle(color: Colors.grey)),
          ]));
        }
        return ListView(
          padding: const EdgeInsets.all(16),
          children: cart.items.entries.map((e) {
            final p = e.key;
            return Card(
              elevation: 2.5,
              shadowColor: Colors.black.withOpacity(0.12),
              color: const Color(0xFFFFFBF6),
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: CircleAvatar(
                    radius: 26,
                    backgroundColor: p.color.withOpacity(.15),
                    child: Icon(p.icon, color: p.color)),
                title: Text(p.name,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text('\$${p.price.toStringAsFixed(2)}'),
                trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('\$${(p.price * e.value).toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      QtyStepper(
                          qty: e.value,
                          onAdd: () => cart.add(p),
                          onRemove: () => cart.remove(p)),
                    ]),
              ),
            );
          }).toList(),
        );
      }),
      bottomNavigationBar: Obx(() => cart.items.isEmpty
          ? const SizedBox.shrink()
          : SafeArea(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    border: Border(
                        top: BorderSide(color: theme.colorScheme.outlineVariant))),
                child: Row(children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Total (${cart.count} items)',
                            style: const TextStyle(color: Colors.grey)),
                        Text('\$${cart.total.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                      ]),
                  const Spacer(),
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                        minimumSize: const Size(150, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14))),
                    onPressed: cart.isPaying.value ? null : cart.checkout,
                    icon: cart.isPaying.value
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2))
                        : const Icon(Icons.lock_outline),
                    label: const Text('Checkout'),
                  ),
                ]),
              ),
            )),
    );
  }
}
