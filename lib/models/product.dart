import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;
  final IconData icon;
  final Color color;
  const Product(this.name, this.price, this.icon, this.color);
}

final products = [
  const Product('Coffee Beans', 12.99, Icons.coffee_rounded, Color(0xFF8D6E63)),
  const Product('Headphones', 59.99, Icons.headphones_rounded, Color(0xFF5C6BC0)),
  const Product('Sneakers', 79.50, Icons.directions_run_rounded, Color(0xFFEF5350)),
  const Product('Backpack', 42.00, Icons.backpack_rounded, Color(0xFF26A69A)),
  const Product('Watch', 99.00, Icons.watch_rounded, Color(0xFFFFA726)),
  const Product('Sunglasses', 24.99, Icons.wb_sunny_rounded, Color(0xFF7E57C2)),
];
