import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class StripeService {
  /// Payment sheet kholta hai. Success par return, cancel/fail par exception.
  static Future<void> pay(double amount) async {
    final clientSecret = await _createPaymentIntent(amount);

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'My Shop',
        style: ThemeMode.light,
      ),
    );
    await Stripe.instance.presentPaymentSheet();
  }

  // ⚠️ Production mein ye kaam apne backend server se karein,
  // secret key app ke andar kabhi na rakhein.
  static Future<String> _createPaymentIntent(double amount) async {
    final res = await http.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      headers: {'Authorization': 'Bearer $stripeSecretKey'},
      body: {
        'amount': (amount * 100).round().toString(), // cents
        'currency': 'usd',
        'automatic_payment_methods[enabled]': 'true',
      },
    );
    debugPrint('STRIPE RESPONSE CODE: ${res.statusCode}');
    debugPrint('STRIPE RESPONSE BODY: ${res.body}');
    final data = jsonDecode(res.body);
    if (res.statusCode != 200) {
      final errorMsg = data['error']?['message'] ?? 'Payment intent failed: ${res.body}';
      debugPrint('STRIPE ERROR: $errorMsg');
      throw Exception(errorMsg);
    }
    return data['client_secret'];
  }
}
