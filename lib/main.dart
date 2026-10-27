import 'package:e_commerece_app_with_admin_pannel/admin/add_product_screen.dart';
import 'package:e_commerece_app_with_admin_pannel/admin/all_orders_screen.dart';
import 'package:e_commerece_app_with_admin_pannel/firebase_options.dart';
import 'package:e_commerece_app_with_admin_pannel/services/constants.dart';

import 'package:e_commerece_app_with_admin_pannel/ui/pages/bottomnav.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Stripe initialization
  Stripe.publishableKey = publishablekey;
  await Stripe.instance.applySettings();

  // Firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zaib Store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home:AddProductScreen(),
    );
  }
}


