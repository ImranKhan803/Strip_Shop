import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'constants.dart';
import 'controllers/cart_controller.dart';
import 'views/shop_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Stripe.publishableKey = stripePublishableKey;
  Get.put(CartController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stripe Shop',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF5E4AA8),
        scaffoldBackgroundColor: const Color(0xFFFBF7FF),
      ),
      home: const ShopPage(),
    );
  }
}
