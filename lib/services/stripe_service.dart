import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StripeService {
  // NOTE: In production, the Secret Key MUST remain on a backend server.
  // We use dotenv locally so it is not exposed in Git history.
  String get _secretKey => dotenv.env['STRIPE_SECRET_KEY'] ?? '';

  Future<bool> processPayment(double amount) async {
    try {
      //  Create Payment Intent
      final paymentIntentData = await _createPaymentIntent(amount, 'USD');
      if (paymentIntentData == null) return false;

      // 2. Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData['client_secret'],
          merchantDisplayName: 'Food Delivery App',
          style: ThemeMode.light,
          billingDetailsCollectionConfiguration: const BillingDetailsCollectionConfiguration(
            address: AddressCollectionMode.never,
          ),
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      return true;
    } catch (e) {
      print('Error during payment processing: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> _createPaymentIntent(
    double amount,
    String currency,
  ) async {
    try {
      final body = {
        'amount': (amount * 100)
            .toInt()
            .toString(), // Stripe expects amount in cents
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $_secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      return json.decode(response.body);
    } catch (err) {
      print('Error charging user: ${err.toString()}');
      return null;
    }
  }
}
